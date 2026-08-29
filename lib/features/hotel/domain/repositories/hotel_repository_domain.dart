import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';

abstract class HotelRepoDomain {
  Future<Result<List<HotelListItemEntity>, Object>> getHotels({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  });

  Future<Result<HotelDetailEntity, Object>> getHotelDetail({
    required String hotelId,
  });
}
