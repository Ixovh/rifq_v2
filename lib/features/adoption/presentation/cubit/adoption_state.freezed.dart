// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adoption_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdoptionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdoptionState()';
}


}

/// @nodoc
class $AdoptionStateCopyWith<$Res>  {
$AdoptionStateCopyWith(AdoptionState _, $Res Function(AdoptionState) __);
}


/// Adds pattern-matching-related methods to [AdoptionState].
extension AdoptionStatePatterns on AdoptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _FeedLoaded value)?  feedLoaded,TResult Function( _MyListingsLoaded value)?  myListingsLoaded,TResult Function( _ActionSuccess value)?  actionSuccess,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _FeedLoaded() when feedLoaded != null:
return feedLoaded(_that);case _MyListingsLoaded() when myListingsLoaded != null:
return myListingsLoaded(_that);case _ActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _FeedLoaded value)  feedLoaded,required TResult Function( _MyListingsLoaded value)  myListingsLoaded,required TResult Function( _ActionSuccess value)  actionSuccess,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _FeedLoaded():
return feedLoaded(_that);case _MyListingsLoaded():
return myListingsLoaded(_that);case _ActionSuccess():
return actionSuccess(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _FeedLoaded value)?  feedLoaded,TResult? Function( _MyListingsLoaded value)?  myListingsLoaded,TResult? Function( _ActionSuccess value)?  actionSuccess,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _FeedLoaded() when feedLoaded != null:
return feedLoaded(_that);case _MyListingsLoaded() when myListingsLoaded != null:
return myListingsLoaded(_that);case _ActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<AdoptionPostEntity> posts)?  feedLoaded,TResult Function( List<AdoptionPostEntity> posts)?  myListingsLoaded,TResult Function()?  actionSuccess,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _FeedLoaded() when feedLoaded != null:
return feedLoaded(_that.posts);case _MyListingsLoaded() when myListingsLoaded != null:
return myListingsLoaded(_that.posts);case _ActionSuccess() when actionSuccess != null:
return actionSuccess();case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<AdoptionPostEntity> posts)  feedLoaded,required TResult Function( List<AdoptionPostEntity> posts)  myListingsLoaded,required TResult Function()  actionSuccess,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _FeedLoaded():
return feedLoaded(_that.posts);case _MyListingsLoaded():
return myListingsLoaded(_that.posts);case _ActionSuccess():
return actionSuccess();case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<AdoptionPostEntity> posts)?  feedLoaded,TResult? Function( List<AdoptionPostEntity> posts)?  myListingsLoaded,TResult? Function()?  actionSuccess,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _FeedLoaded() when feedLoaded != null:
return feedLoaded(_that.posts);case _MyListingsLoaded() when myListingsLoaded != null:
return myListingsLoaded(_that.posts);case _ActionSuccess() when actionSuccess != null:
return actionSuccess();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AdoptionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdoptionState.initial()';
}


}




/// @nodoc


class _Loading implements AdoptionState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdoptionState.loading()';
}


}




/// @nodoc


class _FeedLoaded implements AdoptionState {
  const _FeedLoaded( List<AdoptionPostEntity> posts): _posts = posts;
  

 final  List<AdoptionPostEntity> _posts;
 List<AdoptionPostEntity> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of AdoptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedLoadedCopyWith<_FeedLoaded> get copyWith => __$FeedLoadedCopyWithImpl<_FeedLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedLoaded&&const DeepCollectionEquality().equals(other._posts, _posts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'AdoptionState.feedLoaded(posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$FeedLoadedCopyWith<$Res> implements $AdoptionStateCopyWith<$Res> {
  factory _$FeedLoadedCopyWith(_FeedLoaded value, $Res Function(_FeedLoaded) _then) = __$FeedLoadedCopyWithImpl;
@useResult
$Res call({
 List<AdoptionPostEntity> posts
});




}
/// @nodoc
class __$FeedLoadedCopyWithImpl<$Res>
    implements _$FeedLoadedCopyWith<$Res> {
  __$FeedLoadedCopyWithImpl(this._self, this._then);

  final _FeedLoaded _self;
  final $Res Function(_FeedLoaded) _then;

/// Create a copy of AdoptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,}) {
  return _then(_FeedLoaded(
null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<AdoptionPostEntity>,
  ));
}


}

/// @nodoc


class _MyListingsLoaded implements AdoptionState {
  const _MyListingsLoaded( List<AdoptionPostEntity> posts): _posts = posts;
  

 final  List<AdoptionPostEntity> _posts;
 List<AdoptionPostEntity> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of AdoptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyListingsLoadedCopyWith<_MyListingsLoaded> get copyWith => __$MyListingsLoadedCopyWithImpl<_MyListingsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyListingsLoaded&&const DeepCollectionEquality().equals(other._posts, _posts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'AdoptionState.myListingsLoaded(posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$MyListingsLoadedCopyWith<$Res> implements $AdoptionStateCopyWith<$Res> {
  factory _$MyListingsLoadedCopyWith(_MyListingsLoaded value, $Res Function(_MyListingsLoaded) _then) = __$MyListingsLoadedCopyWithImpl;
@useResult
$Res call({
 List<AdoptionPostEntity> posts
});




}
/// @nodoc
class __$MyListingsLoadedCopyWithImpl<$Res>
    implements _$MyListingsLoadedCopyWith<$Res> {
  __$MyListingsLoadedCopyWithImpl(this._self, this._then);

  final _MyListingsLoaded _self;
  final $Res Function(_MyListingsLoaded) _then;

/// Create a copy of AdoptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,}) {
  return _then(_MyListingsLoaded(
null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<AdoptionPostEntity>,
  ));
}


}

/// @nodoc


class _ActionSuccess implements AdoptionState {
  const _ActionSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdoptionState.actionSuccess()';
}


}




/// @nodoc


class _Error implements AdoptionState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AdoptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AdoptionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AdoptionStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AdoptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
