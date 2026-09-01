import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_pet_card_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_request_card_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_request_model.dart';
import 'package:rifq_v2/features/adoption/data/models/my_adoption_pet_model.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionRemoteDataSource {
  Future<AdoptionPostModel> createAdoptionPost(AdoptionPostModel adoptionPost);

  Future<List<AdoptionPetCardModel>> getAdoptionPetCards();

  Future<Map<String, dynamic>> getAdoptionPetDetails(String adoptionPostId);

  Future<AdoptionRequestModel> createAdoptionRequest(
    AdoptionRequestModel adoptionRequest,
  );

  Future<List<MyAdoptionPetModel>> getMyAdoptionPetCards();

  Future<void> deleteAdoptionPost(String adoptionPostId);

  Future<List<AdoptionRequestCardModel>> getAdoptionRequests(
    String adoptionPostId,
  );

  Future<void> updateAdoptionRequestStatus({
    required String requestId,
    required String status,
  });

  Future<void> updateAdoptionPostStatus({
    required String adoptionPostId,
    required String status,
  });

  Future<String?> getMyAdoptionRequestStatus(String adoptionPostId);

  Future<String?> getPetIdForAdoptionPost(String adoptionPostId);

  Future<void> removeOwnedPetFromCache(String petId);

  Future<void> refreshUserPetsCache();
}

@LazySingleton(as: AdoptionRemoteDataSource)
class AdoptionRemoteDataSourceImpl implements AdoptionRemoteDataSource {
  final SupabaseClient _supabase;

  AdoptionRemoteDataSourceImpl(this._supabase);

  @override
  Future<AdoptionPostModel> createAdoptionPost(
    AdoptionPostModel adoptionPost,
  ) async {
    final response = await _supabase
        .from('adoption_posts')
        .insert(adoptionPost.toJson())
        .select()
        .single();

    return AdoptionPostModel.fromJson(response);
  }

  @override
  Future<List<AdoptionPetCardModel>> getAdoptionPetCards() async {
    final userId = _supabase.auth.currentUser?.id;

    final response = await _supabase
        .from('adoption_pet_cards')
        .select()
        .order('adoption_post_id', ascending: false);

    final cards = (response as List)
        .map((json) => AdoptionPetCardModel.fromJson(json))
        .toList();

    if (userId == null) {
      return cards;
    }

    return cards
        .where((card) => card.posterId != userId)
        .toList();
  }

  Future<Map<String, dynamic>> getAdoptionPetDetails(
    String adoptionPostId,
  ) async {
    final response = await _supabase
        .from('adoption_posts')
        .select('''
        id,
        description,
        status,
        location,

        pet:pets (
          id,
          name,
          birthdate,
          gender,
          breed,
          weight,

          pet_photos (
            public_url,
            is_primary,
            display_order
          )
        ),

        owner:profiles (
          id,
          full_name,
          avatar_url,
          phone_number
        )
      ''')
        .eq('id', adoptionPostId)
        .single();

    return response;
  }

  @override
  Future<AdoptionRequestModel> createAdoptionRequest(
    AdoptionRequestModel adoptionRequest,
  ) async {
    final pending = await _supabase
        .from('adoption_requests')
        .select('id')
        .eq('adoption_post_id', adoptionRequest.adoptionPostId)
        .eq('requester_id', adoptionRequest.requesterId)
        .eq('status', 'pending')
        .maybeSingle();

    if (pending != null) {
      throw Exception(
        'You already have a pending request for this pet. You can submit another request only if the owner rejects it.',
      );
    }

    try {
      final response = await _supabase
          .from('adoption_requests')
          .insert(adoptionRequest.toJson())
          .select()
          .single();

      return AdoptionRequestModel.fromJson(response);
    } on PostgrestException catch (error) {
      if (error.code == '23505') {
        throw Exception(
          'You already have a pending request for this pet. You can submit another request only if the owner rejects it.',
        );
      }
      if (error.message.contains('pending request')) {
        throw Exception(
          'You already have a pending request for this pet. You can submit another request only if the owner rejects it.',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<MyAdoptionPetModel>> getMyAdoptionPetCards() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User not found');
    }

    final postsResponse = await _supabase
        .from('adoption_posts')
        .select('''
          id,
          location,
          status,
          pet:pets (
            id,
            name,
            birthdate,
            species,
            pet_photos (
              public_url,
              is_primary,
              display_order
            )
          )
        ''')
        .eq('poster_id', userId)
        .order('created_at', ascending: false);

    final posts = List<Map<String, dynamic>>.from(postsResponse);

    if (posts.isEmpty) {
      return [];
    }

    final postIds = posts.map((post) => post['id'] as String).toList();

    final requestsResponse = await _supabase
        .from('adoption_requests')
        .select('adoption_post_id, status')
        .inFilter('adoption_post_id', postIds);

    final requests = List<Map<String, dynamic>>.from(requestsResponse);

    return posts.map((post) {
      final adoptionPostId = post['id'] as String;
      final petRaw = post['pet'];
      final pet = petRaw is Map
          ? Map<String, dynamic>.from(petRaw)
          : petRaw is List && petRaw.isNotEmpty && petRaw.first is Map
          ? Map<String, dynamic>.from(petRaw.first as Map)
          : <String, dynamic>{};
      final photos = (pet['pet_photos'] as List<dynamic>?) ?? [];

      String? imageUrl;
      if (photos.isNotEmpty) {
        final sorted = [...photos]
          ..sort((a, b) {
            final aMap = Map<String, dynamic>.from(a as Map);
            final bMap = Map<String, dynamic>.from(b as Map);
            final aPrimary = aMap['is_primary'] == true ? 0 : 1;
            final bPrimary = bMap['is_primary'] == true ? 0 : 1;
            if (aPrimary != bPrimary) return aPrimary.compareTo(bPrimary);
            return ((aMap['display_order'] as int?) ?? 0).compareTo(
              (bMap['display_order'] as int?) ?? 0,
            );
          });
        imageUrl =
            (Map<String, dynamic>.from(sorted.first as Map))['public_url']
                as String?;
      }

      final petRequests = requests.where(
        (request) => request['adoption_post_id'] == adoptionPostId,
      );

      final statuses = petRequests
          .map((request) => request['status'].toString().toLowerCase())
          .toList();

      String status = (post['status'] as String? ?? '').toLowerCase();

      if (statuses.contains('accepted') || status == 'adopted') {
        status = 'adopted';
      } else if (statuses.isNotEmpty &&
          statuses.every((requestStatus) => requestStatus == 'rejected')) {
        status = 'cancelled';
      } else if (statuses.isNotEmpty) {
        status = 'pending';
      } else if (status == 'available') {
        status = '';
      }

      final birthdateRaw = pet['birthdate'];

      return MyAdoptionPetModel(
        adoptionPostId: adoptionPostId,
        petId: pet['id'] as String? ?? '',
        name: pet['name'] as String? ?? '',
        birthdate: birthdateRaw != null
            ? DateTime.parse(birthdateRaw.toString())
            : DateTime.now(),
        location: post['location'] as String? ?? '',
        imageUrl: imageUrl,
        species: pet['species'] as String?,
        status: status,
        requestsCount: statuses.length,
      );
    }).toList();
  }

  @override
  Future<void> deleteAdoptionPost(String adoptionPostId) async {
    await _supabase.from('adoption_posts').delete().eq('id', adoptionPostId);
  }

  @override
  Future<List<AdoptionRequestCardModel>> getAdoptionRequests(
    String adoptionPostId,
  ) async {
    final response = await _supabase
        .from('adoption_requests')
        .select('''
        id,
        adoption_post_id,
        requester_id,
        requester_name,
        requester_phone,
        requester_city,
        message,
        experience,
        status,
        created_at,

        requester:profiles (
          id,
          full_name,
          avatar_url,
          phone_number,
          location:location_text
        )
      ''')
        .eq('adoption_post_id', adoptionPostId)
        .order('created_at', ascending: false);

    return (response as List)
        .map(
          (json) => AdoptionRequestCardModel.fromJson(
            Map<String, dynamic>.from(json),
          ),
        )
        .toList();
  }

  @override
  Future<void> updateAdoptionRequestStatus({
    required String requestId,
    required String status,
  }) async {
    await _supabase
        .from('adoption_requests')
        .update({
          'status': status,
          'responded_at': DateTime.now().toIso8601String(),
        })
        .eq('id', requestId);
  }

  //update Adoption Post Status
  @override
  Future<void> updateAdoptionPostStatus({
    required String adoptionPostId,
    required String status,
  }) async {
    await _supabase
        .from('adoption_posts')
        .update({
          'status': status,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', adoptionPostId);
  }

  @override
  Future<String?> getMyAdoptionRequestStatus(String adoptionPostId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      return null;
    }

    final response = await _supabase
        .from('adoption_requests')
        .select('status')
        .eq('adoption_post_id', adoptionPostId)
        .eq('requester_id', userId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    return response?['status'] as String?;
  }

  @override
  Future<String?> getPetIdForAdoptionPost(String adoptionPostId) async {
    final response = await _supabase
        .from('adoption_posts')
        .select('pet_id')
        .eq('id', adoptionPostId)
        .maybeSingle();

    return response?['pet_id'] as String?;
  }

  @override
  Future<void> removeOwnedPetFromCache(String petId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    await UserDataStore.removePet(userId, petId);
  }

  @override
  Future<void> refreshUserPetsCache() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    await UserDataStore.fetchAndCache(_supabase, userId);
  }
}
