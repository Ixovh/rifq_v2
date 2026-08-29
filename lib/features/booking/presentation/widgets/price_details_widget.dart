import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({
    super.key,
    required this.roomPriceTotal,
    required this.addonPriceTotal,
    required this.appServiceFee,
    required this.totalPrice,
    this.title = 'Price Details',
  });

  final double roomPriceTotal;
  final double addonPriceTotal;
  final double appServiceFee;
  final double totalPrice;
  final String title;

  @override
  Widget build(BuildContext context) {
    final totalBeforeFees = roomPriceTotal + addonPriceTotal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.body1.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        _PriceRow(label: 'Room Price', value: roomPriceTotal),
        _PriceRow(label: 'Add-on Services', value: addonPriceTotal),
        _PriceRow(label: 'Total Before Fees', value: totalBeforeFees),
        _PriceRow(label: 'App Service Fee', value: appServiceFee),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Divider(height: 1, color: context.neutral200),
        ),
        _PriceRow(label: 'Total Price', value: totalPrice, emphasize: true),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final double value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final style = emphasize
        ? context.body1.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w700,
          )
        : context.body2.copyWith(color: context.neutral700);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('${value.toStringAsFixed(0)} SAR', style: style),
        ],
      ),
    );
  }
}
