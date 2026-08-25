import 'package:equatable/equatable.dart';

class HealthRecordEntity extends Equatable {
  final String id;
  final String petId;
  final String title;
  final String recordType;
  final String? description;
  final String? clinicName;
  final DateTime visitDate;

  const HealthRecordEntity({
    required this.id,
    required this.petId,
    required this.title,
    required this.recordType,
    this.description,
    this.clinicName,
    required this.visitDate,
  });

  @override
  List<Object?> get props => [
    id,
    petId,
    title,
    recordType,
    description,
    clinicName,
    visitDate,
  ];
}
