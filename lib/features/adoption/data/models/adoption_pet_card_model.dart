import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';

class AdoptionPetCardModel extends AdoptionPetCardEntity {
  const AdoptionPetCardModel({
    required super.adoptionPostId,
    required super.petId,
    required super.name,
    required super.birthdate,
    required super.location,

    super.imageUrl,
    super.species,
    super.posterId,
  });

  factory AdoptionPetCardModel.fromJson(Map<String, dynamic> json) {
    return AdoptionPetCardModel(
      adoptionPostId: json['adoption_post_id'] as String,
      petId: json['pet_id'] as String,
      name: json['name'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      location: json['location'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      species: json['species'] as String?,
      posterId: json['poster_id'] as String?,
    );
  }
}