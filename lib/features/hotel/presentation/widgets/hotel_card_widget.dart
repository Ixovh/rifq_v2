import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_image_placeholder_widget.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({super.key, required this.hotel, required this.onTap});

  final HotelListItemEntity hotel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(26.r);
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.white,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 16.h, 16.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox(
                      width: 105.w,
                      height: 107.h,
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
                  if (hotel.isAvailable) ...[
                    SizedBox(height: 8.h),
                    Container(
                      width: 67.w,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFFEFB),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.hotel_available,
                        style: context.body3.copyWith(
                          color: const Color(0xFF56CBB5),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.h4.copyWith(
                        color: context.neutral1000,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          hotel.rating.toStringAsFixed(1),
                          style: context.body3.copyWith(
                            color: context.neutral1000,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4.w),
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
                        Flexible(
                          child: Text(
                            l10n.common_reviewsCount(hotel.reviewCount),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.body3.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    _IconLine(
                      icon: Icons.location_on_outlined,
                      text: hotel.distanceKm == null
                          ? hotel.locationText
                          : l10n.hotel_locationDistance(
                              hotel.locationText,
                              hotel.distanceKm!.toStringAsFixed(1),
                            ),
                    ),
                    SizedBox(height: 4.h),
                    _IconLine(
                      icon: Icons.monetization_on_outlined,
                      text: hotel.startingPrice == null
                          ? l10n.hotel_priceUnavailable
                          : l10n.hotel_startingPrice(
                              hotel.startingPrice!.toStringAsFixed(0),
                            ),
                    ),
                    if (hotel.servicesSummary.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: l10n.hotel_servicesLabel,
                              style: context.body3.copyWith(
                                color: context.neutral1000,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                            TextSpan(
                              text: hotel.servicesSummary,
                              style: context.body3.copyWith(
                                color: context.neutral600,
                                fontSize: 10.sp,
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
        Icon(icon, size: 12.sp, color: context.neutral500),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.body3.copyWith(
              color: context.neutral500,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }
}
