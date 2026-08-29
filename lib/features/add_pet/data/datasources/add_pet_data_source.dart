import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/add_pet/data/models/pet_model.dart';
import 'package:rifq_v2/shared/constants/storage_buckets.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAddPetDataSource {
  Future<PetModel> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  });
}

@LazySingleton(as: BaseAddPetDataSource)
class AddPetDataSource implements BaseAddPetDataSource {
  final SupabaseClient supabase;

  AddPetDataSource(this.supabase);

  @override
  Future<PetModel> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  }) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${photoFile.path.split('/').last}';
    final storagePath = '$ownerId/$fileName';

    await supabase.storage
        .from(StorageBuckets.petPhotos)
        .upload(storagePath, photoFile);

    final photoUrl = supabase.storage
        .from(StorageBuckets.petPhotos)
        .getPublicUrl(storagePath);

    final response = await supabase
        .from('pets')
        .insert({
          'owner_id': ownerId,
          'name': name,
          'species': species,
          'gender': gender,
          'breed': breed,
          'birthdate': _dateOnly(birthdate),
          'age': _ageInYears(birthdate),
        })
        .select()
        .single();

    await supabase.from('pet_photos').insert({
      'pet_id': response['id'],
      'uploader_id': ownerId,
      'storage_path': storagePath,
      'public_url': photoUrl,
      'is_primary': true,
      'display_order': 0,
    });

    // Keep the local snapshot in sync so home/profile show the new pet
    // without refetching from the server.
    await UserDataStore.addPet(ownerId, {
      'id': response['id'],
      'name': name,
      'species': species,
      'gender': gender,
      'breed': breed,
      'age': _ageInYears(birthdate),
      'birthdate': _dateOnly(birthdate),
      'weight': null,
      'photo_url': photoUrl,
      'listed_for_adoption': false,
    });

    return PetModelMapper.fromMap({...response, 'photo': photoUrl});
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
}
