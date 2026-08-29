import 'package:equatable/equatable.dart';

class AdoptionPetCardEntity extends Equatable {
  final String adoptionPostId;
  final String petId;
  final String name;
  final DateTime birthdate;
  final String location;
  final String? imageUrl;

  const AdoptionPetCardEntity({
    required this.adoptionPostId,
    required this.petId,
    required this.name,
    required this.birthdate,
    required this.location,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        adoptionPostId,
        petId,
        name,
        birthdate,
        location,
        imageUrl,
      ];
}