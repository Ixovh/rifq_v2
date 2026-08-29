import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/health_record/data/datasources/health_record_data_source.dart';
import 'package:rifq_v2/features/health_record/domain/entities/health_record_entity.dart';
import 'package:rifq_v2/features/health_record/domain/repositories/health_record_repository_domain.dart';

@LazySingleton(as: HealthRecordRepoDomain)
class HealthRecordRepoData implements HealthRecordRepoDomain {
  final BaseHealthRecordDataSource healthRecordDataSource;

  HealthRecordRepoData({required this.healthRecordDataSource});

  @override
  Future<Result<List<HealthRecordEntity>, Object>> fetchRecords(
    String petId,
  ) async => healthRecordDataSource.fetchRecords(petId);

  @override
  Future<Result<HealthRecordEntity, Object>> addRecord({
    required String petId,
    required String title,
    required String recordType,
    String? description,
    String? clinicName,
    required DateTime visitDate,
  }) async => healthRecordDataSource.addRecord(
    petId: petId,
    title: title,
    recordType: recordType,
    description: description,
    clinicName: clinicName,
    visitDate: visitDate,
  );
}
