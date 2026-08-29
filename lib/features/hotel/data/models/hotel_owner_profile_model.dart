import 'package:dart_mappable/dart_mappable.dart';

part 'hotel_owner_profile_model.mapper.dart';

@MappableClass()
class HotelOwnerProfileModel with HotelOwnerProfileModelMappable {
  @MappableField(key: 'full_name')
  final String fullName;

  const HotelOwnerProfileModel({required this.fullName});

  factory HotelOwnerProfileModel.fromJson(Map<String, dynamic> json) =>
      HotelOwnerProfileModelMapper.fromMap(json);
}
