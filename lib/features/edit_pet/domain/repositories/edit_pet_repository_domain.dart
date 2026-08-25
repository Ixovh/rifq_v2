import 'dart:io';

import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';

abstract class EditPetRepoDomain {
  Future<Result<AccountPetEntity, Object>> getPet(String petId);

  Future<Result<AccountPetEntity, Object>> updatePet({
    required String petId,
    required String name,
    required String breed,
    required DateTime birthdate,
    double? weight,
    File? photoFile,
  });
}
