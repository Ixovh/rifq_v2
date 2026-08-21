import 'dart:io';
import '../entities/adoption_entity.dart';

abstract class AdoptionRepositoryDomain {
  Future<List<AdoptionPostEntity>> fetchAvailableAdoptionPosts();

  Future<List<AdoptionPostEntity>> fetchMyListings(String userId);

  Future<void> createAdoptionListing({
    required String petName,
    required String species,
    required String breed,
    required int age,
    required String gender,
    String? healthStatusSummary,
    required String description,
    required String location,
    required List<File> imageFiles,
  });
}
