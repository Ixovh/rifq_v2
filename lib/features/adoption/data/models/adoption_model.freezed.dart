// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adoption_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileModel {

 String get id;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'phone_number') String? get phoneNumber;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<ProfileModel> get copyWith => _$ProfileModelCopyWithImpl<ProfileModel>(this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phoneNumber,avatarUrl);

@override
String toString() {
  return 'ProfileModel(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res>  {
  factory $ProfileModelCopyWith(ProfileModel value, $Res Function(ProfileModel) _then) = _$ProfileModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$ProfileModelCopyWithImpl<$Res>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? phoneNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(ProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.id,_that.fullName,_that.phoneNumber,_that.avatarUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that.id,_that.fullName,_that.phoneNumber,_that.avatarUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.id,_that.fullName,_that.phoneNumber,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileModel extends ProfileModel {
  const _ProfileModel({required this.id, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'phone_number') this.phoneNumber, @JsonKey(name: 'avatar_url') this.avatarUrl}): super._();
  factory _ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileModelCopyWith<_ProfileModel> get copyWith => __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phoneNumber,avatarUrl);

@override
String toString() {
  return 'ProfileModel(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res> implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(_ProfileModel value, $Res Function(_ProfileModel) _then) = __$ProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? phoneNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(_ProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PetModel {

 String get id;@JsonKey(name: 'owner_id') String get ownerId; String get name; String get species; String get breed; int get age; String get gender;@JsonKey(name: 'health_status_summary') String? get healthStatusSummary;
/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetModelCopyWith<PetModel> get copyWith => _$PetModelCopyWithImpl<PetModel>(this as PetModel, _$identity);

  /// Serializes this PetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.species, species) || other.species == species)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.healthStatusSummary, healthStatusSummary) || other.healthStatusSummary == healthStatusSummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,name,species,breed,age,gender,healthStatusSummary);

@override
String toString() {
  return 'PetModel(id: $id, ownerId: $ownerId, name: $name, species: $species, breed: $breed, age: $age, gender: $gender, healthStatusSummary: $healthStatusSummary)';
}


}

/// @nodoc
abstract mixin class $PetModelCopyWith<$Res>  {
  factory $PetModelCopyWith(PetModel value, $Res Function(PetModel) _then) = _$PetModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'owner_id') String ownerId, String name, String species, String breed, int age, String gender,@JsonKey(name: 'health_status_summary') String? healthStatusSummary
});




}
/// @nodoc
class _$PetModelCopyWithImpl<$Res>
    implements $PetModelCopyWith<$Res> {
  _$PetModelCopyWithImpl(this._self, this._then);

  final PetModel _self;
  final $Res Function(PetModel) _then;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? name = null,Object? species = null,Object? breed = null,Object? age = null,Object? gender = null,Object? healthStatusSummary = freezed,}) {
  return _then(PetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,healthStatusSummary: freezed == healthStatusSummary ? _self.healthStatusSummary : healthStatusSummary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PetModel].
extension PetModelPatterns on PetModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetModel value)  $default,){
final _that = this;
switch (_that) {
case _PetModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetModel value)?  $default,){
final _that = this;
switch (_that) {
case _PetModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'owner_id')  String ownerId,  String name,  String species,  String breed,  int age,  String gender, @JsonKey(name: 'health_status_summary')  String? healthStatusSummary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetModel() when $default != null:
return $default(_that.id,_that.ownerId,_that.name,_that.species,_that.breed,_that.age,_that.gender,_that.healthStatusSummary);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'owner_id')  String ownerId,  String name,  String species,  String breed,  int age,  String gender, @JsonKey(name: 'health_status_summary')  String? healthStatusSummary)  $default,) {final _that = this;
switch (_that) {
case _PetModel():
return $default(_that.id,_that.ownerId,_that.name,_that.species,_that.breed,_that.age,_that.gender,_that.healthStatusSummary);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'owner_id')  String ownerId,  String name,  String species,  String breed,  int age,  String gender, @JsonKey(name: 'health_status_summary')  String? healthStatusSummary)?  $default,) {final _that = this;
switch (_that) {
case _PetModel() when $default != null:
return $default(_that.id,_that.ownerId,_that.name,_that.species,_that.breed,_that.age,_that.gender,_that.healthStatusSummary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetModel extends PetModel {
  const _PetModel({required this.id, @JsonKey(name: 'owner_id') required this.ownerId, required this.name, required this.species, required this.breed, required this.age, required this.gender, @JsonKey(name: 'health_status_summary') this.healthStatusSummary}): super._();
  factory _PetModel.fromJson(Map<String, dynamic> json) => _$PetModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'owner_id') final  String ownerId;
@override final  String name;
@override final  String species;
@override final  String breed;
@override final  int age;
@override final  String gender;
@override@JsonKey(name: 'health_status_summary') final  String? healthStatusSummary;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetModelCopyWith<_PetModel> get copyWith => __$PetModelCopyWithImpl<_PetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.species, species) || other.species == species)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.healthStatusSummary, healthStatusSummary) || other.healthStatusSummary == healthStatusSummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,name,species,breed,age,gender,healthStatusSummary);

@override
String toString() {
  return 'PetModel(id: $id, ownerId: $ownerId, name: $name, species: $species, breed: $breed, age: $age, gender: $gender, healthStatusSummary: $healthStatusSummary)';
}


}

/// @nodoc
abstract mixin class _$PetModelCopyWith<$Res> implements $PetModelCopyWith<$Res> {
  factory _$PetModelCopyWith(_PetModel value, $Res Function(_PetModel) _then) = __$PetModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'owner_id') String ownerId, String name, String species, String breed, int age, String gender,@JsonKey(name: 'health_status_summary') String? healthStatusSummary
});




}
/// @nodoc
class __$PetModelCopyWithImpl<$Res>
    implements _$PetModelCopyWith<$Res> {
  __$PetModelCopyWithImpl(this._self, this._then);

  final _PetModel _self;
  final $Res Function(_PetModel) _then;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? name = null,Object? species = null,Object? breed = null,Object? age = null,Object? gender = null,Object? healthStatusSummary = freezed,}) {
  return _then(_PetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,healthStatusSummary: freezed == healthStatusSummary ? _self.healthStatusSummary : healthStatusSummary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PetPhotoModel {

 String get id;@JsonKey(name: 'public_url') String get publicUrl;@JsonKey(name: 'is_primary') bool get isPrimary;
/// Create a copy of PetPhotoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetPhotoModelCopyWith<PetPhotoModel> get copyWith => _$PetPhotoModelCopyWithImpl<PetPhotoModel>(this as PetPhotoModel, _$identity);

  /// Serializes this PetPhotoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetPhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.publicUrl, publicUrl) || other.publicUrl == publicUrl)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,publicUrl,isPrimary);

@override
String toString() {
  return 'PetPhotoModel(id: $id, publicUrl: $publicUrl, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class $PetPhotoModelCopyWith<$Res>  {
  factory $PetPhotoModelCopyWith(PetPhotoModel value, $Res Function(PetPhotoModel) _then) = _$PetPhotoModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'public_url') String publicUrl,@JsonKey(name: 'is_primary') bool isPrimary
});




}
/// @nodoc
class _$PetPhotoModelCopyWithImpl<$Res>
    implements $PetPhotoModelCopyWith<$Res> {
  _$PetPhotoModelCopyWithImpl(this._self, this._then);

  final PetPhotoModel _self;
  final $Res Function(PetPhotoModel) _then;

/// Create a copy of PetPhotoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? publicUrl = null,Object? isPrimary = null,}) {
  return _then(PetPhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,publicUrl: null == publicUrl ? _self.publicUrl : publicUrl // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PetPhotoModel].
extension PetPhotoModelPatterns on PetPhotoModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetPhotoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetPhotoModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetPhotoModel value)  $default,){
final _that = this;
switch (_that) {
case _PetPhotoModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetPhotoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PetPhotoModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'public_url')  String publicUrl, @JsonKey(name: 'is_primary')  bool isPrimary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetPhotoModel() when $default != null:
return $default(_that.id,_that.publicUrl,_that.isPrimary);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'public_url')  String publicUrl, @JsonKey(name: 'is_primary')  bool isPrimary)  $default,) {final _that = this;
switch (_that) {
case _PetPhotoModel():
return $default(_that.id,_that.publicUrl,_that.isPrimary);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'public_url')  String publicUrl, @JsonKey(name: 'is_primary')  bool isPrimary)?  $default,) {final _that = this;
switch (_that) {
case _PetPhotoModel() when $default != null:
return $default(_that.id,_that.publicUrl,_that.isPrimary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetPhotoModel extends PetPhotoModel {
  const _PetPhotoModel({required this.id, @JsonKey(name: 'public_url') required this.publicUrl, @JsonKey(name: 'is_primary') required this.isPrimary}): super._();
  factory _PetPhotoModel.fromJson(Map<String, dynamic> json) => _$PetPhotoModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'public_url') final  String publicUrl;
@override@JsonKey(name: 'is_primary') final  bool isPrimary;

/// Create a copy of PetPhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetPhotoModelCopyWith<_PetPhotoModel> get copyWith => __$PetPhotoModelCopyWithImpl<_PetPhotoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetPhotoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetPhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.publicUrl, publicUrl) || other.publicUrl == publicUrl)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,publicUrl,isPrimary);

@override
String toString() {
  return 'PetPhotoModel(id: $id, publicUrl: $publicUrl, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class _$PetPhotoModelCopyWith<$Res> implements $PetPhotoModelCopyWith<$Res> {
  factory _$PetPhotoModelCopyWith(_PetPhotoModel value, $Res Function(_PetPhotoModel) _then) = __$PetPhotoModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'public_url') String publicUrl,@JsonKey(name: 'is_primary') bool isPrimary
});




}
/// @nodoc
class __$PetPhotoModelCopyWithImpl<$Res>
    implements _$PetPhotoModelCopyWith<$Res> {
  __$PetPhotoModelCopyWithImpl(this._self, this._then);

  final _PetPhotoModel _self;
  final $Res Function(_PetPhotoModel) _then;

/// Create a copy of PetPhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? publicUrl = null,Object? isPrimary = null,}) {
  return _then(_PetPhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,publicUrl: null == publicUrl ? _self.publicUrl : publicUrl // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AdoptionPostModel {

 String get id; String get description; String get status; String get location;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'pets') PetModel get pet;@JsonKey(name: 'profiles') ProfileModel get poster;@JsonKey(name: 'pet_photos') List<PetPhotoModel> get photos;
/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdoptionPostModelCopyWith<AdoptionPostModel> get copyWith => _$AdoptionPostModelCopyWithImpl<AdoptionPostModel>(this as AdoptionPostModel, _$identity);

  /// Serializes this AdoptionPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.poster, poster) || other.poster == poster)&&const DeepCollectionEquality().equals(other.photos, photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,status,location,createdAt,pet,poster,const DeepCollectionEquality().hash(photos));

@override
String toString() {
  return 'AdoptionPostModel(id: $id, description: $description, status: $status, location: $location, createdAt: $createdAt, pet: $pet, poster: $poster, photos: $photos)';
}


}

/// @nodoc
abstract mixin class $AdoptionPostModelCopyWith<$Res>  {
  factory $AdoptionPostModelCopyWith(AdoptionPostModel value, $Res Function(AdoptionPostModel) _then) = _$AdoptionPostModelCopyWithImpl;
@useResult
$Res call({
 String id, String description, String status, String location,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'pets') PetModel pet,@JsonKey(name: 'profiles') ProfileModel poster,@JsonKey(name: 'pet_photos') List<PetPhotoModel> photos
});


$PetModelCopyWith<$Res> get pet;$ProfileModelCopyWith<$Res> get poster;

}
/// @nodoc
class _$AdoptionPostModelCopyWithImpl<$Res>
    implements $AdoptionPostModelCopyWith<$Res> {
  _$AdoptionPostModelCopyWithImpl(this._self, this._then);

  final AdoptionPostModel _self;
  final $Res Function(AdoptionPostModel) _then;

/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? status = null,Object? location = null,Object? createdAt = null,Object? pet = null,Object? poster = null,Object? photos = null,}) {
  return _then(AdoptionPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetModel,poster: null == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as ProfileModel,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<PetPhotoModel>,
  ));
}
/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetModelCopyWith<$Res> get pet {
  
  return $PetModelCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<$Res> get poster {
  
  return $ProfileModelCopyWith<$Res>(_self.poster, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdoptionPostModel].
extension AdoptionPostModelPatterns on AdoptionPostModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdoptionPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdoptionPostModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdoptionPostModel value)  $default,){
final _that = this;
switch (_that) {
case _AdoptionPostModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdoptionPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _AdoptionPostModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  String status,  String location, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'pets')  PetModel pet, @JsonKey(name: 'profiles')  ProfileModel poster, @JsonKey(name: 'pet_photos')  List<PetPhotoModel> photos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdoptionPostModel() when $default != null:
return $default(_that.id,_that.description,_that.status,_that.location,_that.createdAt,_that.pet,_that.poster,_that.photos);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  String status,  String location, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'pets')  PetModel pet, @JsonKey(name: 'profiles')  ProfileModel poster, @JsonKey(name: 'pet_photos')  List<PetPhotoModel> photos)  $default,) {final _that = this;
switch (_that) {
case _AdoptionPostModel():
return $default(_that.id,_that.description,_that.status,_that.location,_that.createdAt,_that.pet,_that.poster,_that.photos);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  String status,  String location, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'pets')  PetModel pet, @JsonKey(name: 'profiles')  ProfileModel poster, @JsonKey(name: 'pet_photos')  List<PetPhotoModel> photos)?  $default,) {final _that = this;
switch (_that) {
case _AdoptionPostModel() when $default != null:
return $default(_that.id,_that.description,_that.status,_that.location,_that.createdAt,_that.pet,_that.poster,_that.photos);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _AdoptionPostModel extends AdoptionPostModel {
  const _AdoptionPostModel({required this.id, required this.description, required this.status, required this.location, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'pets') required this.pet, @JsonKey(name: 'profiles') required this.poster, @JsonKey(name: 'pet_photos')  List<PetPhotoModel> photos = const []}): _photos = photos,super._();
  factory _AdoptionPostModel.fromJson(Map<String, dynamic> json) => _$AdoptionPostModelFromJson(json);

@override final  String id;
@override final  String description;
@override final  String status;
@override final  String location;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'pets') final  PetModel pet;
@override@JsonKey(name: 'profiles') final  ProfileModel poster;
 final  List<PetPhotoModel> _photos;
@override@JsonKey(name: 'pet_photos') List<PetPhotoModel> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdoptionPostModelCopyWith<_AdoptionPostModel> get copyWith => __$AdoptionPostModelCopyWithImpl<_AdoptionPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdoptionPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdoptionPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.poster, poster) || other.poster == poster)&&const DeepCollectionEquality().equals(other._photos, _photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,status,location,createdAt,pet,poster,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'AdoptionPostModel(id: $id, description: $description, status: $status, location: $location, createdAt: $createdAt, pet: $pet, poster: $poster, photos: $photos)';
}


}

/// @nodoc
abstract mixin class _$AdoptionPostModelCopyWith<$Res> implements $AdoptionPostModelCopyWith<$Res> {
  factory _$AdoptionPostModelCopyWith(_AdoptionPostModel value, $Res Function(_AdoptionPostModel) _then) = __$AdoptionPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, String status, String location,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'pets') PetModel pet,@JsonKey(name: 'profiles') ProfileModel poster,@JsonKey(name: 'pet_photos') List<PetPhotoModel> photos
});


@override $PetModelCopyWith<$Res> get pet;@override $ProfileModelCopyWith<$Res> get poster;

}
/// @nodoc
class __$AdoptionPostModelCopyWithImpl<$Res>
    implements _$AdoptionPostModelCopyWith<$Res> {
  __$AdoptionPostModelCopyWithImpl(this._self, this._then);

  final _AdoptionPostModel _self;
  final $Res Function(_AdoptionPostModel) _then;

/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? status = null,Object? location = null,Object? createdAt = null,Object? pet = null,Object? poster = null,Object? photos = null,}) {
  return _then(_AdoptionPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetModel,poster: null == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as ProfileModel,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<PetPhotoModel>,
  ));
}

/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetModelCopyWith<$Res> get pet {
  
  return $PetModelCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of AdoptionPostModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<$Res> get poster {
  
  return $ProfileModelCopyWith<$Res>(_self.poster, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}

// dart format on
