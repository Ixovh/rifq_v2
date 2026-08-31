import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/account/presentation/cubit/account_cubit.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_avatar.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_outlined_field.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_phone_field.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:rifq_v2/shared/storage_service/profile_image_cache.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_back_icon.dart';

@RoutePage()
class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AccountCubit>()..loadAccount(),
      child: const _EditAccountView(),
    );
  }
}

class _EditAccountView extends StatefulWidget {
  const _EditAccountView();

  @override
  State<_EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<_EditAccountView> {
  File? _pickedImage;
  var _removeImage = false;

  Future<void> _pickProfileImage(ImageSource source) async {
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
      setState(() {
        _pickedImage = compressed;
        _removeImage = false;
      });
    } catch (_) {
      if (!mounted) return;
      context.showErrorToast(AppLocalizations.of(context)!.common_couldNotPickImage);
    }
  }

  void _removeProfileImage() {
    setState(() {
      _pickedImage = null;
      _removeImage = true;
    });
  }

  void _showImageSourceSheet({required bool hasPhoto}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(AppLocalizations.of(context)!.common_chooseFromGallery),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickProfileImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(AppLocalizations.of(context)!.common_takePhoto),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickProfileImage(ImageSource.camera);
                },
              ),
              if (hasPhoto)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFFF383C),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.common_removePhoto,
                    style: const TextStyle(color: Color(0xFFFF383C)),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _removeProfileImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountCubit>();

    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) async {
        if (state is AccountUpdateSuccessState) {
          if (state.emailConfirmationPending &&
              (state.pendingEmail?.isNotEmpty ?? false)) {
            context.showInfoToast(AppLocalizations.of(context)!.editProfile_otpSentNewEmail);
            await context.pushRoute(
              OtpRoute(
                email: state.pendingEmail!,
                purpose: OtpPurpose.emailChange,
              ),
            );
            if (context.mounted) {
              context.router.maybePop(true);
            }
            return;
          }

          context.showSuccessToast(AppLocalizations.of(context)!.editProfile_profileUpdated);
          context.router.maybePop(true);
        }
        if (state is AccountErrorState) {
          context.showErrorToast(state.msg);
        }
      },
      builder: (context, state) {
        if (state is AccountLoading || state is AccountInitial) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: LottieLoding(),
          );
        }

        if (state is AccountGuestState) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.router.maybePop(),
                child: Text(AppLocalizations.of(context)!.editProfile_signInToEdit),
              ),
            ),
          );
        }

        final isUpdating = state is AccountUpdatingState;
        final profile = state is AccountLoadedState
            ? state.data.profile
            : state is AccountUpdatingState
            ? state.data.profile
            : state is AccountUpdateSuccessState
            ? state.data.profile
            : null;

        if (profile == null) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => cubit.loadAccount(),
                child: Text(AppLocalizations.of(context)!.common_retry),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: context.background,
          body: SafeArea(
            child: Form(
              key: cubit.editFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.router.maybePop(),
                          icon: AppBackIcon(color: context.neutral1000, size: 20.sp),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.editProfile_title,
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
                          AccountAvatar(
                            initials: profile.initials,
                            avatarUrl: _removeImage ? null : profile.avatarUrl,
                            localImage: _pickedImage,
                            size: 157,
                            showEditBadge: true,
                            onEditTap: isUpdating
                                ? null
                                : () => _showImageSourceSheet(
                                    hasPhoto:
                                        !_removeImage &&
                                        (_pickedImage != null ||
                                            (profile.avatarUrl?.isNotEmpty ??
                                                false)),
                                  ),
                          ),
                          SizedBox(height: 48.h),
                          AccountOutlinedField(
                            label: AppLocalizations.of(context)!.common_firstName,
                            controller: cubit.firstNameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(context)!.editProfile_firstNameRequired;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: AppLocalizations.of(context)!.common_lastName,
                            controller: cubit.lastNameController,
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: AppLocalizations.of(context)!.common_email,
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              final email = value?.trim() ?? '';
                              if (email.isEmpty) return AppLocalizations.of(context)!.editProfile_emailRequired;
                              final emailRegex = RegExp(
                                r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                              );
                              if (!emailRegex.hasMatch(email)) {
                                return AppLocalizations.of(context)!.common_invalidEmail;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 42.h),
                          AccountPhoneField(
                            initialValue: cubit.phoneController.text,
                            onChanged: (phone) {
                              cubit.phoneController.text = phone.number.isEmpty
                                  ? ''
                                  : phone.completeNumber;
                            },
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
                      onTap: () {
                        if (cubit.editFormKey.currentState?.validate() ??
                            false) {
                          final l10n = AppLocalizations.of(context)!;
                          cubit.saveProfile(
                            imageFile: _pickedImage,
                            removeImage: _removeImage,
                            firstNameRequiredMessage:
                                l10n.editProfile_firstNameRequired,
                            emailRequiredMessage: l10n.editProfile_emailRequired,
                            invalidEmailMessage: l10n.common_invalidEmail,
                          );
                        }
                      },
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
