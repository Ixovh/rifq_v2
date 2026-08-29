import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Local snapshot of the signed-in user's profile, email, and pets.
///
/// Home and Account read from this store first and only query Supabase when
/// the snapshot is missing or a refresh is explicitly requested. Mutations
/// (profile edits, new pets) update the snapshot locally before/alongside the
/// server call, so screens stay in sync without refetching.
///
/// Snapshot shape (all JSON-safe):
/// ```
/// {
///   'profile': {id, role, full_name, phone_number, image_url,
///               created_at, updated_at},
///   'email': String,
///   'pets': [{id, name, species, gender, breed, age, birthdate, weight,
///             photo_url, listed_for_adoption}],
/// }
/// ```
class UserDataStore {
  UserDataStore._();

  static final _box = GetStorage();
  static const _keyPrefix = 'user_data_store_';

  static const profileSelect =
      'id, role, full_name, phone_number, image_url, created_at, updated_at';

  static String _key(String userId) => '$_keyPrefix$userId';

  static Map<String, dynamic>? read(String userId) {
    final data = _box.read(_key(userId));
    if (data is! Map) return null;
    return Map<String, dynamic>.from(data);
  }

  static Future<void> write(String userId, Map<String, dynamic> snapshot) =>
      _box.write(_key(userId), snapshot);

  static Future<void> clear(String userId) => _box.remove(_key(userId));

  static Map<String, dynamic> profileOf(Map<String, dynamic> snapshot) =>
      Map<String, dynamic>.from(snapshot['profile'] as Map);

  static List<Map<String, dynamic>> petsOf(Map<String, dynamic> snapshot) =>
      ((snapshot['pets'] as List?) ?? const [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

  /// Merges [fields] into the cached profile row. No-op when nothing is
  /// cached yet (the next read will fetch fresh data anyway).
  static Future<void> mergeProfileFields(
    String userId,
    Map<String, dynamic> fields, {
    String? email,
  }) async {
    final snapshot = read(userId);
    if (snapshot == null) return;
    snapshot['profile'] = {...profileOf(snapshot), ...fields};
    if (email != null) snapshot['email'] = email;
    await write(userId, snapshot);
  }

  /// Prepends [pet] (pets are ordered newest first).
  static Future<void> addPet(String userId, Map<String, dynamic> pet) async {
    final snapshot = read(userId);
    if (snapshot == null) return;
    snapshot['pets'] = [pet, ...petsOf(snapshot)];
    await write(userId, snapshot);
  }

  static Future<void> removePet(String userId, String petId) async {
    final snapshot = read(userId);
    if (snapshot == null) return;
    snapshot['pets'] = petsOf(
      snapshot,
    ).where((pet) => pet['id'] != petId).toList();
    await write(userId, snapshot);
  }

  /// Merges [fields] into a cached pet row by [petId].
  static Future<void> updatePet(
    String userId,
    String petId,
    Map<String, dynamic> fields,
  ) async {
    final snapshot = read(userId);
    if (snapshot == null) return;
    snapshot['pets'] = petsOf(snapshot).map((pet) {
      if (pet['id'] != petId) return pet;
      return {...pet, ...fields};
    }).toList();
    await write(userId, snapshot);
  }

  static Map<String, dynamic>? petById(String userId, String petId) {
    final snapshot = read(userId);
    if (snapshot == null) return null;
    for (final pet in petsOf(snapshot)) {
      if (pet['id'] == petId) return pet;
    }
    return null;
  }

  /// Fetches profile + pets from Supabase, caches the snapshot, returns it.
  static Future<Map<String, dynamic>> fetchAndCache(
    SupabaseClient supabase,
    String userId,
  ) async {
    final profileRow = await supabase
        .from('profiles')
        .select(profileSelect)
        .eq('id', userId)
        .maybeSingle();

    if (profileRow == null) {
      throw Exception('Profile not found');
    }

    final petsRows = await supabase
        .from('pets')
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
        .eq('owner_id', userId)
        .order('created_at', ascending: false);

    final pets = (petsRows as List<dynamic>).map((raw) {
      final row = Map<String, dynamic>.from(raw as Map);

      final photos = (row['pet_photos'] as List<dynamic>?) ?? [];
      String? photoUrl;
      if (photos.isNotEmpty) {
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
            (post as Map)['status'] == 'available' ||
            post['status'] == 'pending',
      );

      return <String, dynamic>{
        'id': row['id'],
        'name': row['name'] ?? '',
        'species': row['species'] ?? '',
        'gender': row['gender'] ?? '',
        'breed': row['breed'] ?? '',
        'age': row['age'],
        'birthdate': row['birthdate'],
        'weight': row['weight'],
        'photo_url': photoUrl,
        'listed_for_adoption': listedForAdoption,
      };
    }).toList();

    final snapshot = <String, dynamic>{
      'profile': Map<String, dynamic>.from(profileRow),
      'email': supabase.auth.currentUser?.email ?? '',
      'pets': pets,
    };
    await write(userId, snapshot);
    return snapshot;
  }
}
