import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/presentation/widgets/custome_button_widgets.dart';
import 'package:rifq_v2/features/add_pet/presentation/cubit/add_pet_cubit.dart';
import 'package:rifq_v2/features/add_pet/presentation/widgets/add_pet_stepper.dart';
import 'package:rifq_v2/shared/presentation/widgets/step1_add_pet.dart';
import 'package:rifq_v2/features/add_pet/presentation/widgets/step2_add_pet.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddPetFormState {
  final String gender;
  final String species;
  final DateTime? birthdate;
  final File? photoFile;

  const AddPetFormState({
    this.gender = '',
    this.species = '',
    this.birthdate,
    this.photoFile,
  });

  AddPetFormState copyWith({
    String? gender,
    String? species,
    DateTime? birthdate,
    File? photoFile,
  }) {
    return AddPetFormState(
      gender: gender ?? this.gender,
      species: species ?? this.species,
      birthdate: birthdate ?? this.birthdate,
      photoFile: photoFile ?? this.photoFile,
    );
  }
}

@RoutePage()
class AddPetScreen extends StatelessWidget {
  AddPetScreen({
    super.key,
    this.showAdoptionFields = false,
  });

  final PageController controller = PageController();

  final ValueNotifier<int> currentStep = ValueNotifier(0);

  final ValueNotifier<AddPetFormState> formState = ValueNotifier(
    const AddPetFormState(),
  );

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController breedCtrl = TextEditingController();

  final bool showAdoptionFields;

  final TextEditingController locationCtrl = TextEditingController();
  String? adoptionPhoneNumber;

  // ID للحيوان الذي تمت إضافته جديدًا من صفحة التبني.
  // نحتاجه فقط لحذفه من UserDataStore بعد نجاح إنشاء adoption post.
  String? newlyCreatedPetId;

  @override
  Widget build(BuildContext context) {
    Future<String?> getOwnerId() async {
      return Supabase.instance.client.auth.currentUser?.id;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AddPetCubit>(),
        ),

        if (showAdoptionFields)
          BlocProvider(
            create: (_) => getIt<AdoptionCubit>(),
          ),
      ],

      child: MultiBlocListener(
        listeners: [
          // ============================================================
          // Add Pet Listener
          // ============================================================
          BlocListener<AddPetCubit, AddPetState>(
            listener: (context, state) async {
              // ========================================================
              // فشل إضافة الحيوان
              // ========================================================
              if (state is AddPetFailure) {
                context.showErrorToast(state.error);
                return;
              }

              // ========================================================
              // نجحت إضافة الحيوان
              // ========================================================
              if (state is AddPetSuccess) {
                // ======================================================
                // 1. إضافة حيوان عادي
                // ======================================================
                if (!showAdoptionFields) {
                  context.showSuccessToast(
                    'Pet added successfully',
                  );

                  Navigator.pop(context, true);
                  return;
                }

                // ======================================================
                // 2. إضافة حيوان جديد للتبني
                // ======================================================

                // نحفظ ID الحيوان الجديد
                newlyCreatedPetId = state.pet.id;

                final ownerId =
                    Supabase.instance.client.auth.currentUser?.id;

                if (ownerId == null) {
                  context.showErrorToast(
                    'User profile not found',
                  );
                  return;
                }

                final phone = adoptionPhoneNumber?.trim();
                if (phone != null && phone.isNotEmpty) {
                  await Supabase.instance.client
                      .from('profiles')
                      .update({'phone_number': phone})
                      .eq('id', ownerId);
                  await UserDataStore.mergeProfileFields(ownerId, {
                    'phone_number': phone,
                  });
                }

                debugPrint(
                  '========================================',
                );
                debugPrint(
                  'NEW PET CREATED FOR ADOPTION',
                );
                debugPrint(
                  'Pet ID: ${state.pet.id}',
                );
                debugPrint(
                  'Pet Name: ${state.pet.name}',
                );
                debugPrint(
                  'Owner ID: $ownerId',
                );
                debugPrint(
                  'Location: ${locationCtrl.text.trim()}',
                );
                debugPrint(
                  '========================================',
                );

                // ======================================================
                // إنشاء adoption post للحيوان الجديد
                // ======================================================
                await context.read<AdoptionCubit>().createAdoptionPost(
                  adoptionPost: AdoptionPostEntity(
                    petId: state.pet.id,
                    posterId: ownerId,
                    description: '',
                    status: 'available',
                    location: locationCtrl.text.trim(),
                  ),
                );
              }
            },
          ),

          // ============================================================
          // Adoption Post Listener
          // ============================================================
          if (showAdoptionFields)
            BlocListener<AdoptionCubit, AdoptionState>(
              listener: (context, state) async {
                // ======================================================
                // نجح إنشاء منشور التبني
                // ======================================================
                if (state.isPostCreated) {
                  final ownerId =
                      Supabase.instance.client.auth.currentUser?.id;

                  if (ownerId == null) {
                    context.showErrorToast(
                      'User profile not found',
                    );
                    return;
                  }

                  // ====================================================
                  // نحذف الحيوان من الكاش المحلي فقط
                  //
                  // مهم:
                  // هذا لا يحذف الحيوان من جدول pets في Supabase.
                  // فقط يمنعه من الظهور في UserDataStore.petsOf()
                  // ====================================================
                  if (newlyCreatedPetId != null) {
                    await UserDataStore.removePet(
                      ownerId,
                      newlyCreatedPetId!,
                    );

                    debugPrint(
                      'Removed pet from local UserDataStore: '
                      '$newlyCreatedPetId',
                    );
                  }

                  context.showSuccessToast(
                    'Pet added to adoption successfully',
                  );

                  Navigator.pop(context, true);

                  return;
                }

                // ======================================================
                // فشل إنشاء منشور التبني
                // ======================================================
                if (state.errorMessage != null) {
                  context.showErrorToast(
                    state.errorMessage!,
                  );
                }
              },
            ),
        ],

        // ==============================================================
        // Screen
        // ==============================================================
        child: Scaffold(
          backgroundColor: context.background,

          // ============================================================
          // App Bar
          // ============================================================
          appBar: AppBar(
            backgroundColor: context.background,
            title: Text(
              "Add Your Pet",
              style: context.body1,
            ),
            centerTitle: true,

            leading: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: context.neutral1000,
              ),
              onPressed: () {
                if (currentStep.value == 0) {
                  Navigator.pop(context);
                } else {
                  currentStep.value = 0;

                  controller.previousPage(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.ease,
                  );
                }
              },
            ),
          ),

          // ============================================================
          // Body
          // ============================================================
          body: Column(
            children: [
              const SizedBox(height: 20),

              // ========================================================
              // Stepper
              // ========================================================
              ValueListenableBuilder<int>(
                valueListenable: currentStep,
                builder: (_, step, _) {
                  return AddPetStepper(
                    currentStep: step,
                  );
                },
              ),

              // ========================================================
              // Pages
              // ========================================================
              Expanded(
                child: ValueListenableBuilder<AddPetFormState>(
                  valueListenable: formState,
                  builder: (_, form, _) {
                    return PageView(
                      controller: controller,
                      physics:
                          const NeverScrollableScrollPhysics(),

                      children: [
                        // ==================================================
                        // Step 1
                        // ==================================================
                        AddPetStepOne(
                          nameCtrl: nameCtrl,

                          selectedGender: form.gender,

                          photoFile: form.photoFile,

                          showAdoptionFields:
                              showAdoptionFields,

                          locationCtrl: locationCtrl,

                          initialPhone: adoptionPhoneNumber,

                          onPhoneChanged: (phone) {
                            adoptionPhoneNumber = phone;
                          },

                          onImagePicked: (file) {
                            formState.value =
                                formState.value.copyWith(
                              photoFile: file,
                            );
                          },

                          onGenderSelected: (gender) {
                            formState.value =
                                formState.value.copyWith(
                              gender: gender,
                            );
                          },
                        ),

                        // ==================================================
                        // Step 2
                        // ==================================================
                        AddPetStepTwo(
                          breedCtrl: breedCtrl,

                          selectedSpecies: form.species,

                          selectedBirthdate:
                              form.birthdate,

                          onSpeciesSelected: (species) {
                            formState.value =
                                formState.value.copyWith(
                              species: species,
                            );
                          },

                          onBirthdateSelected: (birthdate) {
                            formState.value =
                                formState.value.copyWith(
                              birthdate: birthdate,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ========================================================
              // Bottom Button
              // ========================================================
              Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder<int>(
                  valueListenable: currentStep,

                  builder: (context, step, _) {
                    return BlocBuilder<AddPetCubit, AddPetState>(
                      builder: (context, state) {
                        return CustomeButtonWidgets(
                          titel: step == 1
                              ? "Save"
                              : "Next",

                          isLoading:
                              state is AddPetLoading,

                          onPressed: () async {
                            final form = formState.value;

                            // ==================================================
                            // Step 1 -> Step 2
                            // ==================================================
                            if (step == 0) {
                              currentStep.value = 1;

                              controller.nextPage(
                                duration: const Duration(
                                  milliseconds: 300,
                                ),
                                curve: Curves.ease,
                              );

                              return;
                            }

                            // ==================================================
                            // Validation
                            // ==================================================
                            if (form.photoFile == null ||
                                nameCtrl.text.trim().isEmpty ||
                                breedCtrl.text.trim().isEmpty ||
                                form.gender.isEmpty ||
                                form.species.isEmpty ||
                                form.birthdate == null) {
                              context.showWarningToast(
                                'Please complete all fields',
                              );

                              return;
                            }

                            if (showAdoptionFields &&
                                (locationCtrl.text.trim().isEmpty ||
                                    (adoptionPhoneNumber ?? '').isEmpty)) {
                              context.showWarningToast(
                                'Please enter location and phone number',
                              );
                              return;
                            }

                            // ==================================================
                            // Get owner
                            // ==================================================
                            final ownerId =
                                await getOwnerId();

                            if (ownerId == null) {
                              if (!context.mounted) {
                                return;
                              }

                              context.showErrorToast(
                                'User profile not found',
                              );

                              return;
                            }

                            // ==================================================
                            // Add Pet
                            //
                            // هنا ما نفرق:
                            // سواء عادي أو للتبني، نضيف الحيوان
                            // عن طريق AddPetCubit كالمعتاد.
                            //
                            // إذا كان للتبني:
                            // AddPetSuccess -> AdoptionCubit
                            // ==================================================
                            context
                                .read<AddPetCubit>()
                                .addPet(
                              ownerId: ownerId,

                              name: nameCtrl.text.trim(),

                              species: form.species,

                              gender: form.gender,

                              breed: breedCtrl.text.trim(),

                              birthdate:
                                  form.birthdate!,

                              photoFile:
                                  form.photoFile!,
                            );
                          },

                          buttonWidth: 366,

                          buttonhight: 58,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// import 'dart:io';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
// import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
// import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
// import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
// import 'package:rifq_v2/shared/presentation/widgets/custome_button_widgets.dart';
// import 'package:rifq_v2/features/add_pet/presentation/cubit/add_pet_cubit.dart';
// import 'package:rifq_v2/features/add_pet/presentation/widgets/add_pet_stepper.dart';
// import 'package:rifq_v2/shared/presentation/widgets/step1_add_pet.dart';
// import 'package:rifq_v2/features/add_pet/presentation/widgets/step2_add_pet.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:rifq_v2/shared/service_locator/service_locator.dart';

// class AddPetFormState {
//   final String gender;
//   final String species;
//   final DateTime? birthdate;
//   final File? photoFile;

//   const AddPetFormState({
//     this.gender = '',
//     this.species = '',
//     this.birthdate,
//     this.photoFile,
//   });

//   AddPetFormState copyWith({
//     String? gender,
//     String? species,
//     DateTime? birthdate,
//     File? photoFile,
//   }) {
//     return AddPetFormState(
//       gender: gender ?? this.gender,
//       species: species ?? this.species,
//       birthdate: birthdate ?? this.birthdate,
//       photoFile: photoFile ?? this.photoFile,
//     );
//   }
// }

// @RoutePage()
// class AddPetScreen extends StatelessWidget {
//   AddPetScreen({super.key, this.showAdoptionFields = false});

//   final PageController controller = PageController();
//   final ValueNotifier<int> currentStep = ValueNotifier(0);
//   final ValueNotifier<AddPetFormState> formState = ValueNotifier(
//     const AddPetFormState(),
//   );

//   final TextEditingController nameCtrl = TextEditingController();
//   final TextEditingController breedCtrl = TextEditingController();

//   final bool showAdoptionFields;
//   final TextEditingController locationCtrl = TextEditingController();
//   final TextEditingController phoneCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final _ = Supabase.instance.client;

//     Future<String?> getOwnerId() async {
//       // profiles.id matches auth.users.id
//       return Supabase.instance.client.auth.currentUser?.id;
//     }

// return MultiBlocProvider(
//   providers: [
//     BlocProvider(
//       create: (_) => getIt<AddPetCubit>(),
//     ),
//     if (showAdoptionFields)
//       BlocProvider(
//         create: (_) => getIt<AdoptionCubit>(),
//       ),
//   ],
//   child: MultiBlocListener(
//   listeners: [
//     BlocListener<AddPetCubit, AddPetState>(
//       listener: (context, state) async {
//         if (state is AddPetSuccess) {
//           // =========================
//           // إضافة حيوان عادي
//           // =========================
//           if (!showAdoptionFields) {
//             context.showSuccessToast('Pet added successfully');
//             Navigator.pop(context, true);
//             return;
//           }

//           // =========================
//           // إضافة حيوان جديد للتبني
//           // =========================
//           final ownerId =
//               Supabase.instance.client.auth.currentUser?.id;

//           if (ownerId == null) {
//             context.showErrorToast('User profile not found');
//             return;
//           }

//           await context.read<AdoptionCubit>().createAdoptionPost(
//             adoptionPost: AdoptionPostEntity(
//               petId: state.pet.id,
//               posterId: ownerId,
//               description: '',
//               status: 'available',
//               location: locationCtrl.text.trim(),
//             ),
//           );
//         }

//         if (state is AddPetFailure) {
//           context.showErrorToast(state.error);
//         }
//       },
//     ),

//     // =========================
//     // Adoption Post Listener
//     // =========================
//     if (showAdoptionFields)
//       BlocListener<AdoptionCubit, AdoptionState>(
//         listener: (context, state) {
//           if (state.isPostCreated) {
//             context.showSuccessToast(
//               'Pet added to adoption successfully',
//             );

//             Navigator.pop(context, true);
//           }

//           if (state.errorMessage != null) {
//             context.showErrorToast(state.errorMessage!);
//           }
//         },
//       ),
//   ],
//   // child: Scaffold(
//   // child: BlocListener<AddPetCubit, AddPetState>(
//   //       listener: (context, state) {
//   //         if (state is AddPetLoading) {
//   //         }
//   //          else if (state is AddPetSuccess) {
//   //           context.showSuccessToast('Pet added successfully');
//   //           Navigator.pop(context, true);
//   //         } 
//   //         else if (state is AddPetFailure) {
//   //           context.showErrorToast(state.error);
//   //         }
//   //       },
  
//         child: Scaffold(
//           backgroundColor: context.background,
//           appBar: AppBar(
//             backgroundColor: context.background,
//             title: Text("Add Your Pet", style: context.body1),
//             centerTitle: true,
//             leading: IconButton(
//               icon: Icon(CupertinoIcons.back, color: context.neutral1000),
//               onPressed: () {
//                 if (currentStep.value == 0) {
//                   Navigator.pop(context);
//                 } else {
//                   currentStep.value = 0;
//                   controller.previousPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.ease,
//                   );
//                 }
//               },
//             ),
//           ),
//           body: Column(
//             children: [
//               SizedBox(height: 20),

//               // ---------------stepper----------------
//               ValueListenableBuilder<int>(
//                 valueListenable: currentStep,
//                 builder: (_, step, _) {
//                   return AddPetStepper(currentStep: step);
//                 },
//               ),

//               // ---------------pages----------------
//               Expanded(
//                 child: ValueListenableBuilder<AddPetFormState>(
//                   valueListenable: formState,
//                   builder: (_, form, _) {
//                     return PageView(
//                       controller: controller,
//                       physics: const NeverScrollableScrollPhysics(),
//                       children: [
//                         AddPetStepOne(
//                           nameCtrl: nameCtrl,
//                           selectedGender: form.gender,
//                           photoFile: form.photoFile,
//                           showAdoptionFields: showAdoptionFields,
//                           locationCtrl: locationCtrl,
//                           phoneCtrl: phoneCtrl,
//                           onImagePicked: (file) {
//                             formState.value = formState.value.copyWith(
//                               photoFile: file,
//                             );
//                           },
//                           onGenderSelected: (g) {
//                             formState.value = formState.value.copyWith(
//                               gender: g,
//                             );
//                           },
//                         ),
//                         AddPetStepTwo(
//                           breedCtrl: breedCtrl,
//                           selectedSpecies: form.species,
//                           selectedBirthdate: form.birthdate,
//                           onSpeciesSelected: (s) {
//                             formState.value = formState.value.copyWith(
//                               species: s,
//                             );
//                           },
//                           onBirthdateSelected: (d) {
//                             formState.value = formState.value.copyWith(
//                               birthdate: d,
//                             );
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: ValueListenableBuilder<int>(
//                   valueListenable: currentStep,
//                   builder: (context, step, _) {
//                     return BlocBuilder<AddPetCubit, AddPetState>(
//                       builder: (context, state) {
//                         return CustomeButtonWidgets(
//                           titel: step == 1 ? "Save" : "Next",
//                           isLoading: state is AddPetLoading,
//                           onPressed: () async {
//                             final form = formState.value;

//                             if (step == 0) {
//                               currentStep.value = 1;
//                               controller.nextPage(
//                                 duration: Duration(milliseconds: 300),
//                                 curve: Curves.ease,
//                               );
//                               return;
//                             }

//                             if (form.photoFile == null ||
//                                 nameCtrl.text.isEmpty ||
//                                 breedCtrl.text.isEmpty ||
//                                 form.gender.isEmpty ||
//                                 form.species.isEmpty ||
//                                 form.birthdate == null) {
//                               context.showWarningToast(
//                                 'Please complete all fields',
//                               );
//                               return;
//                             }

//                             final ownerId = await getOwnerId();

//                             if (ownerId == null) {
//                               if (!context.mounted) return;
//                               context.showErrorToast('User profile not found');
//                               return;
//                             }

//                             context.read<AddPetCubit>().addPet(
//                               ownerId: ownerId,
//                               name: nameCtrl.text,
//                               species: form.species,
//                               gender: form.gender,
//                               breed: breedCtrl.text,
//                               birthdate: form.birthdate!,
//                               photoFile: form.photoFile!,
//                             );
//                           },
//                           buttonWidth: 366,
//                           buttonhight: 58,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
