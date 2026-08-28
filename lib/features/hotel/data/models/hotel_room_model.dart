import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

part 'hotel_room_model.mapper.dart';

@MappableClass()
class HotelRoomModel extends HotelRoomEntity with HotelRoomModelMappable {
  const HotelRoomModel({
    required super.id,
    required super.name,
    @MappableField(key: 'price_per_night') required super.pricePerNight,
    @MappableField(key: 'size_text') super.sizeText,
    required super.includes,
    @MappableField(key: 'available_rooms') super.availableRooms,
  });

  factory HotelRoomModel.fromJson(Map<String, dynamic> json) =>
      HotelRoomModelMapper.fromMap(json);
}
