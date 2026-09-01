import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/use_cases/home_boarding_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'sitter_detail_state.dart';

@injectable
class SitterDetailCubit extends Cubit<SitterDetailState> {
  final HomeBoardingUseCase _homeBoardingUseCase;

  SitterDetailCubit(this._homeBoardingUseCase) : super(SitterDetailInitial());

  static const _genericErrorMessage =
      'Something went wrong loading this sitter. Please try again.';

  Future<void> loadSitterDetail(String sitterId) async {
    emit(SitterDetailLoading());

    (await _homeBoardingUseCase.getSitterDetail(sitterId: sitterId)).when(
      (detail) => emit(SitterDetailLoaded(detail: detail)),
      (error) {
        debugPrint(
          'SitterDetailCubit.loadSitterDetail failed: '
          '${CatchErrorMessage(error: error).getWriteMessage()}',
        );
        emit(const SitterDetailError(msg: _genericErrorMessage));
      },
    );
  }
}
