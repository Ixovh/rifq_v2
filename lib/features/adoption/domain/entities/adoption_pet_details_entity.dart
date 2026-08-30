import 'package:equatable/equatable.dart';

class AdoptionPetDetailsEntity extends Equatable {
  final String adoptionPostId;

  final String? description;
  final String? status;
  final String? location;

  // Pet
  final String? petId;
  final String? name;
  final DateTime? birthdate;
  final String? imageUrl;
  final String? gender;
  final String? breed;
  final dynamic weight;

  // Owner
  final String? ownerId;
  final String? ownerName;
  final String? ownerAvatarUrl;

  const AdoptionPetDetailsEntity({
    required this.adoptionPostId,
    this.description,
    this.status,
    this.location,
    this.petId,
    this.name,
    this.birthdate,
    this.imageUrl,
    this.gender,
    this.breed,
    this.weight,
    this.ownerId,
    this.ownerName,
    this.ownerAvatarUrl,
  });

  @override
  List<Object?> get props => [
        adoptionPostId,
        description,
        status,
        location,
        petId,
        name,
        birthdate,
        imageUrl,
        gender,
        breed,
        weight,
        ownerId,
        ownerName,
        ownerAvatarUrl,
      ];
}