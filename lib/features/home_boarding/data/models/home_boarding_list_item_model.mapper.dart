// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_boarding_list_item_model.dart';

class HomeBoardingListItemModelMapper
    extends ClassMapperBase<HomeBoardingListItemModel> {
  HomeBoardingListItemModelMapper._();

  static HomeBoardingListItemModelMapper? _instance;
  static HomeBoardingListItemModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = HomeBoardingListItemModelMapper._(),
      );
      SitterProfileRefModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeBoardingListItemModel';

  static String _$id(HomeBoardingListItemModel v) => v.id;
  static const Field<HomeBoardingListItemModel, String> _f$id = Field(
    'id',
    _$id,
  );
  static String _$specialty(HomeBoardingListItemModel v) => v.specialty;
  static const Field<HomeBoardingListItemModel, String> _f$specialty = Field(
    'specialty',
    _$specialty,
  );
  static double _$rating(HomeBoardingListItemModel v) => v.rating;
  static const Field<HomeBoardingListItemModel, double> _f$rating = Field(
    'rating',
    _$rating,
  );
  static int _$reviewCount(HomeBoardingListItemModel v) => v.reviewCount;
  static const Field<HomeBoardingListItemModel, int> _f$reviewCount = Field(
    'reviewCount',
    _$reviewCount,
    key: r'review_count',
  );
  static String _$areaText(HomeBoardingListItemModel v) => v.areaText;
  static const Field<HomeBoardingListItemModel, String> _f$areaText = Field(
    'areaText',
    _$areaText,
    key: r'area_text',
  );
  static double _$pricePerNight(HomeBoardingListItemModel v) => v.pricePerNight;
  static const Field<HomeBoardingListItemModel, double> _f$pricePerNight =
      Field('pricePerNight', _$pricePerNight, key: r'price_per_night');
  static int _$yearsExperience(HomeBoardingListItemModel v) =>
      v.yearsExperience;
  static const Field<HomeBoardingListItemModel, int> _f$yearsExperience = Field(
    'yearsExperience',
    _$yearsExperience,
    key: r'years_experience',
  );
  static SitterProfileRefModel? _$profile(HomeBoardingListItemModel v) =>
      v.profile;
  static const Field<HomeBoardingListItemModel, SitterProfileRefModel>
  _f$profile = Field('profile', _$profile, key: r'profiles', opt: true);

  @override
  final MappableFields<HomeBoardingListItemModel> fields = const {
    #id: _f$id,
    #specialty: _f$specialty,
    #rating: _f$rating,
    #reviewCount: _f$reviewCount,
    #areaText: _f$areaText,
    #pricePerNight: _f$pricePerNight,
    #yearsExperience: _f$yearsExperience,
    #profile: _f$profile,
  };

  static HomeBoardingListItemModel _instantiate(DecodingData data) {
    return HomeBoardingListItemModel(
      id: data.dec(_f$id),
      specialty: data.dec(_f$specialty),
      rating: data.dec(_f$rating),
      reviewCount: data.dec(_f$reviewCount),
      areaText: data.dec(_f$areaText),
      pricePerNight: data.dec(_f$pricePerNight),
      yearsExperience: data.dec(_f$yearsExperience),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeBoardingListItemModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeBoardingListItemModel>(map);
  }

  static HomeBoardingListItemModel fromJson(String json) {
    return ensureInitialized().decodeJson<HomeBoardingListItemModel>(json);
  }
}

mixin HomeBoardingListItemModelMappable {
  String toJson() {
    return HomeBoardingListItemModelMapper.ensureInitialized()
        .encodeJson<HomeBoardingListItemModel>(
          this as HomeBoardingListItemModel,
        );
  }

  Map<String, dynamic> toMap() {
    return HomeBoardingListItemModelMapper.ensureInitialized()
        .encodeMap<HomeBoardingListItemModel>(
          this as HomeBoardingListItemModel,
        );
  }

  HomeBoardingListItemModelCopyWith<
    HomeBoardingListItemModel,
    HomeBoardingListItemModel,
    HomeBoardingListItemModel
  >
  get copyWith =>
      _HomeBoardingListItemModelCopyWithImpl<
        HomeBoardingListItemModel,
        HomeBoardingListItemModel
      >(this as HomeBoardingListItemModel, $identity, $identity);
  @override
  String toString() {
    return HomeBoardingListItemModelMapper.ensureInitialized().stringifyValue(
      this as HomeBoardingListItemModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeBoardingListItemModelMapper.ensureInitialized().equalsValue(
      this as HomeBoardingListItemModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeBoardingListItemModelMapper.ensureInitialized().hashValue(
      this as HomeBoardingListItemModel,
    );
  }
}

extension HomeBoardingListItemModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeBoardingListItemModel, $Out> {
  HomeBoardingListItemModelCopyWith<$R, HomeBoardingListItemModel, $Out>
  get $asHomeBoardingListItemModel => $base.as(
    (v, t, t2) => _HomeBoardingListItemModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HomeBoardingListItemModelCopyWith<
  $R,
  $In extends HomeBoardingListItemModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  SitterProfileRefModelCopyWith<
    $R,
    SitterProfileRefModel,
    SitterProfileRefModel
  >?
  get profile;
  $R call({
    String? id,
    String? specialty,
    double? rating,
    int? reviewCount,
    String? areaText,
    double? pricePerNight,
    int? yearsExperience,
    SitterProfileRefModel? profile,
  });
  HomeBoardingListItemModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HomeBoardingListItemModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeBoardingListItemModel, $Out>
    implements
        HomeBoardingListItemModelCopyWith<$R, HomeBoardingListItemModel, $Out> {
  _HomeBoardingListItemModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeBoardingListItemModel> $mapper =
      HomeBoardingListItemModelMapper.ensureInitialized();
  @override
  SitterProfileRefModelCopyWith<
    $R,
    SitterProfileRefModel,
    SitterProfileRefModel
  >?
  get profile => $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({
    String? id,
    String? specialty,
    double? rating,
    int? reviewCount,
    String? areaText,
    double? pricePerNight,
    int? yearsExperience,
    Object? profile = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (specialty != null) #specialty: specialty,
      if (rating != null) #rating: rating,
      if (reviewCount != null) #reviewCount: reviewCount,
      if (areaText != null) #areaText: areaText,
      if (pricePerNight != null) #pricePerNight: pricePerNight,
      if (yearsExperience != null) #yearsExperience: yearsExperience,
      if (profile != $none) #profile: profile,
    }),
  );
  @override
  HomeBoardingListItemModel $make(CopyWithData data) =>
      HomeBoardingListItemModel(
        id: data.get(#id, or: $value.id),
        specialty: data.get(#specialty, or: $value.specialty),
        rating: data.get(#rating, or: $value.rating),
        reviewCount: data.get(#reviewCount, or: $value.reviewCount),
        areaText: data.get(#areaText, or: $value.areaText),
        pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
        yearsExperience: data.get(#yearsExperience, or: $value.yearsExperience),
        profile: data.get(#profile, or: $value.profile),
      );

  @override
  HomeBoardingListItemModelCopyWith<$R2, HomeBoardingListItemModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HomeBoardingListItemModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

