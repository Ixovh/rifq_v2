class AddPetEntity {
  final String id;
  final String ownerId;
  final String name;
  final String species;
  final String gender;
  final String breed;
  final DateTime birthdate;
  final String photoUrl;

  const AddPetEntity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    required this.gender,
    required this.breed,
    required this.birthdate,
    required this.photoUrl,
  });
}
