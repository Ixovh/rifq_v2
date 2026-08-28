import 'package:equatable/equatable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';

class HotelRoomEntity extends Equatable {
  final String id;
  final String name;
  final double pricePerNight;
  final String? sizeText;
  final List<String> includes;
  final int? availableRooms;

  const HotelRoomEntity({
    required this.id,
    required this.name,
    required this.pricePerNight,
    this.sizeText,
    required this.includes,
    this.availableRooms,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    pricePerNight,
    sizeText,
    includes,
    availableRooms,
  ];
}

class HotelServiceEntity extends Equatable {
  final String id;
  final String name;
  final double? price;
  final String? priceUnit;

  const HotelServiceEntity({
    required this.id,
    required this.name,
    this.price,
    this.priceUnit,
  });

  @override
  List<Object?> get props => [id, name, price, priceUnit];
}

class HotelFacilityEntity extends Equatable {
  final String id;
  final String category;
  final String name;

  const HotelFacilityEntity({
    required this.id,
    required this.category,
    required this.name,
  });

  @override
  List<Object?> get props => [id, category, name];
}

class HotelRuleEntity extends Equatable {
  final String id;
  final String ruleText;

  const HotelRuleEntity({required this.id, required this.ruleText});

  @override
  List<Object?> get props => [id, ruleText];
}

class HotelDetailEntity extends Equatable {
  final String id;
  final String name;
  final String locationText;
  final double? latitude;
  final double? longitude;
  final String? description;
  final List<HotelImageEntity> images;
  final List<HotelRoomEntity> rooms;
  final List<HotelServiceEntity> services;
  final List<HotelFacilityEntity> facilities;
  final List<HotelRuleEntity> rules;

  const HotelDetailEntity({
    required this.id,
    required this.name,
    required this.locationText,
    this.latitude,
    this.longitude,
    this.description,
    required this.images,
    required this.rooms,
    required this.services,
    required this.facilities,
    required this.rules,
  });

  bool get hasLocation => latitude != null && longitude != null;

  @override
  List<Object?> get props => [
    id,
    name,
    locationText,
    latitude,
    longitude,
    description,
    images,
    rooms,
    services,
    facilities,
    rules,
  ];
}
