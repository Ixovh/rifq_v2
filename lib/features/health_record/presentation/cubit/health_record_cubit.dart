import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/health_record/domain/entities/health_record_entity.dart';
import 'package:rifq_v2/features/health_record/domain/use_cases/health_record_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';

part 'health_record_state.dart';

@injectable
class HealthRecordCubit extends Cubit<HealthRecordState> {
  HealthRecordCubit(this._useCase) : super(HealthRecordInitial());

  final HealthRecordUseCase _useCase;

  Future<void> loadRecords(String petId) async {
    emit(HealthRecordLoading());

    (await _useCase.fetchRecords(petId)).when(
      (records) => emit(HealthRecordLoaded(records: records)),
      (error) => emit(
        HealthRecordError(
          message: CatchErrorMessage(error: error).getWriteMessage(),
        ),
      ),
    );
  }

  Future<bool> addRecord({
    required String petId,
    required String title,
    required String recordType,
    String? description,
    String? clinicName,
    required DateTime visitDate,
  }) async {
    final current = state;
    final existing = switch (current) {
      HealthRecordLoaded(:final records) => records,
      HealthRecordSaving(:final records) => records,
      HealthRecordError(:final records) => records,
      _ => const <HealthRecordEntity>[],
    };

    emit(HealthRecordSaving(records: existing));

    var success = false;
    (await _useCase.addRecord(
      petId: petId,
      title: title,
      recordType: recordType,
      description: description,
      clinicName: clinicName,
      visitDate: visitDate,
    )).when(
      (record) {
        success = true;
        emit(HealthRecordLoaded(records: [record, ...existing]));
      },
      (error) {
        emit(
          HealthRecordError(
            message: CatchErrorMessage(error: error).getWriteMessage(),
            records: existing,
          ),
        );
        if (existing.isNotEmpty) {
          emit(HealthRecordLoaded(records: existing));
        }
      },
    );

    return success;
  }
}
