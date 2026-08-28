import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Segmented "Hotels / Home Boarding" toggle + search bar chrome from the
/// Figma reference. Home Boarding, search, and sort/filter are explicitly
/// out of scope for this pass, so everything here is decorative only —
/// "Hotels" is permanently selected and the search field is disabled.
class HotelListToolbar extends StatelessWidget {
  const HotelListToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: context.neutral200,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Hotels',
                    style: context.body2.copyWith(
                      color: context.primary300,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  alignment: Alignment.center,
                  child: Text(
                    'Home Boarding',
                    style: context.body2.copyWith(color: context.neutral500),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: IgnorePointer(
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: context.body2.copyWith(
                      color: context.neutral500,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.neutral500,
                      size: 20.sp,
                    ),
                    filled: true,
                    fillColor: context.neutral100,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: context.neutral200),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: context.neutral100,
                shape: BoxShape.circle,
                border: Border.all(color: context.neutral200),
              ),
              child: Icon(
                Icons.tune,
                size: 18.sp,
                color: context.neutral500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
