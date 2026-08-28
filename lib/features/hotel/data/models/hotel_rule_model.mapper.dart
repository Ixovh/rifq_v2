// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_rule_model.dart';

class HotelRuleModelMapper extends ClassMapperBase<HotelRuleModel> {
  HotelRuleModelMapper._();

  static HotelRuleModelMapper? _instance;
  static HotelRuleModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelRuleModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelRuleModel';

  static String _$id(HotelRuleModel v) => v.id;
  static const Field<HotelRuleModel, String> _f$id = Field('id', _$id);
  static String _$ruleText(HotelRuleModel v) => v.ruleText;
  static const Field<HotelRuleModel, String> _f$ruleText = Field(
    'ruleText',
    _$ruleText,
    key: r'rule_text',
  );

  @override
  final MappableFields<HotelRuleModel> fields = const {
    #id: _f$id,
    #ruleText: _f$ruleText,
  };

  static HotelRuleModel _instantiate(DecodingData data) {
    return HotelRuleModel(id: data.dec(_f$id), ruleText: data.dec(_f$ruleText));
  }

  @override
  final Function instantiate = _instantiate;

  static HotelRuleModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelRuleModel>(map);
  }

  static HotelRuleModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelRuleModel>(json);
  }
}

mixin HotelRuleModelMappable {
  String toJson() {
    return HotelRuleModelMapper.ensureInitialized().encodeJson<HotelRuleModel>(
      this as HotelRuleModel,
    );
  }

  Map<String, dynamic> toMap() {
    return HotelRuleModelMapper.ensureInitialized().encodeMap<HotelRuleModel>(
      this as HotelRuleModel,
    );
  }

  HotelRuleModelCopyWith<HotelRuleModel, HotelRuleModel, HotelRuleModel>
  get copyWith => _HotelRuleModelCopyWithImpl<HotelRuleModel, HotelRuleModel>(
    this as HotelRuleModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return HotelRuleModelMapper.ensureInitialized().stringifyValue(
      this as HotelRuleModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelRuleModelMapper.ensureInitialized().equalsValue(
      this as HotelRuleModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelRuleModelMapper.ensureInitialized().hashValue(
      this as HotelRuleModel,
    );
  }
}

extension HotelRuleModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelRuleModel, $Out> {
  HotelRuleModelCopyWith<$R, HotelRuleModel, $Out> get $asHotelRuleModel =>
      $base.as((v, t, t2) => _HotelRuleModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HotelRuleModelCopyWith<$R, $In extends HotelRuleModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? ruleText});
  HotelRuleModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelRuleModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelRuleModel, $Out>
    implements HotelRuleModelCopyWith<$R, HotelRuleModel, $Out> {
  _HotelRuleModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelRuleModel> $mapper =
      HotelRuleModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? ruleText}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (ruleText != null) #ruleText: ruleText,
    }),
  );
  @override
  HotelRuleModel $make(CopyWithData data) => HotelRuleModel(
    id: data.get(#id, or: $value.id),
    ruleText: data.get(#ruleText, or: $value.ruleText),
  );

  @override
  HotelRuleModelCopyWith<$R2, HotelRuleModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelRuleModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

