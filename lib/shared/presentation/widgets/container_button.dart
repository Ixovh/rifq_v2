import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rifq_v2/shared/presentation/theme/app_color.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    required this.label,
    required this.containerColor,
    required this.textColor,
    required this.fontSize,
    this.width = 366,
    this.height = 58,
    this.onTap,
    this.borderColor = AppColors.primary300,
    this.isLoading = false,
  });
  final String label;
  final Color containerColor;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final double width;
  final double height;
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: borderColor, width: 2.w),
          borderRadius: BorderRadius.circular(250.r),
        ),
        child: Center(
          child: isLoading
              ? Lottie.asset(
                  'assets/lottie/Lovely cats.json',
                  height: (height - 12).h,
                  fit: BoxFit.contain,
                )
              : Text(
                  label,
                  style: context.bodyLarge.copyWith(
                    color: textColor,
                    fontSize: fontSize.sp,
                  ),
                ),
        ),
      ),
    );
  }
}
