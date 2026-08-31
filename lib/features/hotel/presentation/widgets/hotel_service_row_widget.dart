import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelServiceRow extends StatelessWidget {
  const HotelServiceRow({super.key, required this.service});

  final HotelServiceEntity service;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasPrice = service.price != null;
    final label = hasPrice
        ? l10n.hotel_servicePrice(
                service.name,
                service.price!.toStringAsFixed(0),
              ) +
              (service.priceUnit != null && service.priceUnit!.isNotEmpty
                  ? ' / ${service.priceUnit}'
                  : '')
        : service.name;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Icon(Icons.circle, size: 4.sp, color: context.neutral600),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: context.body3.copyWith(
                color: context.neutral700,
                fontSize: 9.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
