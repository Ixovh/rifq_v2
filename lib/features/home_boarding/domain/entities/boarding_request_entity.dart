import 'package:equatable/equatable.dart';

class BoardingRequestEntity extends Equatable {
  final String id;
  final String sitterId;
  final String requesterId;
  final String status;
  final String? message;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BoardingRequestEntity({
    required this.id,
    required this.sitterId,
    required this.requesterId,
    required this.status,
    this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    sitterId,
    requesterId,
    status,
    message,
    createdAt,
    updatedAt,
  ];
}
