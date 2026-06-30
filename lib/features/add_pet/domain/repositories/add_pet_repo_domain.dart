import 'dart:io';

import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';

abstract class AddPetRepoDomain {

  Future<AddPetEntity> addPet({ 
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  });
}