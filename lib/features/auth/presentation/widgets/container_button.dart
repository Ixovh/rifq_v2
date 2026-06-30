import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_theme.dart';

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
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
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
