import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/room_availability_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

abstract class BookingRepoDomain {
  Future<Result<List<RoomAvailabilityIssueEntity>, Object>>
  checkRoomAvailability({
    required String hotelId,
    required List<BookingRoomSelectionEntity> selections,
    required List<HotelRoomEntity> catalogRooms,
    required DateTime checkInDate,
    required DateTime checkOutDate,
  });
}
