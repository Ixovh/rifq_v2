import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'adoption_model.freezed.dart';
part 'adoption_model.g.dart';

@freezed
abstract class AdoptionModel with _$AdoptionModel {
  const factory AdoptionModel({
    required int id,
    required String firstName,
    required String lastName,
    
  }) = _AdoptionModel;

  factory AdoptionModel.fromJson(Map<String, Object?> json) => _$AdoptionModelFromJson(json);
}



extension AdoptionModelMapper on AdoptionModel {
  AdoptionEntity toEntity() {
    return AdoptionEntity(id: id, firstName: firstName, lastName: lastName);
  }
  }
