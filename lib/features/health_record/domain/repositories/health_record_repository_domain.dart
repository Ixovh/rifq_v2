import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/health_record/domain/entities/health_record_entity.dart';

abstract class HealthRecordRepoDomain {
  Future<Result<List<HealthRecordEntity>, Object>> fetchRecords(String petId);

  Future<Result<HealthRecordEntity, Object>> addRecord({
    required String petId,
    required String title,
    required String recordType,
    String? description,
    String? clinicName,
    required DateTime visitDate,
  });
}
