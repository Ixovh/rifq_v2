part of 'booking_create_cubit.dart';

sealed class BookingCreateState extends Equatable {
  const BookingCreateState();

  @override
  List<Object?> get props => [];
}

final class BookingCreateInitial extends BookingCreateState {}

final class BookingCreateCreating extends BookingCreateState {}

final class BookingCreateCreated extends BookingCreateState {
  final BookingConfirmationEntity confirmation;

  const BookingCreateCreated({required this.confirmation});

  @override
  List<Object?> get props => [confirmation];
}

final class BookingCreateError extends BookingCreateState {
  final String msg;

  const BookingCreateError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
