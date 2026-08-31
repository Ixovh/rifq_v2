import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';

part 'hotel_rule_model.mapper.dart';

@MappableClass()
class HotelRuleModel extends HotelRuleEntity with HotelRuleModelMappable {
  const HotelRuleModel({
    required super.id,
    @MappableField(key: 'rule_text') required super.ruleText,
    @MappableField(key: 'display_order') super.displayOrder = 0,
  });

  factory HotelRuleModel.fromJson(Map<String, dynamic> json) =>
      HotelRuleModelMapper.fromMap(json);
}
