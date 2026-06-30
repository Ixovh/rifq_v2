import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/container_button.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_bottom_sheet.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_form_builder_text_field.dart';

@RoutePage()
class SendsToEmailScreen extends StatelessWidget {
  const SendsToEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthPasswordResetEmailSentState _:
              context.pushRoute(
   OtpRoute(
    isResetPassword: true,
          email: cubit.resetEmailController.text,
  ),
);
                // context.push(
                //   Routes.otpScreen,
                //   extra: {"cubit": cubit, "isPassword": true},
                // );
                break;
              case AuthLoadingState _:
                Center(child: CircularProgressIndicator());
                break;
              case AuthErrorState _:
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.msg)));
                break;
              default:
                Center(child: CircularProgressIndicator());
                break;
            }
          },
          child: Scaffold(
            backgroundColor: context.neutral100,
            resizeToAvoidBottomInset: false,
            bottomSheet: CustomBottomSheet(
              content: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Text(
                      'Reset Password',
                      style: context.h5.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: context.primary400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    'Enter your email to verify and reset your password.',
                    style: context.body2.copyWith(color: context.neutral800),
                  ),
                  SizedBox(height: 24.h),
                  FormBuilder(
                    key: cubit.resetVerfiyEmailFormKey,
                    child: CustomFormBuilderTextField(
                      name: 'email',
                      label: 'Email',
                      iconData: CupertinoIcons.mail_solid,
                      controller: cubit.resetEmailController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: '(e.g., username@example.com).',
                        ),
                        FormBuilderValidators.email(
                          errorText: '(e.g., username@example.com).',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  ContainerButton(
                    label: 'verfiy',
                    containerColor: context.primary300,
                    textColor: context.neutral100,
                    fontSize: 20,
                    onTap: () async {
                      if (cubit.resetVerfiyEmailFormKey.currentState
                              ?.saveAndValidate() ??
                          false) {
                        await cubit.sendPasswordResetEmail(
                          email: cubit.resetEmailController.text,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 12.h),

                  ContainerButton(
                    label: 'Cancel',
                    containerColor: context.neutral100,
                    textColor: context.primary300,
                    fontSize: 20,
                    onTap: () {
                      context.maybePop();
                      // if (context.router.pop()) {
                      //   context.pop();
                      // }
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset('assets/icon/logo.svg'),
              ),
            ),
          ),
        );
      },
    );
  }
}
