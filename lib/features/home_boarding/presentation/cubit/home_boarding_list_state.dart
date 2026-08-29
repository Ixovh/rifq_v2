part of 'home_boarding_list_cubit.dart';

sealed class HomeBoardingListState extends Equatable {
  const HomeBoardingListState();

  @override
  List<Object?> get props => [];
}

final class HomeBoardingListInitial extends HomeBoardingListState {}

final class HomeBoardingListLoading extends HomeBoardingListState {}

final class HomeBoardingListLoaded extends HomeBoardingListState {
  final List<HomeBoardingListItemEntity> sitters;

  const HomeBoardingListLoaded({required this.sitters});

  @override
  List<Object?> get props => [sitters];
}

final class HomeBoardingListEmpty extends HomeBoardingListState {
  const HomeBoardingListEmpty();
}

final class HomeBoardingListError extends HomeBoardingListState {
  final String msg;

  const HomeBoardingListError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
