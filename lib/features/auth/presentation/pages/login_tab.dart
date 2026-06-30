import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/core/navigation/routers.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/container_button.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_form_builder_text_field.dart';


class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(
          'Please enter your email and Password.',
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
                label: 'Email',
                iconData: CupertinoIcons.mail_solid,
                controller: cubit.loginEmailController,
                validators: [
                  FormBuilderValidators.required(
                    errorText: '(e.g., username@example.com).',
                  ),
                  FormBuilderValidators.email(
                    errorText: '(e.g., username@example.com).',
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CustomFormBuilderTextField(
                name: 'password',
                label: 'Password',
                iconData: CupertinoIcons.lock_fill,
                controller: cubit.loginPasswordController,
                isPassword: true,
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Incorrect password. Please try again.',
                  ),
                  FormBuilderValidators.minLength(
                    6,
                    errorText:
                        'Includes at least one number or symbol (e.g., @, #, \$, !).',
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () {
            context.pushRoute(
  const SendsToEmailRoute(),
);
            // context.push(Routes.sendsToEmail, extra: cubit);
          },
          child: Text(
            'Forgot password?',
            style: context.body3.copyWith(color: context.primary300),
          ),
        ),
        SizedBox(height: 16.h),
        ContainerButton(
          label: 'Log in',
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
