// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSettingsEntity {

 String get displayName; String get signalingUrl; bool get startWithVideo;
/// Create a copy of UserSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsEntityCopyWith<UserSettingsEntity> get copyWith => _$UserSettingsEntityCopyWithImpl<UserSettingsEntity>(this as UserSettingsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsEntity&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.signalingUrl, signalingUrl) || other.signalingUrl == signalingUrl)&&(identical(other.startWithVideo, startWithVideo) || other.startWithVideo == startWithVideo));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,signalingUrl,startWithVideo);

@override
String toString() {
  return 'UserSettingsEntity(displayName: $displayName, signalingUrl: $signalingUrl, startWithVideo: $startWithVideo)';
}


}

/// @nodoc
abstract mixin class $UserSettingsEntityCopyWith<$Res>  {
  factory $UserSettingsEntityCopyWith(UserSettingsEntity value, $Res Function(UserSettingsEntity) _then) = _$UserSettingsEntityCopyWithImpl;
@useResult
$Res call({
 String displayName, String signalingUrl, bool startWithVideo
});




}
/// @nodoc
class _$UserSettingsEntityCopyWithImpl<$Res>
    implements $UserSettingsEntityCopyWith<$Res> {
  _$UserSettingsEntityCopyWithImpl(this._self, this._then);

  final UserSettingsEntity _self;
  final $Res Function(UserSettingsEntity) _then;

/// Create a copy of UserSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? signalingUrl = null,Object? startWithVideo = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,signalingUrl: null == signalingUrl ? _self.signalingUrl : signalingUrl // ignore: cast_nullable_to_non_nullable
as String,startWithVideo: null == startWithVideo ? _self.startWithVideo : startWithVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettingsEntity].
extension UserSettingsEntityPatterns on UserSettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserSettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String signalingUrl,  bool startWithVideo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettingsEntity() when $default != null:
return $default(_that.displayName,_that.signalingUrl,_that.startWithVideo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String signalingUrl,  bool startWithVideo)  $default,) {final _that = this;
switch (_that) {
case _UserSettingsEntity():
return $default(_that.displayName,_that.signalingUrl,_that.startWithVideo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String signalingUrl,  bool startWithVideo)?  $default,) {final _that = this;
switch (_that) {
case _UserSettingsEntity() when $default != null:
return $default(_that.displayName,_that.signalingUrl,_that.startWithVideo);case _:
  return null;

}
}

}

/// @nodoc


class _UserSettingsEntity implements UserSettingsEntity {
  const _UserSettingsEntity({this.displayName = 'Guest', this.signalingUrl = 'ws://localhost:3000', this.startWithVideo = true});
  

@override@JsonKey() final  String displayName;
@override@JsonKey() final  String signalingUrl;
@override@JsonKey() final  bool startWithVideo;

/// Create a copy of UserSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsEntityCopyWith<_UserSettingsEntity> get copyWith => __$UserSettingsEntityCopyWithImpl<_UserSettingsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettingsEntity&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.signalingUrl, signalingUrl) || other.signalingUrl == signalingUrl)&&(identical(other.startWithVideo, startWithVideo) || other.startWithVideo == startWithVideo));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,signalingUrl,startWithVideo);

@override
String toString() {
  return 'UserSettingsEntity(displayName: $displayName, signalingUrl: $signalingUrl, startWithVideo: $startWithVideo)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsEntityCopyWith<$Res> implements $UserSettingsEntityCopyWith<$Res> {
  factory _$UserSettingsEntityCopyWith(_UserSettingsEntity value, $Res Function(_UserSettingsEntity) _then) = __$UserSettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String signalingUrl, bool startWithVideo
});




}
/// @nodoc
class __$UserSettingsEntityCopyWithImpl<$Res>
    implements _$UserSettingsEntityCopyWith<$Res> {
  __$UserSettingsEntityCopyWithImpl(this._self, this._then);

  final _UserSettingsEntity _self;
  final $Res Function(_UserSettingsEntity) _then;

/// Create a copy of UserSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? signalingUrl = null,Object? startWithVideo = null,}) {
  return _then(_UserSettingsEntity(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,signalingUrl: null == signalingUrl ? _self.signalingUrl : signalingUrl // ignore: cast_nullable_to_non_nullable
as String,startWithVideo: null == startWithVideo ? _self.startWithVideo : startWithVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
