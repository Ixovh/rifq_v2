part of 'sitter_detail_cubit.dart';

sealed class SitterDetailState extends Equatable {
  const SitterDetailState();

  @override
  List<Object?> get props => [];
}

final class SitterDetailInitial extends SitterDetailState {}

final class SitterDetailLoading extends SitterDetailState {}

final class SitterDetailLoaded extends SitterDetailState {
  final HomeBoardingDetailEntity detail;

  const SitterDetailLoaded({required this.detail});

  @override
  List<Object?> get props => [detail];
}

final class SitterDetailError extends SitterDetailState {
  final String msg;

  const SitterDetailError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
