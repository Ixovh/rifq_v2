// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_model.dart';

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
  static String _$gender(PetModel v) => v.gender;
  static const Field<PetModel, String> _f$gender = Field('gender', _$gender);
  static String _$breed(PetModel v) => v.breed;
  static const Field<PetModel, String> _f$breed = Field('breed', _$breed);
  static DateTime _$birthdate(PetModel v) => v.birthdate;
  static const Field<PetModel, DateTime> _f$birthdate = Field(
    'birthdate',
    _$birthdate,
  );
  static String _$photoUrl(PetModel v) => v.photoUrl;
  static const Field<PetModel, String> _f$photoUrl = Field(
    'photoUrl',
    _$photoUrl,
    key: r'photo',
  );
  static DateTime _$createdAt(PetModel v) => v.createdAt;
  static const Field<PetModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );

  @override
  final MappableFields<PetModel> fields = const {
    #id: _f$id,
    #ownerId: _f$ownerId,
    #name: _f$name,
    #species: _f$species,
    #gender: _f$gender,
    #breed: _f$breed,
    #birthdate: _f$birthdate,
    #photoUrl: _f$photoUrl,
    #createdAt: _f$createdAt,
  };

  static PetModel _instantiate(DecodingData data) {
    return PetModel(
      id: data.dec(_f$id),
      ownerId: data.dec(_f$ownerId),
      name: data.dec(_f$name),
      species: data.dec(_f$species),
      gender: data.dec(_f$gender),
      breed: data.dec(_f$breed),
      birthdate: data.dec(_f$birthdate),
      photoUrl: data.dec(_f$photoUrl),
      createdAt: data.dec(_f$createdAt),
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
    String? gender,
    String? breed,
    DateTime? birthdate,
    String? photoUrl,
    DateTime? createdAt,
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
    String? gender,
    String? breed,
    DateTime? birthdate,
    String? photoUrl,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (ownerId != null) #ownerId: ownerId,
      if (name != null) #name: name,
      if (species != null) #species: species,
      if (gender != null) #gender: gender,
      if (breed != null) #breed: breed,
      if (birthdate != null) #birthdate: birthdate,
      if (photoUrl != null) #photoUrl: photoUrl,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  PetModel $make(CopyWithData data) => PetModel(
    id: data.get(#id, or: $value.id),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    name: data.get(#name, or: $value.name),
    species: data.get(#species, or: $value.species),
    gender: data.get(#gender, or: $value.gender),
    breed: data.get(#breed, or: $value.breed),
    birthdate: data.get(#birthdate, or: $value.birthdate),
    photoUrl: data.get(#photoUrl, or: $value.photoUrl),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  PetModelCopyWith<$R2, PetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

