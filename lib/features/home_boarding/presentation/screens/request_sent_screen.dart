import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/success_check_icon_widget.dart';

@RoutePage()
class RequestSentScreen extends StatelessWidget {
  const RequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SuccessCheckIcon(),
                      SizedBox(height: 24.h),
                      Text(
                        'Request Sent!',
                        style: context.h3.copyWith(
                          color: context.neutral1000,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Your home boarding request has been sent to the host.',
                        textAlign: TextAlign.center,
                        style: context.body2.copyWith(
                          color: context.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () =>
                      context.replaceRoute(const NavWrapperRoute()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: context.body1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
