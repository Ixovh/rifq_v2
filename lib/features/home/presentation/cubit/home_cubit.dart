import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/domain/use_cases/home_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeCubit(this._homeUseCase) : super(HomeInitial());

  Future<void> loadHomeData({
    bool silent = false,
    bool forceRefresh = false,
  }) async {
    if (!silent) emit(HomeLoading());

    (await _homeUseCase.getHomeData(forceRefresh: forceRefresh)).when(
      (data) {
        if (data.pets.isEmpty) {
          emit(HomeEmptyState(data: data));
        } else {
          emit(HomeLoadedState(data: data));
        }
      },
      (error) {
        final message = error.toString();
        if (message == 'guest') {
          emit(const HomeGuestState());
          return;
        }
        emit(
          HomeErrorState(
            msg: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
      },
    );
  }
}
