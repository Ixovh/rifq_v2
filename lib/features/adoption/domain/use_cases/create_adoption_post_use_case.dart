import 'dart:io';
import 'package:injectable/injectable.dart';
import '../repositories/adoption_repository_domain.dart';

@injectable
class CreateAdoptionPostUseCase {
  final AdoptionRepositoryDomain repository;

  CreateAdoptionPostUseCase(this.repository);

  Future<void> call({
    required String petName,
    required String species,
    required String breed,
    required int age,
    required String gender,
    String? healthStatusSummary,
    required String description,
    required String location,
    required List<File> imageFiles,
  }) async {
    return await repository.createAdoptionListing(
      petName: petName,
      species: species,
      breed: breed,
      age: age,
      gender: gender,
      healthStatusSummary: healthStatusSummary,
      description: description,
      location: location,
      imageFiles: imageFiles,
    );
  }
}