import 'package:equatable/equatable.dart';

class AdoptionRequestEntity extends Equatable {
  final String? id;

  final String adoptionPostId;

  final String requesterId;

  final String? message;

  final String? experience;

  final String status;

  final String? rejectionReason;

  final DateTime? respondedAt;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const AdoptionRequestEntity({
    this.id,
    required this.adoptionPostId,
    required this.requesterId,
    this.message,
    this.experience,
    this.status = 'pending',
    this.rejectionReason,
    this.respondedAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        adoptionPostId,
        requesterId,
        message,
        experience,
        status,
        rejectionReason,
        respondedAt,
        createdAt,
        updatedAt,
      ];
}