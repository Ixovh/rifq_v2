part of 'hotel_detail_cubit.dart';

sealed class HotelDetailState extends Equatable {
  const HotelDetailState();

  @override
  List<Object?> get props => [];
}

final class HotelDetailInitial extends HotelDetailState {}

final class HotelDetailLoading extends HotelDetailState {}

final class HotelDetailLoaded extends HotelDetailState {
  final HotelDetailEntity detail;

  const HotelDetailLoaded({required this.detail});

  @override
  List<Object?> get props => [detail];
}

final class HotelDetailError extends HotelDetailState {
  final String msg;

  const HotelDetailError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
