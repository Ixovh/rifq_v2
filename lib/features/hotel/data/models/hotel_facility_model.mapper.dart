// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_facility_model.dart';

class HotelFacilityModelMapper extends ClassMapperBase<HotelFacilityModel> {
  HotelFacilityModelMapper._();

  static HotelFacilityModelMapper? _instance;
  static HotelFacilityModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelFacilityModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelFacilityModel';

  static String _$id(HotelFacilityModel v) => v.id;
  static const Field<HotelFacilityModel, String> _f$id = Field('id', _$id);
  static String _$category(HotelFacilityModel v) => v.category;
  static const Field<HotelFacilityModel, String> _f$category = Field(
    'category',
    _$category,
  );
  static String _$name(HotelFacilityModel v) => v.name;
  static const Field<HotelFacilityModel, String> _f$name = Field(
    'name',
    _$name,
    key: r'label',
  );

  @override
  final MappableFields<HotelFacilityModel> fields = const {
    #id: _f$id,
    #category: _f$category,
    #name: _f$name,
  };

  static HotelFacilityModel _instantiate(DecodingData data) {
    return HotelFacilityModel(
      id: data.dec(_f$id),
      category: data.dec(_f$category),
      name: data.dec(_f$name),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelFacilityModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelFacilityModel>(map);
  }

  static HotelFacilityModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelFacilityModel>(json);
  }
}

mixin HotelFacilityModelMappable {
  String toJson() {
    return HotelFacilityModelMapper.ensureInitialized()
        .encodeJson<HotelFacilityModel>(this as HotelFacilityModel);
  }

  Map<String, dynamic> toMap() {
    return HotelFacilityModelMapper.ensureInitialized()
        .encodeMap<HotelFacilityModel>(this as HotelFacilityModel);
  }

  HotelFacilityModelCopyWith<
    HotelFacilityModel,
    HotelFacilityModel,
    HotelFacilityModel
  >
  get copyWith =>
      _HotelFacilityModelCopyWithImpl<HotelFacilityModel, HotelFacilityModel>(
        this as HotelFacilityModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelFacilityModelMapper.ensureInitialized().stringifyValue(
      this as HotelFacilityModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelFacilityModelMapper.ensureInitialized().equalsValue(
      this as HotelFacilityModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelFacilityModelMapper.ensureInitialized().hashValue(
      this as HotelFacilityModel,
    );
  }
}

extension HotelFacilityModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelFacilityModel, $Out> {
  HotelFacilityModelCopyWith<$R, HotelFacilityModel, $Out>
  get $asHotelFacilityModel => $base.as(
    (v, t, t2) => _HotelFacilityModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HotelFacilityModelCopyWith<
  $R,
  $In extends HotelFacilityModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? category, String? name});
  HotelFacilityModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelFacilityModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelFacilityModel, $Out>
    implements HotelFacilityModelCopyWith<$R, HotelFacilityModel, $Out> {
  _HotelFacilityModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelFacilityModel> $mapper =
      HotelFacilityModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? category, String? name}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (category != null) #category: category,
      if (name != null) #name: name,
    }),
  );
  @override
  HotelFacilityModel $make(CopyWithData data) => HotelFacilityModel(
    id: data.get(#id, or: $value.id),
    category: data.get(#category, or: $value.category),
    name: data.get(#name, or: $value.name),
  );

  @override
  HotelFacilityModelCopyWith<$R2, HotelFacilityModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelFacilityModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

