import 'package:dart_mappable/dart_mappable.dart';

part 'sitter_profile_ref_model.mapper.dart';

@MappableClass()
class SitterProfileRefModel with SitterProfileRefModelMappable {
  @MappableField(key: 'full_name')
  final String fullName;

  @MappableField(key: 'image_url')
  final String? imageUrl;

  @MappableField(key: 'phone_number')
  final String? phoneNumber;

  const SitterProfileRefModel({
    required this.fullName,
    this.imageUrl,
    this.phoneNumber,
  });

  factory SitterProfileRefModel.fromJson(Map<String, dynamic> json) =>
      SitterProfileRefModelMapper.fromMap(json);
}
