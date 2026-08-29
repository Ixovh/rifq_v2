import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/data/models/account_model.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/shared/constants/storage_buckets.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/profile_image_cache.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAccountDataSource {
  Future<Result<AccountDataEntity, Object>> getAccountData({
    bool forceRefresh = false,
  });

  Future<Result<AccountUpdateResult, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
    File? imageFile,
    bool removeImage = false,
    required String email,
  });

  Future<Result<Null, Object>> logOut();
}

@LazySingleton(as: BaseAccountDataSource)
class AccountDataSource implements BaseAccountDataSource {
  AccountDataSource({required SupabaseClient supabase}) : _supabase = supabase;

  final SupabaseClient _supabase;

  static const _profileSelect =
      'id, role, full_name, phone_number, image_url, created_at, updated_at';

  @override
  Future<Result<AccountDataEntity, Object>> getAccountData({
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

      var snapshot = forceRefresh ? null : UserDataStore.read(userId);
      snapshot ??= await UserDataStore.fetchAndCache(_supabase, userId);

      final profile = AccountModel.fromJson(UserDataStore.profileOf(snapshot));
      final email = (snapshot['email'] as String?) ?? '';
      final pets = UserDataStore.petsOf(
        snapshot,
      ).map(AccountPetModel.fromJson).toList();

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
    File? imageFile,
    bool removeImage = false,
    required String email,
  }) async {
    final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
    if (userId == null) {
      return Error('User not found');
    }

    // Local-first: apply the edits to the cached snapshot before hitting the
    // server, so every screen reading the store sees them immediately.
    // Kept for rollback if the server rejects the update.
    final previousSnapshot = UserDataStore.read(userId);
    await UserDataStore.mergeProfileFields(userId, {
      'full_name': fullName.trim().isEmpty ? null : fullName.trim(),
      'phone_number': phoneNumber?.trim().isEmpty == true
          ? null
          : phoneNumber?.trim(),
    });

    try {
      final uploadedImageUrl = imageFile != null
          ? await _replaceProfileImage(userId: userId, file: imageFile)
          : null;

      final updates = <String, dynamic>{
        'full_name': fullName.trim().isEmpty ? null : fullName.trim(),
        'phone_number': phoneNumber?.trim().isEmpty == true
            ? null
            : phoneNumber?.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      };
      if (removeImage && imageFile == null) {
        await _deleteRemoteProfileImages(userId);
        await ProfileImageCache.clear(userId);
        updates['image_url'] = null;
      } else if (uploadedImageUrl != null) {
        updates['image_url'] = uploadedImageUrl;
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

      // Sync the store with the authoritative server row (adds image_url
      // and updated_at on top of the optimistic local write above).
      await UserDataStore.mergeProfileFields(
        userId,
        Map<String, dynamic>.from(updated),
        email: resolvedEmail,
      );

      return Success(
        AccountUpdateResult(
          profile: AccountModel.fromJson(updated),
          email: resolvedEmail,
          pendingEmail: emailConfirmationPending ? nextEmail : null,
          emailConfirmationPending: emailConfirmationPending,
        ),
      );
    } catch (e) {
      if (previousSnapshot != null) {
        await UserDataStore.write(userId, previousSnapshot);
      }
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> logOut() async {
    try {
      final userId = AuthHelper.getUserId();
      await _supabase.auth.signOut();
      await AuthHelper.logout();
      if (userId != null) {
        await ProfileImageCache.clear(userId);
        await UserDataStore.clear(userId);
      }
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  Future<String> _replaceProfileImage({
    required String userId,
    required File file,
  }) async {
    final compressed = await ProfileImageCache.compress(file);

    // Drop the stale local copy and old remote files before uploading, and
    // use a timestamped name so the public URL changes — otherwise clients
    // that cached the previous URL would keep showing the old picture.
    await ProfileImageCache.clear(userId);
    await _deleteRemoteProfileImages(userId);

    final storagePath =
        '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await _supabase.storage
        .from(StorageBuckets.userProfiles)
        .upload(
          storagePath,
          compressed,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    final publicUrl = _supabase.storage
        .from(StorageBuckets.userProfiles)
        .getPublicUrl(storagePath);

    await ProfileImageCache.save(
      userId: userId,
      file: compressed,
      imageUrl: publicUrl,
    );
    return publicUrl;
  }

  Future<void> _deleteRemoteProfileImages(String userId) async {
    try {
      final items = await _supabase.storage
          .from(StorageBuckets.userProfiles)
          .list(path: userId);
      final paths = items
          .where((item) => item.name.isNotEmpty)
          .map((item) => '$userId/${item.name}')
          .toList();
      if (paths.isEmpty) return;
      await _supabase.storage.from(StorageBuckets.userProfiles).remove(paths);
    } catch (_) {
      // Folder may not exist yet for a first upload.
    }
  }
}
