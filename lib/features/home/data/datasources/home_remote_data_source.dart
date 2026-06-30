import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/core/errors/custome_exception.dart';
import 'package:rifq_v2/core/widgets/shared/shared_in_owner_flow/shared_auth/helpers/auth_helper.dart';
import 'package:rifq_v2/features/add_pet/data/models/pet_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseHomeDataSource {
  Future<Map<String, dynamic>?> fetchUserProfile();
  Future<List<PetModel>> fetchUserPets(String ownerId);
}

@LazySingleton(as: BaseHomeDataSource)
class HomeDataSource implements BaseHomeDataSource {
  final SupabaseClient supabase;

  HomeDataSource(this.supabase);

  //!!------------------USER PROFILE --------------------------
  @override
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    try{
      final isGuest = AuthHelper.isGuestUser();
      if (isGuest) return null;
      final userId = AuthHelper.getUserId();
      if (userId == null) return null;
      final profile = await supabase
          .from('users')
          .select('id, name')
          .eq('id', userId)
          .maybeSingle();
      return profile;
    }catch (e) {
      throw CustomException(
        message: CatchErrorMessage(error: e).getWriteMessage(),
      );
    }

  }


  //!!------------------USER PETS-----------------------------
  @override
  Future<List<PetModel>> fetchUserPets(String ownerId) async {
    try{
      final petsData = await supabase
          .from('pets')
          .select()
          .eq('owner_id', ownerId);

      return (petsData as List<dynamic>)
          .map((e) => PetModelMapper.fromJson(jsonEncode(e)))
          .toList();
    }catch (e) {
      throw CustomException(
        message: CatchErrorMessage(error: e).getWriteMessage(),
      );
    }

  }

}