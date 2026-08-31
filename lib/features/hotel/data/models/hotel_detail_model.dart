import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_json_coercion.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_facility_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_image_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_owner_profile_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_room_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_rule_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_service_model.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

part 'hotel_detail_model.mapper.dart';

@MappableClass()
class HotelDetailModel with HotelDetailModelMappable {
  final String id;
  final String? name;

  @MappableField(key: 'location_text')
  final String locationText;

  final double? latitude;
  final double? longitude;
  final String? description;

  @MappableField(key: 'profiles')
  final HotelOwnerProfileModel? profile;

  @MappableField(key: 'hotel_images')
  final List<HotelImageModel> images;

  @MappableField(key: 'hotel_rooms')
  final List<HotelRoomModel> rooms;

  @MappableField(key: 'hotel_services')
  final List<HotelServiceModel> services;

  @MappableField(key: 'hotel_facilities')
  final List<HotelFacilityModel> facilities;

  @MappableField(key: 'hotel_rules')
  final List<HotelRuleModel> rules;

  const HotelDetailModel({
    required this.id,
    this.name,
    required this.locationText,
    this.latitude,
    this.longitude,
    this.description,
    this.profile,
    this.images = const [],
    this.rooms = const [],
    this.services = const [],
    this.facilities = const [],
    this.rules = const [],
  });

  factory HotelDetailModel.fromJson(Map<String, dynamic> json) =>
      HotelDetailModelMapper.fromMap(coerceHotelJson(json));

  HotelDetailEntity toEntity({double? distanceKm}) {
    final sortedImages = [...images]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    final sortedRooms = [...rooms]
      ..sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
    final listingName = name?.trim();
    final sortedRules = [...rules]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return HotelDetailEntity(
      id: id,
      name: (listingName != null && listingName.isNotEmpty)
          ? listingName
          : (profile?.fullName ?? 'Hotel'),
      locationText: locationText,
      latitude: latitude,
      longitude: longitude,
      distanceKm: distanceKm,
      description: description,
      images: sortedImages,
      rooms: sortedRooms,
      services: services,
      facilities: facilities,
      rules: sortedRules,
    );
  }
}
