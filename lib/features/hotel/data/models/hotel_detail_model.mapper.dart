// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_detail_model.dart';

class HotelDetailModelMapper extends ClassMapperBase<HotelDetailModel> {
  HotelDetailModelMapper._();

  static HotelDetailModelMapper? _instance;
  static HotelDetailModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelDetailModelMapper._());
      HotelImageModelMapper.ensureInitialized();
      HotelRoomModelMapper.ensureInitialized();
      HotelServiceModelMapper.ensureInitialized();
      HotelFacilityModelMapper.ensureInitialized();
      HotelRuleModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HotelDetailModel';

  static String _$id(HotelDetailModel v) => v.id;
  static const Field<HotelDetailModel, String> _f$id = Field('id', _$id);
  static String _$name(HotelDetailModel v) => v.name;
  static const Field<HotelDetailModel, String> _f$name = Field('name', _$name);
  static String _$locationText(HotelDetailModel v) => v.locationText;
  static const Field<HotelDetailModel, String> _f$locationText = Field(
    'locationText',
    _$locationText,
    key: r'location_text',
  );
  static double? _$latitude(HotelDetailModel v) => v.latitude;
  static const Field<HotelDetailModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(HotelDetailModel v) => v.longitude;
  static const Field<HotelDetailModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static String? _$description(HotelDetailModel v) => v.description;
  static const Field<HotelDetailModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static List<HotelImageModel> _$images(HotelDetailModel v) => v.images;
  static const Field<HotelDetailModel, List<HotelImageModel>> _f$images = Field(
    'images',
    _$images,
    key: r'hotel_images',
    opt: true,
    def: const [],
  );
  static List<HotelRoomModel> _$rooms(HotelDetailModel v) => v.rooms;
  static const Field<HotelDetailModel, List<HotelRoomModel>> _f$rooms = Field(
    'rooms',
    _$rooms,
    key: r'hotel_rooms',
    opt: true,
    def: const [],
  );
  static List<HotelServiceModel> _$services(HotelDetailModel v) => v.services;
  static const Field<HotelDetailModel, List<HotelServiceModel>> _f$services =
      Field(
        'services',
        _$services,
        key: r'hotel_services',
        opt: true,
        def: const [],
      );
  static List<HotelFacilityModel> _$facilities(HotelDetailModel v) =>
      v.facilities;
  static const Field<HotelDetailModel, List<HotelFacilityModel>> _f$facilities =
      Field(
        'facilities',
        _$facilities,
        key: r'hotel_facilities',
        opt: true,
        def: const [],
      );
  static List<HotelRuleModel> _$rules(HotelDetailModel v) => v.rules;
  static const Field<HotelDetailModel, List<HotelRuleModel>> _f$rules = Field(
    'rules',
    _$rules,
    key: r'hotel_rules',
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<HotelDetailModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #locationText: _f$locationText,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #description: _f$description,
    #images: _f$images,
    #rooms: _f$rooms,
    #services: _f$services,
    #facilities: _f$facilities,
    #rules: _f$rules,
  };

  static HotelDetailModel _instantiate(DecodingData data) {
    return HotelDetailModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      locationText: data.dec(_f$locationText),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      description: data.dec(_f$description),
      images: data.dec(_f$images),
      rooms: data.dec(_f$rooms),
      services: data.dec(_f$services),
      facilities: data.dec(_f$facilities),
      rules: data.dec(_f$rules),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelDetailModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelDetailModel>(map);
  }

  static HotelDetailModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelDetailModel>(json);
  }
}

mixin HotelDetailModelMappable {
  String toJson() {
    return HotelDetailModelMapper.ensureInitialized()
        .encodeJson<HotelDetailModel>(this as HotelDetailModel);
  }

  Map<String, dynamic> toMap() {
    return HotelDetailModelMapper.ensureInitialized()
        .encodeMap<HotelDetailModel>(this as HotelDetailModel);
  }

  HotelDetailModelCopyWith<HotelDetailModel, HotelDetailModel, HotelDetailModel>
  get copyWith =>
      _HotelDetailModelCopyWithImpl<HotelDetailModel, HotelDetailModel>(
        this as HotelDetailModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelDetailModelMapper.ensureInitialized().stringifyValue(
      this as HotelDetailModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelDetailModelMapper.ensureInitialized().equalsValue(
      this as HotelDetailModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelDetailModelMapper.ensureInitialized().hashValue(
      this as HotelDetailModel,
    );
  }
}

extension HotelDetailModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelDetailModel, $Out> {
  HotelDetailModelCopyWith<$R, HotelDetailModel, $Out>
  get $asHotelDetailModel =>
      $base.as((v, t, t2) => _HotelDetailModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HotelDetailModelCopyWith<$R, $In extends HotelDetailModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    HotelImageModel,
    HotelImageModelCopyWith<$R, HotelImageModel, HotelImageModel>
  >
  get images;
  ListCopyWith<
    $R,
    HotelRoomModel,
    HotelRoomModelCopyWith<$R, HotelRoomModel, HotelRoomModel>
  >
  get rooms;
  ListCopyWith<
    $R,
    HotelServiceModel,
    HotelServiceModelCopyWith<$R, HotelServiceModel, HotelServiceModel>
  >
  get services;
  ListCopyWith<
    $R,
    HotelFacilityModel,
    HotelFacilityModelCopyWith<$R, HotelFacilityModel, HotelFacilityModel>
  >
  get facilities;
  ListCopyWith<
    $R,
    HotelRuleModel,
    HotelRuleModelCopyWith<$R, HotelRuleModel, HotelRuleModel>
  >
  get rules;
  $R call({
    String? id,
    String? name,
    String? locationText,
    double? latitude,
    double? longitude,
    String? description,
    List<HotelImageModel>? images,
    List<HotelRoomModel>? rooms,
    List<HotelServiceModel>? services,
    List<HotelFacilityModel>? facilities,
    List<HotelRuleModel>? rules,
  });
  HotelDetailModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelDetailModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelDetailModel, $Out>
    implements HotelDetailModelCopyWith<$R, HotelDetailModel, $Out> {
  _HotelDetailModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelDetailModel> $mapper =
      HotelDetailModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    HotelImageModel,
    HotelImageModelCopyWith<$R, HotelImageModel, HotelImageModel>
  >
  get images => ListCopyWith(
    $value.images,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(images: v),
  );
  @override
  ListCopyWith<
    $R,
    HotelRoomModel,
    HotelRoomModelCopyWith<$R, HotelRoomModel, HotelRoomModel>
  >
  get rooms => ListCopyWith(
    $value.rooms,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(rooms: v),
  );
  @override
  ListCopyWith<
    $R,
    HotelServiceModel,
    HotelServiceModelCopyWith<$R, HotelServiceModel, HotelServiceModel>
  >
  get services => ListCopyWith(
    $value.services,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(services: v),
  );
  @override
  ListCopyWith<
    $R,
    HotelFacilityModel,
    HotelFacilityModelCopyWith<$R, HotelFacilityModel, HotelFacilityModel>
  >
  get facilities => ListCopyWith(
    $value.facilities,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(facilities: v),
  );
  @override
  ListCopyWith<
    $R,
    HotelRuleModel,
    HotelRuleModelCopyWith<$R, HotelRuleModel, HotelRuleModel>
  >
  get rules => ListCopyWith(
    $value.rules,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(rules: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    String? locationText,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? description = $none,
    List<HotelImageModel>? images,
    List<HotelRoomModel>? rooms,
    List<HotelServiceModel>? services,
    List<HotelFacilityModel>? facilities,
    List<HotelRuleModel>? rules,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (locationText != null) #locationText: locationText,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (description != $none) #description: description,
      if (images != null) #images: images,
      if (rooms != null) #rooms: rooms,
      if (services != null) #services: services,
      if (facilities != null) #facilities: facilities,
      if (rules != null) #rules: rules,
    }),
  );
  @override
  HotelDetailModel $make(CopyWithData data) => HotelDetailModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    locationText: data.get(#locationText, or: $value.locationText),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    description: data.get(#description, or: $value.description),
    images: data.get(#images, or: $value.images),
    rooms: data.get(#rooms, or: $value.rooms),
    services: data.get(#services, or: $value.services),
    facilities: data.get(#facilities, or: $value.facilities),
    rules: data.get(#rules, or: $value.rules),
  );

  @override
  HotelDetailModelCopyWith<$R2, HotelDetailModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelDetailModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

