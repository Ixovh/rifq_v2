import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/health_record/domain/entities/health_record_entity.dart';
import 'package:rifq_v2/features/health_record/domain/repositories/health_record_repository_domain.dart';

@lazySingleton
class HealthRecordUseCase {
  final HealthRecordRepoDomain healthRecordRepoData;

  const HealthRecordUseCase({required this.healthRecordRepoData});

  Future<Result<List<HealthRecordEntity>, Object>> fetchRecords(
    String petId,
  ) async => healthRecordRepoData.fetchRecords(petId);

  Future<Result<HealthRecordEntity, Object>> addRecord({
    required String petId,
    required String title,
    required String recordType,
    String? description,
    String? clinicName,
    required DateTime visitDate,
  }) async => healthRecordRepoData.addRecord(
    petId: petId,
    title: title,
    recordType: recordType,
    description: description,
    clinicName: clinicName,
    visitDate: visitDate,
  );
}
