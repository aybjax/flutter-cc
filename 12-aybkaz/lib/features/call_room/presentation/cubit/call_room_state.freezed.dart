// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_room_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallRoomState {

 bool get isJoining; CallSessionEntity get session; UserSettingsEntity? get settings; String? get errorMessage;
/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallRoomStateCopyWith<CallRoomState> get copyWith => _$CallRoomStateCopyWithImpl<CallRoomState>(this as CallRoomState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallRoomState&&(identical(other.isJoining, isJoining) || other.isJoining == isJoining)&&(identical(other.session, session) || other.session == session)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isJoining,session,settings,errorMessage);

@override
String toString() {
  return 'CallRoomState(isJoining: $isJoining, session: $session, settings: $settings, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CallRoomStateCopyWith<$Res>  {
  factory $CallRoomStateCopyWith(CallRoomState value, $Res Function(CallRoomState) _then) = _$CallRoomStateCopyWithImpl;
@useResult
$Res call({
 bool isJoining, CallSessionEntity session, UserSettingsEntity? settings, String? errorMessage
});


$CallSessionEntityCopyWith<$Res> get session;$UserSettingsEntityCopyWith<$Res>? get settings;

}
/// @nodoc
class _$CallRoomStateCopyWithImpl<$Res>
    implements $CallRoomStateCopyWith<$Res> {
  _$CallRoomStateCopyWithImpl(this._self, this._then);

  final CallRoomState _self;
  final $Res Function(CallRoomState) _then;

/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isJoining = null,Object? session = null,Object? settings = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isJoining: null == isJoining ? _self.isJoining : isJoining // ignore: cast_nullable_to_non_nullable
as bool,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as CallSessionEntity,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as UserSettingsEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallSessionEntityCopyWith<$Res> get session {
  
  return $CallSessionEntityCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSettingsEntityCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $UserSettingsEntityCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallRoomState].
extension CallRoomStatePatterns on CallRoomState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallRoomState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallRoomState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallRoomState value)  $default,){
final _that = this;
switch (_that) {
case _CallRoomState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallRoomState value)?  $default,){
final _that = this;
switch (_that) {
case _CallRoomState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isJoining,  CallSessionEntity session,  UserSettingsEntity? settings,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallRoomState() when $default != null:
return $default(_that.isJoining,_that.session,_that.settings,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isJoining,  CallSessionEntity session,  UserSettingsEntity? settings,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CallRoomState():
return $default(_that.isJoining,_that.session,_that.settings,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isJoining,  CallSessionEntity session,  UserSettingsEntity? settings,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CallRoomState() when $default != null:
return $default(_that.isJoining,_that.session,_that.settings,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CallRoomState implements CallRoomState {
  const _CallRoomState({this.isJoining = false, this.session = const CallSessionEntity(), this.settings, this.errorMessage});
  

@override@JsonKey() final  bool isJoining;
@override@JsonKey() final  CallSessionEntity session;
@override final  UserSettingsEntity? settings;
@override final  String? errorMessage;

/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallRoomStateCopyWith<_CallRoomState> get copyWith => __$CallRoomStateCopyWithImpl<_CallRoomState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallRoomState&&(identical(other.isJoining, isJoining) || other.isJoining == isJoining)&&(identical(other.session, session) || other.session == session)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isJoining,session,settings,errorMessage);

@override
String toString() {
  return 'CallRoomState(isJoining: $isJoining, session: $session, settings: $settings, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CallRoomStateCopyWith<$Res> implements $CallRoomStateCopyWith<$Res> {
  factory _$CallRoomStateCopyWith(_CallRoomState value, $Res Function(_CallRoomState) _then) = __$CallRoomStateCopyWithImpl;
@override @useResult
$Res call({
 bool isJoining, CallSessionEntity session, UserSettingsEntity? settings, String? errorMessage
});


@override $CallSessionEntityCopyWith<$Res> get session;@override $UserSettingsEntityCopyWith<$Res>? get settings;

}
/// @nodoc
class __$CallRoomStateCopyWithImpl<$Res>
    implements _$CallRoomStateCopyWith<$Res> {
  __$CallRoomStateCopyWithImpl(this._self, this._then);

  final _CallRoomState _self;
  final $Res Function(_CallRoomState) _then;

/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isJoining = null,Object? session = null,Object? settings = freezed,Object? errorMessage = freezed,}) {
  return _then(_CallRoomState(
isJoining: null == isJoining ? _self.isJoining : isJoining // ignore: cast_nullable_to_non_nullable
as bool,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as CallSessionEntity,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as UserSettingsEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallSessionEntityCopyWith<$Res> get session {
  
  return $CallSessionEntityCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of CallRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSettingsEntityCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $UserSettingsEntityCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
