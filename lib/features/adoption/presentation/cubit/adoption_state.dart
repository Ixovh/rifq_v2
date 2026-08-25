import 'package:equatable/equatable.dart';
import '../../domain/entities/adoption_entity.dart';

abstract class AdoptionState extends Equatable {
  const AdoptionState();

  const factory AdoptionState.initial() = AdoptionInitial;
  const factory AdoptionState.loading() = AdoptionLoading;
  const factory AdoptionState.feedLoaded(List<AdoptionPostEntity> posts) =
      AdoptionFeedLoaded;
  const factory AdoptionState.myListingsLoaded(List<AdoptionPostEntity> posts) =
      AdoptionMyListingsLoaded;
  const factory AdoptionState.actionSuccess() = AdoptionActionSuccess;
  const factory AdoptionState.error(String message) = AdoptionError;

  @override
  List<Object?> get props => [];
}

class AdoptionInitial extends AdoptionState {
  const AdoptionInitial();
}

class AdoptionLoading extends AdoptionState {
  const AdoptionLoading();
}

class AdoptionFeedLoaded extends AdoptionState {
  final List<AdoptionPostEntity> posts;

  const AdoptionFeedLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class AdoptionMyListingsLoaded extends AdoptionState {
  final List<AdoptionPostEntity> posts;

  const AdoptionMyListingsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

// Used after successful creation
class AdoptionActionSuccess extends AdoptionState {
  const AdoptionActionSuccess();
}

class AdoptionError extends AdoptionState {
  final String message;

  const AdoptionError(this.message);

  @override
  List<Object?> get props => [message];
}
