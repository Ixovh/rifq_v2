import 'package:equatable/equatable.dart';

class AdoptionPostEntity extends Equatable {
  final String id;
  final String petId;
  final String posterId;
  final String description;
  final String status;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdoptionPostEntity({
    required this.id,
    required this.petId,
    required this.posterId,
    required this.description,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        petId,
        posterId,
        description,
        status,
        location,
        createdAt,
        updatedAt,
      ];
}
