import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';

class AdoptionRequestModel extends AdoptionRequestEntity {
  const AdoptionRequestModel({
    super.id,
    required super.adoptionPostId,
    required super.requesterId,
    super.message,
    super.experience,
    super.status,
    super.rejectionReason,
    super.respondedAt,
    super.createdAt,
    super.updatedAt,
  });

  factory AdoptionRequestModel.fromJson(Map<String, dynamic> json) {
    return AdoptionRequestModel(
      id: json['id'] as String?,
      adoptionPostId: json['adoption_post_id'] as String,
      requesterId: json['requester_id'] as String,
      message: json['message'] as String?,
      experience: json['experience'] as String?,
      status: json['status'] as String? ?? 'pending',
      rejectionReason: json['rejection_reason'] as String?,
      respondedAt: json['responded_at'] != null
          ? DateTime.tryParse(json['responded_at'].toString())
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  factory AdoptionRequestModel.fromEntity(
    AdoptionRequestEntity entity,
  ) {
    return AdoptionRequestModel(
      id: entity.id,
      adoptionPostId: entity.adoptionPostId,
      requesterId: entity.requesterId,
      message: entity.message,
      experience: entity.experience,
      status: entity.status,
      rejectionReason: entity.rejectionReason,
      respondedAt: entity.respondedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adoption_post_id': adoptionPostId,
      'requester_id': requesterId,
      'message': message,
      'experience': experience,
      'status': status,
    };
  }
}