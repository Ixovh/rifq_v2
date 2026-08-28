// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_image_model.dart';

class HotelImageModelMapper extends ClassMapperBase<HotelImageModel> {
  HotelImageModelMapper._();

  static HotelImageModelMapper? _instance;
  static HotelImageModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelImageModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelImageModel';

  static String _$id(HotelImageModel v) => v.id;
  static const Field<HotelImageModel, String> _f$id = Field('id', _$id);
  static String _$imageUrl(HotelImageModel v) => v.imageUrl;
  static const Field<HotelImageModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    key: r'image_url',
  );
  static int _$displayOrder(HotelImageModel v) => v.displayOrder;
  static const Field<HotelImageModel, int> _f$displayOrder = Field(
    'displayOrder',
    _$displayOrder,
    key: r'display_order',
  );
  static bool _$isPrimary(HotelImageModel v) => v.isPrimary;
  static const Field<HotelImageModel, bool> _f$isPrimary = Field(
    'isPrimary',
    _$isPrimary,
    key: r'is_primary',
    opt: true,
    def: false,
  );

  @override
  final MappableFields<HotelImageModel> fields = const {
    #id: _f$id,
    #imageUrl: _f$imageUrl,
    #displayOrder: _f$displayOrder,
    #isPrimary: _f$isPrimary,
  };

  static HotelImageModel _instantiate(DecodingData data) {
    return HotelImageModel(
      id: data.dec(_f$id),
      imageUrl: data.dec(_f$imageUrl),
      displayOrder: data.dec(_f$displayOrder),
      isPrimary: data.dec(_f$isPrimary),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelImageModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelImageModel>(map);
  }

  static HotelImageModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelImageModel>(json);
  }
}

mixin HotelImageModelMappable {
  String toJson() {
    return HotelImageModelMapper.ensureInitialized()
        .encodeJson<HotelImageModel>(this as HotelImageModel);
  }

  Map<String, dynamic> toMap() {
    return HotelImageModelMapper.ensureInitialized().encodeMap<HotelImageModel>(
      this as HotelImageModel,
    );
  }

  HotelImageModelCopyWith<HotelImageModel, HotelImageModel, HotelImageModel>
  get copyWith =>
      _HotelImageModelCopyWithImpl<HotelImageModel, HotelImageModel>(
        this as HotelImageModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelImageModelMapper.ensureInitialized().stringifyValue(
      this as HotelImageModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelImageModelMapper.ensureInitialized().equalsValue(
      this as HotelImageModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelImageModelMapper.ensureInitialized().hashValue(
      this as HotelImageModel,
    );
  }
}

extension HotelImageModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelImageModel, $Out> {
  HotelImageModelCopyWith<$R, HotelImageModel, $Out> get $asHotelImageModel =>
      $base.as((v, t, t2) => _HotelImageModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HotelImageModelCopyWith<$R, $In extends HotelImageModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? imageUrl, int? displayOrder, bool? isPrimary});
  HotelImageModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelImageModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelImageModel, $Out>
    implements HotelImageModelCopyWith<$R, HotelImageModel, $Out> {
  _HotelImageModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelImageModel> $mapper =
      HotelImageModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? imageUrl, int? displayOrder, bool? isPrimary}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (imageUrl != null) #imageUrl: imageUrl,
          if (displayOrder != null) #displayOrder: displayOrder,
          if (isPrimary != null) #isPrimary: isPrimary,
        }),
      );
  @override
  HotelImageModel $make(CopyWithData data) => HotelImageModel(
    id: data.get(#id, or: $value.id),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
    displayOrder: data.get(#displayOrder, or: $value.displayOrder),
    isPrimary: data.get(#isPrimary, or: $value.isPrimary),
  );

  @override
  HotelImageModelCopyWith<$R2, HotelImageModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelImageModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

