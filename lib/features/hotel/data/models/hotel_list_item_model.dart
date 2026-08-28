import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_image_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_room_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_service_model.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';

part 'hotel_list_item_model.mapper.dart';

@MappableClass()
class HotelListItemModel with HotelListItemModelMappable {
  final String id;
  final String name;
  final double rating;

  @MappableField(key: 'review_count')
  final int reviewCount;

  @MappableField(key: 'location_text')
  final String locationText;

  final double? latitude;
  final double? longitude;

  @MappableField(key: 'hotel_images')
  final List<HotelImageModel> images;

  @MappableField(key: 'hotel_rooms')
  final List<HotelRoomModel> rooms;

  @MappableField(key: 'hotel_services')
  final List<HotelServiceModel> services;

  const HotelListItemModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.locationText,
    this.latitude,
    this.longitude,
    this.images = const [],
    this.rooms = const [],
    this.services = const [],
  });

  factory HotelListItemModel.fromJson(Map<String, dynamic> json) =>
      HotelListItemModelMapper.fromMap(json);

  HotelListItemEntity toEntity({double? distanceKm}) {
    final sortedImages = [...images]..sort((a, b) {
      if (a.isPrimary != b.isPrimary) return a.isPrimary ? -1 : 1;
      return a.displayOrder.compareTo(b.displayOrder);
    });

    final prices = rooms.map((r) => r.pricePerNight).toList();
    double? startingPrice;
    for (final price in prices) {
      if (startingPrice == null || price < startingPrice) startingPrice = price;
    }

    return HotelListItemEntity(
      id: id,
      name: name,
      rating: rating,
      reviewCount: reviewCount,
      locationText: locationText,
      distanceKm: distanceKm,
      startingPrice: startingPrice,
      servicesSummary: services.map((s) => s.name).join(' / '),
      imageUrl: sortedImages.isEmpty ? null : sortedImages.first.imageUrl,
    );
  }
}
