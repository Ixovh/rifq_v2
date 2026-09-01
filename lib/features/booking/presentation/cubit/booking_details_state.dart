part of 'booking_details_cubit.dart';

sealed class BookingDetailsState extends Equatable {
  const BookingDetailsState();

  @override
  List<Object?> get props => [];
}

final class BookingDetailsInitial extends BookingDetailsState {}

final class BookingDetailsChecking extends BookingDetailsState {}

final class BookingDetailsReady extends BookingDetailsState {
  final BookingDraftEntity draft;

  const BookingDetailsReady({required this.draft});

  @override
  List<Object?> get props => [draft];
}

final class BookingDetailsBlocked extends BookingDetailsState {
  final List<RoomAvailabilityIssueEntity> issues;

  const BookingDetailsBlocked({required this.issues});

  @override
  List<Object?> get props => [issues];
}

final class BookingDetailsError extends BookingDetailsState {
  final String msg;

  const BookingDetailsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
