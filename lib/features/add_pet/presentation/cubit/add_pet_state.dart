
part of 'add_pet_cubit.dart';

sealed class AddPetState extends Equatable {
  const AddPetState();

  @override
  List<Object?> get props => [];
}

final class AddPetInitial extends AddPetState {}

final class AddPetLoading extends AddPetState {}

final class AddPetSuccess extends AddPetState {
  final String message;
  const AddPetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class AddPetFailure extends AddPetState {
  final String error;
  const AddPetFailure(this.error);

  @override
  List<Object?> get props => [error];
}
