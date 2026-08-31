// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_list_item_model.dart';

class HotelListItemModelMapper extends ClassMapperBase<HotelListItemModel> {
  HotelListItemModelMapper._();

  static HotelListItemModelMapper? _instance;
  static HotelListItemModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelListItemModelMapper._());
      HotelOwnerProfileModelMapper.ensureInitialized();
      HotelImageModelMapper.ensureInitialized();
      HotelRoomModelMapper.ensureInitialized();
      HotelServiceModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HotelListItemModel';

  static String _$id(HotelListItemModel v) => v.id;
  static const Field<HotelListItemModel, String> _f$id = Field('id', _$id);
  static String? _$name(HotelListItemModel v) => v.name;
  static const Field<HotelListItemModel, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static double _$rating(HotelListItemModel v) => v.rating;
  static const Field<HotelListItemModel, double> _f$rating = Field(
    'rating',
    _$rating,
  );
  static int _$reviewCount(HotelListItemModel v) => v.reviewCount;
  static const Field<HotelListItemModel, int> _f$reviewCount = Field(
    'reviewCount',
    _$reviewCount,
    key: r'review_count',
  );
  static String _$locationText(HotelListItemModel v) => v.locationText;
  static const Field<HotelListItemModel, String> _f$locationText = Field(
    'locationText',
    _$locationText,
    key: r'location_text',
  );
  static double? _$latitude(HotelListItemModel v) => v.latitude;
  static const Field<HotelListItemModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(HotelListItemModel v) => v.longitude;
  static const Field<HotelListItemModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static HotelOwnerProfileModel? _$profile(HotelListItemModel v) => v.profile;
  static const Field<HotelListItemModel, HotelOwnerProfileModel> _f$profile =
      Field('profile', _$profile, key: r'profiles', opt: true);
  static List<HotelImageModel> _$images(HotelListItemModel v) => v.images;
  static const Field<HotelListItemModel, List<HotelImageModel>> _f$images =
      Field('images', _$images, key: r'hotel_images', opt: true, def: const []);
  static List<HotelRoomModel> _$rooms(HotelListItemModel v) => v.rooms;
  static const Field<HotelListItemModel, List<HotelRoomModel>> _f$rooms = Field(
    'rooms',
    _$rooms,
    key: r'hotel_rooms',
    opt: true,
    def: const [],
  );
  static List<HotelServiceModel> _$services(HotelListItemModel v) => v.services;
  static const Field<HotelListItemModel, List<HotelServiceModel>> _f$services =
      Field(
        'services',
        _$services,
        key: r'hotel_services',
        opt: true,
        def: const [],
      );

  @override
  final MappableFields<HotelListItemModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #rating: _f$rating,
    #reviewCount: _f$reviewCount,
    #locationText: _f$locationText,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #profile: _f$profile,
    #images: _f$images,
    #rooms: _f$rooms,
    #services: _f$services,
  };

  static HotelListItemModel _instantiate(DecodingData data) {
    return HotelListItemModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      rating: data.dec(_f$rating),
      reviewCount: data.dec(_f$reviewCount),
      locationText: data.dec(_f$locationText),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      profile: data.dec(_f$profile),
      images: data.dec(_f$images),
      rooms: data.dec(_f$rooms),
      services: data.dec(_f$services),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelListItemModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelListItemModel>(map);
  }

  static HotelListItemModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelListItemModel>(json);
  }
}

mixin HotelListItemModelMappable {
  String toJson() {
    return HotelListItemModelMapper.ensureInitialized()
        .encodeJson<HotelListItemModel>(this as HotelListItemModel);
  }

  Map<String, dynamic> toMap() {
    return HotelListItemModelMapper.ensureInitialized()
        .encodeMap<HotelListItemModel>(this as HotelListItemModel);
  }

  HotelListItemModelCopyWith<
    HotelListItemModel,
    HotelListItemModel,
    HotelListItemModel
  >
  get copyWith =>
      _HotelListItemModelCopyWithImpl<HotelListItemModel, HotelListItemModel>(
        this as HotelListItemModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelListItemModelMapper.ensureInitialized().stringifyValue(
      this as HotelListItemModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelListItemModelMapper.ensureInitialized().equalsValue(
      this as HotelListItemModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelListItemModelMapper.ensureInitialized().hashValue(
      this as HotelListItemModel,
    );
  }
}

extension HotelListItemModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelListItemModel, $Out> {
  HotelListItemModelCopyWith<$R, HotelListItemModel, $Out>
  get $asHotelListItemModel => $base.as(
    (v, t, t2) => _HotelListItemModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HotelListItemModelCopyWith<
  $R,
  $In extends HotelListItemModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  HotelOwnerProfileModelCopyWith<
    $R,
    HotelOwnerProfileModel,
    HotelOwnerProfileModel
  >?
  get profile;
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
  $R call({
    String? id,
    String? name,
    double? rating,
    int? reviewCount,
    String? locationText,
    double? latitude,
    double? longitude,
    HotelOwnerProfileModel? profile,
    List<HotelImageModel>? images,
    List<HotelRoomModel>? rooms,
    List<HotelServiceModel>? services,
  });
  HotelListItemModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelListItemModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelListItemModel, $Out>
    implements HotelListItemModelCopyWith<$R, HotelListItemModel, $Out> {
  _HotelListItemModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelListItemModel> $mapper =
      HotelListItemModelMapper.ensureInitialized();
  @override
  HotelOwnerProfileModelCopyWith<
    $R,
    HotelOwnerProfileModel,
    HotelOwnerProfileModel
  >?
  get profile => $value.profile?.copyWith.$chain((v) => call(profile: v));
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
  $R call({
    String? id,
    Object? name = $none,
    double? rating,
    int? reviewCount,
    String? locationText,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? profile = $none,
    List<HotelImageModel>? images,
    List<HotelRoomModel>? rooms,
    List<HotelServiceModel>? services,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != $none) #name: name,
      if (rating != null) #rating: rating,
      if (reviewCount != null) #reviewCount: reviewCount,
      if (locationText != null) #locationText: locationText,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (profile != $none) #profile: profile,
      if (images != null) #images: images,
      if (rooms != null) #rooms: rooms,
      if (services != null) #services: services,
    }),
  );
  @override
  HotelListItemModel $make(CopyWithData data) => HotelListItemModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    rating: data.get(#rating, or: $value.rating),
    reviewCount: data.get(#reviewCount, or: $value.reviewCount),
    locationText: data.get(#locationText, or: $value.locationText),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    profile: data.get(#profile, or: $value.profile),
    images: data.get(#images, or: $value.images),
    rooms: data.get(#rooms, or: $value.rooms),
    services: data.get(#services, or: $value.services),
  );

  @override
  HotelListItemModelCopyWith<$R2, HotelListItemModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelListItemModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

