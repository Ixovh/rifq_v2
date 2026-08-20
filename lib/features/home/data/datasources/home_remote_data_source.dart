import 'package:injectable/injectable.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
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
    try {
      final isGuest = AuthHelper.isGuestUser();
      if (isGuest) return null;
      final userId = AuthHelper.getUserId();
      if (userId == null) return null;
      final profile = await supabase
          .from('profiles')
          .select('id, full_name')
          .eq('id', userId)
          .maybeSingle();
      return profile;
    } catch (e) {
      throw CustomException(
        message: CatchErrorMessage(error: e).getWriteMessage(),
      );
    }
  }

  //!!------------------USER PETS-----------------------------
  @override
  Future<List<PetModel>> fetchUserPets(String ownerId) async {
    try {
      final petsData = await supabase
          .from('pets')
          .select(
            'id, owner_id, name, species, gender, breed, age, created_at, '
            'pet_photos ( public_url, is_primary, display_order )',
          )
          .eq('owner_id', ownerId);

      return (petsData as List<dynamic>).map((raw) {
        final row = Map<String, dynamic>.from(raw as Map);
        final photos = (row['pet_photos'] as List<dynamic>?) ?? [];
        String photoUrl = '';
        if (photos.isNotEmpty) {
          final sorted = [...photos]..sort((a, b) {
            final aMap = Map<String, dynamic>.from(a as Map);
            final bMap = Map<String, dynamic>.from(b as Map);
            final aPrimary = aMap['is_primary'] == true ? 0 : 1;
            final bPrimary = bMap['is_primary'] == true ? 0 : 1;
            if (aPrimary != bPrimary) return aPrimary.compareTo(bPrimary);
            return ((aMap['display_order'] as int?) ?? 0)
                .compareTo((bMap['display_order'] as int?) ?? 0);
          });
          photoUrl =
              (Map<String, dynamic>.from(sorted.first as Map))['public_url']
                  as String? ??
              '';
        }

        final age = row['age'] as int?;
        final birthdate = age != null
            ? DateTime.now().subtract(Duration(days: 365 * age))
            : DateTime.now();
        final createdAtRaw = row['created_at'];
        final createdAt = createdAtRaw is String
            ? DateTime.parse(createdAtRaw)
            : (createdAtRaw as DateTime? ?? DateTime.now());

        return PetModel(
          id: row['id'] as String,
          ownerId: row['owner_id'] as String,
          name: row['name'] as String? ?? '',
          species: row['species'] as String? ?? '',
          gender: row['gender'] as String? ?? '',
          breed: row['breed'] as String? ?? '',
          birthdate: birthdate,
          photoUrl: photoUrl,
          createdAt: createdAt,
        );
      }).toList();
    } catch (e) {
      throw CustomException(
        message: CatchErrorMessage(error: e).getWriteMessage(),
      );
    }
  }

}