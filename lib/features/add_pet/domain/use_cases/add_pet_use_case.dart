import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq_v2/features/add_pet/domain/repositories/add_pet_repo_domain.dart';


@injectable
class AddPetUseCase {
  final AddPetRepoDomain repository;

  AddPetUseCase(this.repository);

  Future<AddPetEntity> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  }) {
    return repository.addPet(
      ownerId: ownerId,
      name: name,
      species: species,
      gender: gender,
      breed: breed,
      birthdate: birthdate,
      photoFile: photoFile,
    );
  }
}
