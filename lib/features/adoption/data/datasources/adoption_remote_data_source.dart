import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_pet_card_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionRemoteDataSource {
  Future<AdoptionPostModel> createAdoptionPost(
    AdoptionPostModel adoptionPost,
  );

  Future<List<AdoptionPetCardModel>> getAdoptionPetCards();

   Future<Map<String, dynamic>> getAdoptionPetDetails(
    String adoptionPostId,
  );
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
        .map(
          (json) => AdoptionPetCardModel.fromJson(json),
        )
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
          avatar_url
        )
      ''')
      .eq('id', adoptionPostId)
      .single();

  return response;
}
}