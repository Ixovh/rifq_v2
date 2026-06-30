import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/core/widgets/custome_button_widgets.dart';
import 'package:rifq_v2/features/add_pet/presentation/cubit/add_pet_cubit.dart';
import 'package:rifq_v2/features/add_pet/presentation/widgets/add_pet_stepper.dart';
import 'package:rifq_v2/features/add_pet/presentation/widgets/step1_add_pet.dart';
import 'package:rifq_v2/features/add_pet/presentation/widgets/step2_add_pet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rifq_v2/core/di/configure_dependencies.dart';

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
  AddPetScreen({super.key});

  final PageController controller = PageController();
  final ValueNotifier<int> currentStep = ValueNotifier(0);
  final ValueNotifier<AddPetFormState> formState = ValueNotifier(
    const AddPetFormState(),
  );

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController breedCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _ = Supabase.instance.client;

    Future<String?> getOwnerId() async {
      final supabase = Supabase.instance.client;

      final authId = supabase.auth.currentUser?.id;

      if (authId == null) return null;

      final res = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authId)
          .maybeSingle();

      return res?['id'];
    }

    return BlocProvider(
      create: (_) => getIt<AddPetCubit>(),
      child: BlocListener<AddPetCubit, AddPetState>(
        listener: (context, state) {
          if (state is AddPetLoading) {
          } else if (state is AddPetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: context.green10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
                content: Text("Pet added successfully"),
              ),
            );
            Navigator.pop(context, true);
          } else if (state is AddPetFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Scaffold(
          backgroundColor: context.background,
          appBar: AppBar(
            backgroundColor: context.background,
            title: Text("Add Your Pet", style: context.body1),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back, color: context.neutral1000),
              onPressed: () {
                if (currentStep.value == 0) {
                  Navigator.pop(context);
                } else {
                  currentStep.value = 0;
                  controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 20),

              // ---------------stepper----------------
              ValueListenableBuilder<int>(
                valueListenable: currentStep,
                builder: (_, step, _) {
                  return AddPetStepper(currentStep: step);
                },
              ),

              // ---------------pages----------------
              Expanded(
                child: ValueListenableBuilder<AddPetFormState>(
                  valueListenable: formState,
                  builder: (_, form, _) {
                    return PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AddPetStepOne(
                          nameCtrl: nameCtrl,
                          selectedGender: form.gender,
                          photoFile: form.photoFile,
                          onImagePicked: (file) {
                            formState.value = formState.value.copyWith(
                              photoFile: file,
                            );
                          },
                          onGenderSelected: (g) {
                            formState.value = formState.value.copyWith(
                              gender: g,
                            );
                          },
                        ),
                        AddPetStepTwo(
                          breedCtrl: breedCtrl,
                          selectedSpecies: form.species,
                          selectedBirthdate: form.birthdate,
                          onSpeciesSelected: (s) {
                            formState.value = formState.value.copyWith(
                              species: s,
                            );
                          },
                          onBirthdateSelected: (d) {
                            formState.value = formState.value.copyWith(
                              birthdate: d,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder<int>(
                  valueListenable: currentStep,
                  builder: (context, step, _) {
                    return CustomeButtonWidgets(
                      titel: step == 1 ? "Save" : "Next",
                      onPressed: () async {
                        final form = formState.value;

                        if (step == 0) {
                          currentStep.value = 1;
                          controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                          return;
                        }

                        if (form.photoFile == null ||
                            nameCtrl.text.isEmpty ||
                            breedCtrl.text.isEmpty ||
                            form.gender.isEmpty ||
                            form.species.isEmpty ||
                            form.birthdate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please complete all fields"),
                            ),
                          );
                          return;
                        }

                        final ownerId = await getOwnerId();

                        if (ownerId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User profile not found")),
                          );
                          return;
                        }

                        context.read<AddPetCubit>().addPet(
                          ownerId: ownerId,
                          name: nameCtrl.text,
                          species: form.species,
                          gender: form.gender,
                          breed: breedCtrl.text,
                          birthdate: form.birthdate!,
                          photoFile: form.photoFile!,
                        );
                      },
                      buttonWidth: 366,
                      buttonhight: 58,
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
