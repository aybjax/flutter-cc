// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signaling_message_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignalingMessageDto {

 String get type; String? get id; String? get from; String? get to; String? get sdp; String? get candidate; String? get sdpMid; int? get sdpMLineIndex; String? get senderName; String? get text; DateTime? get sentAt; List<String>? get peers; String? get message;
/// Create a copy of SignalingMessageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignalingMessageDtoCopyWith<SignalingMessageDto> get copyWith => _$SignalingMessageDtoCopyWithImpl<SignalingMessageDto>(this as SignalingMessageDto, _$identity);

  /// Serializes this SignalingMessageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignalingMessageDto&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.sdp, sdp) || other.sdp == sdp)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.sdpMid, sdpMid) || other.sdpMid == sdpMid)&&(identical(other.sdpMLineIndex, sdpMLineIndex) || other.sdpMLineIndex == sdpMLineIndex)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.text, text) || other.text == text)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&const DeepCollectionEquality().equals(other.peers, peers)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,from,to,sdp,candidate,sdpMid,sdpMLineIndex,senderName,text,sentAt,const DeepCollectionEquality().hash(peers),message);

@override
String toString() {
  return 'SignalingMessageDto(type: $type, id: $id, from: $from, to: $to, sdp: $sdp, candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex, senderName: $senderName, text: $text, sentAt: $sentAt, peers: $peers, message: $message)';
}


}

/// @nodoc
abstract mixin class $SignalingMessageDtoCopyWith<$Res>  {
  factory $SignalingMessageDtoCopyWith(SignalingMessageDto value, $Res Function(SignalingMessageDto) _then) = _$SignalingMessageDtoCopyWithImpl;
@useResult
$Res call({
 String type, String? id, String? from, String? to, String? sdp, String? candidate, String? sdpMid, int? sdpMLineIndex, String? senderName, String? text, DateTime? sentAt, List<String>? peers, String? message
});




}
/// @nodoc
class _$SignalingMessageDtoCopyWithImpl<$Res>
    implements $SignalingMessageDtoCopyWith<$Res> {
  _$SignalingMessageDtoCopyWithImpl(this._self, this._then);

  final SignalingMessageDto _self;
  final $Res Function(SignalingMessageDto) _then;

/// Create a copy of SignalingMessageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = freezed,Object? from = freezed,Object? to = freezed,Object? sdp = freezed,Object? candidate = freezed,Object? sdpMid = freezed,Object? sdpMLineIndex = freezed,Object? senderName = freezed,Object? text = freezed,Object? sentAt = freezed,Object? peers = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,sdp: freezed == sdp ? _self.sdp : sdp // ignore: cast_nullable_to_non_nullable
as String?,candidate: freezed == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as String?,sdpMid: freezed == sdpMid ? _self.sdpMid : sdpMid // ignore: cast_nullable_to_non_nullable
as String?,sdpMLineIndex: freezed == sdpMLineIndex ? _self.sdpMLineIndex : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
as int?,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,peers: freezed == peers ? _self.peers : peers // ignore: cast_nullable_to_non_nullable
as List<String>?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignalingMessageDto].
extension SignalingMessageDtoPatterns on SignalingMessageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignalingMessageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignalingMessageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignalingMessageDto value)  $default,){
final _that = this;
switch (_that) {
case _SignalingMessageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignalingMessageDto value)?  $default,){
final _that = this;
switch (_that) {
case _SignalingMessageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String? id,  String? from,  String? to,  String? sdp,  String? candidate,  String? sdpMid,  int? sdpMLineIndex,  String? senderName,  String? text,  DateTime? sentAt,  List<String>? peers,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignalingMessageDto() when $default != null:
return $default(_that.type,_that.id,_that.from,_that.to,_that.sdp,_that.candidate,_that.sdpMid,_that.sdpMLineIndex,_that.senderName,_that.text,_that.sentAt,_that.peers,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String? id,  String? from,  String? to,  String? sdp,  String? candidate,  String? sdpMid,  int? sdpMLineIndex,  String? senderName,  String? text,  DateTime? sentAt,  List<String>? peers,  String? message)  $default,) {final _that = this;
switch (_that) {
case _SignalingMessageDto():
return $default(_that.type,_that.id,_that.from,_that.to,_that.sdp,_that.candidate,_that.sdpMid,_that.sdpMLineIndex,_that.senderName,_that.text,_that.sentAt,_that.peers,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String? id,  String? from,  String? to,  String? sdp,  String? candidate,  String? sdpMid,  int? sdpMLineIndex,  String? senderName,  String? text,  DateTime? sentAt,  List<String>? peers,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _SignalingMessageDto() when $default != null:
return $default(_that.type,_that.id,_that.from,_that.to,_that.sdp,_that.candidate,_that.sdpMid,_that.sdpMLineIndex,_that.senderName,_that.text,_that.sentAt,_that.peers,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignalingMessageDto implements SignalingMessageDto {
  const _SignalingMessageDto({required this.type, this.id, this.from, this.to, this.sdp, this.candidate, this.sdpMid, this.sdpMLineIndex, this.senderName, this.text, this.sentAt, final  List<String>? peers, this.message}): _peers = peers;
  factory _SignalingMessageDto.fromJson(Map<String, dynamic> json) => _$SignalingMessageDtoFromJson(json);

@override final  String type;
@override final  String? id;
@override final  String? from;
@override final  String? to;
@override final  String? sdp;
@override final  String? candidate;
@override final  String? sdpMid;
@override final  int? sdpMLineIndex;
@override final  String? senderName;
@override final  String? text;
@override final  DateTime? sentAt;
 final  List<String>? _peers;
@override List<String>? get peers {
  final value = _peers;
  if (value == null) return null;
  if (_peers is EqualUnmodifiableListView) return _peers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? message;

/// Create a copy of SignalingMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignalingMessageDtoCopyWith<_SignalingMessageDto> get copyWith => __$SignalingMessageDtoCopyWithImpl<_SignalingMessageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignalingMessageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignalingMessageDto&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.sdp, sdp) || other.sdp == sdp)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.sdpMid, sdpMid) || other.sdpMid == sdpMid)&&(identical(other.sdpMLineIndex, sdpMLineIndex) || other.sdpMLineIndex == sdpMLineIndex)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.text, text) || other.text == text)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&const DeepCollectionEquality().equals(other._peers, _peers)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,from,to,sdp,candidate,sdpMid,sdpMLineIndex,senderName,text,sentAt,const DeepCollectionEquality().hash(_peers),message);

@override
String toString() {
  return 'SignalingMessageDto(type: $type, id: $id, from: $from, to: $to, sdp: $sdp, candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex, senderName: $senderName, text: $text, sentAt: $sentAt, peers: $peers, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SignalingMessageDtoCopyWith<$Res> implements $SignalingMessageDtoCopyWith<$Res> {
  factory _$SignalingMessageDtoCopyWith(_SignalingMessageDto value, $Res Function(_SignalingMessageDto) _then) = __$SignalingMessageDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, String? id, String? from, String? to, String? sdp, String? candidate, String? sdpMid, int? sdpMLineIndex, String? senderName, String? text, DateTime? sentAt, List<String>? peers, String? message
});




}
/// @nodoc
class __$SignalingMessageDtoCopyWithImpl<$Res>
    implements _$SignalingMessageDtoCopyWith<$Res> {
  __$SignalingMessageDtoCopyWithImpl(this._self, this._then);

  final _SignalingMessageDto _self;
  final $Res Function(_SignalingMessageDto) _then;

/// Create a copy of SignalingMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = freezed,Object? from = freezed,Object? to = freezed,Object? sdp = freezed,Object? candidate = freezed,Object? sdpMid = freezed,Object? sdpMLineIndex = freezed,Object? senderName = freezed,Object? text = freezed,Object? sentAt = freezed,Object? peers = freezed,Object? message = freezed,}) {
  return _then(_SignalingMessageDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,sdp: freezed == sdp ? _self.sdp : sdp // ignore: cast_nullable_to_non_nullable
as String?,candidate: freezed == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as String?,sdpMid: freezed == sdpMid ? _self.sdpMid : sdpMid // ignore: cast_nullable_to_non_nullable
as String?,sdpMLineIndex: freezed == sdpMLineIndex ? _self.sdpMLineIndex : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
as int?,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,peers: freezed == peers ? _self._peers : peers // ignore: cast_nullable_to_non_nullable
as List<String>?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
