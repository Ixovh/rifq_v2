import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/adoption_entity.dart';

part 'adoption_state.freezed.dart';

@freezed
class AdoptionState with _$AdoptionState {
  const factory AdoptionState.initial() = _Initial;
  const factory AdoptionState.loading() = _Loading;

  const factory AdoptionState.feedLoaded(List<AdoptionPostEntity> posts) =
      _FeedLoaded;
  const factory AdoptionState.myListingsLoaded(List<AdoptionPostEntity> posts) =
      _MyListingsLoaded;

  const factory AdoptionState.actionSuccess() =
      _ActionSuccess; // Used after successful creation
  const factory AdoptionState.error(String message) = _Error;
}
