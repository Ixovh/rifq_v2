import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/use_cases/home_boarding_use_case.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'home_boarding_list_state.dart';

@injectable
class HomeBoardingListCubit extends Cubit<HomeBoardingListState> {
  final HomeBoardingUseCase _homeBoardingUseCase;

  HomeBoardingListCubit(this._homeBoardingUseCase)
    : super(HomeBoardingListInitial());

  static const _genericErrorMessage =
      'Something went wrong loading sitters. Please try again.';

  Future<void> loadSitters({
    SortOption sortOption = SortOption.recommended,
  }) async {
    emit(HomeBoardingListLoading());

    (await _homeBoardingUseCase.getSitters(sortOption: sortOption)).when(
      (sitters) => emit(
        sitters.isEmpty
            ? const HomeBoardingListEmpty()
            : HomeBoardingListLoaded(sitters: sitters),
      ),
      (error) {
        debugPrint(
          'HomeBoardingListCubit.loadSitters failed: '
          '${CatchErrorMessage(error: error).getWriteMessage()}',
        );
        emit(const HomeBoardingListError(msg: _genericErrorMessage));
      },
    );
  }
}
