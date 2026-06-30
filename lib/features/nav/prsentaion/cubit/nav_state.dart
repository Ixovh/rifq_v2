import 'package:equatable/equatable.dart';

abstract class NavState extends Equatable {
  const NavState();

  @override
  List<Object?> get props => [];
}

class NavInitialState extends NavState {

}

class NavLoadingState extends NavState {}

class NavLoadedState extends NavState {}

class NavErrorState extends NavState {
  final String message;
  const NavErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}