import 'package:equatable/equatable.dart';
import '../../domain/entities/adoption_entity.dart';

class ProfileModel extends Equatable {
  final String id;
  final String fullName;
  final String? phoneNumber;
  final String? avatarUrl;

  const ProfileModel({
    required this.id,
    required this.fullName,
    this.phoneNumber,
    this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'] as String,
    fullName: json['full_name'] as String,
    phoneNumber: json['phone_number'] as String?,
    avatarUrl: json['avatar_url'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'full_name': fullName,
    'phone_number': phoneNumber,
    'avatar_url': avatarUrl,
  };

  ProfileModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  ProfileEntity toEntity() => ProfileEntity(
    id: id,
    fullName: fullName,
    phoneNumber: phoneNumber,
    avatarUrl: avatarUrl,
  );

  @override
  List<Object?> get props => [id, fullName, phoneNumber, avatarUrl];
}

class PetModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String species;
  final String breed;
  final int age;
  final String gender;
  final String? healthStatusSummary;

  const PetModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.gender,
    this.healthStatusSummary,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
    id: json['id'] as String,
    ownerId: json['owner_id'] as String,
    name: json['name'] as String,
    species: json['species'] as String,
    breed: json['breed'] as String,
    age: (json['age'] as num).toInt(),
    gender: json['gender'] as String,
    healthStatusSummary: json['health_status_summary'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'owner_id': ownerId,
    'name': name,
    'species': species,
    'breed': breed,
    'age': age,
    'gender': gender,
    'health_status_summary': healthStatusSummary,
  };

  PetModel copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? species,
    String? breed,
    int? age,
    String? gender,
    String? healthStatusSummary,
  }) {
    return PetModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      healthStatusSummary: healthStatusSummary ?? this.healthStatusSummary,
    );
  }

  PetEntity toEntity() => PetEntity(
    id: id,
    ownerId: ownerId,
    name: name,
    species: species,
    breed: breed,
    age: age,
    gender: gender,
    healthStatusSummary: healthStatusSummary,
  );

  @override
  List<Object?> get props => [
    id,
    ownerId,
    name,
    species,
    breed,
    age,
    gender,
    healthStatusSummary,
  ];
}

class PetPhotoModel extends Equatable {
  final String id;
  final String publicUrl;
  final bool isPrimary;

  const PetPhotoModel({
    required this.id,
    required this.publicUrl,
    required this.isPrimary,
  });

  factory PetPhotoModel.fromJson(Map<String, dynamic> json) => PetPhotoModel(
    id: json['id'] as String,
    publicUrl: json['public_url'] as String,
    isPrimary: json['is_primary'] as bool,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'public_url': publicUrl,
    'is_primary': isPrimary,
  };

  PetPhotoModel copyWith({String? id, String? publicUrl, bool? isPrimary}) {
    return PetPhotoModel(
      id: id ?? this.id,
      publicUrl: publicUrl ?? this.publicUrl,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  PetPhotoEntity toEntity() =>
      PetPhotoEntity(id: id, publicUrl: publicUrl, isPrimary: isPrimary);

  @override
  List<Object?> get props => [id, publicUrl, isPrimary];
}

class AdoptionPostModel extends Equatable {
  final String id;
  final String description;
  final String status;
  final String location;
  final DateTime createdAt;
  final PetModel pet;
  final ProfileModel poster;
  final List<PetPhotoModel> photos;

  const AdoptionPostModel({
    required this.id,
    required this.description,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.pet,
    required this.poster,
    this.photos = const [],
  });

  factory AdoptionPostModel.fromJson(Map<String, dynamic> json) =>
      AdoptionPostModel(
        id: json['id'] as String,
        description: json['description'] as String,
        status: json['status'] as String,
        location: json['location'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        pet: PetModel.fromJson(json['pets'] as Map<String, dynamic>),
        poster: ProfileModel.fromJson(
          json['profiles'] as Map<String, dynamic>,
        ),
        photos:
            (json['pet_photos'] as List<dynamic>?)
                ?.map((e) => PetPhotoModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'description': description,
    'status': status,
    'location': location,
    'created_at': createdAt.toIso8601String(),
    'pets': pet.toJson(),
    'profiles': poster.toJson(),
    'pet_photos': photos.map((e) => e.toJson()).toList(),
  };

  AdoptionPostModel copyWith({
    String? id,
    String? description,
    String? status,
    String? location,
    DateTime? createdAt,
    PetModel? pet,
    ProfileModel? poster,
    List<PetPhotoModel>? photos,
  }) {
    return AdoptionPostModel(
      id: id ?? this.id,
      description: description ?? this.description,
      status: status ?? this.status,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      pet: pet ?? this.pet,
      poster: poster ?? this.poster,
      photos: photos ?? this.photos,
    );
  }

  AdoptionPostEntity toEntity() => AdoptionPostEntity(
    id: id,
    description: description,
    status: status,
    location: location,
    createdAt: createdAt,
    pet: pet.toEntity(),
    poster: poster.toEntity(),
    photos: photos.map((p) => p.toEntity()).toList(),
  );

  @override
  List<Object?> get props => [
    id,
    description,
    status,
    location,
    createdAt,
    pet,
    poster,
    photos,
  ];
}
