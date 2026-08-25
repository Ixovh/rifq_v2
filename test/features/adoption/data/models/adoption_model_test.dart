import 'package:flutter_test/flutter_test.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';

/// fromJson/toJson round-trip coverage for every model converted from
/// freezed (commit 7a4387a) to dart_mappable, to match AuthModel's
/// convention. Supabase depends on these exact keys, so every JSON key
/// (including the ones that differ from the Dart field name) is checked
/// explicitly, not just "the round-trip doesn't throw".
void main() {
  group('ProfileModel', () {
    final json = {
      'id': 'profile-1',
      'full_name': 'Jane Doe',
      'phone_number': '+966500000000',
      'image_url': 'https://example.com/avatar.png',
    };

    test('fromJson maps snake_case Supabase keys to camelCase fields', () {
      final model = ProfileModel.fromJson(json);
      expect(model.id, 'profile-1');
      expect(model.fullName, 'Jane Doe');
      expect(model.phoneNumber, '+966500000000');
      expect(model.avatarUrl, 'https://example.com/avatar.png');
    });

    test('fromJson tolerates null optional fields', () {
      final model = ProfileModel.fromJson({
        'id': 'profile-2',
        'full_name': 'No Contact Info',
        'phone_number': null,
        'image_url': null,
      });
      expect(model.phoneNumber, isNull);
      expect(model.avatarUrl, isNull);
    });

    test('toMap round-trips to the exact same key set and values', () {
      final model = ProfileModel.fromJson(json);
      final map = model.toMap();
      expect(map.keys.toSet(), json.keys.toSet());
      expect(map, json);
    });

    test('value equality and copyWith', () {
      final a = ProfileModel.fromJson(json);
      final b = ProfileModel.fromJson(json);
      expect(a, equals(b));
      final renamed = a.copyWith(fullName: 'Jane Smith');
      expect(renamed.fullName, 'Jane Smith');
      expect(renamed.id, a.id);
      expect(renamed, isNot(equals(a)));
    });
  });

  group('PetModel', () {
    final json = {
      'id': 'pet-1',
      'owner_id': 'owner-1',
      'name': 'Rex',
      'species': 'dog',
      'breed': 'Labrador',
      'age': 3,
      'gender': 'male',
      'health_status_summary': 'Healthy',
    };

    test('fromJson maps snake_case Supabase keys to camelCase fields', () {
      final model = PetModel.fromJson(json);
      expect(model.id, 'pet-1');
      expect(model.ownerId, 'owner-1');
      expect(model.name, 'Rex');
      expect(model.species, 'dog');
      expect(model.breed, 'Labrador');
      expect(model.age, 3);
      expect(model.gender, 'male');
      expect(model.healthStatusSummary, 'Healthy');
    });

    test('toMap round-trips to the exact same key set and values', () {
      final model = PetModel.fromJson(json);
      expect(model.toMap(), json);
    });

    test('healthStatusSummary is nullable and optional', () {
      final model = PetModel.fromJson({
        'id': 'pet-2',
        'owner_id': 'owner-2',
        'name': 'Milo',
        'species': 'cat',
        'breed': 'Persian',
        'age': 1,
        'gender': 'female',
        'health_status_summary': null,
      });
      expect(model.healthStatusSummary, isNull);
    });
  });

  group('PetPhotoModel', () {
    final json = {
      'id': 'photo-1',
      'public_url': 'https://example.com/1.png',
      'is_primary': true,
    };

    test('fromJson maps snake_case Supabase keys to camelCase fields', () {
      final model = PetPhotoModel.fromJson(json);
      expect(model.id, 'photo-1');
      expect(model.publicUrl, 'https://example.com/1.png');
      expect(model.isPrimary, isTrue);
    });

    test('toMap round-trips to the exact same key set and values', () {
      final model = PetPhotoModel.fromJson(json);
      expect(model.toMap(), json);
    });
  });

  group('AdoptionPostModel', () {
    // Shaped exactly like the nested `select()` Supabase query in
    // adoption_remote_data_source.dart: `*, pets (*), profiles (*),
    // pet_photos (*)`.
    final json = {
      'id': 'post-1',
      'description': 'Friendly dog looking for a home',
      'status': 'available',
      'location': 'Riyadh',
      'created_at': '2026-01-15T10:30:00.000Z',
      'pets': {
        'id': 'pet-1',
        'owner_id': 'owner-1',
        'name': 'Rex',
        'species': 'dog',
        'breed': 'Labrador',
        'age': 3,
        'gender': 'male',
        'health_status_summary': 'Healthy',
      },
      'profiles': {
        'id': 'profile-1',
        'full_name': 'Jane Doe',
        'phone_number': '+966500000000',
        'image_url': 'https://example.com/avatar.png',
      },
      'pet_photos': [
        {
          'id': 'photo-1',
          'public_url': 'https://example.com/1.png',
          'is_primary': true,
        },
        {
          'id': 'photo-2',
          'public_url': 'https://example.com/2.png',
          'is_primary': false,
        },
      ],
    };

    test('fromJson maps top-level fields and JSON-key-renamed fields', () {
      final model = AdoptionPostModel.fromJson(json);
      expect(model.id, 'post-1');
      expect(model.description, 'Friendly dog looking for a home');
      expect(model.status, 'available');
      expect(model.location, 'Riyadh');
      expect(model.createdAt, DateTime.parse('2026-01-15T10:30:00.000Z'));
    });

    test('fromJson decodes the nested "pets" object (renamed to `pet`)', () {
      final model = AdoptionPostModel.fromJson(json);
      expect(model.pet, isA<PetModel>());
      expect(model.pet.id, 'pet-1');
      expect(model.pet.ownerId, 'owner-1');
      expect(model.pet.age, 3);
    });

    test(
      'fromJson decodes the nested "profiles" object (renamed to `poster`)',
      () {
        final model = AdoptionPostModel.fromJson(json);
        expect(model.poster, isA<ProfileModel>());
        expect(model.poster.id, 'profile-1');
        expect(model.poster.fullName, 'Jane Doe');
      },
    );

    test('fromJson decodes the "pet_photos" list (renamed to `photos`)', () {
      final model = AdoptionPostModel.fromJson(json);
      expect(model.photos, hasLength(2));
      expect(model.photos[0].id, 'photo-1');
      expect(model.photos[0].isPrimary, isTrue);
      expect(model.photos[1].isPrimary, isFalse);
    });

    test('missing "pet_photos" key defaults to an empty list', () {
      final withoutPhotos = Map<String, dynamic>.from(json)
        ..remove('pet_photos');
      final model = AdoptionPostModel.fromJson(withoutPhotos);
      expect(model.photos, isEmpty);
    });

    test(
      'toMap round-trips to the exact same top-level and nested key set',
      () {
        final model = AdoptionPostModel.fromJson(json);
        final map = model.toMap();

        expect(map.keys.toSet(), json.keys.toSet());
        expect(
          (map['pets'] as Map).keys.toSet(),
          (json['pets'] as Map).keys.toSet(),
        );
        expect(
          (map['profiles'] as Map).keys.toSet(),
          (json['profiles'] as Map).keys.toSet(),
        );
        expect(map['pets'], json['pets']);
        expect(map['profiles'], json['profiles']);
        expect(map['pet_photos'], json['pet_photos']);
        expect(map['created_at'], json['created_at']);
      },
    );

    test('toEntity() maps every field through to the domain entity', () {
      final model = AdoptionPostModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.description, model.description);
      expect(entity.status, model.status);
      expect(entity.location, model.location);
      expect(entity.createdAt, model.createdAt);
      expect(entity.pet.id, model.pet.id);
      expect(entity.pet.ownerId, model.pet.ownerId);
      expect(entity.poster.id, model.poster.id);
      expect(entity.poster.fullName, model.poster.fullName);
      expect(entity.photos, hasLength(2));
      expect(entity.photos[0].id, model.photos[0].id);
    });

    test('value equality and copyWith', () {
      final a = AdoptionPostModel.fromJson(json);
      final b = AdoptionPostModel.fromJson(json);
      expect(a, equals(b));

      final updated = a.copyWith(status: 'adopted');
      expect(updated.status, 'adopted');
      expect(updated.id, a.id);
      expect(updated, isNot(equals(a)));
    });
  });
}
