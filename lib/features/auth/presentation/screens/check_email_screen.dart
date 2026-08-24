import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/container_button.dart';

@RoutePage()
class CheckEmailScreen extends StatelessWidget {
  final String email;
  const CheckEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.neutral100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mark_email_read_outlined, size: 80.r, color: context.primary300),
              SizedBox(height: 24.h),
              Text('تحقق من بريدك', style: context.h5),
              SizedBox(height: 8.h),
              Text(
                'أرسلنا رابط تفعيل إلى $email\nاضغط عليه من جوالك لتفعيل حسابك',
                textAlign: TextAlign.center,
                style: context.body2.copyWith(color: context.neutral800),
              ),
              SizedBox(height: 32.h),
              ContainerButton(
                label: 'رجوع لتسجيل الدخول',
                containerColor: context.primary300,
                textColor: context.neutral100,
                fontSize: 18,
                onTap: () => context.router.popUntilRoot(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}