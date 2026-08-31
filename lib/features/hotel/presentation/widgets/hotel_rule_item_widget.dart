import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelRuleItem extends StatelessWidget {
  const HotelRuleItem({super.key, required this.ruleText});

  final String ruleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/mdi_checkbox-outline.png',
          width: 14.w,
          height: 14.w,
          errorBuilder: (_, _, _) => Icon(
            Icons.check_box_outlined,
            size: 14.sp,
            color: context.red100,
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            ruleText,
            style: context.body3.copyWith(color: context.neutral600),
          ),
        ),
      ],
    );
  }
}
