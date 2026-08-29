import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key, required this.isGuest, this.firstName});

  final bool isGuest;
  final String? firstName;

  @override
  Widget build(BuildContext context) {
    final greetingStyle = context.h5.copyWith(
      color: context.neutral1000,
      fontWeight: FontWeight.w700,
    );
    final nameStyle = greetingStyle.copyWith(color: context.primary300);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: isGuest
          ? Text('Welcome', style: greetingStyle)
          : Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Hello, ', style: greetingStyle),
                  TextSpan(text: firstName ?? 'User', style: nameStyle),
                ],
              ),
            ),
    );
  }
}
