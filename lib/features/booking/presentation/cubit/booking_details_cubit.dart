import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/room_availability_entity.dart';
import 'package:rifq_v2/features/booking/domain/use_cases/booking_use_case.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'booking_details_state.dart';

@injectable
class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  final BookingUseCase _bookingUseCase;

  BookingDetailsCubit(this._bookingUseCase) : super(BookingDetailsInitial());

  static const _genericErrorMessage =
      'Something went wrong checking room availability. Please try again.';

  Future<void> checkAvailabilityAndBuildDraft({
    required BookingDraftEntity candidate,
    required List<HotelRoomEntity> catalogRooms,
  }) async {
    emit(BookingDetailsChecking());

    (await _bookingUseCase.checkRoomAvailability(
      hotelId: candidate.hotelDetail.id,
      selections: candidate.selectedRooms,
      catalogRooms: catalogRooms,
      checkInDate: candidate.checkInDate,
      checkOutDate: candidate.checkOutDate,
    )).when(
      (issues) => emit(
        issues.isEmpty
            ? BookingDetailsReady(draft: candidate)
            : BookingDetailsBlocked(issues: issues),
      ),
      (error) {
        debugPrint(
          'BookingDetailsCubit.checkAvailabilityAndBuildDraft failed: '
          '${CatchErrorMessage(error: error).getWriteMessage()}',
        );
        emit(const BookingDetailsError(msg: _genericErrorMessage));
      },
    );
  }
}
