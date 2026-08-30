import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_header_widget.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_option_sheet.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_tabs_widgets.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/my_pets_selection_sheet.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../cubit/adoption_cubit.dart';
import '../widgets/pet_categories_section.dart';

@RoutePage()
class AdoptionFeatureScreen extends StatelessWidget {
  const AdoptionFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdoptionCubit>(),
      child: const _AdoptionView(),
    );
  }
}

class _AdoptionView extends StatefulWidget {
  const _AdoptionView();

  @override
  State<_AdoptionView> createState() => _AdoptionViewState();
}

class _AdoptionViewState extends State<_AdoptionView> {
  @override
  void initState() {
    super.initState();
    context.read<AdoptionCubit>().getAdoptionPetCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =========================
      // Add Adoption
      // =========================
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) {
                return AdoptionOptionSheet(
                  // =========================
                  // Add New Pet
                  // =========================
                  onAddNewPet: () {
                    final router = context.router;

                    Navigator.pop(context);

                    router.push(AddPetRoute(showAdoptionFields: true));
                  },

                  // =========================
                  // Select My Pet
                  // =========================
                  onSelectMyPet: () {
                    Navigator.pop(context);

                    final userId =
                        Supabase.instance.client.auth.currentUser?.id;

                    if (userId == null) {
                      context.showErrorToast('User profile not found');
                      return;
                    }

                    final snapshot = UserDataStore.read(userId);

                    final pets = snapshot == null
                        ? <Map<String, dynamic>>[]
                        : UserDataStore.petsOf(snapshot);

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (_) {
                        return MyPetsSelectionSheet(
                          pets: pets,

                          onPetSelected: (pet) async {
                            final adoptionCubit = context.read<AdoptionCubit>();

                            Navigator.pop(context);

                            final userId =
                                Supabase.instance.client.auth.currentUser?.id;

                            if (userId == null) {
                              context.showErrorToast('User profile not found');
                              return;
                            }

                            debugPrint('========== CREATE ADOPTION ==========');

                            debugPrint('Pet ID: ${pet['id']}');

                            debugPrint('Pet Name: ${pet['name']}');

                            debugPrint('Poster ID: $userId');

                            final adoptionPost = AdoptionPostEntity(
                              id: '',
                              petId: pet['id'].toString(),
                              posterId: userId,
                              description: 'Pet available for adoption',
                              status: 'available',
                              location: '',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            await adoptionCubit.createAdoptionPost(
                              adoptionPost: adoptionPost,
                            );

                            debugPrint(
                              '========== CREATE ADOPTION FINISHED ==========',
                            );

                            debugPrint(
                              'isPostCreated: '
                              '${adoptionCubit.state.isPostCreated}',
                            );

                            debugPrint(
                              'errorMessage: '
                              '${adoptionCubit.state.errorMessage}',
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },

          backgroundColor: context.primary50,
          elevation: 2,

          icon: const Icon(Icons.add, color: Colors.white),

          label: const Text(
            'Adopt',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

      // =========================
      // Body
      // =========================
      body: SafeArea(
        child: Column(
          children: [
            AdoptionHeader(
              userInitial: _getUserInitial(),
              onNotificationTap: () {
                // TODO
              },
            ),

            const SizedBox(height: 12),

            PetCategoriesSection(onMoreCategoryTap: () {}),

            const SizedBox(height: 12),

            const AdoptionTabs(),

            // =========================
            // Adoption Posts
            // =========================
            Expanded(
              child: BlocBuilder<AdoptionCubit, AdoptionState>(
                builder: (context, state) {
                  // Loading
                  if (state.isLoadingPosts) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error
                  if (state.errorMessage != null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          state.errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  // Empty
                  if (state.adoptionPetCards.isEmpty) {
                    return const Center(
                      child: Text('No pets available for adoption'),
                    );
                  }

                  // Posts
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.adoptionPetCards.length,
                    itemBuilder: (context, index) {
                      final card = state.adoptionPetCards[index];
                      final imageUrl = card.imageUrl;

                      return InkWell(
                        onTap: () {
                          context.router.root.push(PetDetailsRoute(pet: card));
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // =========================
                              // Pet Image
                              // =========================
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 220.h,
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) {
                                            return Container(
                                              color: context.neutral100,
                                              child: Icon(
                                                Icons.pets,
                                                size: 60.r,
                                                color: context.primary,
                                              ),
                                            );
                                          },
                                        )
                                      : Container(
                                          color: context.neutral100,
                                          child: Icon(
                                            Icons.pets,
                                            size: 60.r,
                                            color: context.primary,
                                          ),
                                        ),
                                ),
                              ),

                              // =========================
                              // Pet Info
                              // =========================
                              Padding(
                                padding: EdgeInsets.all(16.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card.name,
                                      style: context.body1.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: context.neutral700,
                                      ),
                                    ),

                                    SizedBox(height: 8.h),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 20.r,
                                          color: context.primary,
                                        ),
                                        SizedBox(width: 6.w),
                                        Expanded(
                                          child: Text(
                                            card.location,
                                            style: context.body2.copyWith(
                                              color: context.neutral400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 6.h),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.cake_outlined,
                                          size: 20.r,
                                          color: context.primary,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          _formatAge(card.birthdate),
                                          style: context.body2.copyWith(
                                            color: context.neutral400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAge(DateTime birthdate) {
    final now = DateTime.now();

    int years = now.year - birthdate.year;

    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      years--;
    }

    if (years < 0) {
      years = 0;
    }

    if (years == 0) {
      final months =
          (now.year - birthdate.year) * 12 + now.month - birthdate.month;

      if (months <= 0) {
        return 'Less than 1 month';
      }

      return months == 1 ? '1 month' : '$months months';
    }

    return years == 1 ? '1 year' : '$years years';
  }

  String _getUserInitial() {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return '?';
    }

    final metadata = user.userMetadata;

    final name =
        metadata?['name']?.toString() ??
        metadata?['full_name']?.toString() ??
        metadata?['username']?.toString() ??
        user.email?.split('@').first ??
        '';

    if (name.trim().isEmpty) {
      return '?';
    }

    return name.trim()[0].toUpperCase();
  }
}
