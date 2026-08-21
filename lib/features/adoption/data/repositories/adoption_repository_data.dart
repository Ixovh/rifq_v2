import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/adoption_entity.dart';
import '../../domain/repositories/adoption_repository_domain.dart';
import '../models/adoption_model.dart';

@LazySingleton(as: AdoptionRepositoryDomain)
class AdoptionRepositoryData implements AdoptionRepositoryDomain {
  final SupabaseClient _supabase;
  final Uuid _uuid = const Uuid();

  AdoptionRepositoryData(this._supabase);

  @override
  Future<List<AdoptionPostEntity>> fetchAvailableAdoptionPosts() async {
    final response = await _supabase
        .from('adoption_posts')
        .select('''
          *,
          pets (*),
          profiles (*),
          pet_photos (*)
        ''')
        .eq('status', 'available')
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => AdoptionPostModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<List<AdoptionPostEntity>> fetchMyListings(String userId) async {
    final response = await _supabase
        .from('adoption_posts')
        .select('''
          *,
          pets (*),
          profiles (*),
          pet_photos (*)
        ''')
        .eq('poster_id', userId)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => AdoptionPostModel.fromJson(json).toEntity())
        .toList();
  }

  @override
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
  }) async {
    final currentUserId = _supabase.auth.currentUser!.id;
    final petId = _uuid.v4();
    final postId = _uuid.v4();

    await _supabase.from('pets').insert({
      'id': petId,
      'owner_id': currentUserId,
      'name': petName,
      'species': species,
      'breed': breed,
      'age': age,
      'gender': gender,
      'health_status_summary': healthStatusSummary,
    });

    for (int i = 0; i < imageFiles.length; i++) {
      final file = imageFiles[i];
      final photoId = _uuid.v4();
      final fileExt = file.path.split('.').last;
      final storagePath = 'pets/$petId/$photoId.$fileExt';

      await _supabase.storage.from('rifq_media').upload(storagePath, file);
      final publicUrl = _supabase.storage
          .from('rifq_media')
          .getPublicUrl(storagePath);

      await _supabase.from('pet_photos').insert({
        'id': photoId,
        'pet_id': petId,
        'uploader_id': currentUserId,
        'storage_path': storagePath,
        'public_url': publicUrl,
        'is_primary': i == 0,
        'display_order': i,
      });
    }

    await _supabase.from('adoption_posts').insert({
      'id': postId,
      'pet_id': petId,
      'poster_id': currentUserId,
      'description': description,
      'status': 'available',
      'location': location,
    });
  }
}
