// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'avatar_url': instance.avatarUrl,
    };

_PetModel _$PetModelFromJson(Map<String, dynamic> json) => _PetModel(
  id: json['id'] as String,
  ownerId: json['owner_id'] as String,
  name: json['name'] as String,
  species: json['species'] as String,
  breed: json['breed'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  healthStatusSummary: json['health_status_summary'] as String?,
);

Map<String, dynamic> _$PetModelToJson(_PetModel instance) => <String, dynamic>{
  'id': instance.id,
  'owner_id': instance.ownerId,
  'name': instance.name,
  'species': instance.species,
  'breed': instance.breed,
  'age': instance.age,
  'gender': instance.gender,
  'health_status_summary': instance.healthStatusSummary,
};

_PetPhotoModel _$PetPhotoModelFromJson(Map<String, dynamic> json) =>
    _PetPhotoModel(
      id: json['id'] as String,
      publicUrl: json['public_url'] as String,
      isPrimary: json['is_primary'] as bool,
    );

Map<String, dynamic> _$PetPhotoModelToJson(_PetPhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'public_url': instance.publicUrl,
      'is_primary': instance.isPrimary,
    };

_AdoptionPostModel _$AdoptionPostModelFromJson(Map<String, dynamic> json) =>
    _AdoptionPostModel(
      id: json['id'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      location: json['location'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      pet: PetModel.fromJson(json['pets'] as Map<String, dynamic>),
      poster: ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>),
      photos:
          (json['pet_photos'] as List<dynamic>?)
              ?.map((e) => PetPhotoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AdoptionPostModelToJson(_AdoptionPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'status': instance.status,
      'location': instance.location,
      'created_at': instance.createdAt.toIso8601String(),
      'pets': instance.pet.toJson(),
      'profiles': instance.poster.toJson(),
      'pet_photos': instance.photos.map((e) => e.toJson()).toList(),
    };
