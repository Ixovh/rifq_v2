import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

part 'hotel_service_model.mapper.dart';

@MappableClass()
class HotelServiceModel extends HotelServiceEntity
    with HotelServiceModelMappable {
  const HotelServiceModel({
    required super.id,
    required super.name,
    super.price,
    @MappableField(key: 'price_unit') super.priceUnit,
  });

  factory HotelServiceModel.fromJson(Map<String, dynamic> json) =>
      HotelServiceModelMapper.fromMap(json);
}
