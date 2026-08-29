import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';

part 'account_model.mapper.dart';

/// Data model for `public.profiles`.
@MappableClass()
class AccountModel extends AccountEntity with AccountModelMappable {
  @MappableField(key: 'full_name')
  @override
  final String? fullName;

  @MappableField(key: 'phone_number')
  @override
  final String? phoneNumber;

  @MappableField(key: 'image_url')
  @override
  final String? avatarUrl;

  @MappableField(key: 'created_at')
  @override
  final DateTime createdAt;

  @MappableField(key: 'updated_at')
  @override
  final DateTime updatedAt;

  const AccountModel({
    required super.id,
    this.fullName,
    this.phoneNumber,
    this.avatarUrl,
    required super.role,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
         fullName: fullName,
         phoneNumber: phoneNumber,
         avatarUrl: avatarUrl,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      AccountModelMapper.fromMap(json);
}

@MappableClass()
class AccountPetModel extends AccountPetEntity with AccountPetModelMappable {
  @MappableField(key: 'photo_url')
  @override
  final String? photoUrl;

  @MappableField(key: 'listed_for_adoption')
  @override
  final bool listedForAdoption;

  @override
  final DateTime? birthdate;

  @override
  final double? weight;

  @override
  final String species;

  const AccountPetModel({
    required super.id,
    required super.name,
    this.species = '',
    required super.gender,
    required super.breed,
    super.age,
    this.birthdate,
    this.weight,
    this.photoUrl,
    this.listedForAdoption = false,
  }) : super(
         species: species,
         birthdate: birthdate,
         weight: weight,
         photoUrl: photoUrl,
         listedForAdoption: listedForAdoption,
       );

  factory AccountPetModel.fromJson(Map<String, dynamic> json) =>
      AccountPetModelMapper.fromMap(json);
}
