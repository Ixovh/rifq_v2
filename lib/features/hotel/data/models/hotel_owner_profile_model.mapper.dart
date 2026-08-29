// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_owner_profile_model.dart';

class HotelOwnerProfileModelMapper
    extends ClassMapperBase<HotelOwnerProfileModel> {
  HotelOwnerProfileModelMapper._();

  static HotelOwnerProfileModelMapper? _instance;
  static HotelOwnerProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelOwnerProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelOwnerProfileModel';

  static String _$fullName(HotelOwnerProfileModel v) => v.fullName;
  static const Field<HotelOwnerProfileModel, String> _f$fullName = Field(
    'fullName',
    _$fullName,
    key: r'full_name',
  );

  @override
  final MappableFields<HotelOwnerProfileModel> fields = const {
    #fullName: _f$fullName,
  };

  static HotelOwnerProfileModel _instantiate(DecodingData data) {
    return HotelOwnerProfileModel(fullName: data.dec(_f$fullName));
  }

  @override
  final Function instantiate = _instantiate;

  static HotelOwnerProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelOwnerProfileModel>(map);
  }

  static HotelOwnerProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelOwnerProfileModel>(json);
  }
}

mixin HotelOwnerProfileModelMappable {
  String toJson() {
    return HotelOwnerProfileModelMapper.ensureInitialized()
        .encodeJson<HotelOwnerProfileModel>(this as HotelOwnerProfileModel);
  }

  Map<String, dynamic> toMap() {
    return HotelOwnerProfileModelMapper.ensureInitialized()
        .encodeMap<HotelOwnerProfileModel>(this as HotelOwnerProfileModel);
  }

  HotelOwnerProfileModelCopyWith<
    HotelOwnerProfileModel,
    HotelOwnerProfileModel,
    HotelOwnerProfileModel
  >
  get copyWith =>
      _HotelOwnerProfileModelCopyWithImpl<
        HotelOwnerProfileModel,
        HotelOwnerProfileModel
      >(this as HotelOwnerProfileModel, $identity, $identity);
  @override
  String toString() {
    return HotelOwnerProfileModelMapper.ensureInitialized().stringifyValue(
      this as HotelOwnerProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelOwnerProfileModelMapper.ensureInitialized().equalsValue(
      this as HotelOwnerProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelOwnerProfileModelMapper.ensureInitialized().hashValue(
      this as HotelOwnerProfileModel,
    );
  }
}

extension HotelOwnerProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelOwnerProfileModel, $Out> {
  HotelOwnerProfileModelCopyWith<$R, HotelOwnerProfileModel, $Out>
  get $asHotelOwnerProfileModel => $base.as(
    (v, t, t2) => _HotelOwnerProfileModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HotelOwnerProfileModelCopyWith<
  $R,
  $In extends HotelOwnerProfileModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? fullName});
  HotelOwnerProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelOwnerProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelOwnerProfileModel, $Out>
    implements
        HotelOwnerProfileModelCopyWith<$R, HotelOwnerProfileModel, $Out> {
  _HotelOwnerProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelOwnerProfileModel> $mapper =
      HotelOwnerProfileModelMapper.ensureInitialized();
  @override
  $R call({String? fullName}) =>
      $apply(FieldCopyWithData({if (fullName != null) #fullName: fullName}));
  @override
  HotelOwnerProfileModel $make(CopyWithData data) => HotelOwnerProfileModel(
    fullName: data.get(#fullName, or: $value.fullName),
  );

  @override
  HotelOwnerProfileModelCopyWith<$R2, HotelOwnerProfileModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HotelOwnerProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

