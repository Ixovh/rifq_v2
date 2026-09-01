import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/shared/presentation/widgets/custom_bottom_sheet.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_form_builder_text_field.dart';

@RoutePage()
class SendsToEmailScreen extends StatelessWidget {
  const SendsToEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<AuthCubit>();
        final l10n = AppLocalizations.of(context)!;
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthPasswordResetEmailSentState _:
                context.pushRoute(
                  OtpRoute(
                    email: cubit.resetEmailController.text,
                    purpose: OtpPurpose.resetPassword,
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
                context.showErrorToast(state.msg);
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
                      l10n.auth_resetPasswordTitle,
                      style: context.h5.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: context.primary400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    l10n.auth_sendEmailPrompt,
                    style: context.body2.copyWith(color: context.neutral800),
                  ),
                  SizedBox(height: 24.h),
                  FormBuilder(
                    key: cubit.resetVerfiyEmailFormKey,
                    child: CustomFormBuilderTextField(
                      name: 'email',
                      label: l10n.common_email,
                      iconData: CupertinoIcons.mail_solid,
                      controller: cubit.resetEmailController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: l10n.auth_emailHintError,
                        ),
                        FormBuilderValidators.email(
                          errorText: l10n.auth_emailHintError,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  ContainerButton(
                    label: l10n.auth_verifyButton,
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
                    label: l10n.common_cancel,
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
