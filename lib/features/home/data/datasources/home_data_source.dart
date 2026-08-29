import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseHomeDataSource {
  Future<Result<HomeDataEntity, Object>> getHomeData({
    bool forceRefresh = false,
  });
}

@LazySingleton(as: BaseHomeDataSource)
class HomeDataSource implements BaseHomeDataSource {
  const HomeDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<Result<HomeDataEntity, Object>> getHomeData({
    bool forceRefresh = false,
  }) async {
    try {
      if (AuthHelper.isGuestUser()) {
        return Error('guest');
      }

      final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
      if (userId == null) {
        return Error('User not found');
      }

      // Shared snapshot with Account: whichever screen loads first fetches
      // once, every later read is local.
      var snapshot = forceRefresh ? null : UserDataStore.read(userId);
      snapshot ??= await UserDataStore.fetchAndCache(_supabase, userId);

      final profile = UserDataStore.profileOf(snapshot);
      final fullName = (profile['full_name'] as String?)?.trim() ?? '';
      final imageUrl = profile['image_url'] as String?;

      final pets = UserDataStore.petsOf(snapshot)
          .map(
            (pet) => HomePetEntity(
              id: pet['id'] as String,
              name: pet['name'] as String? ?? '',
              photoUrl: pet['photo_url'] as String?,
            ),
          )
          .toList();

      return Success(
        HomeDataEntity(
          username: fullName.isEmpty ? 'User' : fullName,
          imageUrl: imageUrl,
          pets: pets,
        ),
      );
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
