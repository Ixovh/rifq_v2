part of 'edit_pet_cubit.dart';

sealed class EditPetState extends Equatable {
  const EditPetState();

  @override
  List<Object?> get props => [];
}

final class EditPetInitial extends EditPetState {}

final class EditPetLoading extends EditPetState {}

final class EditPetLoaded extends EditPetState {
  const EditPetLoaded({required this.pet});

  final AccountPetEntity pet;

  @override
  List<Object?> get props => [pet];
}

final class EditPetUpdating extends EditPetState {
  const EditPetUpdating({required this.pet});

  final AccountPetEntity pet;

  @override
  List<Object?> get props => [pet];
}

final class EditPetUpdateSuccess extends EditPetState {
  const EditPetUpdateSuccess({required this.pet});

  final AccountPetEntity pet;

  @override
  List<Object?> get props => [pet];
}

final class EditPetError extends EditPetState {
  const EditPetError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
