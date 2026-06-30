import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rifq_v2/core/theme/app_color.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';

class PathButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const PathButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.body2.copyWith(color: context.primary500),

            ),
            SizedBox(width: 10.w),
            Icon(icon, color: AppColors.primary500),
          ],
        ),
      ),
    );
  }
}