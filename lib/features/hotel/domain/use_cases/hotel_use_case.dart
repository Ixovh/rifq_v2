import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/domain/repositories/hotel_repository_domain.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';

@lazySingleton
class HotelUseCase {
  final HotelRepoDomain hotelRepoData;

  const HotelUseCase({required this.hotelRepoData});

  Future<Result<List<HotelListItemEntity>, Object>> getHotels({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  }) async => await hotelRepoData.getHotels(
    sortOption: sortOption,
    searchQuery: searchQuery,
  );

  Future<Result<HotelDetailEntity, Object>> getHotelDetail({
    required String hotelId,
  }) async => await hotelRepoData.getHotelDetail(hotelId: hotelId);
}
