import 'package:dart_mappable/dart_mappable.dart';
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
      HomeBoardingListItemModelMapper.fromMap(json);

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
