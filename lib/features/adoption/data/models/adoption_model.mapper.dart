// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adoption_model.dart';

class ProfileModelMapper extends ClassMapperBase<ProfileModel> {
  ProfileModelMapper._();

  static ProfileModelMapper? _instance;
  static ProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileModel';

  static String _$id(ProfileModel v) => v.id;
  static const Field<ProfileModel, String> _f$id = Field('id', _$id);
  static String _$fullName(ProfileModel v) => v.fullName;
  static const Field<ProfileModel, String> _f$fullName = Field(
    'fullName',
    _$fullName,
    key: r'full_name',
  );
  static String? _$phoneNumber(ProfileModel v) => v.phoneNumber;
  static const Field<ProfileModel, String> _f$phoneNumber = Field(
    'phoneNumber',
    _$phoneNumber,
    key: r'phone_number',
    opt: true,
  );
  static String? _$avatarUrl(ProfileModel v) => v.avatarUrl;
  static const Field<ProfileModel, String> _f$avatarUrl = Field(
    'avatarUrl',
    _$avatarUrl,
    key: r'avatar_url',
    opt: true,
  );

  @override
  final MappableFields<ProfileModel> fields = const {
    #id: _f$id,
    #fullName: _f$fullName,
    #phoneNumber: _f$phoneNumber,
    #avatarUrl: _f$avatarUrl,
  };

  static ProfileModel _instantiate(DecodingData data) {
    return ProfileModel(
      id: data.dec(_f$id),
      fullName: data.dec(_f$fullName),
      phoneNumber: data.dec(_f$phoneNumber),
      avatarUrl: data.dec(_f$avatarUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileModel>(map);
  }

  static ProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileModel>(json);
  }
}

mixin ProfileModelMappable {
  String toJson() {
    return ProfileModelMapper.ensureInitialized().encodeJson<ProfileModel>(
      this as ProfileModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileModelMapper.ensureInitialized().encodeMap<ProfileModel>(
      this as ProfileModel,
    );
  }

  ProfileModelCopyWith<ProfileModel, ProfileModel, ProfileModel> get copyWith =>
      _ProfileModelCopyWithImpl<ProfileModel, ProfileModel>(
        this as ProfileModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileModelMapper.ensureInitialized().stringifyValue(
      this as ProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileModelMapper.ensureInitialized().equalsValue(
      this as ProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileModelMapper.ensureInitialized().hashValue(
      this as ProfileModel,
    );
  }
}

extension ProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileModel, $Out> {
  ProfileModelCopyWith<$R, ProfileModel, $Out> get $asProfileModel =>
      $base.as((v, t, t2) => _ProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileModelCopyWith<$R, $In extends ProfileModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
  });
  ProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileModel, $Out>
    implements ProfileModelCopyWith<$R, ProfileModel, $Out> {
  _ProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileModel> $mapper =
      ProfileModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? fullName,
    Object? phoneNumber = $none,
    Object? avatarUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (fullName != null) #fullName: fullName,
      if (phoneNumber != $none) #phoneNumber: phoneNumber,
      if (avatarUrl != $none) #avatarUrl: avatarUrl,
    }),
  );
  @override
  ProfileModel $make(CopyWithData data) => ProfileModel(
    id: data.get(#id, or: $value.id),
    fullName: data.get(#fullName, or: $value.fullName),
    phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
    avatarUrl: data.get(#avatarUrl, or: $value.avatarUrl),
  );

  @override
  ProfileModelCopyWith<$R2, ProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetModelMapper extends ClassMapperBase<PetModel> {
  PetModelMapper._();

  static PetModelMapper? _instance;
  static PetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetModel';

  static String _$id(PetModel v) => v.id;
  static const Field<PetModel, String> _f$id = Field('id', _$id);
  static String _$ownerId(PetModel v) => v.ownerId;
  static const Field<PetModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
    key: r'owner_id',
  );
  static String _$name(PetModel v) => v.name;
  static const Field<PetModel, String> _f$name = Field('name', _$name);
  static String _$species(PetModel v) => v.species;
  static const Field<PetModel, String> _f$species = Field('species', _$species);
  static String _$breed(PetModel v) => v.breed;
  static const Field<PetModel, String> _f$breed = Field('breed', _$breed);
  static int _$age(PetModel v) => v.age;
  static const Field<PetModel, int> _f$age = Field('age', _$age);
  static String _$gender(PetModel v) => v.gender;
  static const Field<PetModel, String> _f$gender = Field('gender', _$gender);
  static String? _$healthStatusSummary(PetModel v) => v.healthStatusSummary;
  static const Field<PetModel, String> _f$healthStatusSummary = Field(
    'healthStatusSummary',
    _$healthStatusSummary,
    key: r'health_status_summary',
    opt: true,
  );

  @override
  final MappableFields<PetModel> fields = const {
    #id: _f$id,
    #ownerId: _f$ownerId,
    #name: _f$name,
    #species: _f$species,
    #breed: _f$breed,
    #age: _f$age,
    #gender: _f$gender,
    #healthStatusSummary: _f$healthStatusSummary,
  };

  static PetModel _instantiate(DecodingData data) {
    return PetModel(
      id: data.dec(_f$id),
      ownerId: data.dec(_f$ownerId),
      name: data.dec(_f$name),
      species: data.dec(_f$species),
      breed: data.dec(_f$breed),
      age: data.dec(_f$age),
      gender: data.dec(_f$gender),
      healthStatusSummary: data.dec(_f$healthStatusSummary),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetModel>(map);
  }

  static PetModel fromJson(String json) {
    return ensureInitialized().decodeJson<PetModel>(json);
  }
}

mixin PetModelMappable {
  String toJson() {
    return PetModelMapper.ensureInitialized().encodeJson<PetModel>(
      this as PetModel,
    );
  }

  Map<String, dynamic> toMap() {
    return PetModelMapper.ensureInitialized().encodeMap<PetModel>(
      this as PetModel,
    );
  }

  PetModelCopyWith<PetModel, PetModel, PetModel> get copyWith =>
      _PetModelCopyWithImpl<PetModel, PetModel>(
        this as PetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetModelMapper.ensureInitialized().stringifyValue(this as PetModel);
  }

  @override
  bool operator ==(Object other) {
    return PetModelMapper.ensureInitialized().equalsValue(
      this as PetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PetModelMapper.ensureInitialized().hashValue(this as PetModel);
  }
}

extension PetModelValueCopy<$R, $Out> on ObjectCopyWith<$R, PetModel, $Out> {
  PetModelCopyWith<$R, PetModel, $Out> get $asPetModel =>
      $base.as((v, t, t2) => _PetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetModelCopyWith<$R, $In extends PetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? ownerId,
    String? name,
    String? species,
    String? breed,
    int? age,
    String? gender,
    String? healthStatusSummary,
  });
  PetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetModel, $Out>
    implements PetModelCopyWith<$R, PetModel, $Out> {
  _PetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetModel> $mapper =
      PetModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? ownerId,
    String? name,
    String? species,
    String? breed,
    int? age,
    String? gender,
    Object? healthStatusSummary = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (ownerId != null) #ownerId: ownerId,
      if (name != null) #name: name,
      if (species != null) #species: species,
      if (breed != null) #breed: breed,
      if (age != null) #age: age,
      if (gender != null) #gender: gender,
      if (healthStatusSummary != $none)
        #healthStatusSummary: healthStatusSummary,
    }),
  );
  @override
  PetModel $make(CopyWithData data) => PetModel(
    id: data.get(#id, or: $value.id),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    name: data.get(#name, or: $value.name),
    species: data.get(#species, or: $value.species),
    breed: data.get(#breed, or: $value.breed),
    age: data.get(#age, or: $value.age),
    gender: data.get(#gender, or: $value.gender),
    healthStatusSummary: data.get(
      #healthStatusSummary,
      or: $value.healthStatusSummary,
    ),
  );

  @override
  PetModelCopyWith<$R2, PetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetPhotoModelMapper extends ClassMapperBase<PetPhotoModel> {
  PetPhotoModelMapper._();

  static PetPhotoModelMapper? _instance;
  static PetPhotoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetPhotoModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetPhotoModel';

  static String _$id(PetPhotoModel v) => v.id;
  static const Field<PetPhotoModel, String> _f$id = Field('id', _$id);
  static String _$publicUrl(PetPhotoModel v) => v.publicUrl;
  static const Field<PetPhotoModel, String> _f$publicUrl = Field(
    'publicUrl',
    _$publicUrl,
    key: r'public_url',
  );
  static bool _$isPrimary(PetPhotoModel v) => v.isPrimary;
  static const Field<PetPhotoModel, bool> _f$isPrimary = Field(
    'isPrimary',
    _$isPrimary,
    key: r'is_primary',
  );

  @override
  final MappableFields<PetPhotoModel> fields = const {
    #id: _f$id,
    #publicUrl: _f$publicUrl,
    #isPrimary: _f$isPrimary,
  };

  static PetPhotoModel _instantiate(DecodingData data) {
    return PetPhotoModel(
      id: data.dec(_f$id),
      publicUrl: data.dec(_f$publicUrl),
      isPrimary: data.dec(_f$isPrimary),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetPhotoModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetPhotoModel>(map);
  }

  static PetPhotoModel fromJson(String json) {
    return ensureInitialized().decodeJson<PetPhotoModel>(json);
  }
}

mixin PetPhotoModelMappable {
  String toJson() {
    return PetPhotoModelMapper.ensureInitialized().encodeJson<PetPhotoModel>(
      this as PetPhotoModel,
    );
  }

  Map<String, dynamic> toMap() {
    return PetPhotoModelMapper.ensureInitialized().encodeMap<PetPhotoModel>(
      this as PetPhotoModel,
    );
  }

  PetPhotoModelCopyWith<PetPhotoModel, PetPhotoModel, PetPhotoModel>
  get copyWith => _PetPhotoModelCopyWithImpl<PetPhotoModel, PetPhotoModel>(
    this as PetPhotoModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PetPhotoModelMapper.ensureInitialized().stringifyValue(
      this as PetPhotoModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetPhotoModelMapper.ensureInitialized().equalsValue(
      this as PetPhotoModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PetPhotoModelMapper.ensureInitialized().hashValue(
      this as PetPhotoModel,
    );
  }
}

extension PetPhotoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetPhotoModel, $Out> {
  PetPhotoModelCopyWith<$R, PetPhotoModel, $Out> get $asPetPhotoModel =>
      $base.as((v, t, t2) => _PetPhotoModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetPhotoModelCopyWith<$R, $In extends PetPhotoModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? publicUrl, bool? isPrimary});
  PetPhotoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetPhotoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetPhotoModel, $Out>
    implements PetPhotoModelCopyWith<$R, PetPhotoModel, $Out> {
  _PetPhotoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetPhotoModel> $mapper =
      PetPhotoModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? publicUrl, bool? isPrimary}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (publicUrl != null) #publicUrl: publicUrl,
      if (isPrimary != null) #isPrimary: isPrimary,
    }),
  );
  @override
  PetPhotoModel $make(CopyWithData data) => PetPhotoModel(
    id: data.get(#id, or: $value.id),
    publicUrl: data.get(#publicUrl, or: $value.publicUrl),
    isPrimary: data.get(#isPrimary, or: $value.isPrimary),
  );

  @override
  PetPhotoModelCopyWith<$R2, PetPhotoModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetPhotoModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AdoptionPostModelMapper extends ClassMapperBase<AdoptionPostModel> {
  AdoptionPostModelMapper._();

  static AdoptionPostModelMapper? _instance;
  static AdoptionPostModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdoptionPostModelMapper._());
      PetModelMapper.ensureInitialized();
      ProfileModelMapper.ensureInitialized();
      PetPhotoModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AdoptionPostModel';

  static String _$id(AdoptionPostModel v) => v.id;
  static const Field<AdoptionPostModel, String> _f$id = Field('id', _$id);
  static String _$description(AdoptionPostModel v) => v.description;
  static const Field<AdoptionPostModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$status(AdoptionPostModel v) => v.status;
  static const Field<AdoptionPostModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static String _$location(AdoptionPostModel v) => v.location;
  static const Field<AdoptionPostModel, String> _f$location = Field(
    'location',
    _$location,
  );
  static DateTime _$createdAt(AdoptionPostModel v) => v.createdAt;
  static const Field<AdoptionPostModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );
  static PetModel _$pet(AdoptionPostModel v) => v.pet;
  static const Field<AdoptionPostModel, PetModel> _f$pet = Field(
    'pet',
    _$pet,
    key: r'pets',
  );
  static ProfileModel _$poster(AdoptionPostModel v) => v.poster;
  static const Field<AdoptionPostModel, ProfileModel> _f$poster = Field(
    'poster',
    _$poster,
    key: r'profiles',
  );
  static List<PetPhotoModel> _$photos(AdoptionPostModel v) => v.photos;
  static const Field<AdoptionPostModel, List<PetPhotoModel>> _f$photos = Field(
    'photos',
    _$photos,
    key: r'pet_photos',
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<AdoptionPostModel> fields = const {
    #id: _f$id,
    #description: _f$description,
    #status: _f$status,
    #location: _f$location,
    #createdAt: _f$createdAt,
    #pet: _f$pet,
    #poster: _f$poster,
    #photos: _f$photos,
  };

  static AdoptionPostModel _instantiate(DecodingData data) {
    return AdoptionPostModel(
      id: data.dec(_f$id),
      description: data.dec(_f$description),
      status: data.dec(_f$status),
      location: data.dec(_f$location),
      createdAt: data.dec(_f$createdAt),
      pet: data.dec(_f$pet),
      poster: data.dec(_f$poster),
      photos: data.dec(_f$photos),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdoptionPostModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdoptionPostModel>(map);
  }

  static AdoptionPostModel fromJson(String json) {
    return ensureInitialized().decodeJson<AdoptionPostModel>(json);
  }
}

mixin AdoptionPostModelMappable {
  String toJson() {
    return AdoptionPostModelMapper.ensureInitialized()
        .encodeJson<AdoptionPostModel>(this as AdoptionPostModel);
  }

  Map<String, dynamic> toMap() {
    return AdoptionPostModelMapper.ensureInitialized()
        .encodeMap<AdoptionPostModel>(this as AdoptionPostModel);
  }

  AdoptionPostModelCopyWith<
    AdoptionPostModel,
    AdoptionPostModel,
    AdoptionPostModel
  >
  get copyWith =>
      _AdoptionPostModelCopyWithImpl<AdoptionPostModel, AdoptionPostModel>(
        this as AdoptionPostModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AdoptionPostModelMapper.ensureInitialized().stringifyValue(
      this as AdoptionPostModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdoptionPostModelMapper.ensureInitialized().equalsValue(
      this as AdoptionPostModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AdoptionPostModelMapper.ensureInitialized().hashValue(
      this as AdoptionPostModel,
    );
  }
}

extension AdoptionPostModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdoptionPostModel, $Out> {
  AdoptionPostModelCopyWith<$R, AdoptionPostModel, $Out>
  get $asAdoptionPostModel => $base.as(
    (v, t, t2) => _AdoptionPostModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AdoptionPostModelCopyWith<
  $R,
  $In extends AdoptionPostModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PetModelCopyWith<$R, PetModel, PetModel> get pet;
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel> get poster;
  ListCopyWith<
    $R,
    PetPhotoModel,
    PetPhotoModelCopyWith<$R, PetPhotoModel, PetPhotoModel>
  >
  get photos;
  $R call({
    String? id,
    String? description,
    String? status,
    String? location,
    DateTime? createdAt,
    PetModel? pet,
    ProfileModel? poster,
    List<PetPhotoModel>? photos,
  });
  AdoptionPostModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AdoptionPostModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdoptionPostModel, $Out>
    implements AdoptionPostModelCopyWith<$R, AdoptionPostModel, $Out> {
  _AdoptionPostModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdoptionPostModel> $mapper =
      AdoptionPostModelMapper.ensureInitialized();
  @override
  PetModelCopyWith<$R, PetModel, PetModel> get pet =>
      $value.pet.copyWith.$chain((v) => call(pet: v));
  @override
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel> get poster =>
      $value.poster.copyWith.$chain((v) => call(poster: v));
  @override
  ListCopyWith<
    $R,
    PetPhotoModel,
    PetPhotoModelCopyWith<$R, PetPhotoModel, PetPhotoModel>
  >
  get photos => ListCopyWith(
    $value.photos,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(photos: v),
  );
  @override
  $R call({
    String? id,
    String? description,
    String? status,
    String? location,
    DateTime? createdAt,
    PetModel? pet,
    ProfileModel? poster,
    List<PetPhotoModel>? photos,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (description != null) #description: description,
      if (status != null) #status: status,
      if (location != null) #location: location,
      if (createdAt != null) #createdAt: createdAt,
      if (pet != null) #pet: pet,
      if (poster != null) #poster: poster,
      if (photos != null) #photos: photos,
    }),
  );
  @override
  AdoptionPostModel $make(CopyWithData data) => AdoptionPostModel(
    id: data.get(#id, or: $value.id),
    description: data.get(#description, or: $value.description),
    status: data.get(#status, or: $value.status),
    location: data.get(#location, or: $value.location),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    pet: data.get(#pet, or: $value.pet),
    poster: data.get(#poster, or: $value.poster),
    photos: data.get(#photos, or: $value.photos),
  );

  @override
  AdoptionPostModelCopyWith<$R2, AdoptionPostModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AdoptionPostModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

