import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/adoption_entity.dart';

part 'adoption_model.mapper.dart';

@MappableClass()
class ProfileModel with ProfileModelMappable {
  final String id;

  @MappableField(key: 'full_name')
  final String fullName;

  @MappableField(key: 'phone_number')
  final String? phoneNumber;

  @MappableField(key: 'image_url')
  final String? avatarUrl;

  const ProfileModel({
    required this.id,
    required this.fullName,
    this.phoneNumber,
    this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfileModelMapper.fromMap(json);

  ProfileEntity toEntity() => ProfileEntity(
    id: id,
    fullName: fullName,
    phoneNumber: phoneNumber,
    avatarUrl: avatarUrl,
  );
}

@MappableClass()
class PetModel with PetModelMappable {
  final String id;

  @MappableField(key: 'owner_id')
  final String ownerId;

  final String name;
  final String species;
  final String breed;
  final int age;
  final String gender;

  @MappableField(key: 'health_status_summary')
  final String? healthStatusSummary;

  const PetModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.gender,
    this.healthStatusSummary,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      PetModelMapper.fromMap(json);

  PetEntity toEntity() => PetEntity(
    id: id,
    ownerId: ownerId,
    name: name,
    species: species,
    breed: breed,
    age: age,
    gender: gender,
    healthStatusSummary: healthStatusSummary,
  );
}

@MappableClass()
class PetPhotoModel with PetPhotoModelMappable {
  final String id;

  @MappableField(key: 'public_url')
  final String publicUrl;

  @MappableField(key: 'is_primary')
  final bool isPrimary;

  const PetPhotoModel({
    required this.id,
    required this.publicUrl,
    required this.isPrimary,
  });

  factory PetPhotoModel.fromJson(Map<String, dynamic> json) =>
      PetPhotoModelMapper.fromMap(json);

  PetPhotoEntity toEntity() =>
      PetPhotoEntity(id: id, publicUrl: publicUrl, isPrimary: isPrimary);
}

@MappableClass()
class AdoptionPostModel with AdoptionPostModelMappable {
  final String id;
  final String description;
  final String status;
  final String location;

  @MappableField(key: 'created_at')
  final DateTime createdAt;

  @MappableField(key: 'pets')
  final PetModel pet;

  @MappableField(key: 'profiles')
  final ProfileModel poster;

  @MappableField(key: 'pet_photos')
  final List<PetPhotoModel> photos;

  const AdoptionPostModel({
    required this.id,
    required this.description,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.pet,
    required this.poster,
    this.photos = const [],
  });

  factory AdoptionPostModel.fromJson(Map<String, dynamic> json) =>
      AdoptionPostModelMapper.fromMap(json);

  AdoptionPostEntity toEntity() => AdoptionPostEntity(
    id: id,
    description: description,
    status: status,
    location: location,
    createdAt: createdAt,
    pet: pet.toEntity(),
    poster: poster.toEntity(),
    photos: photos.map((p) => p.toEntity()).toList(),
  );
}
