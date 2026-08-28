import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/domain/use_cases/hotel_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'hotel_list_state.dart';

@injectable
class HotelListCubit extends Cubit<HotelListState> {
  final HotelUseCase _hotelUseCase;

  HotelListCubit(this._hotelUseCase) : super(HotelListInitial());

  Future<void> loadHotels() async {
    emit(HotelListLoading());

    (await _hotelUseCase.getHotels()).when(
      (hotels) => emit(HotelListLoaded(hotels: hotels)),
      (error) => emit(
        HotelListError(msg: CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }
}
