import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/health_record/domain/entities/health_record_entity.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseHealthRecordDataSource {
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

@LazySingleton(as: BaseHealthRecordDataSource)
class HealthRecordDataSource implements BaseHealthRecordDataSource {
  HealthRecordDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  String? get _userId =>
      AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;

  @override
  Future<Result<List<HealthRecordEntity>, Object>> fetchRecords(
    String petId,
  ) async {
    try {
      final userId = _userId;
      if (userId == null) return Error('User not found');

      final rows = await _supabase
          .from('pet_health_records')
          .select()
          .eq('pet_id', petId)
          .eq('owner_id', userId)
          .order('visit_date', ascending: false);

      final records = (rows as List<dynamic>)
          .map((raw) => _fromRow(Map<String, dynamic>.from(raw as Map)))
          .toList();

      return Success(records);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<HealthRecordEntity, Object>> addRecord({
    required String petId,
    required String title,
    required String recordType,
    String? description,
    String? clinicName,
    required DateTime visitDate,
  }) async {
    try {
      final userId = _userId;
      if (userId == null) return Error('User not found');

      final row = await _supabase
          .from('pet_health_records')
          .insert({
            'pet_id': petId,
            'owner_id': userId,
            'title': title.trim(),
            'record_type': recordType.trim(),
            'description': description?.trim().isEmpty == true
                ? null
                : description?.trim(),
            'clinic_name': clinicName?.trim().isEmpty == true
                ? null
                : clinicName?.trim(),
            'visit_date': _dateOnly(visitDate),
          })
          .select()
          .single();

      return Success(_fromRow(Map<String, dynamic>.from(row)));
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  HealthRecordEntity _fromRow(Map<String, dynamic> row) {
    return HealthRecordEntity(
      id: row['id'] as String,
      petId: row['pet_id'] as String,
      title: row['title'] as String? ?? '',
      recordType: row['record_type'] as String? ?? '',
      description: row['description'] as String?,
      clinicName: row['clinic_name'] as String?,
      visitDate: _parseDate(row['visit_date']) ?? DateTime.now(),
    );
  }

  static String _dateOnly(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) {
      return DateTime(value.year, value.month, value.day);
    }
    if (value is String && value.isNotEmpty) {
      final parsed = DateTime.tryParse(value);
      if (parsed == null) return null;
      return DateTime(parsed.year, parsed.month, parsed.day);
    }
    return null;
  }
}
