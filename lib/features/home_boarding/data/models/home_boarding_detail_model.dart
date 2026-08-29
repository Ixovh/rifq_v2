import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/home_boarding/data/models/home_boarding_skill_model.dart';
import 'package:rifq_v2/features/home_boarding/data/models/sitter_profile_ref_model.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';

part 'home_boarding_detail_model.mapper.dart';

@MappableClass()
class HomeBoardingDetailModel with HomeBoardingDetailModelMappable {
  final String id;
  final String specialty;
  final double rating;
  final String? bio;

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

  @MappableField(key: 'home_boarding_skills')
  final List<HomeBoardingSkillModel> skills;

  const HomeBoardingDetailModel({
    required this.id,
    required this.specialty,
    required this.rating,
    this.bio,
    required this.reviewCount,
    required this.areaText,
    required this.pricePerNight,
    required this.yearsExperience,
    this.profile,
    this.skills = const [],
  });

  factory HomeBoardingDetailModel.fromJson(Map<String, dynamic> json) =>
      HomeBoardingDetailModelMapper.fromMap(json);

  HomeBoardingDetailEntity toEntity() => HomeBoardingDetailEntity(
    id: id,
    name: profile?.fullName ?? 'Sitter',
    imageUrl: profile?.imageUrl,
    specialty: specialty,
    rating: rating,
    reviewCount: reviewCount,
    areaText: areaText,
    pricePerNight: pricePerNight,
    yearsExperience: yearsExperience,
    bio: bio,
    phoneNumber: profile?.phoneNumber,
    skills: skills.map((s) => s.skillLabel).toList(),
  );
}
