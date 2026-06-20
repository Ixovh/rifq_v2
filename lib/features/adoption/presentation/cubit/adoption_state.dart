import 'package:equatable/equatable.dart';

abstract class AdoptionState extends Equatable {
  const AdoptionState();

  @override
  List<Object?> get props => [];
}

class AdoptionInitialState extends AdoptionState {}
class AdoptionSuccessState extends AdoptionState {}

class AdoptionErrorState extends AdoptionState {
  final String message;
  const AdoptionErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

