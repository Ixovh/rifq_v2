import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/features/home/presentation/widgets/home_header.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_option_sheet.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_pet_list_section.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_tabs_widgets.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/my_adoption_listings_section.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/my_pets_selection_sheet.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/pet_categories_section.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AdoptionFeatureScreen extends StatelessWidget {
  const AdoptionFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdoptionCubit>()..getAdoptionPetCards(),
      child: const _AdoptionView(),
    );
  }
}

class _AdoptionView extends StatelessWidget {
  const _AdoptionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton.extended(
          onPressed: () => _showAdoptionOptions(context),
          backgroundColor: context.primary50,
          elevation: 2,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Adopt',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              isGuest: AuthHelper.isGuestUser(),
              imageUrl: _profileImageUrl(),
              initials: _getUserInitial(),
              onAvatarTap: () => context.pushRoute(const AccountRoute()),
            ),
            const SizedBox(height: 12),
            PetCategoriesSection(
              onMoreCategoryTap: () {},
            ),
            const SizedBox(height: 12),
            const AdoptionTabs(),
            Flexible(
              child: BlocBuilder<AdoptionCubit, AdoptionState>(
                buildWhen: (previous, current) =>
                    previous.selectedTabIndex != current.selectedTabIndex,
                builder: (context, state) {
                  return state.selectedTabIndex == 1
                      ? const MyAdoptionListingsSection()
                      : const AdoptionPetListSection();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAdoptionOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (_) {
        return AdoptionOptionSheet(
          onAddNewPet: () async {
            Navigator.pop(context);
            final added = await context.router.push(
              AddPetRoute(showAdoptionFields: true),
            );
            if (!context.mounted) return;
            if (added == true) {
              await context.read<AdoptionCubit>().getMyAdoptionPets(
                silent: true,
              );
            }
          },
          onSelectMyPet: () {
            Navigator.pop(context);
            _showMyPetsSelection(context);
          },
        );
      },
    );
  }

  Future<void> _showMyPetsSelection(BuildContext context) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      context.showErrorToast('User profile not found');
      return;
    }

    final snapshot = UserDataStore.read(userId);

    final pets = snapshot == null
        ? <Map<String, dynamic>>[]
        : UserDataStore.petsOf(snapshot);

    await showModalBottomSheet(
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
            Navigator.pop(context);

            final adoptionCubit = context.read<AdoptionCubit>();
            final currentUserId =
                Supabase.instance.client.auth.currentUser?.id;

            if (currentUserId == null) {
              context.showErrorToast('User profile not found');
              return;
            }

            final now = DateTime.now();

            final adoptionPost = AdoptionPostEntity(
              id: '',
              petId: pet['id'].toString(),
              posterId: currentUserId,
              description: 'Pet available for adoption',
              status: 'available',
              location: '',
              createdAt: now,
              updatedAt: now,
            );

            await adoptionCubit.createAdoptionPost(
              adoptionPost: adoptionPost,
            );
          },
        );
      },
    );
  }

  String? _profileImageUrl() {
    final userId = AuthHelper.getUserId() ??
        Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return null;
    final snapshot = UserDataStore.read(userId);
    if (snapshot == null) return null;
    return UserDataStore.profileOf(snapshot)['image_url'] as String?;
  }

  String _getUserInitial() {
    final userId = AuthHelper.getUserId() ??
        Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      final snapshot = UserDataStore.read(userId);
      if (snapshot != null) {
        final name =
            (UserDataStore.profileOf(snapshot)['full_name'] as String?)
                ?.trim() ??
            '';
        if (name.isNotEmpty) {
          return name[0].toUpperCase();
        }
      }
    }

    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return 'U';
    }

    final metadata = user.userMetadata;

    final name =
        metadata?['name']?.toString() ??
        metadata?['full_name']?.toString() ??
        metadata?['username']?.toString() ??
        user.email?.split('@').first ??
        '';

    if (name.trim().isEmpty) {
      return 'U';
    }

    return name.trim()[0].toUpperCase();
  }
}








// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_header_widget.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_option_sheet.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_tabs_widgets.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/my_adoption_pet_card.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/my_pets_selection_sheet.dart';
// import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
// import 'package:rifq_v2/shared/presentation/router/app_router.dart';
// import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
// import 'package:rifq_v2/shared/service_locator/service_locator.dart';
// import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
// import 'package:rifq_v2/shared/utils/app_date_utils.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../cubit/adoption_cubit.dart';
// import '../widgets/pet_categories_section.dart';

// @RoutePage()
// class AdoptionFeatureScreen extends StatelessWidget {
//   const AdoptionFeatureScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<AdoptionCubit>(),
//       child: const _AdoptionView(),
//     );
//   }
// }

// class _AdoptionView extends StatefulWidget {
//   const _AdoptionView();

//   @override
//   State<_AdoptionView> createState() => _AdoptionViewState();
// }

// class _AdoptionViewState extends State<_AdoptionView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<AdoptionCubit>().getAdoptionPetCards();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // =========================
//       // Add Adoption
//       // =========================
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 70),
//         child: FloatingActionButton.extended(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               backgroundColor: Colors.white,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//               ),
//               builder: (_) {
//                 return AdoptionOptionSheet(
//                   // =========================
//                   // Add New Pet
//                   // =========================
//                   onAddNewPet: () {
//                     final router = context.router;

//                     Navigator.pop(context);

//                     router.push(AddPetRoute(showAdoptionFields: true));
//                   },

//                   // =========================
//                   // Select My Pet
//                   // =========================
//                   onSelectMyPet: () {
//                     Navigator.pop(context);

//                     final userId =
//                         Supabase.instance.client.auth.currentUser?.id;

//                     if (userId == null) {
//                       context.showErrorToast('User profile not found');
//                       return;
//                     }

//                     final snapshot = UserDataStore.read(userId);

//                     final pets = snapshot == null
//                         ? <Map<String, dynamic>>[]
//                         : UserDataStore.petsOf(snapshot);

//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       backgroundColor: Colors.white,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(24),
//                         ),
//                       ),
//                       builder: (_) {
//                         return MyPetsSelectionSheet(
//                           pets: pets,

//                           onPetSelected: (pet) async {
//                             final adoptionCubit = context.read<AdoptionCubit>();

//                             Navigator.pop(context);

//                             final userId =
//                                 Supabase.instance.client.auth.currentUser?.id;

//                             if (userId == null) {
//                               context.showErrorToast('User profile not found');
//                               return;
//                             }

//                             debugPrint('========== CREATE ADOPTION ==========');

//                             debugPrint('Pet ID: ${pet['id']}');

//                             debugPrint('Pet Name: ${pet['name']}');

//                             debugPrint('Poster ID: $userId');

//                             final adoptionPost = AdoptionPostEntity(
//                               id: '',
//                               petId: pet['id'].toString(),
//                               posterId: userId,
//                               description: 'Pet available for adoption',
//                               status: 'available',
//                               location: '',
//                               createdAt: DateTime.now(),
//                               updatedAt: DateTime.now(),
//                             );

//                             await adoptionCubit.createAdoptionPost(
//                               adoptionPost: adoptionPost,
//                             );

//                             debugPrint(
//                               '========== CREATE ADOPTION FINISHED ==========',
//                             );

//                             debugPrint(
//                               'isPostCreated: '
//                               '${adoptionCubit.state.isPostCreated}',
//                             );

//                             debugPrint(
//                               'errorMessage: '
//                               '${adoptionCubit.state.errorMessage}',
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             );
//           },

//           backgroundColor: context.primary50,
//           elevation: 2,

//           icon: const Icon(Icons.add, color: Colors.white),

//           label: const Text(
//             'Adopt',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ),

//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

//       // =========================
//       // Body
//       // =========================
//       body: SafeArea(
//         child: Column(
//           children: [
//             AdoptionHeader(
//               userInitial: _getUserInitial(),
//               onNotificationTap: () {
//                 // TODO
//               },
//             ),

//             const SizedBox(height: 12),

//             PetCategoriesSection(onMoreCategoryTap: () {}),

//             const SizedBox(height: 12),

//             const AdoptionTabs(),

//             // =========================
//             // Adoption Posts
//             // =========================
//             Expanded(
//               child: BlocBuilder<AdoptionCubit, AdoptionState>(
//                 builder: (context, state) {
//                   // =========================
//                   // MY PETS
//                   // =========================
//                   if (state.selectedTabIndex == 1) {
//                     if (state.isLoadingMyAdoptionPets) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (state.myAdoptionPets.isEmpty) {
//                       return const Center(
//                         child: Text('You have no pets for adoption'),
//                       );
//                     }

//                     return ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: state.myAdoptionPets.length,
//                       itemBuilder: (context, index) {
//                         final pet = state.myAdoptionPets[index];

//                         return Card(
//                           margin: EdgeInsets.only(bottom: 16.h),
//                           child: ListTile(
//                             leading:
//                                 pet.imageUrl != null && pet.imageUrl!.isNotEmpty
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(10.r),
//                                     child: Image.network(
//                                       pet.imageUrl!,
//                                       width: 70.w,
//                                       height: 70.h,
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (_, __, ___) {
//                                         return Container(
//                                           width: 70.w,
//                                           height: 70.h,
//                                           color: context.neutral100,
//                                           child: Icon(
//                                             Icons.pets,
//                                             color: context.primary,
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   )
//                                 : Container(
//                                     width: 70.w,
//                                     height: 70.h,
//                                     color: context.neutral100,
//                                     child: Icon(
//                                       Icons.pets,
//                                       color: context.primary,
//                                     ),
//                                   ),
//                             title: Text(
//                               pet.name,
//                               style: context.body1.copyWith(
//                                 fontWeight: FontWeight.w700,
//                                 color: context.neutral700,
//                               ),
//                             ),
//                             subtitle: Padding(
//                               padding: EdgeInsets.only(top: 6.h),
//                               child: Text(
//                                 '${pet.location}\nRequests: ${pet.requestsCount}',
//                                 style: context.body2.copyWith(
//                                   color: context.neutral400,
//                                 ),
//                               ),
//                             ),
//                             trailing: Text(
//                               pet.status,
//                               style: context.body2.copyWith(
//                                 color: context.primary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }

//                   // =========================
//                   // FOR ADOPTION
//                   // =========================

//                   if (state.isLoadingPosts) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (state.errorMessage != null) {
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Text(
//                           state.errorMessage!,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                   }

//                   if (state.adoptionPetCards.isEmpty) {
//                     return const Center(
//                       child: Text('No pets available for adoption'),
//                     );
//                   }

//                   return ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: state.adoptionPetCards.length,
//                     itemBuilder: (context, index) {
//                       final card = state.adoptionPetCards[index];
//                       final imageUrl = card.imageUrl;

//                       return InkWell(
//                         onTap: () {
//                           context.router.root.push(PetDetailsRoute(pet: card));
//                         },
//                         borderRadius: BorderRadius.circular(16.r),
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: 16.h),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16.r),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.10),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // =========================
//                               // Image
//                               // =========================
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(16.r),
//                                 ),
//                                 child: SizedBox(
//                                   width: double.infinity,
//                                   height: 220.h,
//                                   child: imageUrl != null && imageUrl.isNotEmpty
//                                       ? Image.network(
//                                           imageUrl,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (_, __, ___) {
//                                             return Container(
//                                               color: context.neutral100,
//                                               child: Icon(
//                                                 Icons.pets,
//                                                 size: 60.r,
//                                                 color: context.primary,
//                                               ),
//                                             );
//                                           },
//                                         )
//                                       : Container(
//                                           color: context.neutral100,
//                                           child: Icon(
//                                             Icons.pets,
//                                             size: 60.r,
//                                             color: context.primary,
//                                           ),
//                                         ),
//                                 ),
//                               ),

//                               // =========================
//                               // Pet Info
//                               // =========================
//                               Padding(
//                                 padding: EdgeInsets.all(16.r),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       card.name,
//                                       style: context.body1.copyWith(
//                                         fontSize: 20.sp,
//                                         fontWeight: FontWeight.w700,
//                                         color: context.neutral700,
//                                       ),
//                                     ),

//                                     SizedBox(height: 8.h),

//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.location_on_outlined,
//                                           size: 20.r,
//                                           color: context.primary,
//                                         ),
//                                         SizedBox(width: 6.w),
//                                         Expanded(
//                                           child: Text(
//                                             card.location,
//                                             style: context.body2.copyWith(
//                                               color: context.neutral400,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),

//                                     SizedBox(height: 6.h),

//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.cake_outlined,
//                                           size: 20.r,
//                                           color: context.primary,
//                                         ),
//                                         SizedBox(width: 6.w),
//                                         Text(
//                                           AppDateUtils.formatAge(
//                                             card.birthdate,
//                                           ),
//                                           style: context.body2.copyWith(
//                                             color: context.neutral400,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),

//             // Expanded(
//             //   child: BlocBuilder<AdoptionCubit, AdoptionState>(
//             //     builder: (context, state) {
//             //       // Loading
//             //       if (state.isLoadingPosts) {
//             //         return const Center(child: CircularProgressIndicator());
//             //       }

//             //       // Error
//             //       if (state.errorMessage != null) {
//             //         return Center(
//             //           child: Padding(
//             //             padding: const EdgeInsets.all(24),
//             //             child: Text(
//             //               state.errorMessage!,
//             //               textAlign: TextAlign.center,
//             //             ),
//             //           ),
//             //         );
//             //       }

//             //       // Empty
//             //       if (state.adoptionPetCards.isEmpty) {
//             //         return const Center(
//             //           child: Text('No pets available for adoption'),
//             //         );
//             //       }

//             //       // Posts
//             //       return ListView.builder(
//             //         padding: const EdgeInsets.all(16),
//             //         itemCount: state.adoptionPetCards.length,
//             //         itemBuilder: (context, index) {
//             //           final card = state.adoptionPetCards[index];
//             //           final imageUrl = card.imageUrl;

//             //           return InkWell(
//             //             onTap: () {
//             //               context.router.root.push(PetDetailsRoute(pet: card));
//             //             },
//             //             borderRadius: BorderRadius.circular(16.r),
//             //             child: Container(
//             //               margin: EdgeInsets.only(bottom: 16.h),
//             //               decoration: BoxDecoration(
//             //                 color: Colors.white,
//             //                 borderRadius: BorderRadius.circular(16.r),
//             //                 boxShadow: [
//             //                   BoxShadow(
//             //                     color: Colors.black.withOpacity(0.10),
//             //                     blurRadius: 8,
//             //                     offset: const Offset(0, 3),
//             //                   ),
//             //                 ],
//             //               ),
//             //               child: Column(
//             //                 crossAxisAlignment: CrossAxisAlignment.start,
//             //                 children: [
//             //                   // =========================
//             //                   // Pet Image
//             //                   // =========================
//             //                   ClipRRect(
//             //                     borderRadius: BorderRadius.vertical(
//             //                       top: Radius.circular(16.r),
//             //                     ),
//             //                     child: SizedBox(
//             //                       width: double.infinity,
//             //                       height: 220.h,
//             //                       child: imageUrl != null && imageUrl.isNotEmpty
//             //                           ? Image.network(
//             //                               imageUrl,
//             //                               fit: BoxFit.cover,
//             //                               errorBuilder: (_, __, ___) {
//             //                                 return Container(
//             //                                   color: context.neutral100,
//             //                                   child: Icon(
//             //                                     Icons.pets,
//             //                                     size: 60.r,
//             //                                     color: context.primary,
//             //                                   ),
//             //                                 );
//             //                               },
//             //                             )
//             //                           : Container(
//             //                               color: context.neutral100,
//             //                               child: Icon(
//             //                                 Icons.pets,
//             //                                 size: 60.r,
//             //                                 color: context.primary,
//             //                               ),
//             //                             ),
//             //                     ),
//             //                   ),

//             //                   // =========================
//             //                   // Pet Info
//             //                   // =========================
//             //                   Padding(
//             //                     padding: EdgeInsets.all(16.r),
//             //                     child: Column(
//             //                       crossAxisAlignment: CrossAxisAlignment.start,
//             //                       children: [
//             //                         Text(
//             //                           card.name,
//             //                           style: context.body1.copyWith(
//             //                             fontSize: 20.sp,
//             //                             fontWeight: FontWeight.w700,
//             //                             color: context.neutral700,
//             //                           ),
//             //                         ),

//             //                         SizedBox(height: 8.h),

//             //                         Row(
//             //                           children: [
//             //                             Icon(
//             //                               Icons.location_on_outlined,
//             //                               size: 20.r,
//             //                               color: context.primary,
//             //                             ),
//             //                             SizedBox(width: 6.w),
//             //                             Expanded(
//             //                               child: Text(
//             //                                 card.location,
//             //                                 style: context.body2.copyWith(
//             //                                   color: context.neutral400,
//             //                                 ),
//             //                               ),
//             //                             ),
//             //                           ],
//             //                         ),

//             //                         SizedBox(height: 6.h),

//             //                         Row(
//             //                           children: [
//             //                             Icon(
//             //                               Icons.cake_outlined,
//             //                               size: 20.r,
//             //                               color: context.primary,
//             //                             ),
//             //                             SizedBox(width: 6.w),
//             //                             Text(
//             //                               _formatAge(card.birthdate),
//             //                               style: context.body2.copyWith(
//             //                                 color: context.neutral400,
//             //                               ),
//             //                             ),
//             //                           ],
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                 ],
//             //               ),
//             //             ),
//             //           );
//             //         },
//             //       );
//             //     },
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }


//   String _getUserInitial() {
//     final user = Supabase.instance.client.auth.currentUser;

//     if (user == null) {
//       return '?';
//     }

//     final metadata = user.userMetadata;

//     final name =
//         metadata?['name']?.toString() ??
//         metadata?['full_name']?.toString() ??
//         metadata?['username']?.toString() ??
//         user.email?.split('@').first ??
//         '';

//     if (name.trim().isEmpty) {
//       return '?';
//     }

//     return name.trim()[0].toUpperCase();
//   }
// }
