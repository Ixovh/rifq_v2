import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/domain/repositories/hotel_repository_domain.dart';

@lazySingleton
class HotelUseCase {
  final HotelRepoDomain hotelRepoData;

  const HotelUseCase({required this.hotelRepoData});

  Future<Result<List<HotelListItemEntity>, Object>> getHotels() async =>
      await hotelRepoData.getHotels();

  Future<Result<HotelDetailEntity, Object>> getHotelDetail({
    required String hotelId,
  }) async => await hotelRepoData.getHotelDetail(hotelId: hotelId);
}
