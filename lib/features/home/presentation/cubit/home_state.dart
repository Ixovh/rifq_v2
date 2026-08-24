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
  final String? imageUrl;

  const HomeEmptyState(this.username, {this.imageUrl});

  @override
  List<Object?> get props => [username, imageUrl];
}

///!!----------------HAS PETS-------------------
class HomeLoadedState extends HomeState {
  final String username;
  final String? imageUrl;
  final List<PetModel> pets;

  const HomeLoadedState({
    required this.username,
    this.imageUrl,
    required this.pets,
  });

  @override
  List<Object?> get props => [username, imageUrl, pets];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
