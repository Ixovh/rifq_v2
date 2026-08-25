import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionRemoteDataSource {
  Future<AdoptionPostModel> createAdoptionPost(
    AdoptionPostModel adoptionPost,
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
}