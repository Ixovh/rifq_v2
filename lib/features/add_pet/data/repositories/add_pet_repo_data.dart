import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/add_pet/data/datasources/add_pet_data_source.dart';
import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq_v2/features/add_pet/domain/repositories/add_pet_repo_domain.dart';


@LazySingleton(as: AddPetRepoDomain)
class AddPetRepoData implements AddPetRepoDomain {
  final BaseAddPetDataSource dataSource;

  AddPetRepoData(this.dataSource);

  @override
  Future<AddPetEntity> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  }) async {
    final model = await dataSource.addPet(
      ownerId: ownerId,
      name: name,
      species: species,
      gender: gender,
      breed: breed,
      birthdate: birthdate,
      photoFile: photoFile,
    );

    return model;
  }
}
