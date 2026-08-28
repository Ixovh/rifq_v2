import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/domain/use_cases/hotel_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'hotel_detail_state.dart';

@injectable
class HotelDetailCubit extends Cubit<HotelDetailState> {
  final HotelUseCase _hotelUseCase;

  HotelDetailCubit(this._hotelUseCase) : super(HotelDetailInitial());

  Future<void> loadHotelDetail(String hotelId) async {
    emit(HotelDetailLoading());

    (await _hotelUseCase.getHotelDetail(hotelId: hotelId)).when(
      (detail) => emit(HotelDetailLoaded(detail: detail)),
      (error) => emit(
        HotelDetailError(
          msg: CatchErrorMessage(error: error).getWriteMessage(),
        ),
      ),
    );
  }
}
