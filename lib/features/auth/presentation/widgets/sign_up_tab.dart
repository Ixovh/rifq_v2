import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_form_builder_text_field.dart';

class SignUpTab extends StatelessWidget {
  final String role;
  const SignUpTab({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(
          l10n.auth_signupPrompt,
          style: context.body1.copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 24.h),
        FormBuilder(
          key: cubit.sinUpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormBuilderTextField(
                name: 'name',
                label: l10n.common_name,
                iconData: CupertinoIcons.person_alt,
                controller: cubit.nameController,
              ),
              SizedBox(height: 24.h),
              CustomFormBuilderTextField(
                name: 'email',
                label: l10n.common_email,
                iconData: CupertinoIcons.mail_solid,
                controller: cubit.sinUpEmailController,
                validators: [
                  FormBuilderValidators.required(
                    errorText: l10n.auth_emailHintError,
                  ),
                  FormBuilderValidators.email(
                    errorText: l10n.auth_emailHintError,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CustomFormBuilderTextField(
                name: 'password',
                label: l10n.common_password,
                iconData: CupertinoIcons.lock_fill,
                controller: cubit.sinUpPasswordController,
                isPassword: true,
                validators: [
                  FormBuilderValidators.required(
                    errorText: l10n.auth_passwordError,
                  ),
                  FormBuilderValidators.minLength(
                    6,
                    errorText: l10n.auth_passwordRule,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ContainerButton(
          label: l10n.auth_signupButton,
          containerColor: context.primary300,
          textColor: context.neutral100,
          fontSize: 20,
          onTap: () async {
            if (cubit.sinUpFormKey.currentState?.saveAndValidate() ?? false) {
              await cubit.signUp(
                name: cubit.nameController.text,
                email: cubit.sinUpEmailController.text,
                password: cubit.sinUpPasswordController.text,
                role: role,
              );
              // await cubit.signUpWithOtp(
              //   name: cubit.nameController.text,
              //   email: cubit.sinUpEmailController.text,
              //   role: role,
              // );
            }
          },
        ),
        SizedBox(height: 24.h),
        RichText(
          text: TextSpan(
            text: l10n.auth_agreePrefix,
            style: context.body3.copyWith(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            children: <TextSpan>[
              TextSpan(
                text: l10n.auth_termsAndConditions,
                style: context.body3.copyWith(color: context.primary300),
              ),
              TextSpan(
                text: l10n.auth_agreeAnd,
                style: context.body3.copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              TextSpan(
                text: l10n.auth_privacyPolicy,
                style: context.body3.copyWith(color: context.primary300),
              ),
              TextSpan(
                text: '.',
                style: context.body3.copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
