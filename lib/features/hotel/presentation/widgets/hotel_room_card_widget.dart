import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelRoomCard extends StatelessWidget {
  const HotelRoomCard({super.key, required this.room, this.showDivider = true});

  final HotelRoomEntity room;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                room.name,
                style: context.body2.copyWith(
                  color: context.neutral1000,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            _Pill(
              icon: Icons.monetization_on_outlined,
              text: l10n.common_pricePerNightSar(
                room.pricePerNight.toStringAsFixed(0),
              ),
            ),
            if (room.sizeText != null) ...[
              SizedBox(width: 6.w),
              _Pill(icon: Icons.open_in_full, text: room.sizeText!),
            ],
          ],
        ),
        if (room.includes.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                l10n.hotel_includesLabel,
                style: context.body3.copyWith(
                  color: context.neutral1000,
                  fontSize: 9.sp,
                ),
              ),
              for (final item in room.includes)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 3.w,
                      height: 3.w,
                      decoration: BoxDecoration(
                        color: context.primary300,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item,
                      style: context.body3.copyWith(
                        color: context.neutral600,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
        if (room.totalRooms != null) ...[
          SizedBox(height: 6.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: l10n.hotel_availabilityLabel,
                  style: context.body3.copyWith(
                    color: context.primary300,
                    fontSize: 10.sp,
                  ),
                ),
                TextSpan(
                  text: l10n.hotel_roomsAvailable(room.totalRooms!),
                  style: context.body3.copyWith(
                    color: context.neutral600,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (showDivider) ...[
          SizedBox(height: 10.h),
          Divider(height: 1, color: context.neutral200),
          SizedBox(height: 10.h),
        ],
      ],
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
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: context.neutral200,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: context.neutral700),
          SizedBox(width: 2.w),
          Text(
            text,
            style: context.body3.copyWith(
              color: context.neutral1000,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}
