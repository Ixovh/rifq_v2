part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeGuestState extends HomeState {
  const HomeGuestState();
}

class HomeEmptyState extends HomeState {
  final HomeDataEntity data;

  const HomeEmptyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class HomeLoadedState extends HomeState {
  final HomeDataEntity data;

  const HomeLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class HomeErrorState extends HomeState {
  final String msg;

  const HomeErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
