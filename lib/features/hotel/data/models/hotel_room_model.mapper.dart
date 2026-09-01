// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_room_model.dart';

class HotelRoomModelMapper extends ClassMapperBase<HotelRoomModel> {
  HotelRoomModelMapper._();

  static HotelRoomModelMapper? _instance;
  static HotelRoomModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelRoomModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelRoomModel';

  static String _$id(HotelRoomModel v) => v.id;
  static const Field<HotelRoomModel, String> _f$id = Field('id', _$id);
  static String _$name(HotelRoomModel v) => v.name;
  static const Field<HotelRoomModel, String> _f$name = Field(
    'name',
    _$name,
    key: r'room_type',
  );
  static double _$pricePerNight(HotelRoomModel v) => v.pricePerNight;
  static const Field<HotelRoomModel, double> _f$pricePerNight = Field(
    'pricePerNight',
    _$pricePerNight,
    key: r'price_per_night',
  );
  static String? _$sizeText(HotelRoomModel v) => v.sizeText;
  static const Field<HotelRoomModel, String> _f$sizeText = Field(
    'sizeText',
    _$sizeText,
    key: r'size_label',
    opt: true,
  );
  static List<String> _$includes(HotelRoomModel v) => v.includes;
  static const Field<HotelRoomModel, List<String>> _f$includes = Field(
    'includes',
    _$includes,
  );
  static int? _$totalRooms(HotelRoomModel v) => v.totalRooms;
  static const Field<HotelRoomModel, int> _f$totalRooms = Field(
    'totalRooms',
    _$totalRooms,
    key: r'total_rooms',
    opt: true,
  );

  @override
  final MappableFields<HotelRoomModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #pricePerNight: _f$pricePerNight,
    #sizeText: _f$sizeText,
    #includes: _f$includes,
    #totalRooms: _f$totalRooms,
  };

  static HotelRoomModel _instantiate(DecodingData data) {
    return HotelRoomModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      pricePerNight: data.dec(_f$pricePerNight),
      sizeText: data.dec(_f$sizeText),
      includes: data.dec(_f$includes),
      totalRooms: data.dec(_f$totalRooms),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelRoomModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelRoomModel>(map);
  }

  static HotelRoomModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelRoomModel>(json);
  }
}

mixin HotelRoomModelMappable {
  String toJson() {
    return HotelRoomModelMapper.ensureInitialized().encodeJson<HotelRoomModel>(
      this as HotelRoomModel,
    );
  }

  Map<String, dynamic> toMap() {
    return HotelRoomModelMapper.ensureInitialized().encodeMap<HotelRoomModel>(
      this as HotelRoomModel,
    );
  }

  HotelRoomModelCopyWith<HotelRoomModel, HotelRoomModel, HotelRoomModel>
  get copyWith => _HotelRoomModelCopyWithImpl<HotelRoomModel, HotelRoomModel>(
    this as HotelRoomModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return HotelRoomModelMapper.ensureInitialized().stringifyValue(
      this as HotelRoomModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelRoomModelMapper.ensureInitialized().equalsValue(
      this as HotelRoomModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelRoomModelMapper.ensureInitialized().hashValue(
      this as HotelRoomModel,
    );
  }
}

extension HotelRoomModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelRoomModel, $Out> {
  HotelRoomModelCopyWith<$R, HotelRoomModel, $Out> get $asHotelRoomModel =>
      $base.as((v, t, t2) => _HotelRoomModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HotelRoomModelCopyWith<$R, $In extends HotelRoomModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get includes;
  $R call({
    String? id,
    String? name,
    double? pricePerNight,
    String? sizeText,
    List<String>? includes,
    int? totalRooms,
  });
  HotelRoomModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelRoomModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelRoomModel, $Out>
    implements HotelRoomModelCopyWith<$R, HotelRoomModel, $Out> {
  _HotelRoomModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelRoomModel> $mapper =
      HotelRoomModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get includes =>
      ListCopyWith(
        $value.includes,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(includes: v),
      );
  @override
  $R call({
    String? id,
    String? name,
    double? pricePerNight,
    Object? sizeText = $none,
    List<String>? includes,
    Object? totalRooms = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (pricePerNight != null) #pricePerNight: pricePerNight,
      if (sizeText != $none) #sizeText: sizeText,
      if (includes != null) #includes: includes,
      if (totalRooms != $none) #totalRooms: totalRooms,
    }),
  );
  @override
  HotelRoomModel $make(CopyWithData data) => HotelRoomModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
    sizeText: data.get(#sizeText, or: $value.sizeText),
    includes: data.get(#includes, or: $value.includes),
    totalRooms: data.get(#totalRooms, or: $value.totalRooms),
  );

  @override
  HotelRoomModelCopyWith<$R2, HotelRoomModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelRoomModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

