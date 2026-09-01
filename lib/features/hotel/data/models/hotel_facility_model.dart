import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

part 'hotel_facility_model.mapper.dart';

@MappableClass()
class HotelFacilityModel extends HotelFacilityEntity
    with HotelFacilityModelMappable {
  const HotelFacilityModel({
    required super.id,
    required super.category,
    @MappableField(key: 'label') required super.name,
  });

  factory HotelFacilityModel.fromJson(Map<String, dynamic> json) =>
      HotelFacilityModelMapper.fromMap(json);
}
