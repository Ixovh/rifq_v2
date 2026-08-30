import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelSummaryCard extends StatefulWidget {
  const HotelSummaryCard({super.key, required this.hotel});

  final HotelDetailEntity hotel;

  @override
  State<HotelSummaryCard> createState() => _HotelSummaryCardState();
}

class _HotelSummaryCardState extends State<HotelSummaryCard> {
  double? _distanceKm;

  @override
  void initState() {
    super.initState();
    _loadDistance();
  }

  Future<void> _loadDistance() async {
    final lat = widget.hotel.latitude;
    final lng = widget.hotel.longitude;
    if (lat == null || lng == null) return;

    final position = await _currentPositionOrNull();
    if (position == null || !mounted) return;

    setState(() {
      _distanceKm =
          Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            lat,
            lng,
          ) /
          1000;
    });
  }

  // Same best-effort pattern as HotelDataSource — never throws, permission
  // denial or a disabled location service just omits the distance.
  Future<Position?> _currentPositionOrNull() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
    } catch (_) {
      return null;
    }
  }

  String? get _primaryImageUrl {
    if (widget.hotel.images.isEmpty) return null;
    final sorted = [...widget.hotel.images]
      ..sort((a, b) {
        if (a.isPrimary != b.isPrimary) return a.isPrimary ? -1 : 1;
        return a.displayOrder.compareTo(b.displayOrder);
      });
    return sorted.first.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _primaryImageUrl;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.neutral200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: imageUrl == null
                ? Container(
                    width: 56.w,
                    height: 56.w,
                    color: context.neutral200,
                    child: Icon(
                      Icons.house_outlined,
                      color: context.neutral500,
                    ),
                  )
                : Image.network(
                    imageUrl,
                    width: 56.w,
                    height: 56.w,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hotel.name,
                  style: context.body1.copyWith(
                    color: context.neutral1000,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: context.neutral600,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        _distanceKm == null
                            ? widget.hotel.locationText
                            : AppLocalizations.of(
                                context,
                              )!.common_locationDistance(
                                widget.hotel.locationText,
                                _distanceKm!.toStringAsFixed(1),
                              ),
                        style: context.body3.copyWith(
                          color: context.neutral600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
