import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/shared/constants/otp_purpose.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/shared/presentation/widgets/custom_bottom_sheet.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.email,
    this.purpose = OtpPurpose.signUp,
  });

  final String email;
  final OtpPurpose purpose;

  String get _title => switch (purpose) {
        OtpPurpose.resetPassword => 'Reset Password',
        OtpPurpose.emailChange => 'Confirm New Email',
        OtpPurpose.signUp => 'Email Verification',
      };

  bool get _canResend =>
      purpose == OtpPurpose.signUp || purpose == OtpPurpose.emailChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(GetIt.I.get<AuthUseCase>()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AuthCubit>();
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthSuccessState _:
                  if (purpose == OtpPurpose.emailChange) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email updated successfully'),
                      ),
                    );
                    context.router.popUntil(
                      (route) =>
                          route.settings.name == AccountRoute.name ||
                          route.isFirst,
                    );
                  } else {
                    context.replaceRoute(const NavWrapperRoute());
                  }
                  break;
                case AuthErrorState _:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.msg)),
                  );
                  break;
                default:
                  break;
              }
            },
            child: Scaffold(
              backgroundColor: context.neutral100,
              resizeToAvoidBottomInset: false,
              bottomSheet: CustomBottomSheet(
                content: _OtpContent(
                  title: _title,
                  email: email,
                  purpose: purpose,
                  canResend: _canResend,
                  onVerify: (pin) async {
                    if (purpose == OtpPurpose.resetPassword) {
                      context.pushRoute(const ResetPasswordRoute());
                      return;
                    }
                    await cubit.verifyOtp(
                      email: email,
                      otp: pin,
                      purpose: purpose,
                    );
                  },
                  onResend: () => cubit.resendOtp(
                    email: email,
                    purpose: purpose,
                  ),
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
      ),
    );
  }
}

class _OtpContent extends StatefulWidget {
  const _OtpContent({
    required this.title,
    required this.email,
    required this.purpose,
    required this.canResend,
    required this.onVerify,
    required this.onResend,
  });

  final String title;
  final String email;
  final OtpPurpose purpose;
  final bool canResend;
  final ValueChanged<String> onVerify;
  final VoidCallback onResend;

  @override
  State<_OtpContent> createState() => _OtpContentState();
}

class _OtpContentState extends State<_OtpContent> {
  static const int _resendSeconds = 60;

  Timer? _timer;
  int _remainingSeconds = _resendSeconds;
  bool _isResending = false;

  bool get _canTapResend =>
      widget.canResend && _remainingSeconds == 0 && !_isResending;

  @override
  void initState() {
    super.initState();
    if (widget.canResend) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _remainingSeconds = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() => _remainingSeconds = 0);
      } else {
        setState(() => _remainingSeconds -= 1);
      }
    });
  }

  String get _timerLabel {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _handleResend() async {
    if (!_canTapResend) return;
    setState(() => _isResending = true);
    widget.onResend();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpResentState) {
          setState(() => _isResending = false);
          _startTimer();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP sent again')),
          );
        } else if (state is AuthErrorState && _isResending) {
          setState(() => _isResending = false);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: context.h5.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: context.primary400,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.purpose == OtpPurpose.emailChange
                ? 'We have sent an OTP to your new email address'
                : 'We have sent an OTP to your email address',
            style: context.body2.copyWith(color: context.neutral800),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            widget.email,
            style: context.body2.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black,
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
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onCompleted: widget.onVerify,
          ),
          if (widget.canResend) ...[
            SizedBox(height: 20.h),
            if (_remainingSeconds > 0)
              Text(
                'Resend code in $_timerLabel',
                style: context.body2.copyWith(color: context.neutral800),
              )
            else
              TextButton(
                onPressed: _canTapResend ? _handleResend : null,
                child: Text(
                  _isResending ? 'Sending...' : 'Resend OTP',
                  style: context.body2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _canTapResend
                        ? context.primary300
                        : context.neutral800,
                  ),
                ),
              ),
          ],
          const Spacer(),
          ContainerButton(
            label: 'Cancel',
            containerColor: context.neutral100,
            textColor: context.primary300,
            fontSize: 20,
            onTap: () => context.maybePop(),
          ),
        ],
      ),
    );
  }
}
