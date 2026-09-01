import 'package:equatable/equatable.dart';

class HomeBoardingSkillEntity extends Equatable {
  final String id;
  final String skillLabel;

  const HomeBoardingSkillEntity({required this.id, required this.skillLabel});

  @override
  List<Object?> get props => [id, skillLabel];
}

class HomeBoardingDetailEntity extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String areaText;
  final double pricePerNight;
  final int yearsExperience;
  final String? bio;
  final String? phoneNumber;
  final List<String> skills;

  const HomeBoardingDetailEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.areaText,
    required this.pricePerNight,
    required this.yearsExperience,
    this.bio,
    this.phoneNumber,
    required this.skills,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    specialty,
    rating,
    reviewCount,
    areaText,
    pricePerNight,
    yearsExperience,
    bio,
    phoneNumber,
    skills,
  ];
}
