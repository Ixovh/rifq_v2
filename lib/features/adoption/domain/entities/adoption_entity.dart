import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String fullName;
  final String? phoneNumber;
  final String? avatarUrl;

  const ProfileEntity({
    required this.id,
    required this.fullName,
    this.phoneNumber,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, fullName, phoneNumber, avatarUrl];
}

class PetEntity extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String species;
  final String breed;
  final int age;
  final String gender;
  final String? healthStatusSummary;

  const PetEntity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.gender,
    this.healthStatusSummary,
  });

  @override
  List<Object?> get props => [
    id,
    ownerId,
    name,
    species,
    breed,
    age,
    gender,
    healthStatusSummary,
  ];
}

class PetPhotoEntity extends Equatable {
  final String id;
  final String publicUrl;
  final bool isPrimary;

  const PetPhotoEntity({
    required this.id,
    required this.publicUrl,
    required this.isPrimary,
  });

  @override
  List<Object?> get props => [id, publicUrl, isPrimary];
}

class AdoptionPostEntity extends Equatable {
  final String id;
  final String description;
  final String status;
  final String location;
  final DateTime createdAt;

  final PetEntity pet;
  final ProfileEntity poster;
  final List<PetPhotoEntity> photos;

  const AdoptionPostEntity({
    required this.id,
    required this.description,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.pet,
    required this.poster,
    required this.photos,
  });

  @override
  List<Object?> get props => [
    id,
    description,
    status,
    location,
    createdAt,
    pet,
    poster,
    photos,
  ];
}
