import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/room_availability_entity.dart';
import 'package:rifq_v2/features/booking/domain/repositories/booking_repository_domain.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';

@lazySingleton
class BookingUseCase {
  final BookingRepoDomain bookingRepoData;

  const BookingUseCase({required this.bookingRepoData});

  Future<Result<List<RoomAvailabilityIssueEntity>, Object>>
  checkRoomAvailability({
    required String hotelId,
    required List<BookingRoomSelectionEntity> selections,
    required List<HotelRoomEntity> catalogRooms,
    required DateTime checkInDate,
    required DateTime checkOutDate,
  }) async => await bookingRepoData.checkRoomAvailability(
    hotelId: hotelId,
    selections: selections,
    catalogRooms: catalogRooms,
    checkInDate: checkInDate,
    checkOutDate: checkOutDate,
  );

  Future<Result<HotelBookingEntity, Object>> createHotelBooking({
    required BookingDraftEntity draft,
    required PaymentMethodOption paymentMethod,
  }) async => await bookingRepoData.createHotelBooking(
    draft: draft,
    paymentMethod: paymentMethod,
  );
}
