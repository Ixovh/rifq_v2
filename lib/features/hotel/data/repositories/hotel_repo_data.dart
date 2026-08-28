import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/hotel/data/datasources/hotel_data_source.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/domain/repositories/hotel_repository_domain.dart';

@LazySingleton(as: HotelRepoDomain)
class HotelRepoData implements HotelRepoDomain {
  final BaseHotelDataSource hotelDataSource;

  HotelRepoData({required this.hotelDataSource});

  @override
  Future<Result<List<HotelListItemEntity>, Object>> getHotels() async =>
      await hotelDataSource.getHotels();

  @override
  Future<Result<HotelDetailEntity, Object>> getHotelDetail({
    required String hotelId,
  }) async => await hotelDataSource.getHotelDetail(hotelId: hotelId);
}
