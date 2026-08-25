import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/data/models/account_model.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/shared/constants/storage_buckets.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseEditPetDataSource {
  Future<Result<AccountPetEntity, Object>> getPet(String petId);

  Future<Result<AccountPetEntity, Object>> updatePet({
    required String petId,
    required String name,
    required String breed,
    required DateTime birthdate,
    double? weight,
    File? photoFile,
  });
}

@LazySingleton(as: BaseEditPetDataSource)
class EditPetDataSource implements BaseEditPetDataSource {
  EditPetDataSource({required SupabaseClient supabase}) : _supabase = supabase;

  final SupabaseClient _supabase;

  String? get _userId =>
      AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;

  @override
  Future<Result<AccountPetEntity, Object>> getPet(String petId) async {
    try {
      final userId = _userId;
      if (userId == null) return Error('User not found');

      var cached = UserDataStore.petById(userId, petId);
      if (cached == null) {
        await UserDataStore.fetchAndCache(_supabase, userId);
        cached = UserDataStore.petById(userId, petId);
      }
      if (cached == null) return Error('Pet not found');

      return Success(_petFromCache(cached));
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AccountPetEntity, Object>> updatePet({
    required String petId,
    required String name,
    required String breed,
    required DateTime birthdate,
    double? weight,
    File? photoFile,
  }) async {
    final userId = _userId;
    if (userId == null) return Error('User not found');

    final previous = UserDataStore.petById(userId, petId);
    final birthdateStr = _dateOnly(birthdate);
    final ageYears = _ageInYears(birthdate);

    await UserDataStore.updatePet(userId, petId, {
      'name': name,
      'breed': breed,
      'birthdate': birthdateStr,
      'age': ageYears,
      'weight': weight,
    });

    try {
      String? photoUrl;
      if (photoFile != null) {
        photoUrl = await _replacePetPhoto(
          userId: userId,
          petId: petId,
          file: photoFile,
        );
        await UserDataStore.updatePet(userId, petId, {'photo_url': photoUrl});
      }

      final updates = <String, dynamic>{
        'name': name,
        'breed': breed,
        'birthdate': birthdateStr,
        'age': ageYears,
        'weight': weight,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final row = await _supabase
          .from('pets')
          .update(updates)
          .eq('id', petId)
          .eq('owner_id', userId)
          .select('''
            id,
            name,
            species,
            gender,
            breed,
            age,
            birthdate,
            weight,
            pet_photos ( public_url, is_primary, display_order ),
            adoption_posts ( status )
          ''')
          .single();

      final pet = _petFromRow(row, overridePhotoUrl: photoUrl);
      await UserDataStore.updatePet(userId, petId, _petToCache(pet));

      return Success(pet);
    } catch (e) {
      if (previous != null) {
        await UserDataStore.updatePet(userId, petId, previous);
      }
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  AccountPetEntity _petFromCache(Map<String, dynamic> cached) =>
      AccountPetModel.fromJson(cached);

  AccountPetEntity _petFromRow(
    Map<String, dynamic> row, {
    String? overridePhotoUrl,
  }) {
    final photos = (row['pet_photos'] as List<dynamic>?) ?? [];
    String? photoUrl = overridePhotoUrl;
    if (photoUrl == null && photos.isNotEmpty) {
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
      photoUrl =
          (Map<String, dynamic>.from(sorted.first as Map))['public_url']
              as String?;
    }

    final adoptionPosts = (row['adoption_posts'] as List<dynamic>?) ?? [];
    final listedForAdoption = adoptionPosts.any(
      (post) =>
          (post as Map)['status'] == 'available' || post['status'] == 'pending',
    );

    return AccountPetModel(
      id: row['id'] as String,
      name: row['name'] as String? ?? '',
      species: row['species'] as String? ?? '',
      gender: row['gender'] as String? ?? '',
      breed: row['breed'] as String? ?? '',
      age: row['age'] as int?,
      birthdate: _parseDate(row['birthdate']),
      weight: _parseWeight(row['weight']),
      photoUrl: photoUrl,
      listedForAdoption: listedForAdoption,
    );
  }

  Map<String, dynamic> _petToCache(AccountPetEntity pet) => {
    'id': pet.id,
    'name': pet.name,
    'species': pet.species,
    'gender': pet.gender,
    'breed': pet.breed,
    'age': pet.age,
    'birthdate': pet.birthdate != null ? _dateOnly(pet.birthdate!) : null,
    'weight': pet.weight,
    'photo_url': pet.photoUrl,
    'listed_for_adoption': pet.listedForAdoption,
  };

  Future<String> _replacePetPhoto({
    required String userId,
    required String petId,
    required File file,
  }) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final storagePath = '$userId/$petId/$fileName';

    await _supabase.storage
        .from(StorageBuckets.petPhotos)
        .upload(storagePath, file);

    final photoUrl = _supabase.storage
        .from(StorageBuckets.petPhotos)
        .getPublicUrl(storagePath);

    await _supabase
        .from('pet_photos')
        .update({'is_primary': false})
        .eq('pet_id', petId);

    await _supabase.from('pet_photos').insert({
      'pet_id': petId,
      'uploader_id': userId,
      'storage_path': storagePath,
      'public_url': photoUrl,
      'is_primary': true,
      'display_order': 0,
    });

    return photoUrl;
  }

  static String _dateOnly(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static int _ageInYears(DateTime birthdate) {
    final now = DateTime.now();
    var years = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      years--;
    }
    return years < 0 ? 0 : years;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) {
      return DateTime(value.year, value.month, value.day);
    }
    if (value is String && value.isNotEmpty) {
      final parsed = DateTime.tryParse(value);
      if (parsed == null) return null;
      return DateTime(parsed.year, parsed.month, parsed.day);
    }
    return null;
  }

  static double? _parseWeight(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String && value.isNotEmpty) {
      return double.tryParse(value);
    }
    return null;
  }
}
