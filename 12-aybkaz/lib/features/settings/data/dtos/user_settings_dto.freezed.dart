// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettingsDto {

 String get displayName; String get signalingUrl; bool get startWithVideo;
/// Create a copy of UserSettingsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsDtoCopyWith<UserSettingsDto> get copyWith => _$UserSettingsDtoCopyWithImpl<UserSettingsDto>(this as UserSettingsDto, _$identity);

  /// Serializes this UserSettingsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.signalingUrl, signalingUrl) || other.signalingUrl == signalingUrl)&&(identical(other.startWithVideo, startWithVideo) || other.startWithVideo == startWithVideo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,signalingUrl,startWithVideo);

@override
String toString() {
  return 'UserSettingsDto(displayName: $displayName, signalingUrl: $signalingUrl, startWithVideo: $startWithVideo)';
}


}

/// @nodoc
abstract mixin class $UserSettingsDtoCopyWith<$Res>  {
  factory $UserSettingsDtoCopyWith(UserSettingsDto value, $Res Function(UserSettingsDto) _then) = _$UserSettingsDtoCopyWithImpl;
@useResult
$Res call({
 String displayName, String signalingUrl, bool startWithVideo
});




}
/// @nodoc
class _$UserSettingsDtoCopyWithImpl<$Res>
    implements $UserSettingsDtoCopyWith<$Res> {
  _$UserSettingsDtoCopyWithImpl(this._self, this._then);

  final UserSettingsDto _self;
  final $Res Function(UserSettingsDto) _then;

/// Create a copy of UserSettingsDto
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


/// Adds pattern-matching-related methods to [UserSettingsDto].
extension UserSettingsDtoPatterns on UserSettingsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettingsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettingsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettingsDto value)  $default,){
final _that = this;
switch (_that) {
case _UserSettingsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettingsDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettingsDto() when $default != null:
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
case _UserSettingsDto() when $default != null:
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
case _UserSettingsDto():
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
case _UserSettingsDto() when $default != null:
return $default(_that.displayName,_that.signalingUrl,_that.startWithVideo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSettingsDto implements UserSettingsDto {
  const _UserSettingsDto({this.displayName = 'Guest', this.signalingUrl = 'ws://localhost:3000', this.startWithVideo = true});
  factory _UserSettingsDto.fromJson(Map<String, dynamic> json) => _$UserSettingsDtoFromJson(json);

@override@JsonKey() final  String displayName;
@override@JsonKey() final  String signalingUrl;
@override@JsonKey() final  bool startWithVideo;

/// Create a copy of UserSettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsDtoCopyWith<_UserSettingsDto> get copyWith => __$UserSettingsDtoCopyWithImpl<_UserSettingsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSettingsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettingsDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.signalingUrl, signalingUrl) || other.signalingUrl == signalingUrl)&&(identical(other.startWithVideo, startWithVideo) || other.startWithVideo == startWithVideo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,signalingUrl,startWithVideo);

@override
String toString() {
  return 'UserSettingsDto(displayName: $displayName, signalingUrl: $signalingUrl, startWithVideo: $startWithVideo)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsDtoCopyWith<$Res> implements $UserSettingsDtoCopyWith<$Res> {
  factory _$UserSettingsDtoCopyWith(_UserSettingsDto value, $Res Function(_UserSettingsDto) _then) = __$UserSettingsDtoCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String signalingUrl, bool startWithVideo
});




}
/// @nodoc
class __$UserSettingsDtoCopyWithImpl<$Res>
    implements _$UserSettingsDtoCopyWith<$Res> {
  __$UserSettingsDtoCopyWithImpl(this._self, this._then);

  final _UserSettingsDto _self;
  final $Res Function(_UserSettingsDto) _then;

/// Create a copy of UserSettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? signalingUrl = null,Object? startWithVideo = null,}) {
  return _then(_UserSettingsDto(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,signalingUrl: null == signalingUrl ? _self.signalingUrl : signalingUrl // ignore: cast_nullable_to_non_nullable
as String,startWithVideo: null == startWithVideo ? _self.startWithVideo : startWithVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
