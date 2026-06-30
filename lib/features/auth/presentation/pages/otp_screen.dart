import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/container_button.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_bottom_sheet.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  final bool? isResetPassword;
  final String email;
     const OtpScreen({super.key, this.isResetPassword = false,required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(GetIt.I.get<AuthUseCase>()),
    child:Builder( builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthSuccessState _:
                // context.replaceRoute(const HomeRoute());
                // context.go(Routes.home);
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
                crossAxisAlignment: .center,
                children: [
                  Text(
                    isResetPassword! ? 'Reset Password' : 'Email Verification',
                    style: context.h5.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: context.primary400,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    'We have sent an OTP to your email address',
                    style: context.body2.copyWith(color: context.neutral800),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    email,
                    // cubit.email!,
                    style: context.body2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    'Please enter the OTP below',
                    style: context.body2.copyWith(color: context.neutral800),
                  ),
                  SizedBox(height: 24.h),

                  Pinput(
                    defaultPinTheme: PinTheme(
                      width: 50.h,
                      height: 60.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: context.primary500),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    length: 6,
                    focusedPinTheme: PinTheme(
                      width: 50.h,
                      height: 60.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onCompleted: (pin) async {
                      if (!isResetPassword!) {
                        await cubit.verifyAccount(
                          email:email,
                          otp: pin,
                        );
                      } else {
                        context.pushRoute(const ResetPasswordRoute());
                        // context.push(Routes.resetPassword, extra:  cubit);
                      }
                    },
                  ),
                  Spacer(),
                  ContainerButton(
                    label: 'Cancel',
                    containerColor: context.neutral100,
                    textColor: context.primary300,
                    fontSize: 20,
                    onTap: () {
                      context.maybePop();
                      // if (context.canPop()) {
                      //   context.pop();
                      // }
                    },
                  ),
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
      )  );
  }
}
