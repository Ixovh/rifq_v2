import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/adoption_entity.dart';

part 'adoption_model.freezed.dart';
part 'adoption_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const ProfileModel._();
  const factory ProfileModel({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() => ProfileEntity(
    id: id,
    fullName: fullName,
    phoneNumber: phoneNumber,
    avatarUrl: avatarUrl,
  );
}

@freezed
class PetModel with _$PetModel {
  const PetModel._();
  const factory PetModel({
    required String id,
    @JsonKey(name: 'owner_id') required String ownerId,
    required String name,
    required String species,
    required String breed,
    required int age,
    required String gender,
    @JsonKey(name: 'health_status_summary') String? healthStatusSummary,
  }) = _PetModel;

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

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
}

@freezed
class PetPhotoModel with _$PetPhotoModel {
  const PetPhotoModel._();
  const factory PetPhotoModel({
    required String id,
    @JsonKey(name: 'public_url') required String publicUrl,
    @JsonKey(name: 'is_primary') required bool isPrimary,
  }) = _PetPhotoModel;

  factory PetPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PetPhotoModelFromJson(json);

  PetPhotoEntity toEntity() =>
      PetPhotoEntity(id: id, publicUrl: publicUrl, isPrimary: isPrimary);
}

@freezed
class AdoptionPostModel with _$AdoptionPostModel {
  const AdoptionPostModel._();
  @JsonSerializable(explicitToJson: true)
  const factory AdoptionPostModel({
    required String id,
    required String description,
    required String status,
    required String location,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'pets') required PetModel pet,
    @JsonKey(name: 'profiles') required ProfileModel poster,
    @JsonKey(name: 'pet_photos') @Default([]) List<PetPhotoModel> photos,
  }) = _AdoptionPostModel;

  factory AdoptionPostModel.fromJson(Map<String, dynamic> json) =>
      _$AdoptionPostModelFromJson(json);

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
}
