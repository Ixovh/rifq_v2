import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelRoomCard extends StatelessWidget {
  const HotelRoomCard({super.key, required this.room});

  final HotelRoomEntity room;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  room.name,
                  style: context.body1.copyWith(
                    color: context.neutral1000,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _Pill(
                icon: Icons.payments_outlined,
                text: l10n.common_pricePerNightSar(
                  room.pricePerNight.toStringAsFixed(0),
                ),
              ),
              if (room.sizeText != null) ...[
                SizedBox(width: 6.w),
                _Pill(icon: Icons.aspect_ratio, text: room.sizeText!),
              ],
            ],
          ),
          if (room.includes.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              l10n.hotel_includesLabel,
              style: context.body3.copyWith(
                color: context.neutral1000,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Wrap(
              spacing: 4.w,
              runSpacing: 2.h,
              children: room.includes
                  .map(
                    (item) => Text(
                      '• $item',
                      style: context.body3.copyWith(color: context.neutral700),
                    ),
                  )
                  .toList(),
            ),
          ],
          if (room.totalRooms != null) ...[
            SizedBox(height: 8.h),
            Text(
              l10n.hotel_roomsTotal(room.totalRooms!),
              style: context.body3.copyWith(
                color: context.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.neutral200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: context.neutral600),
          SizedBox(width: 4.w),
          Text(
            text,
            style: context.body3.copyWith(
              color: context.neutral700,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
