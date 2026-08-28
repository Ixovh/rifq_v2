import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';

part 'hotel_image_model.mapper.dart';

@MappableClass()
class HotelImageModel extends HotelImageEntity with HotelImageModelMappable {
  const HotelImageModel({
    required super.id,
    @MappableField(key: 'image_url') required super.imageUrl,
    @MappableField(key: 'display_order') required super.displayOrder,
    @MappableField(key: 'is_primary') super.isPrimary = false,
  });

  factory HotelImageModel.fromJson(Map<String, dynamic> json) =>
      HotelImageModelMapper.fromMap(json);
}
