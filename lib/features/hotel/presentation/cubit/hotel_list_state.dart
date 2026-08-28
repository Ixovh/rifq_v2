part of 'hotel_list_cubit.dart';

sealed class HotelListState extends Equatable {
  const HotelListState();

  @override
  List<Object?> get props => [];
}

final class HotelListInitial extends HotelListState {}

final class HotelListLoading extends HotelListState {}

final class HotelListLoaded extends HotelListState {
  final List<HotelListItemEntity> hotels;

  const HotelListLoaded({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

final class HotelListError extends HotelListState {
  final String msg;

  const HotelListError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
