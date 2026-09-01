import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/boarding_request_entity.dart';

part 'boarding_request_model.mapper.dart';

@MappableClass()
class BoardingRequestModel extends BoardingRequestEntity
    with BoardingRequestModelMappable {
  const BoardingRequestModel({
    required super.id,
    @MappableField(key: 'sitter_id') required super.sitterId,
    @MappableField(key: 'requester_id') required super.requesterId,
    required super.status,
    super.message,
    @MappableField(key: 'created_at') required super.createdAt,
    @MappableField(key: 'updated_at') required super.updatedAt,
  });

  factory BoardingRequestModel.fromJson(Map<String, dynamic> json) =>
      BoardingRequestModelMapper.fromMap(json);
}
