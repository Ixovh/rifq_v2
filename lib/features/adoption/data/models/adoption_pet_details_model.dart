import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';

class AdoptionPetDetailsModel extends AdoptionPetDetailsEntity {
  const AdoptionPetDetailsModel({
    required super.adoptionPostId,
    super.description,
    super.status,
    super.location,
    super.petId,
    super.name,
    super.birthdate,
    super.imageUrl,
    super.gender,
    super.breed,
    super.weight,
    super.ownerId,
    super.ownerName,
    super.ownerAvatarUrl,
     super.ownerPhone,
  });

  factory AdoptionPetDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final pet = json['pet'] as Map<String, dynamic>?;
    final owner = json['owner'] as Map<String, dynamic>?;

    // =========================
    // Pet Photos
    // =========================
    final photos = pet?['pet_photos'] as List<dynamic>?;

    String? imageUrl;

    if (photos != null && photos.isNotEmpty) {
      // أولًا نحاول نجيب الصورة الأساسية
      final primaryPhoto = photos.cast<Map<String, dynamic>?>().firstWhere(
        (photo) => photo?['is_primary'] == true,
        orElse: () => null,
      );

      if (primaryPhoto != null) {
        imageUrl = primaryPhoto['public_url'] as String?;
      } else {
        // إذا ما فيه صورة primary نأخذ أول صورة
        imageUrl = photos.first['public_url'] as String?;
      }
    }

    return AdoptionPetDetailsModel(
      adoptionPostId: json['id'] as String,

      // =========================
      // Adoption Post
      // =========================
      description: json['description'] as String?,
      status: json['status'] as String?,
      location: json['location'] as String?,

      // =========================
      // Pet
      // =========================
      petId: pet?['id'] as String?,
      name: pet?['name'] as String?,
      birthdate: pet?['birthdate'] != null
          ? DateTime.tryParse(
              pet!['birthdate'].toString(),
            )
          : null,

      // الصورة من pet_photos وليس pets
      imageUrl: imageUrl,

      gender: pet?['gender'] as String?,
      breed: pet?['breed'] as String?,
      weight: pet?['weight'],

      // =========================
      // Owner
      // =========================
      ownerId: owner?['id'] as String?,
      ownerName: owner?['full_name'] as String?,
      ownerAvatarUrl: owner?['avatar_url'] as String?,
      ownerPhone: owner?['phone_number'] as String?,
    );
  }
}