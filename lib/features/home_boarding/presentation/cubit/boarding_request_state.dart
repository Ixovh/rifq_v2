part of 'boarding_request_cubit.dart';

sealed class BoardingRequestState extends Equatable {
  const BoardingRequestState();

  @override
  List<Object?> get props => [];
}

final class BoardingRequestInitial extends BoardingRequestState {}

final class BoardingRequestChecking extends BoardingRequestState {}

final class BoardingRequestIdle extends BoardingRequestState {}

final class BoardingRequestAlreadyPending extends BoardingRequestState {
  const BoardingRequestAlreadyPending();
}

final class BoardingRequestSending extends BoardingRequestState {}

final class BoardingRequestSent extends BoardingRequestState {}

final class BoardingRequestError extends BoardingRequestState {
  final String msg;

  const BoardingRequestError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
