import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_image_placeholder_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({super.key, required this.hotel, required this.onTap});

  final HotelListItemEntity hotel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);

    return Material(
      color: Colors.white,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: SizedBox(
                  width: 84.w,
                  height: 84.w,
                  child: hotel.imageUrl == null
                      ? HotelImagePlaceholder(iconSize: 28.sp)
                      : Image.network(
                          hotel.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              HotelImagePlaceholder(iconSize: 28.sp),
                        ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.body1.copyWith(
                        color: context.neutral1000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            Icons.star_rounded,
                            size: 14.sp,
                            color: i < hotel.rating.round()
                                ? context.warning
                                : context.neutral300,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '(${hotel.reviewCount} reviews)',
                          style: context.body3.copyWith(
                            color: context.neutral600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    _IconLine(
                      icon: Icons.location_on_outlined,
                      text: hotel.distanceKm == null
                          ? hotel.locationText
                          : '${hotel.locationText} – ${hotel.distanceKm!.toStringAsFixed(1)} km',
                    ),
                    SizedBox(height: 2.h),
                    _IconLine(
                      icon: Icons.payments_outlined,
                      text: hotel.startingPrice == null
                          ? 'Price unavailable'
                          : 'Start from ${hotel.startingPrice!.toStringAsFixed(0)} SAR/night',
                    ),
                    if (hotel.servicesSummary.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Services : ',
                              style: context.body3.copyWith(
                                color: context.neutral1000,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: hotel.servicesSummary,
                              style: context.body3.copyWith(
                                color: context.neutral700,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: context.neutral600),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.body3.copyWith(color: context.neutral700),
          ),
        ),
      ],
    );
  }
}
