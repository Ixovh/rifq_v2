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
      width: 78.w,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF5F5F5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.body3.copyWith(
              color: context.primary300,
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              height: 1.15,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            category,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.body3.copyWith(
              color: const Color(0xFFB4AEAE),
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}
