import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/home_boarding/domain/use_cases/home_boarding_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'boarding_request_state.dart';

@injectable
class BoardingRequestCubit extends Cubit<BoardingRequestState> {
  final HomeBoardingUseCase _homeBoardingUseCase;

  BoardingRequestCubit(this._homeBoardingUseCase)
    : super(BoardingRequestInitial());

  static const _checkErrorMessage =
      'Something went wrong checking your requests. Please try again.';
  static const _sendErrorMessage =
      'Something went wrong sending your request. Please try again.';

  Future<void> checkExistingRequest(String sitterId) async {
    emit(BoardingRequestChecking());

    (await _homeBoardingUseCase.getPendingRequest(sitterId: sitterId)).when(
      (existing) => emit(
        existing == null
            ? BoardingRequestIdle()
            : const BoardingRequestAlreadyPending(),
      ),
      (error) {
        debugPrint(
          'BoardingRequestCubit.checkExistingRequest failed: '
          '${CatchErrorMessage(error: error).getWriteMessage()}',
        );
        emit(const BoardingRequestError(msg: _checkErrorMessage));
      },
    );
  }

  Future<void> sendRequest(String sitterId) async {
    if (state is BoardingRequestSending ||
        state is BoardingRequestAlreadyPending) {
      return;
    }
    emit(BoardingRequestSending());

    (await _homeBoardingUseCase.sendBoardingRequest(
      sitterId: sitterId,
    )).when(
      (_) => emit(BoardingRequestSent()),
      (error) {
        debugPrint(
          'BoardingRequestCubit.sendRequest failed: '
          '${CatchErrorMessage(error: error).getWriteMessage()}',
        );
        emit(const BoardingRequestError(msg: _sendErrorMessage));
      },
    );
  }
}
