import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/edit_pet/domain/use_cases/edit_pet_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'edit_pet_state.dart';

@injectable
class EditPetCubit extends Cubit<EditPetState> {
  EditPetCubit(this._editPetUseCase) : super(EditPetInitial());

  final EditPetUseCase _editPetUseCase;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final breedController = TextEditingController();
  final weightController = TextEditingController();

  DateTime? _birthdate;
  AccountPetEntity? _loadedPet;

  DateTime? get birthdate => _birthdate;

  void setBirthdate(DateTime value) {
    _birthdate = value;
  }

  Future<void> loadPet(String petId) async {
    emit(EditPetLoading());

    (await _editPetUseCase.getPet(petId)).when(
      (pet) {
        _loadedPet = pet;
        _birthdate = pet.birthdate;
        nameController.text = pet.name;
        breedController.text = pet.breed;
        weightController.text = pet.weight?.toString() ?? '';
        emit(EditPetLoaded(pet: pet));
      },
      (error) => emit(
        EditPetError(
          message: CatchErrorMessage(error: error).getWriteMessage(),
        ),
      ),
    );
  }

  Future<void> savePet({
    required String petId,
    File? photoFile,
    // Passed in from the screen so validation copy stays localized without
    // pulling a BuildContext into the cubit.
    required String ageRequiredMessage,
    required String invalidWeightMessage,
  }) async {
    final current = state;
    if (current is! EditPetLoaded) return;

    if (!(formKey.currentState?.validate() ?? false)) return;

    final name = nameController.text.trim();
    final breed = breedController.text.trim();
    final birthdate = _birthdate;

    if (birthdate == null) {
      emit(EditPetError(message: ageRequiredMessage));
      emit(current);
      return;
    }

    final weightText = weightController.text.trim();
    double? weight;
    if (weightText.isNotEmpty) {
      weight = double.tryParse(weightText.replaceAll(',', '.'));
      if (weight == null || weight <= 0) {
        emit(EditPetError(message: invalidWeightMessage));
        emit(current);
        return;
      }
    }

    emit(EditPetUpdating(pet: current.pet));

    (await _editPetUseCase.updatePet(
      petId: petId,
      name: name,
      breed: breed,
      birthdate: birthdate,
      weight: weight,
      photoFile: photoFile,
    )).when(
      (pet) {
        _loadedPet = pet;
        emit(EditPetUpdateSuccess(pet: pet));
        emit(EditPetLoaded(pet: pet));
      },
      (error) {
        emit(
          EditPetError(
            message: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
        emit(EditPetLoaded(pet: current.pet));
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    breedController.dispose();
    weightController.dispose();
    return super.close();
  }
}
