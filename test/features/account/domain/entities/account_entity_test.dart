import 'package:flutter_test/flutter_test.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';

AccountPetEntity _pet({int? age, DateTime? birthdate}) {
  return AccountPetEntity(
    id: '1',
    name: 'ddd',
    gender: 'male',
    breed: 'husky',
    age: age,
    birthdate: birthdate,
  );
}

void main() {
  group('AccountPetEntity.ageLabel', () {
    test('shows months when the pet is younger than 1 year', () {
      final now = DateTime.now();
      final pet = _pet(birthdate: DateTime(now.year, now.month - 6, 1));

      expect(pet.ageLabel, '6 month');
    });

    test('shows 1 month for a newborn', () {
      final now = DateTime.now();
      final pet = _pet(birthdate: DateTime(now.year, now.month, now.day));

      expect(pet.ageLabel, '1 month');
    });

    test('shows years when the pet is 1 year or older', () {
      final now = DateTime.now();
      final pet = _pet(birthdate: DateTime(now.year - 2, now.month, 1));

      expect(pet.ageLabel, '2 Years');
    });

    test('falls back to age years when birthdate is missing', () {
      expect(_pet(age: 3).ageLabel, '3 Years');
      expect(_pet(age: 1).ageLabel, '1 Year');
      expect(_pet(age: 0).ageLabel, '1 month');
      expect(_pet().ageLabel, '-');
    });
  });
}
