part of 'health_record_cubit.dart';

sealed class HealthRecordState extends Equatable {
  const HealthRecordState();

  @override
  List<Object?> get props => [];
}

final class HealthRecordInitial extends HealthRecordState {}

final class HealthRecordLoading extends HealthRecordState {}

final class HealthRecordLoaded extends HealthRecordState {
  const HealthRecordLoaded({required this.records});

  final List<HealthRecordEntity> records;

  @override
  List<Object?> get props => [records];
}

final class HealthRecordSaving extends HealthRecordState {
  const HealthRecordSaving({required this.records});

  final List<HealthRecordEntity> records;

  @override
  List<Object?> get props => [records];
}

final class HealthRecordError extends HealthRecordState {
  const HealthRecordError({required this.message, this.records = const []});

  final String message;
  final List<HealthRecordEntity> records;

  @override
  List<Object?> get props => [message, records];
}
