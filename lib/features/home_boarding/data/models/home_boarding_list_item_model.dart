import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_json_coercion.dart';
import 'package:rifq_v2/features/home_boarding/data/models/sitter_profile_ref_model.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';

part 'home_boarding_list_item_model.mapper.dart';

@MappableClass()
class HomeBoardingListItemModel with HomeBoardingListItemModelMappable {
  final String id;
  final String specialty;
  final double rating;

  @MappableField(key: 'review_count')
  final int reviewCount;

  @MappableField(key: 'area_text')
  final String areaText;

  @MappableField(key: 'price_per_night')
  final double pricePerNight;

  @MappableField(key: 'years_experience')
  final int yearsExperience;

  @MappableField(key: 'profiles')
  final SitterProfileRefModel? profile;

  const HomeBoardingListItemModel({
    required this.id,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.areaText,
    required this.pricePerNight,
    required this.yearsExperience,
    this.profile,
  });

  factory HomeBoardingListItemModel.fromJson(Map<String, dynamic> json) =>
      HomeBoardingListItemModelMapper.fromMap(_coerce(json));

  static Map<String, dynamic> _coerce(Map<String, dynamic> json) {
    final copy = Map<String, dynamic>.from(json);
    copy['rating'] = toDouble(copy['rating']) ?? 0;
    copy['price_per_night'] = toDouble(copy['price_per_night']) ?? 0;
    final listingName = (copy['name'] as String?)?.trim();
    if (listingName != null && listingName.isNotEmpty) {
      final profile = copy['profiles'] is Map
          ? Map<String, dynamic>.from(copy['profiles'] as Map)
          : <String, dynamic>{};
      profile['full_name'] = listingName;
      copy['profiles'] = profile;
    }
    return copy;
  }

  HomeBoardingListItemEntity toEntity() => HomeBoardingListItemEntity(
    id: id,
    name: profile?.fullName ?? 'Sitter',
    imageUrl: profile?.imageUrl,
    specialty: specialty,
    rating: rating,
    reviewCount: reviewCount,
    areaText: areaText,
    pricePerNight: pricePerNight,
    yearsExperience: yearsExperience,
  );
}
