part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

///!!----------------USER IS GUEST------------------
class HomeGuestState extends HomeState {}

///!!----------------NO PETS-------------------
class HomeEmptyState extends HomeState {
  final String username;

  const HomeEmptyState(this.username);

  @override
  List<Object?> get props => [username];
}

///!!----------------HAS PETS-------------------
class HomeLoadedState extends HomeState {
  final String username;
  final List<PetModel> pets;

  const HomeLoadedState({
    required this.username,
    required this.pets,
  });

  @override
  List<Object?> get props => [username, pets];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}