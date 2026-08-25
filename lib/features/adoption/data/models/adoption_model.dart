
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';

class AdoptionPostModel extends AdoptionPostEntity {
  const AdoptionPostModel({
    required super.id,
    required super.petId,
    required super.posterId,
    required super.description,
    required super.status,
    required super.location,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AdoptionPostModel.fromJson(Map<String, dynamic> json) {
    return AdoptionPostModel(
      id: json['id'] as String,
      petId: json['pet_id'] as String,
      posterId: json['poster_id'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      location: json['location'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  factory AdoptionPostModel.fromEntity(AdoptionPostEntity entity) {
    return AdoptionPostModel(
      id: entity.id,
      petId: entity.petId,
      posterId: entity.posterId,
      description: entity.description,
      status: entity.status,
      location: entity.location,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_id': petId,
      'poster_id': posterId,
      'description': description,
      'status': status,
      'location': location,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}