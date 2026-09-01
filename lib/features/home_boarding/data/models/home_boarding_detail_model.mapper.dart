// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_boarding_detail_model.dart';

class HomeBoardingDetailModelMapper
    extends ClassMapperBase<HomeBoardingDetailModel> {
  HomeBoardingDetailModelMapper._();

  static HomeBoardingDetailModelMapper? _instance;
  static HomeBoardingDetailModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = HomeBoardingDetailModelMapper._(),
      );
      SitterProfileRefModelMapper.ensureInitialized();
      HomeBoardingSkillModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeBoardingDetailModel';

  static String _$id(HomeBoardingDetailModel v) => v.id;
  static const Field<HomeBoardingDetailModel, String> _f$id = Field('id', _$id);
  static String _$specialty(HomeBoardingDetailModel v) => v.specialty;
  static const Field<HomeBoardingDetailModel, String> _f$specialty = Field(
    'specialty',
    _$specialty,
  );
  static double _$rating(HomeBoardingDetailModel v) => v.rating;
  static const Field<HomeBoardingDetailModel, double> _f$rating = Field(
    'rating',
    _$rating,
  );
  static String? _$bio(HomeBoardingDetailModel v) => v.bio;
  static const Field<HomeBoardingDetailModel, String> _f$bio = Field(
    'bio',
    _$bio,
    opt: true,
  );
  static int _$reviewCount(HomeBoardingDetailModel v) => v.reviewCount;
  static const Field<HomeBoardingDetailModel, int> _f$reviewCount = Field(
    'reviewCount',
    _$reviewCount,
    key: r'review_count',
  );
  static String _$areaText(HomeBoardingDetailModel v) => v.areaText;
  static const Field<HomeBoardingDetailModel, String> _f$areaText = Field(
    'areaText',
    _$areaText,
    key: r'area_text',
  );
  static double _$pricePerNight(HomeBoardingDetailModel v) => v.pricePerNight;
  static const Field<HomeBoardingDetailModel, double> _f$pricePerNight = Field(
    'pricePerNight',
    _$pricePerNight,
    key: r'price_per_night',
  );
  static int _$yearsExperience(HomeBoardingDetailModel v) => v.yearsExperience;
  static const Field<HomeBoardingDetailModel, int> _f$yearsExperience = Field(
    'yearsExperience',
    _$yearsExperience,
    key: r'years_experience',
  );
  static SitterProfileRefModel? _$profile(HomeBoardingDetailModel v) =>
      v.profile;
  static const Field<HomeBoardingDetailModel, SitterProfileRefModel>
  _f$profile = Field('profile', _$profile, key: r'profiles', opt: true);
  static List<HomeBoardingSkillModel> _$skills(HomeBoardingDetailModel v) =>
      v.skills;
  static const Field<HomeBoardingDetailModel, List<HomeBoardingSkillModel>>
  _f$skills = Field(
    'skills',
    _$skills,
    key: r'home_boarding_skills',
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<HomeBoardingDetailModel> fields = const {
    #id: _f$id,
    #specialty: _f$specialty,
    #rating: _f$rating,
    #bio: _f$bio,
    #reviewCount: _f$reviewCount,
    #areaText: _f$areaText,
    #pricePerNight: _f$pricePerNight,
    #yearsExperience: _f$yearsExperience,
    #profile: _f$profile,
    #skills: _f$skills,
  };

  static HomeBoardingDetailModel _instantiate(DecodingData data) {
    return HomeBoardingDetailModel(
      id: data.dec(_f$id),
      specialty: data.dec(_f$specialty),
      rating: data.dec(_f$rating),
      bio: data.dec(_f$bio),
      reviewCount: data.dec(_f$reviewCount),
      areaText: data.dec(_f$areaText),
      pricePerNight: data.dec(_f$pricePerNight),
      yearsExperience: data.dec(_f$yearsExperience),
      profile: data.dec(_f$profile),
      skills: data.dec(_f$skills),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeBoardingDetailModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeBoardingDetailModel>(map);
  }

  static HomeBoardingDetailModel fromJson(String json) {
    return ensureInitialized().decodeJson<HomeBoardingDetailModel>(json);
  }
}

mixin HomeBoardingDetailModelMappable {
  String toJson() {
    return HomeBoardingDetailModelMapper.ensureInitialized()
        .encodeJson<HomeBoardingDetailModel>(this as HomeBoardingDetailModel);
  }

  Map<String, dynamic> toMap() {
    return HomeBoardingDetailModelMapper.ensureInitialized()
        .encodeMap<HomeBoardingDetailModel>(this as HomeBoardingDetailModel);
  }

  HomeBoardingDetailModelCopyWith<
    HomeBoardingDetailModel,
    HomeBoardingDetailModel,
    HomeBoardingDetailModel
  >
  get copyWith =>
      _HomeBoardingDetailModelCopyWithImpl<
        HomeBoardingDetailModel,
        HomeBoardingDetailModel
      >(this as HomeBoardingDetailModel, $identity, $identity);
  @override
  String toString() {
    return HomeBoardingDetailModelMapper.ensureInitialized().stringifyValue(
      this as HomeBoardingDetailModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeBoardingDetailModelMapper.ensureInitialized().equalsValue(
      this as HomeBoardingDetailModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeBoardingDetailModelMapper.ensureInitialized().hashValue(
      this as HomeBoardingDetailModel,
    );
  }
}

extension HomeBoardingDetailModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeBoardingDetailModel, $Out> {
  HomeBoardingDetailModelCopyWith<$R, HomeBoardingDetailModel, $Out>
  get $asHomeBoardingDetailModel => $base.as(
    (v, t, t2) => _HomeBoardingDetailModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HomeBoardingDetailModelCopyWith<
  $R,
  $In extends HomeBoardingDetailModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  SitterProfileRefModelCopyWith<
    $R,
    SitterProfileRefModel,
    SitterProfileRefModel
  >?
  get profile;
  ListCopyWith<
    $R,
    HomeBoardingSkillModel,
    HomeBoardingSkillModelCopyWith<
      $R,
      HomeBoardingSkillModel,
      HomeBoardingSkillModel
    >
  >
  get skills;
  $R call({
    String? id,
    String? specialty,
    double? rating,
    String? bio,
    int? reviewCount,
    String? areaText,
    double? pricePerNight,
    int? yearsExperience,
    SitterProfileRefModel? profile,
    List<HomeBoardingSkillModel>? skills,
  });
  HomeBoardingDetailModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HomeBoardingDetailModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeBoardingDetailModel, $Out>
    implements
        HomeBoardingDetailModelCopyWith<$R, HomeBoardingDetailModel, $Out> {
  _HomeBoardingDetailModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeBoardingDetailModel> $mapper =
      HomeBoardingDetailModelMapper.ensureInitialized();
  @override
  SitterProfileRefModelCopyWith<
    $R,
    SitterProfileRefModel,
    SitterProfileRefModel
  >?
  get profile => $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  ListCopyWith<
    $R,
    HomeBoardingSkillModel,
    HomeBoardingSkillModelCopyWith<
      $R,
      HomeBoardingSkillModel,
      HomeBoardingSkillModel
    >
  >
  get skills => ListCopyWith(
    $value.skills,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(skills: v),
  );
  @override
  $R call({
    String? id,
    String? specialty,
    double? rating,
    Object? bio = $none,
    int? reviewCount,
    String? areaText,
    double? pricePerNight,
    int? yearsExperience,
    Object? profile = $none,
    List<HomeBoardingSkillModel>? skills,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (specialty != null) #specialty: specialty,
      if (rating != null) #rating: rating,
      if (bio != $none) #bio: bio,
      if (reviewCount != null) #reviewCount: reviewCount,
      if (areaText != null) #areaText: areaText,
      if (pricePerNight != null) #pricePerNight: pricePerNight,
      if (yearsExperience != null) #yearsExperience: yearsExperience,
      if (profile != $none) #profile: profile,
      if (skills != null) #skills: skills,
    }),
  );
  @override
  HomeBoardingDetailModel $make(CopyWithData data) => HomeBoardingDetailModel(
    id: data.get(#id, or: $value.id),
    specialty: data.get(#specialty, or: $value.specialty),
    rating: data.get(#rating, or: $value.rating),
    bio: data.get(#bio, or: $value.bio),
    reviewCount: data.get(#reviewCount, or: $value.reviewCount),
    areaText: data.get(#areaText, or: $value.areaText),
    pricePerNight: data.get(#pricePerNight, or: $value.pricePerNight),
    yearsExperience: data.get(#yearsExperience, or: $value.yearsExperience),
    profile: data.get(#profile, or: $value.profile),
    skills: data.get(#skills, or: $value.skills),
  );

  @override
  HomeBoardingDetailModelCopyWith<$R2, HomeBoardingDetailModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HomeBoardingDetailModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

