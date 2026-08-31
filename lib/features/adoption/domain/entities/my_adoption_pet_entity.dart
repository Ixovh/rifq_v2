import 'package:equatable/equatable.dart';

class MyAdoptionPetEntity extends Equatable {
  final String adoptionPostId;
  final String petId;
  final String name;
  final DateTime birthdate;
  final String location;
  final String? imageUrl;
  final String? species;

  final String status;
  final int requestsCount;

  const MyAdoptionPetEntity({
    required this.adoptionPostId,
    required this.petId,
    required this.name,
    required this.birthdate,
    required this.location,
    this.imageUrl,
    this.species,
    required this.status,
    required this.requestsCount,
  });

  @override
  List<Object?> get props => [
        adoptionPostId,
        petId,
        name,
        birthdate,
        location,
        imageUrl,
        species,
        status,
        requestsCount,
      ];
}