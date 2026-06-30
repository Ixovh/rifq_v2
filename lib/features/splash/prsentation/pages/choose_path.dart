import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/core/theme/app_color.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/core/widgets/button/path_button.dart';

@RoutePage()
class ChoosePathScreen extends StatelessWidget {
  const ChoosePathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary100, AppColors.primary50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 150.h),

                Image.asset('assets/images/logo (2).png', width: 250.w),

                SizedBox(height: 20.h),

                Text(
                  "Welcome to Rifq",
                  style: context.h3.copyWith(color: context.neutral100),
                ),

                SizedBox(height: 8.h),

                Text(
                  "making pet care simple for everyone",
                  textAlign: TextAlign.center,
                  style: context.body1.copyWith(color: context.neutral100),
                ),
              ],
            ),

            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose your path to start:",
                    style: context.body1.copyWith(color: context.neutral100),
                  ),
                ),
                SizedBox(height: 16.h),
                PathButton(
                  title: "I own a pet",
                  icon: Icons.pets,
            
                  onTap: () {
                    print("Pet button pressed");
                    context.router.push(OnbordingRoute(role: 'pet_owner'));
                  },
                ),

                SizedBox(height: 16.h),

                PathButton(
                  title: "I provide care services",
                  icon: Icons.add_circle_outline,
                  onTap: () {
    // context.router.push(OnbordingRoute(role: 'service_provider'));
  },
                ),

                SizedBox(height: 60.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
