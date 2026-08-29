import 'package:dart_mappable/dart_mappable.dart';
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
      HotelDetailModelMapper.fromMap(json);

  HotelDetailEntity toEntity() {
    final sortedImages = [...images]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return HotelDetailEntity(
      id: id,
      name: profile?.fullName ?? 'Hotel',
      locationText: locationText,
      latitude: latitude,
      longitude: longitude,
      description: description,
      images: sortedImages,
      rooms: rooms,
      services: services,
      facilities: facilities,
      rules: rules,
    );
  }
}
