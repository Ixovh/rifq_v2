import 'package:equatable/equatable.dart';

class HomeBoardingListItemEntity extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String areaText;
  final double pricePerNight;
  final int yearsExperience;

  const HomeBoardingListItemEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.areaText,
    required this.pricePerNight,
    required this.yearsExperience,
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
  ];
}
