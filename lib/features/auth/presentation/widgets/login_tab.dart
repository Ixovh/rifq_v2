import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/router/routers.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_form_builder_text_field.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(
          l10n.auth_loginPrompt,
          style: context.body1.copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 24.h),
        FormBuilder(
          key: cubit.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormBuilderTextField(
                name: 'email',
                label: l10n.common_email,
                iconData: CupertinoIcons.mail_solid,
                controller: cubit.loginEmailController,
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
                controller: cubit.loginPasswordController,
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
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () {
            context.pushRoute(const SendsToEmailRoute());
            // context.push(Routes.sendsToEmail, extra: cubit);
          },
          child: Text(
            l10n.auth_forgotPassword,
            style: context.body3.copyWith(color: context.primary300),
          ),
        ),
        SizedBox(height: 16.h),
        ContainerButton(
          label: l10n.auth_loginButton,
          containerColor: context.primary300,
          textColor: context.neutral100,
          fontSize: 20,
          onTap: () async {
            if (cubit.loginFormKey.currentState?.saveAndValidate() ?? false) {
              await cubit.login(
                email: cubit.loginEmailController.text,
                password: cubit.loginPasswordController.text,
              );
            }
          },
        ),
      ],
    );
  }
}
