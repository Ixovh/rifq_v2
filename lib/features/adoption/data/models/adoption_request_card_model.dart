import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_card_entity.dart';

class AdoptionRequestCardModel extends AdoptionRequestCardEntity {
  const AdoptionRequestCardModel({
    required super.id,
    required super.adoptionPostId,
    required super.requesterId,
    super.fullName,
    super.avatarUrl,
    super.phoneNumber,
    super.location,
    super.message,
    super.experience,
    required super.status,
    super.createdAt,
  });

  factory AdoptionRequestCardModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final profile = json['requester'] as Map<String, dynamic>?;

    return AdoptionRequestCardModel(
      id: json['id'] as String,
      adoptionPostId: json['adoption_post_id'] as String,
      requesterId: json['requester_id'] as String,

      fullName: profile?['full_name'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      phoneNumber: profile?['phone_number'] as String?,
      location: profile?['location'] as String?,

      message: json['message'] as String?,
      experience: json['experience'] as String?,
      status: json['status'] as String? ?? 'pending',

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(
              json['created_at'].toString(),
            )
          : null,
    );
  }
}