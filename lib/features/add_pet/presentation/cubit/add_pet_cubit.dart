import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/add_pet/domain/usecases/add_pet_use_case.dart';

part 'add_pet_state.dart';

@injectable
class AddPetCubit extends Cubit<AddPetState> {
  final AddPetUseCase addPetUseCase;

  AddPetCubit(this.addPetUseCase) : super(AddPetInitial());

  Future<void> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  }) async {
    emit(AddPetLoading());

    try {
      await addPetUseCase.addPet(
        ownerId: ownerId,
        name: name,
        species: species,
        gender: gender,
        breed: breed,
        birthdate: birthdate,
        photoFile: photoFile,
      );

      emit(AddPetSuccess("Pet added successfully"));
    } catch (e) {
      emit(AddPetFailure(e.toString()));
    }
  }
}
