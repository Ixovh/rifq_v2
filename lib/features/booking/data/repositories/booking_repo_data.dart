import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/booking/data/datasources/booking_data_source.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/room_availability_entity.dart';
import 'package:rifq_v2/features/booking/domain/repositories/booking_repository_domain.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

@LazySingleton(as: BookingRepoDomain)
class BookingRepoData implements BookingRepoDomain {
  final BaseBookingDataSource bookingDataSource;

  BookingRepoData({required this.bookingDataSource});

  @override
  Future<Result<List<RoomAvailabilityIssueEntity>, Object>>
  checkRoomAvailability({
    required String hotelId,
    required List<BookingRoomSelectionEntity> selections,
    required List<HotelRoomEntity> catalogRooms,
    required DateTime checkInDate,
    required DateTime checkOutDate,
  }) async => await bookingDataSource.checkRoomAvailability(
    hotelId: hotelId,
    selections: selections,
    catalogRooms: catalogRooms,
    checkInDate: checkInDate,
    checkOutDate: checkOutDate,
  );
}
