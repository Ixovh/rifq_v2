import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/edit_pet/domain/repositories/edit_pet_repository_domain.dart';
import '../datasources/edit_pet_data_source.dart';

@LazySingleton(as: EditPetRepoDomain)
class EditPetRepoData implements EditPetRepoDomain {
  final BaseEditPetDataSource editPetDataSource;

  EditPetRepoData({required this.editPetDataSource});

  @override
  Future<Result<AccountPetEntity, Object>> getPet(String petId) async =>
      editPetDataSource.getPet(petId);

  @override
  Future<Result<AccountPetEntity, Object>> updatePet({
    required String petId,
    required String name,
    required String breed,
    required DateTime birthdate,
    double? weight,
    File? photoFile,
  }) async => editPetDataSource.updatePet(
    petId: petId,
    name: name,
    breed: breed,
    birthdate: birthdate,
    weight: weight,
    photoFile: photoFile,
  );
}
