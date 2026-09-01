import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';

part 'home_boarding_skill_model.mapper.dart';

@MappableClass()
class HomeBoardingSkillModel extends HomeBoardingSkillEntity
    with HomeBoardingSkillModelMappable {
  const HomeBoardingSkillModel({
    required super.id,
    @MappableField(key: 'skill_label') required super.skillLabel,
  });

  factory HomeBoardingSkillModel.fromJson(Map<String, dynamic> json) =>
      HomeBoardingSkillModelMapper.fromMap(json);
}
