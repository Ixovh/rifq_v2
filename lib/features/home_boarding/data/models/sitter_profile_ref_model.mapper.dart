// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sitter_profile_ref_model.dart';

class SitterProfileRefModelMapper
    extends ClassMapperBase<SitterProfileRefModel> {
  SitterProfileRefModelMapper._();

  static SitterProfileRefModelMapper? _instance;
  static SitterProfileRefModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SitterProfileRefModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SitterProfileRefModel';

  static String _$fullName(SitterProfileRefModel v) => v.fullName;
  static const Field<SitterProfileRefModel, String> _f$fullName = Field(
    'fullName',
    _$fullName,
    key: r'full_name',
  );
  static String? _$imageUrl(SitterProfileRefModel v) => v.imageUrl;
  static const Field<SitterProfileRefModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    key: r'image_url',
    opt: true,
  );
  static String? _$phoneNumber(SitterProfileRefModel v) => v.phoneNumber;
  static const Field<SitterProfileRefModel, String> _f$phoneNumber = Field(
    'phoneNumber',
    _$phoneNumber,
    key: r'phone_number',
    opt: true,
  );

  @override
  final MappableFields<SitterProfileRefModel> fields = const {
    #fullName: _f$fullName,
    #imageUrl: _f$imageUrl,
    #phoneNumber: _f$phoneNumber,
  };

  static SitterProfileRefModel _instantiate(DecodingData data) {
    return SitterProfileRefModel(
      fullName: data.dec(_f$fullName),
      imageUrl: data.dec(_f$imageUrl),
      phoneNumber: data.dec(_f$phoneNumber),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SitterProfileRefModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SitterProfileRefModel>(map);
  }

  static SitterProfileRefModel fromJson(String json) {
    return ensureInitialized().decodeJson<SitterProfileRefModel>(json);
  }
}

mixin SitterProfileRefModelMappable {
  String toJson() {
    return SitterProfileRefModelMapper.ensureInitialized()
        .encodeJson<SitterProfileRefModel>(this as SitterProfileRefModel);
  }

  Map<String, dynamic> toMap() {
    return SitterProfileRefModelMapper.ensureInitialized()
        .encodeMap<SitterProfileRefModel>(this as SitterProfileRefModel);
  }

  SitterProfileRefModelCopyWith<
    SitterProfileRefModel,
    SitterProfileRefModel,
    SitterProfileRefModel
  >
  get copyWith =>
      _SitterProfileRefModelCopyWithImpl<
        SitterProfileRefModel,
        SitterProfileRefModel
      >(this as SitterProfileRefModel, $identity, $identity);
  @override
  String toString() {
    return SitterProfileRefModelMapper.ensureInitialized().stringifyValue(
      this as SitterProfileRefModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return SitterProfileRefModelMapper.ensureInitialized().equalsValue(
      this as SitterProfileRefModel,
      other,
    );
  }

  @override
  int get hashCode {
    return SitterProfileRefModelMapper.ensureInitialized().hashValue(
      this as SitterProfileRefModel,
    );
  }
}

extension SitterProfileRefModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SitterProfileRefModel, $Out> {
  SitterProfileRefModelCopyWith<$R, SitterProfileRefModel, $Out>
  get $asSitterProfileRefModel => $base.as(
    (v, t, t2) => _SitterProfileRefModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SitterProfileRefModelCopyWith<
  $R,
  $In extends SitterProfileRefModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? fullName, String? imageUrl, String? phoneNumber});
  SitterProfileRefModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SitterProfileRefModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SitterProfileRefModel, $Out>
    implements SitterProfileRefModelCopyWith<$R, SitterProfileRefModel, $Out> {
  _SitterProfileRefModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SitterProfileRefModel> $mapper =
      SitterProfileRefModelMapper.ensureInitialized();
  @override
  $R call({
    String? fullName,
    Object? imageUrl = $none,
    Object? phoneNumber = $none,
  }) => $apply(
    FieldCopyWithData({
      if (fullName != null) #fullName: fullName,
      if (imageUrl != $none) #imageUrl: imageUrl,
      if (phoneNumber != $none) #phoneNumber: phoneNumber,
    }),
  );
  @override
  SitterProfileRefModel $make(CopyWithData data) => SitterProfileRefModel(
    fullName: data.get(#fullName, or: $value.fullName),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
    phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
  );

  @override
  SitterProfileRefModelCopyWith<$R2, SitterProfileRefModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SitterProfileRefModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

