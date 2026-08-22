import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/data/models/account_model.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAccountDataSource {
  Future<Result<AccountDataEntity, Object>> getAccountData();

  Future<Result<AccountUpdateResult, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
    required String email,
  });

  Future<Result<Null, Object>> logOut();
}

@LazySingleton(as: BaseAccountDataSource)
class AccountDataSource implements BaseAccountDataSource {
  AccountDataSource({required SupabaseClient supabase}) : _supabase = supabase;

  final SupabaseClient _supabase;

  static const _profileSelect =
      'id, role, full_name, phone_number, avatar_url, created_at, updated_at';

  @override
  Future<Result<AccountDataEntity, Object>> getAccountData() async {
    try {
      if (AuthHelper.isGuestUser()) {
        return Error('guest');
      }

      final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
      if (userId == null) {
        return Error('User not found');
      }

      final profileRow = await _supabase
          .from('profiles')
          .select(_profileSelect)
          .eq('id', userId)
          .maybeSingle();

      if (profileRow == null) {
        return Error('Profile not found');
      }

      final profile = AccountModel.fromJson(profileRow);
      final email = _supabase.auth.currentUser?.email ?? '';

      final petsRows = await _supabase
          .from('pets')
          .select('''
            id,
            name,
            gender,
            breed,
            age,
            pet_photos ( public_url, is_primary, display_order ),
            adoption_posts ( status )
          ''')
          .eq('owner_id', userId)
          .order('created_at', ascending: false);

      final pets = (petsRows as List<dynamic>).map((raw) {
        final row = Map<String, dynamic>.from(raw as Map);
        final photos = (row['pet_photos'] as List<dynamic>?) ?? [];
        String? photoUrl;
        if (photos.isNotEmpty) {
          final sorted = [...photos]..sort((a, b) {
            final aMap = Map<String, dynamic>.from(a as Map);
            final bMap = Map<String, dynamic>.from(b as Map);
            final aPrimary = aMap['is_primary'] == true ? 0 : 1;
            final bPrimary = bMap['is_primary'] == true ? 0 : 1;
            if (aPrimary != bPrimary) return aPrimary.compareTo(bPrimary);
            final aOrder = aMap['display_order'] as int? ?? 0;
            final bOrder = bMap['display_order'] as int? ?? 0;
            return aOrder.compareTo(bOrder);
          });
          photoUrl =
              (Map<String, dynamic>.from(sorted.first as Map))['public_url']
                  as String?;
        }

        final adoptionPosts = (row['adoption_posts'] as List<dynamic>?) ?? [];
        final listedForAdoption = adoptionPosts.any(
          (post) =>
              (post as Map)['status'] == 'available' ||
              post['status'] == 'pending',
        );

        return AccountPetModel(
          id: row['id'] as String,
          name: row['name'] as String? ?? '',
          gender: row['gender'] as String? ?? '',
          breed: row['breed'] as String? ?? '',
          age: row['age'] as int?,
          photoUrl: photoUrl,
          listedForAdoption: listedForAdoption,
        );
      }).toList();

      return Success(
        AccountDataEntity(profile: profile, email: email, pets: pets),
      );
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AccountUpdateResult, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
    required String email,
  }) async {
    try {
      final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
      if (userId == null) {
        return Error('User not found');
      }

      final updates = <String, dynamic>{
        'full_name': fullName.trim().isEmpty ? null : fullName.trim(),
        'phone_number':
            phoneNumber?.trim().isEmpty == true ? null : phoneNumber?.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      };
      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }

      final updated = await _supabase
          .from('profiles')
          .update(updates)
          .eq('id', userId)
          .select(_profileSelect)
          .single();

      final currentEmail = _supabase.auth.currentUser?.email?.trim() ?? '';
      final nextEmail = email.trim();
      var emailConfirmationPending = false;
      var resolvedEmail = currentEmail;

      if (nextEmail.isNotEmpty &&
          nextEmail.toLowerCase() != currentEmail.toLowerCase()) {
        await _supabase.auth.updateUser(UserAttributes(email: nextEmail));
        // Until the user confirms, Auth often still exposes the old email.
        final afterUpdate = _supabase.auth.currentUser?.email?.trim() ?? '';
        emailConfirmationPending =
            afterUpdate.toLowerCase() != nextEmail.toLowerCase();
        resolvedEmail = emailConfirmationPending ? currentEmail : nextEmail;
      }

      return Success(
        AccountUpdateResult(
          profile: AccountModel.fromJson(updated),
          email: resolvedEmail,
          pendingEmail: emailConfirmationPending ? nextEmail : null,
          emailConfirmationPending: emailConfirmationPending,
        ),
      );
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> logOut() async {
    try {
      await _supabase.auth.signOut();
      await AuthHelper.logout();
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
