// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 UserSettingsEntity get settings; bool get isLoading; bool get isSaving; bool get isCheckingServer; bool? get serverReachable; String? get errorMessage;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isCheckingServer, isCheckingServer) || other.isCheckingServer == isCheckingServer)&&(identical(other.serverReachable, serverReachable) || other.serverReachable == serverReachable)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,settings,isLoading,isSaving,isCheckingServer,serverReachable,errorMessage);

@override
String toString() {
  return 'SettingsState(settings: $settings, isLoading: $isLoading, isSaving: $isSaving, isCheckingServer: $isCheckingServer, serverReachable: $serverReachable, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 UserSettingsEntity settings, bool isLoading, bool isSaving, bool isCheckingServer, bool? serverReachable, String? errorMessage
});


$UserSettingsEntityCopyWith<$Res> get settings;

}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? isLoading = null,Object? isSaving = null,Object? isCheckingServer = null,Object? serverReachable = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as UserSettingsEntity,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isCheckingServer: null == isCheckingServer ? _self.isCheckingServer : isCheckingServer // ignore: cast_nullable_to_non_nullable
as bool,serverReachable: freezed == serverReachable ? _self.serverReachable : serverReachable // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSettingsEntityCopyWith<$Res> get settings {
  
  return $UserSettingsEntityCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserSettingsEntity settings,  bool isLoading,  bool isSaving,  bool isCheckingServer,  bool? serverReachable,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.settings,_that.isLoading,_that.isSaving,_that.isCheckingServer,_that.serverReachable,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserSettingsEntity settings,  bool isLoading,  bool isSaving,  bool isCheckingServer,  bool? serverReachable,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.settings,_that.isLoading,_that.isSaving,_that.isCheckingServer,_that.serverReachable,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserSettingsEntity settings,  bool isLoading,  bool isSaving,  bool isCheckingServer,  bool? serverReachable,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.settings,_that.isLoading,_that.isSaving,_that.isCheckingServer,_that.serverReachable,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.settings = const UserSettingsEntity(), this.isLoading = false, this.isSaving = false, this.isCheckingServer = false, this.serverReachable, this.errorMessage});
  

@override@JsonKey() final  UserSettingsEntity settings;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isCheckingServer;
@override final  bool? serverReachable;
@override final  String? errorMessage;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isCheckingServer, isCheckingServer) || other.isCheckingServer == isCheckingServer)&&(identical(other.serverReachable, serverReachable) || other.serverReachable == serverReachable)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,settings,isLoading,isSaving,isCheckingServer,serverReachable,errorMessage);

@override
String toString() {
  return 'SettingsState(settings: $settings, isLoading: $isLoading, isSaving: $isSaving, isCheckingServer: $isCheckingServer, serverReachable: $serverReachable, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 UserSettingsEntity settings, bool isLoading, bool isSaving, bool isCheckingServer, bool? serverReachable, String? errorMessage
});


@override $UserSettingsEntityCopyWith<$Res> get settings;

}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? isLoading = null,Object? isSaving = null,Object? isCheckingServer = null,Object? serverReachable = freezed,Object? errorMessage = freezed,}) {
  return _then(_SettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as UserSettingsEntity,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isCheckingServer: null == isCheckingServer ? _self.isCheckingServer : isCheckingServer // ignore: cast_nullable_to_non_nullable
as bool,serverReachable: freezed == serverReachable ? _self.serverReachable : serverReachable // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSettingsEntityCopyWith<$Res> get settings {
  
  return $UserSettingsEntityCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
