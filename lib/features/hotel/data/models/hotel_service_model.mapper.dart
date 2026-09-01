// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_service_model.dart';

class HotelServiceModelMapper extends ClassMapperBase<HotelServiceModel> {
  HotelServiceModelMapper._();

  static HotelServiceModelMapper? _instance;
  static HotelServiceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelServiceModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelServiceModel';

  static String _$id(HotelServiceModel v) => v.id;
  static const Field<HotelServiceModel, String> _f$id = Field('id', _$id);
  static String _$name(HotelServiceModel v) => v.name;
  static const Field<HotelServiceModel, String> _f$name = Field('name', _$name);
  static double? _$price(HotelServiceModel v) => v.price;
  static const Field<HotelServiceModel, double> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String? _$priceUnit(HotelServiceModel v) => v.priceUnit;
  static const Field<HotelServiceModel, String> _f$priceUnit = Field(
    'priceUnit',
    _$priceUnit,
    key: r'price_unit',
    opt: true,
  );

  @override
  final MappableFields<HotelServiceModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #price: _f$price,
    #priceUnit: _f$priceUnit,
  };

  static HotelServiceModel _instantiate(DecodingData data) {
    return HotelServiceModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      price: data.dec(_f$price),
      priceUnit: data.dec(_f$priceUnit),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelServiceModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelServiceModel>(map);
  }

  static HotelServiceModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelServiceModel>(json);
  }
}

mixin HotelServiceModelMappable {
  String toJson() {
    return HotelServiceModelMapper.ensureInitialized()
        .encodeJson<HotelServiceModel>(this as HotelServiceModel);
  }

  Map<String, dynamic> toMap() {
    return HotelServiceModelMapper.ensureInitialized()
        .encodeMap<HotelServiceModel>(this as HotelServiceModel);
  }

  HotelServiceModelCopyWith<
    HotelServiceModel,
    HotelServiceModel,
    HotelServiceModel
  >
  get copyWith =>
      _HotelServiceModelCopyWithImpl<HotelServiceModel, HotelServiceModel>(
        this as HotelServiceModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelServiceModelMapper.ensureInitialized().stringifyValue(
      this as HotelServiceModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelServiceModelMapper.ensureInitialized().equalsValue(
      this as HotelServiceModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelServiceModelMapper.ensureInitialized().hashValue(
      this as HotelServiceModel,
    );
  }
}

extension HotelServiceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelServiceModel, $Out> {
  HotelServiceModelCopyWith<$R, HotelServiceModel, $Out>
  get $asHotelServiceModel => $base.as(
    (v, t, t2) => _HotelServiceModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HotelServiceModelCopyWith<
  $R,
  $In extends HotelServiceModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, double? price, String? priceUnit});
  HotelServiceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelServiceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelServiceModel, $Out>
    implements HotelServiceModelCopyWith<$R, HotelServiceModel, $Out> {
  _HotelServiceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelServiceModel> $mapper =
      HotelServiceModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    Object? price = $none,
    Object? priceUnit = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (price != $none) #price: price,
      if (priceUnit != $none) #priceUnit: priceUnit,
    }),
  );
  @override
  HotelServiceModel $make(CopyWithData data) => HotelServiceModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    price: data.get(#price, or: $value.price),
    priceUnit: data.get(#priceUnit, or: $value.priceUnit),
  );

  @override
  HotelServiceModelCopyWith<$R2, HotelServiceModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelServiceModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

