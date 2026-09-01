import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_pet_card_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_request_card_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_request_model.dart';
import 'package:rifq_v2/features/adoption/data/models/my_adoption_pet_model.dart';
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
    final response = await _supabase
        .from('adoption_pet_cards')
        .select()
        .order('adoption_post_id', ascending: false);

    return (response as List)
        .map((json) => AdoptionPetCardModel.fromJson(json))
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
    final response = await _supabase
        .from('adoption_requests')
        .insert(adoptionRequest.toJson())
        .select()
        .single();

    return AdoptionRequestModel.fromJson(response);
  }

  @override
  Future<List<MyAdoptionPetModel>> getMyAdoptionPetCards() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User not found');
    }

    // =========================
    // 1. Get my adoption posts
    // =========================

    final postsResponse = await _supabase
        .from('adoption_posts')
        .select('id')
        .eq('poster_id', userId);

    final posts = List<Map<String, dynamic>>.from(postsResponse);

    if (posts.isEmpty) {
      return [];
    }

    final postIds = posts.map((post) => post['id'] as String).toList();

    // =========================
    // 2. Get pets information
    // =========================

    final petsResponse = await _supabase
        .from('adoption_pet_cards')
        .select()
        .inFilter('adoption_post_id', postIds);

    final pets = List<Map<String, dynamic>>.from(petsResponse);

    // =========================
    // 3. Get adoption requests
    // =========================

    final requestsResponse = await _supabase
        .from('adoption_requests')
        .select('adoption_post_id, status')
        .inFilter('adoption_post_id', postIds);

    final requests = List<Map<String, dynamic>>.from(requestsResponse);

    // =========================
    // 4. Build My Pets cards
    // =========================

    return pets.map((pet) {
      final adoptionPostId = pet['adoption_post_id'] as String;

      final petRequests = requests.where(
        (request) => request['adoption_post_id'] == adoptionPostId,
      );

      final statuses = petRequests
          .map((request) => request['status'].toString().toLowerCase())
          .toList();

      // String status = 'pending';

      // if (statuses.contains('accepted')) {
      //   status = 'adopted';
      // } else if (statuses.isNotEmpty &&
      //     statuses.every((status) => status == 'rejected')) {
      //   status = 'cancelled';
      // }

      String status = '';

      if (statuses.contains('accepted')) {
        status = 'adopted';
      } else if (statuses.isNotEmpty &&
          statuses.every((status) => status == 'rejected')) {
        status = 'cancelled';
      } else if (statuses.isNotEmpty) {
        status = 'pending';
      }

      return MyAdoptionPetModel(
        adoptionPostId: adoptionPostId,
        petId: pet['pet_id'] as String,
        name: pet['name'] as String,
        birthdate: DateTime.parse(pet['birthdate'] as String),
        location: pet['location'] as String? ?? '',
        imageUrl: pet['image_url'] as String?,
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
}
