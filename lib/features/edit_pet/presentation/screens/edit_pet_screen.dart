import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_outlined_field.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';
import 'package:rifq_v2/features/edit_pet/presentation/cubit/edit_pet_cubit.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:rifq_v2/shared/storage_service/profile_image_cache.dart';

@RoutePage()
class EditPetScreen extends StatelessWidget {
  const EditPetScreen({super.key, required this.petId});

  final String petId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<EditPetCubit>()..loadPet(petId),
      child: _EditPetView(petId: petId),
    );
  }
}

class _EditPetView extends StatefulWidget {
  const _EditPetView({required this.petId});

  final String petId;

  @override
  State<_EditPetView> createState() => _EditPetViewState();
}

class _EditPetViewState extends State<_EditPetView> {
  File? _pickedImage;

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (file == null || !mounted) return;
      final compressed = await ProfileImageCache.compress(File(file.path));
      if (!mounted) return;
      setState(() => _pickedImage = compressed);
    } catch (_) {
      if (!mounted) return;
      context.showErrorToast(
        AppLocalizations.of(context)!.common_couldNotPickImage,
      );
    }
  }

  void _showPhotoSheet({required bool hasPhoto}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(
                  AppLocalizations.of(context)!.common_chooseFromGallery,
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(AppLocalizations.of(context)!.common_takePhoto),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickBirthdate(EditPetCubit cubit) async {
    final picked = await showAppDatePicker(
      context: context,
      selectedDate: cubit.birthdate,
      title: AppLocalizations.of(context)!.common_chooseDateOfBirth,
    );
    if (picked != null) {
      cubit.setBirthdate(picked);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditPetCubit>();

    return BlocConsumer<EditPetCubit, EditPetState>(
      listener: (context, state) {
        if (state is EditPetUpdateSuccess) {
          context.showSuccessToast(
            AppLocalizations.of(context)!.editPet_updated,
          );
          context.router.maybePop(true);
        }
        if (state is EditPetError) {
          context.showErrorToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is EditPetLoading || state is EditPetInitial) {
          return const Scaffold(body: LottieLoding());
        }

        if (state is EditPetError && state.message.contains('not found')) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.router.maybePop(),
                child: Text(AppLocalizations.of(context)!.common_goBack),
              ),
            ),
          );
        }

        final pet = switch (state) {
          EditPetLoaded(:final pet) => pet,
          EditPetUpdating(:final pet) => pet,
          EditPetUpdateSuccess(:final pet) => pet,
          _ => null,
        };

        if (pet == null) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => cubit.loadPet(widget.petId),
                child: Text(AppLocalizations.of(context)!.common_retry),
              ),
            ),
          );
        }

        final isUpdating = state is EditPetUpdating;
        final photoUrl = pet.photoUrl;

        return Scaffold(
          backgroundColor: context.background,
          body: SafeArea(
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.router.maybePop(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20.sp,
                            color: context.neutral1000,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.editPet_title,
                            textAlign: TextAlign.center,
                            style: context.h4.copyWith(
                              color: context.primary300,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),
                          GestureDetector(
                            onTap: isUpdating
                                ? null
                                : () => _showPhotoSheet(
                                    hasPhoto:
                                        _pickedImage != null ||
                                        (photoUrl?.isNotEmpty ?? false),
                                  ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 166.w,
                                  height: 166.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.neutral100,
                                    border: Border.all(
                                      color: context.primary300,
                                      width: 2,
                                    ),
                                    image: _pickedImage != null
                                        ? DecorationImage(
                                            image: FileImage(_pickedImage!),
                                            fit: BoxFit.cover,
                                          )
                                        : photoUrl != null &&
                                              photoUrl.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(photoUrl),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child:
                                      _pickedImage == null &&
                                          (photoUrl == null || photoUrl.isEmpty)
                                      ? Icon(
                                          Icons.pets,
                                          size: 48.sp,
                                          color: context.primary300,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  right: 8.w,
                                  bottom: 8.h,
                                  child: Container(
                                    width: 38.w,
                                    height: 33.h,
                                    decoration: BoxDecoration(
                                      color: context.primary300,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Icon(
                                      Icons.edit_outlined,
                                      color: context.neutral100,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 48.h),
                          AccountOutlinedField(
                            label: AppLocalizations.of(
                              context,
                            )!.editPet_nameLabel,
                            controller: cubit.nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.common_nameRequired;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 42.h),
                          _BirthdateField(
                            birthdate: cubit.birthdate,
                            onTap: isUpdating
                                ? null
                                : () => _pickBirthdate(cubit),
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: AppLocalizations.of(
                              context,
                            )!.editPet_breedLabel,
                            controller: cubit.breedController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.editPet_breedRequired;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: AppLocalizations.of(
                              context,
                            )!.editPet_weightLabel,
                            controller: cubit.weightController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.,]'),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 24.h),
                    child: ContainerButton(
                      label: AppLocalizations.of(context)!.common_save,
                      containerColor: context.primary300,
                      textColor: context.neutral100,
                      fontSize: 20,
                      isLoading: isUpdating,
                      onTap: () => cubit.savePet(
                        petId: widget.petId,
                        photoFile: _pickedImage,
                        ageRequiredMessage: AppLocalizations.of(
                          context,
                        )!.editPet_ageRequired,
                        invalidWeightMessage: AppLocalizations.of(
                          context,
                        )!.editPet_invalidWeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BirthdateField extends StatelessWidget {
  const _BirthdateField({required this.birthdate, required this.onTap});

  final DateTime? birthdate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasDate = birthdate != null;
    final label = hasDate
        ? DateFormat('dd-MM-yyyy').format(birthdate!)
        : AppLocalizations.of(context)!.common_chooseDate;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: context.neutral100,
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              height: 56.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: context.neutral200),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: hasDate ? context.primary300 : context.neutral600,
                    size: 24.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    label,
                    style: context.body2.copyWith(
                      color: hasDate ? context.neutral1000 : context.neutral500,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          start: 22.w,
          top: -10.h,
          child: Container(
            color: context.neutral100,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              AppLocalizations.of(context)!.editPet_ageLabel,
              style: context.body2.copyWith(
                color: context.neutral700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
