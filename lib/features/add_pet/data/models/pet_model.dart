import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';

part 'pet_model.mapper.dart';

@MappableClass()
class PetModel extends AddPetEntity with PetModelMappable {
  @MappableField(key: 'owner_id')
  @override
  final String ownerId;

  @MappableField(key: 'photo')
  @override
  final String photoUrl;

  @MappableField(key: 'created_at')
  final DateTime createdAt;

  const PetModel({
    required String id,
    required this.ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required this.photoUrl,
    required this.createdAt,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          species: species,
          gender: gender,
          breed: breed,
          birthdate: birthdate,
          photoUrl: photoUrl,
        );
}
