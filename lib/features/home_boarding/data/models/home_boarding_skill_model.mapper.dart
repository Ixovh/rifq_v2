// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_boarding_skill_model.dart';

class HomeBoardingSkillModelMapper
    extends ClassMapperBase<HomeBoardingSkillModel> {
  HomeBoardingSkillModelMapper._();

  static HomeBoardingSkillModelMapper? _instance;
  static HomeBoardingSkillModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeBoardingSkillModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HomeBoardingSkillModel';

  static String _$id(HomeBoardingSkillModel v) => v.id;
  static const Field<HomeBoardingSkillModel, String> _f$id = Field('id', _$id);
  static String _$skillLabel(HomeBoardingSkillModel v) => v.skillLabel;
  static const Field<HomeBoardingSkillModel, String> _f$skillLabel = Field(
    'skillLabel',
    _$skillLabel,
    key: r'skill_label',
  );

  @override
  final MappableFields<HomeBoardingSkillModel> fields = const {
    #id: _f$id,
    #skillLabel: _f$skillLabel,
  };

  static HomeBoardingSkillModel _instantiate(DecodingData data) {
    return HomeBoardingSkillModel(
      id: data.dec(_f$id),
      skillLabel: data.dec(_f$skillLabel),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeBoardingSkillModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeBoardingSkillModel>(map);
  }

  static HomeBoardingSkillModel fromJson(String json) {
    return ensureInitialized().decodeJson<HomeBoardingSkillModel>(json);
  }
}

mixin HomeBoardingSkillModelMappable {
  String toJson() {
    return HomeBoardingSkillModelMapper.ensureInitialized()
        .encodeJson<HomeBoardingSkillModel>(this as HomeBoardingSkillModel);
  }

  Map<String, dynamic> toMap() {
    return HomeBoardingSkillModelMapper.ensureInitialized()
        .encodeMap<HomeBoardingSkillModel>(this as HomeBoardingSkillModel);
  }

  HomeBoardingSkillModelCopyWith<
    HomeBoardingSkillModel,
    HomeBoardingSkillModel,
    HomeBoardingSkillModel
  >
  get copyWith =>
      _HomeBoardingSkillModelCopyWithImpl<
        HomeBoardingSkillModel,
        HomeBoardingSkillModel
      >(this as HomeBoardingSkillModel, $identity, $identity);
  @override
  String toString() {
    return HomeBoardingSkillModelMapper.ensureInitialized().stringifyValue(
      this as HomeBoardingSkillModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeBoardingSkillModelMapper.ensureInitialized().equalsValue(
      this as HomeBoardingSkillModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeBoardingSkillModelMapper.ensureInitialized().hashValue(
      this as HomeBoardingSkillModel,
    );
  }
}

extension HomeBoardingSkillModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeBoardingSkillModel, $Out> {
  HomeBoardingSkillModelCopyWith<$R, HomeBoardingSkillModel, $Out>
  get $asHomeBoardingSkillModel => $base.as(
    (v, t, t2) => _HomeBoardingSkillModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HomeBoardingSkillModelCopyWith<
  $R,
  $In extends HomeBoardingSkillModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? skillLabel});
  HomeBoardingSkillModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HomeBoardingSkillModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeBoardingSkillModel, $Out>
    implements
        HomeBoardingSkillModelCopyWith<$R, HomeBoardingSkillModel, $Out> {
  _HomeBoardingSkillModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeBoardingSkillModel> $mapper =
      HomeBoardingSkillModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? skillLabel}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (skillLabel != null) #skillLabel: skillLabel,
    }),
  );
  @override
  HomeBoardingSkillModel $make(CopyWithData data) => HomeBoardingSkillModel(
    id: data.get(#id, or: $value.id),
    skillLabel: data.get(#skillLabel, or: $value.skillLabel),
  );

  @override
  HomeBoardingSkillModelCopyWith<$R2, HomeBoardingSkillModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HomeBoardingSkillModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

