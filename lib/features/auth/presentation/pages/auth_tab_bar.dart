

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
class AuthTabBar extends StatelessWidget {
  /// this holds the tabs that are in auth_screen.dart
  const AuthTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: context.neutral200,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: TabBar(
        labelStyle: context.body2.copyWith(
          fontWeight: FontWeight.w600,
          color: context.neutral800,
        ),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: context.neutral100,
          borderRadius: BorderRadius.circular(50.r),
        ),
        tabs: const [
          Tab(text: 'Log in'),
          Tab(text: 'Sign up'),
        ],
      ),
    );
  }
}