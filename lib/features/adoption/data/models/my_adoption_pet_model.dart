import 'package:rifq_v2/features/adoption/domain/entities/my_adoption_pet_entity.dart';

class MyAdoptionPetModel extends MyAdoptionPetEntity {
  const MyAdoptionPetModel({
    required super.adoptionPostId,
    required super.petId,
    required super.name,
    required super.birthdate,
    required super.location,
    super.imageUrl,
    super.species,
    required super.status,
    required super.requestsCount,
  });

  factory MyAdoptionPetModel.fromJson(Map<String, dynamic> json) {
    return MyAdoptionPetModel(
      adoptionPostId: json['adoption_post_id'] as String,
      petId: json['pet_id'] as String,
      name: json['name'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      location: json['location'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      species: json['species'] as String?,
      status: json['status'] as String,
      requestsCount: json['requests_count'] as int? ?? 0,
    );
  }
}