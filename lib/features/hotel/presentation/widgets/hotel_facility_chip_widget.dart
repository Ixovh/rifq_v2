import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelFacilityChip extends StatelessWidget {
  const HotelFacilityChip({
    super.key,
    required this.name,
    required this.category,
  });

  final String name;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.primary100.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.primary100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: context.body3.copyWith(
              color: context.primary400,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            category,
            style: context.body3.copyWith(
              color: context.neutral600,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
