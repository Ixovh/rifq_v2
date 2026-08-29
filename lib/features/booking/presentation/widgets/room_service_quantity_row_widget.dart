import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/quantity_stepper_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class RoomServiceQuantityRow extends StatelessWidget {
  const RoomServiceQuantityRow({
    super.key,
    required this.label,
    required this.priceCaption,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String priceCaption;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.body2.copyWith(color: context.neutral1000),
                ),
                Text(
                  priceCaption,
                  style: context.body3.copyWith(color: context.neutral600),
                ),
              ],
            ),
          ),
          QuantityStepper(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
