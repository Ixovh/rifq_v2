// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'account_model.dart';

class AccountModelMapper extends ClassMapperBase<AccountModel> {
  AccountModelMapper._();

  static AccountModelMapper? _instance;
  static AccountModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AccountModel';

  static String _$id(AccountModel v) => v.id;
  static const Field<AccountModel, String> _f$id = Field('id', _$id);
  static String? _$fullName(AccountModel v) => v.fullName;
  static const Field<AccountModel, String> _f$fullName = Field(
    'fullName',
    _$fullName,
    key: r'full_name',
    opt: true,
  );
  static String? _$phoneNumber(AccountModel v) => v.phoneNumber;
  static const Field<AccountModel, String> _f$phoneNumber = Field(
    'phoneNumber',
    _$phoneNumber,
    key: r'phone_number',
    opt: true,
  );
  static String? _$avatarUrl(AccountModel v) => v.avatarUrl;
  static const Field<AccountModel, String> _f$avatarUrl = Field(
    'avatarUrl',
    _$avatarUrl,
    key: r'avatar_url',
    opt: true,
  );
  static String _$role(AccountModel v) => v.role;
  static const Field<AccountModel, String> _f$role = Field('role', _$role);
  static DateTime _$createdAt(AccountModel v) => v.createdAt;
  static const Field<AccountModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );
  static DateTime _$updatedAt(AccountModel v) => v.updatedAt;
  static const Field<AccountModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
  );

  @override
  final MappableFields<AccountModel> fields = const {
    #id: _f$id,
    #fullName: _f$fullName,
    #phoneNumber: _f$phoneNumber,
    #avatarUrl: _f$avatarUrl,
    #role: _f$role,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static AccountModel _instantiate(DecodingData data) {
    return AccountModel(
      id: data.dec(_f$id),
      fullName: data.dec(_f$fullName),
      phoneNumber: data.dec(_f$phoneNumber),
      avatarUrl: data.dec(_f$avatarUrl),
      role: data.dec(_f$role),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AccountModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountModel>(map);
  }

  static AccountModel fromJson(String json) {
    return ensureInitialized().decodeJson<AccountModel>(json);
  }
}

mixin AccountModelMappable {
  String toJson() {
    return AccountModelMapper.ensureInitialized().encodeJson<AccountModel>(
      this as AccountModel,
    );
  }

  Map<String, dynamic> toMap() {
    return AccountModelMapper.ensureInitialized().encodeMap<AccountModel>(
      this as AccountModel,
    );
  }

  AccountModelCopyWith<AccountModel, AccountModel, AccountModel> get copyWith =>
      _AccountModelCopyWithImpl<AccountModel, AccountModel>(
        this as AccountModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AccountModelMapper.ensureInitialized().stringifyValue(
      this as AccountModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AccountModelMapper.ensureInitialized().equalsValue(
      this as AccountModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AccountModelMapper.ensureInitialized().hashValue(
      this as AccountModel,
    );
  }
}

extension AccountModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountModel, $Out> {
  AccountModelCopyWith<$R, AccountModel, $Out> get $asAccountModel =>
      $base.as((v, t, t2) => _AccountModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AccountModelCopyWith<$R, $In extends AccountModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  AccountModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AccountModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountModel, $Out>
    implements AccountModelCopyWith<$R, AccountModel, $Out> {
  _AccountModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountModel> $mapper =
      AccountModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? fullName = $none,
    Object? phoneNumber = $none,
    Object? avatarUrl = $none,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (fullName != $none) #fullName: fullName,
      if (phoneNumber != $none) #phoneNumber: phoneNumber,
      if (avatarUrl != $none) #avatarUrl: avatarUrl,
      if (role != null) #role: role,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  AccountModel $make(CopyWithData data) => AccountModel(
    id: data.get(#id, or: $value.id),
    fullName: data.get(#fullName, or: $value.fullName),
    phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
    avatarUrl: data.get(#avatarUrl, or: $value.avatarUrl),
    role: data.get(#role, or: $value.role),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  AccountModelCopyWith<$R2, AccountModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AccountModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AccountPetModelMapper extends ClassMapperBase<AccountPetModel> {
  AccountPetModelMapper._();

  static AccountPetModelMapper? _instance;
  static AccountPetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountPetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AccountPetModel';

  static String _$id(AccountPetModel v) => v.id;
  static const Field<AccountPetModel, String> _f$id = Field('id', _$id);
  static String _$name(AccountPetModel v) => v.name;
  static const Field<AccountPetModel, String> _f$name = Field('name', _$name);
  static String _$gender(AccountPetModel v) => v.gender;
  static const Field<AccountPetModel, String> _f$gender = Field(
    'gender',
    _$gender,
  );
  static String _$breed(AccountPetModel v) => v.breed;
  static const Field<AccountPetModel, String> _f$breed = Field(
    'breed',
    _$breed,
  );
  static int? _$age(AccountPetModel v) => v.age;
  static const Field<AccountPetModel, int> _f$age = Field(
    'age',
    _$age,
    opt: true,
  );
  static String? _$photoUrl(AccountPetModel v) => v.photoUrl;
  static const Field<AccountPetModel, String> _f$photoUrl = Field(
    'photoUrl',
    _$photoUrl,
    key: r'photo_url',
    opt: true,
  );
  static bool _$listedForAdoption(AccountPetModel v) => v.listedForAdoption;
  static const Field<AccountPetModel, bool> _f$listedForAdoption = Field(
    'listedForAdoption',
    _$listedForAdoption,
    key: r'listed_for_adoption',
    opt: true,
    def: false,
  );

  @override
  final MappableFields<AccountPetModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #gender: _f$gender,
    #breed: _f$breed,
    #age: _f$age,
    #photoUrl: _f$photoUrl,
    #listedForAdoption: _f$listedForAdoption,
  };

  static AccountPetModel _instantiate(DecodingData data) {
    return AccountPetModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      gender: data.dec(_f$gender),
      breed: data.dec(_f$breed),
      age: data.dec(_f$age),
      photoUrl: data.dec(_f$photoUrl),
      listedForAdoption: data.dec(_f$listedForAdoption),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AccountPetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountPetModel>(map);
  }

  static AccountPetModel fromJson(String json) {
    return ensureInitialized().decodeJson<AccountPetModel>(json);
  }
}

mixin AccountPetModelMappable {
  String toJson() {
    return AccountPetModelMapper.ensureInitialized()
        .encodeJson<AccountPetModel>(this as AccountPetModel);
  }

  Map<String, dynamic> toMap() {
    return AccountPetModelMapper.ensureInitialized().encodeMap<AccountPetModel>(
      this as AccountPetModel,
    );
  }

  AccountPetModelCopyWith<AccountPetModel, AccountPetModel, AccountPetModel>
  get copyWith =>
      _AccountPetModelCopyWithImpl<AccountPetModel, AccountPetModel>(
        this as AccountPetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AccountPetModelMapper.ensureInitialized().stringifyValue(
      this as AccountPetModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AccountPetModelMapper.ensureInitialized().equalsValue(
      this as AccountPetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AccountPetModelMapper.ensureInitialized().hashValue(
      this as AccountPetModel,
    );
  }
}

extension AccountPetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountPetModel, $Out> {
  AccountPetModelCopyWith<$R, AccountPetModel, $Out> get $asAccountPetModel =>
      $base.as((v, t, t2) => _AccountPetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AccountPetModelCopyWith<$R, $In extends AccountPetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? gender,
    String? breed,
    int? age,
    String? photoUrl,
    bool? listedForAdoption,
  });
  AccountPetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AccountPetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountPetModel, $Out>
    implements AccountPetModelCopyWith<$R, AccountPetModel, $Out> {
  _AccountPetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountPetModel> $mapper =
      AccountPetModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    String? gender,
    String? breed,
    Object? age = $none,
    Object? photoUrl = $none,
    bool? listedForAdoption,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (gender != null) #gender: gender,
      if (breed != null) #breed: breed,
      if (age != $none) #age: age,
      if (photoUrl != $none) #photoUrl: photoUrl,
      if (listedForAdoption != null) #listedForAdoption: listedForAdoption,
    }),
  );
  @override
  AccountPetModel $make(CopyWithData data) => AccountPetModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    gender: data.get(#gender, or: $value.gender),
    breed: data.get(#breed, or: $value.breed),
    age: data.get(#age, or: $value.age),
    photoUrl: data.get(#photoUrl, or: $value.photoUrl),
    listedForAdoption: data.get(
      #listedForAdoption,
      or: $value.listedForAdoption,
    ),
  );

  @override
  AccountPetModelCopyWith<$R2, AccountPetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AccountPetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

