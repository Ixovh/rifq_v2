// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_header_widget.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_option_sheet.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_tabs_widgets.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/my_pets_selection_sheet.dart';
// import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
// import 'package:rifq_v2/shared/presentation/router/app_router.dart';
// import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
// import 'package:rifq_v2/shared/service_locator/service_locator.dart';
// import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
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

// class _AdoptionView extends StatelessWidget {
//   const _AdoptionView();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
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
//                   onAddNewPet: () {
//                     final router = context.router;

//                     Navigator.pop(context);

//                     router.push(AddPetRoute(showAdoptionFields: true));
//                   },
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
//                               petId: pet['id'].toString(),
//                               posterId: userId,
//                               description: 'Pet available for adoption',
//                               status: 'available',
//                               location: '',
//                             );

//                             await adoptionCubit.createAdoptionPost(
//                               adoptionPost: adoptionPost,
//                             );

//                             debugPrint(
//                               '========== CREATE ADOPTION FINISHED ==========',
//                             );
//                             debugPrint(
//                               'isPostCreated: ${adoptionCubit.state.isPostCreated}',
//                             );
//                             debugPrint(
//                               'errorMessage: ${adoptionCubit.state.errorMessage}',
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
//       body: SafeArea(
//         child: Column(
//           children: [
//             AdoptionHeader(
//               onNotificationTap: () {
//                 // TODO
//               },
//             ),

//             const SizedBox(height: 12),

//             PetCategoriesSection(onMoreCategoryTap: () {}),

//             const SizedBox(height: 12),

//             const AdoptionTabs(),

//             const Expanded(child: SizedBox()),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    context.read<AdoptionCubit>().getAdoptionPosts();
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
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              builder: (_) {
                return AdoptionOptionSheet(
                  // =========================
                  // Add New Pet
                  // =========================
                  onAddNewPet: () {
                    final router = context.router;

                    Navigator.pop(context);

                    router.push(
                      AddPetRoute(
                        showAdoptionFields: true,
                      ),
                    );
                  },

                  // =========================
                  // Select My Pet
                  // =========================
                  onSelectMyPet: () {
                    Navigator.pop(context);

                    final userId =
                        Supabase.instance.client.auth.currentUser?.id;

                    if (userId == null) {
                      context.showErrorToast(
                        'User profile not found',
                      );
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
                            final adoptionCubit =
                                context.read<AdoptionCubit>();

                            Navigator.pop(context);

                            final userId = Supabase
                                .instance
                                .client
                                .auth
                                .currentUser
                                ?.id;

                            if (userId == null) {
                              context.showErrorToast(
                                'User profile not found',
                              );
                              return;
                            }

                            debugPrint(
                              '========== CREATE ADOPTION ==========',
                            );

                            debugPrint(
                              'Pet ID: ${pet['id']}',
                            );

                            debugPrint(
                              'Pet Name: ${pet['name']}',
                            );

                            debugPrint(
                              'Poster ID: $userId',
                            );

                            final adoptionPost =
                                AdoptionPostEntity(
                              id: '',
                              petId: pet['id'].toString(),
                              posterId: userId,
                              description:
                                  'Pet available for adoption',
                              status: 'available',
                              location: '',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            await adoptionCubit
                                .createAdoptionPost(
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

      floatingActionButtonLocation:
          FloatingActionButtonLocation.startFloat,

      // =========================
      // Body
      // =========================
      body: SafeArea(
        child: Column(
          children: [
            AdoptionHeader(
              onNotificationTap: () {
                // TODO
              },
            ),

            const SizedBox(height: 12),

            PetCategoriesSection(
              onMoreCategoryTap: () {},
            ),

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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
                  if (state.adoptionPosts.isEmpty) {
                    return const Center(
                      child: Text(
                        'No pets available for adoption',
                      ),
                    );
                  }

                  // Posts
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.adoptionPosts.length,
                    itemBuilder: (context, index) {
                      final post =
                          state.adoptionPosts[index];

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.pets),
                          ),

                          title: Text(
                            'Pet ID: ${post.petId}',
                          ),

                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),

                              Text(
                                post.description,
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Status: ${post.status}',
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
}