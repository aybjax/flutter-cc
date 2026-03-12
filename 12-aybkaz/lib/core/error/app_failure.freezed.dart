// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFailure {

 String get message;
/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFailureCopyWith<AppFailure> get copyWith => _$AppFailureCopyWithImpl<AppFailure>(this as AppFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AppFailureCopyWith<$Res>  {
  factory $AppFailureCopyWith(AppFailure value, $Res Function(AppFailure) _then) = _$AppFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AppFailureCopyWithImpl<$Res>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._self, this._then);

  final AppFailure _self;
  final $Res Function(AppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFailure].
extension AppFailurePatterns on AppFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkAppFailure value)?  network,TResult Function( ServerAppFailure value)?  server,TResult Function( CacheAppFailure value)?  cache,TResult Function( ValidationAppFailure value)?  validation,TResult Function( WebRtcAppFailure value)?  webrtc,TResult Function( UnknownAppFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkAppFailure() when network != null:
return network(_that);case ServerAppFailure() when server != null:
return server(_that);case CacheAppFailure() when cache != null:
return cache(_that);case ValidationAppFailure() when validation != null:
return validation(_that);case WebRtcAppFailure() when webrtc != null:
return webrtc(_that);case UnknownAppFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkAppFailure value)  network,required TResult Function( ServerAppFailure value)  server,required TResult Function( CacheAppFailure value)  cache,required TResult Function( ValidationAppFailure value)  validation,required TResult Function( WebRtcAppFailure value)  webrtc,required TResult Function( UnknownAppFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkAppFailure():
return network(_that);case ServerAppFailure():
return server(_that);case CacheAppFailure():
return cache(_that);case ValidationAppFailure():
return validation(_that);case WebRtcAppFailure():
return webrtc(_that);case UnknownAppFailure():
return unknown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkAppFailure value)?  network,TResult? Function( ServerAppFailure value)?  server,TResult? Function( CacheAppFailure value)?  cache,TResult? Function( ValidationAppFailure value)?  validation,TResult? Function( WebRtcAppFailure value)?  webrtc,TResult? Function( UnknownAppFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkAppFailure() when network != null:
return network(_that);case ServerAppFailure() when server != null:
return server(_that);case CacheAppFailure() when cache != null:
return cache(_that);case ValidationAppFailure() when validation != null:
return validation(_that);case WebRtcAppFailure() when webrtc != null:
return webrtc(_that);case UnknownAppFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  network,TResult Function( String message)?  server,TResult Function( String message)?  cache,TResult Function( String message)?  validation,TResult Function( String message)?  webrtc,TResult Function( String message)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkAppFailure() when network != null:
return network(_that.message);case ServerAppFailure() when server != null:
return server(_that.message);case CacheAppFailure() when cache != null:
return cache(_that.message);case ValidationAppFailure() when validation != null:
return validation(_that.message);case WebRtcAppFailure() when webrtc != null:
return webrtc(_that.message);case UnknownAppFailure() when unknown != null:
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  network,required TResult Function( String message)  server,required TResult Function( String message)  cache,required TResult Function( String message)  validation,required TResult Function( String message)  webrtc,required TResult Function( String message)  unknown,}) {final _that = this;
switch (_that) {
case NetworkAppFailure():
return network(_that.message);case ServerAppFailure():
return server(_that.message);case CacheAppFailure():
return cache(_that.message);case ValidationAppFailure():
return validation(_that.message);case WebRtcAppFailure():
return webrtc(_that.message);case UnknownAppFailure():
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  network,TResult? Function( String message)?  server,TResult? Function( String message)?  cache,TResult? Function( String message)?  validation,TResult? Function( String message)?  webrtc,TResult? Function( String message)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkAppFailure() when network != null:
return network(_that.message);case ServerAppFailure() when server != null:
return server(_that.message);case CacheAppFailure() when cache != null:
return cache(_that.message);case ValidationAppFailure() when validation != null:
return validation(_that.message);case WebRtcAppFailure() when webrtc != null:
return webrtc(_that.message);case UnknownAppFailure() when unknown != null:
return unknown(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NetworkAppFailure implements AppFailure {
  const NetworkAppFailure({this.message = 'Network error.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkAppFailureCopyWith<NetworkAppFailure> get copyWith => _$NetworkAppFailureCopyWithImpl<NetworkAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.network(message: $message)';
}


}

/// @nodoc
abstract mixin class $NetworkAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $NetworkAppFailureCopyWith(NetworkAppFailure value, $Res Function(NetworkAppFailure) _then) = _$NetworkAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NetworkAppFailureCopyWithImpl<$Res>
    implements $NetworkAppFailureCopyWith<$Res> {
  _$NetworkAppFailureCopyWithImpl(this._self, this._then);

  final NetworkAppFailure _self;
  final $Res Function(NetworkAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NetworkAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ServerAppFailure implements AppFailure {
  const ServerAppFailure({this.message = 'Server error.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerAppFailureCopyWith<ServerAppFailure> get copyWith => _$ServerAppFailureCopyWithImpl<ServerAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.server(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $ServerAppFailureCopyWith(ServerAppFailure value, $Res Function(ServerAppFailure) _then) = _$ServerAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ServerAppFailureCopyWithImpl<$Res>
    implements $ServerAppFailureCopyWith<$Res> {
  _$ServerAppFailureCopyWithImpl(this._self, this._then);

  final ServerAppFailure _self;
  final $Res Function(ServerAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CacheAppFailure implements AppFailure {
  const CacheAppFailure({this.message = 'Cache error.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheAppFailureCopyWith<CacheAppFailure> get copyWith => _$CacheAppFailureCopyWithImpl<CacheAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.cache(message: $message)';
}


}

/// @nodoc
abstract mixin class $CacheAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $CacheAppFailureCopyWith(CacheAppFailure value, $Res Function(CacheAppFailure) _then) = _$CacheAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CacheAppFailureCopyWithImpl<$Res>
    implements $CacheAppFailureCopyWith<$Res> {
  _$CacheAppFailureCopyWithImpl(this._self, this._then);

  final CacheAppFailure _self;
  final $Res Function(CacheAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CacheAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ValidationAppFailure implements AppFailure {
  const ValidationAppFailure({this.message = 'Validation error.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationAppFailureCopyWith<ValidationAppFailure> get copyWith => _$ValidationAppFailureCopyWithImpl<ValidationAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.validation(message: $message)';
}


}

/// @nodoc
abstract mixin class $ValidationAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $ValidationAppFailureCopyWith(ValidationAppFailure value, $Res Function(ValidationAppFailure) _then) = _$ValidationAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ValidationAppFailureCopyWithImpl<$Res>
    implements $ValidationAppFailureCopyWith<$Res> {
  _$ValidationAppFailureCopyWithImpl(this._self, this._then);

  final ValidationAppFailure _self;
  final $Res Function(ValidationAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ValidationAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WebRtcAppFailure implements AppFailure {
  const WebRtcAppFailure({this.message = 'Call setup error.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebRtcAppFailureCopyWith<WebRtcAppFailure> get copyWith => _$WebRtcAppFailureCopyWithImpl<WebRtcAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebRtcAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.webrtc(message: $message)';
}


}

/// @nodoc
abstract mixin class $WebRtcAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $WebRtcAppFailureCopyWith(WebRtcAppFailure value, $Res Function(WebRtcAppFailure) _then) = _$WebRtcAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WebRtcAppFailureCopyWithImpl<$Res>
    implements $WebRtcAppFailureCopyWith<$Res> {
  _$WebRtcAppFailureCopyWithImpl(this._self, this._then);

  final WebRtcAppFailure _self;
  final $Res Function(WebRtcAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WebRtcAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnknownAppFailure implements AppFailure {
  const UnknownAppFailure({this.message = 'Unexpected error.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownAppFailureCopyWith<UnknownAppFailure> get copyWith => _$UnknownAppFailureCopyWithImpl<UnknownAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $UnknownAppFailureCopyWith(UnknownAppFailure value, $Res Function(UnknownAppFailure) _then) = _$UnknownAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UnknownAppFailureCopyWithImpl<$Res>
    implements $UnknownAppFailureCopyWith<$Res> {
  _$UnknownAppFailureCopyWithImpl(this._self, this._then);

  final UnknownAppFailure _self;
  final $Res Function(UnknownAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UnknownAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
