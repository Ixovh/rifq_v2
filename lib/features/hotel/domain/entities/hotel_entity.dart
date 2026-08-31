import 'package:equatable/equatable.dart';

class HotelImageEntity extends Equatable {
  final String id;
  final String imageUrl;
  final int displayOrder;
  final bool isPrimary;

  const HotelImageEntity({
    required this.id,
    required this.imageUrl,
    required this.displayOrder,
    this.isPrimary = false,
  });

  @override
  List<Object?> get props => [id, imageUrl, displayOrder, isPrimary];
}

class HotelListItemEntity extends Equatable {
  final String id;
  final String name;
  final double rating;
  final int reviewCount;
  final String locationText;
  final double? distanceKm;
  final double? startingPrice;
  final String servicesSummary;
  final String? imageUrl;
  final bool isAvailable;

  const HotelListItemEntity({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.locationText,
    this.distanceKm,
    this.startingPrice,
    required this.servicesSummary,
    this.imageUrl,
    this.isAvailable = true,
  });

  String get locationLine {
    if (distanceKm == null) return locationText;
    return '$locationText – ${distanceKm!.toStringAsFixed(1)} km';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    rating,
    reviewCount,
    locationText,
    distanceKm,
    startingPrice,
    servicesSummary,
    imageUrl,
    isAvailable,
  ];
}
