import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';
import 'package:rifq_v2/features/booking/domain/use_cases/booking_use_case.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'booking_create_state.dart';

@injectable
class BookingCreateCubit extends Cubit<BookingCreateState> {
  final BookingUseCase _bookingUseCase;

  BookingCreateCubit(this._bookingUseCase) : super(BookingCreateInitial());

  static const _genericErrorMessage =
      'Something went wrong creating your booking. Please try again.';

  Future<void> confirmAndPay({
    required BookingDraftEntity draft,
    required PaymentMethodOption paymentMethod,
  }) async {
    emit(BookingCreateCreating());

    (await _bookingUseCase.createHotelBooking(
      draft: draft,
      paymentMethod: paymentMethod,
    )).when(
      (booking) => emit(
        BookingCreateCreated(
          confirmation: BookingConfirmationEntity(
            draft: draft,
            booking: booking,
          ),
        ),
      ),
      (error) {
        debugPrint(
          'BookingCreateCubit.confirmAndPay failed: '
          '${CatchErrorMessage(error: error).getWriteMessage()}',
        );
        emit(const BookingCreateError(msg: _genericErrorMessage));
      },
    );
  }
}
