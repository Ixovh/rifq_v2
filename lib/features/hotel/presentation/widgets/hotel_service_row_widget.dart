import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelServiceRow extends StatelessWidget {
  const HotelServiceRow({super.key, required this.service});

  final HotelServiceEntity service;

  @override
  Widget build(BuildContext context) {
    final hasPrice = service.price != null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(Icons.circle, size: 5.sp, color: context.neutral600),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              hasPrice
                  ? '${service.name} : SAR ${service.price!.toStringAsFixed(0)}'
                        '${service.priceUnit != null ? ' / ${service.priceUnit}' : ''}'
                  : service.name,
              style: context.body3.copyWith(color: context.neutral700),
            ),
          ),
        ],
      ),
    );
  }
}
