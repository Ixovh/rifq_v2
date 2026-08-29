import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class QuickService extends StatelessWidget {
  const QuickService({
    super.key,
    required this.assetPath,
    required this.title,
    required this.onTap,
  });

  final String assetPath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.r);

    return Container(
      width: 110.w,
      height: 110.w,
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: radius,
        border: Border.all(color: context.neutral200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 10.w,
                width: 90.w,
                height: 90.w,
                child: Image.asset(assetPath, fit: BoxFit.contain),
              ),
              Positioned(
                left: 4.w,
                right: 4.w,
                bottom: 6.h,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.body3.copyWith(
                    color: context.neutral1000,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
