import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({
    super.key,
    required this.roomPriceTotal,
    required this.addonPriceTotal,
    required this.appServiceFee,
    required this.totalPrice,
    this.title,
  });

  final double roomPriceTotal;
  final double addonPriceTotal;
  final double appServiceFee;
  final double totalPrice;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalBeforeFees = roomPriceTotal + addonPriceTotal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? l10n.booking_priceDetailsTitle,
          style: context.body1.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        _PriceRow(label: l10n.booking_roomPrice, value: roomPriceTotal),
        _PriceRow(label: l10n.booking_addonServices, value: addonPriceTotal),
        _PriceRow(label: l10n.booking_totalBeforeFees, value: totalBeforeFees),
        _PriceRow(label: l10n.booking_appServiceFee, value: appServiceFee),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Divider(height: 1, color: context.neutral200),
        ),
        _PriceRow(
          label: l10n.booking_totalPrice,
          value: totalPrice,
          emphasize: true,
        ),
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
          Flexible(
            child: Text(
              label,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            AppLocalizations.of(
              context,
            )!.booking_amountSar(value.toStringAsFixed(0)),
            style: style,
          ),
        ],
      ),
    );
  }
}
