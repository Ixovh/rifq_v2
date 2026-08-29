import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/room_availability_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseBookingDataSource {
  Future<Result<List<RoomAvailabilityIssueEntity>, Object>>
  checkRoomAvailability({
    required String hotelId,
    required List<BookingRoomSelectionEntity> selections,
    required List<HotelRoomEntity> catalogRooms,
    required DateTime checkInDate,
    required DateTime checkOutDate,
  });
}

@LazySingleton(as: BaseBookingDataSource)
class BookingDataSource implements BaseBookingDataSource {
  const BookingDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<Result<List<RoomAvailabilityIssueEntity>, Object>>
  checkRoomAvailability({
    required String hotelId,
    required List<BookingRoomSelectionEntity> selections,
    required List<HotelRoomEntity> catalogRooms,
    required DateTime checkInDate,
    required DateTime checkOutDate,
  }) async {
    try {
      final roomIds = selections.map((s) => s.roomId).toList();
      final checkInIso = _dateOnlyIso(checkInDate);
      final checkOutIso = _dateOnlyIso(checkOutDate);

      final rows = await _supabase
          .from('hotel_booking_rooms')
          .select(
            'room_id, quantity, '
            'hotel_bookings!inner(check_in_date, check_out_date, booking_status, hotel_id)',
          )
          .inFilter('room_id', roomIds)
          .eq('hotel_bookings.hotel_id', hotelId)
          .neq('hotel_bookings.booking_status', 'cancelled')
          .lt('hotel_bookings.check_in_date', checkOutIso)
          .gt('hotel_bookings.check_out_date', checkInIso);

      final bookedByRoom = <String, int>{};
      for (final row in rows) {
        final roomId = row['room_id'] as String;
        final quantity = (row['quantity'] as num?)?.toInt() ?? 0;
        bookedByRoom[roomId] = (bookedByRoom[roomId] ?? 0) + quantity;
      }

      final issues = <RoomAvailabilityIssueEntity>[];
      for (final selection in selections) {
        final room = catalogRooms.firstWhere(
          (r) => r.id == selection.roomId,
          orElse: () => HotelRoomEntity(
            id: selection.roomId,
            name: selection.roomName,
            pricePerNight: selection.pricePerNight,
            includes: const [],
          ),
        );
        final totalCapacity = room.totalRooms;
        if (totalCapacity == null) continue;

        final alreadyBooked = bookedByRoom[selection.roomId] ?? 0;
        final available = totalCapacity - alreadyBooked;
        if (selection.quantity > available) {
          issues.add(
            RoomAvailabilityIssueEntity(
              roomId: selection.roomId,
              roomName: selection.roomName,
              requestedQuantity: selection.quantity,
              availableQuantity: available < 0 ? 0 : available,
            ),
          );
        }
      }

      return Success(issues);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  String _dateOnlyIso(DateTime date) =>
      DateTime(date.year, date.month, date.day).toIso8601String().split('T').first;
}
