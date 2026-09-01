import 'package:equatable/equatable.dart';

class AdoptionRequestCardEntity extends Equatable {
  final String id;
  final String adoptionPostId;
  final String requesterId;

  final String? fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? location;

  final String? message;
  final String? experience;
  final String status;
  final DateTime? createdAt;

  const AdoptionRequestCardEntity({
    required this.id,
    required this.adoptionPostId,
    required this.requesterId,
    this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    this.location,
    this.message,
    this.experience,
    required this.status,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        adoptionPostId,
        requesterId,
        fullName,
        avatarUrl,
        phoneNumber,
        location,
        message,
        experience,
        status,
        createdAt,
      ];
}