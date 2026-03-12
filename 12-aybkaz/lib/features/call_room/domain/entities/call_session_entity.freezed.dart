// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_session_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallSessionEntity {

 CallConnectionStatus get status; String? get localPeerId; String? get remotePeerId; String? get localDisplayName; String? get remoteDisplayName; bool get localAudioEnabled; bool get localVideoEnabled; List<ChatMessageEntity> get chatMessages; String? get statusMessage;
/// Create a copy of CallSessionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallSessionEntityCopyWith<CallSessionEntity> get copyWith => _$CallSessionEntityCopyWithImpl<CallSessionEntity>(this as CallSessionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallSessionEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.localPeerId, localPeerId) || other.localPeerId == localPeerId)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.localDisplayName, localDisplayName) || other.localDisplayName == localDisplayName)&&(identical(other.remoteDisplayName, remoteDisplayName) || other.remoteDisplayName == remoteDisplayName)&&(identical(other.localAudioEnabled, localAudioEnabled) || other.localAudioEnabled == localAudioEnabled)&&(identical(other.localVideoEnabled, localVideoEnabled) || other.localVideoEnabled == localVideoEnabled)&&const DeepCollectionEquality().equals(other.chatMessages, chatMessages)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,localPeerId,remotePeerId,localDisplayName,remoteDisplayName,localAudioEnabled,localVideoEnabled,const DeepCollectionEquality().hash(chatMessages),statusMessage);

@override
String toString() {
  return 'CallSessionEntity(status: $status, localPeerId: $localPeerId, remotePeerId: $remotePeerId, localDisplayName: $localDisplayName, remoteDisplayName: $remoteDisplayName, localAudioEnabled: $localAudioEnabled, localVideoEnabled: $localVideoEnabled, chatMessages: $chatMessages, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class $CallSessionEntityCopyWith<$Res>  {
  factory $CallSessionEntityCopyWith(CallSessionEntity value, $Res Function(CallSessionEntity) _then) = _$CallSessionEntityCopyWithImpl;
@useResult
$Res call({
 CallConnectionStatus status, String? localPeerId, String? remotePeerId, String? localDisplayName, String? remoteDisplayName, bool localAudioEnabled, bool localVideoEnabled, List<ChatMessageEntity> chatMessages, String? statusMessage
});




}
/// @nodoc
class _$CallSessionEntityCopyWithImpl<$Res>
    implements $CallSessionEntityCopyWith<$Res> {
  _$CallSessionEntityCopyWithImpl(this._self, this._then);

  final CallSessionEntity _self;
  final $Res Function(CallSessionEntity) _then;

/// Create a copy of CallSessionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? localPeerId = freezed,Object? remotePeerId = freezed,Object? localDisplayName = freezed,Object? remoteDisplayName = freezed,Object? localAudioEnabled = null,Object? localVideoEnabled = null,Object? chatMessages = null,Object? statusMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallConnectionStatus,localPeerId: freezed == localPeerId ? _self.localPeerId : localPeerId // ignore: cast_nullable_to_non_nullable
as String?,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,localDisplayName: freezed == localDisplayName ? _self.localDisplayName : localDisplayName // ignore: cast_nullable_to_non_nullable
as String?,remoteDisplayName: freezed == remoteDisplayName ? _self.remoteDisplayName : remoteDisplayName // ignore: cast_nullable_to_non_nullable
as String?,localAudioEnabled: null == localAudioEnabled ? _self.localAudioEnabled : localAudioEnabled // ignore: cast_nullable_to_non_nullable
as bool,localVideoEnabled: null == localVideoEnabled ? _self.localVideoEnabled : localVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,chatMessages: null == chatMessages ? _self.chatMessages : chatMessages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageEntity>,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallSessionEntity].
extension CallSessionEntityPatterns on CallSessionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallSessionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallSessionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallSessionEntity value)  $default,){
final _that = this;
switch (_that) {
case _CallSessionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallSessionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CallSessionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallConnectionStatus status,  String? localPeerId,  String? remotePeerId,  String? localDisplayName,  String? remoteDisplayName,  bool localAudioEnabled,  bool localVideoEnabled,  List<ChatMessageEntity> chatMessages,  String? statusMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallSessionEntity() when $default != null:
return $default(_that.status,_that.localPeerId,_that.remotePeerId,_that.localDisplayName,_that.remoteDisplayName,_that.localAudioEnabled,_that.localVideoEnabled,_that.chatMessages,_that.statusMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallConnectionStatus status,  String? localPeerId,  String? remotePeerId,  String? localDisplayName,  String? remoteDisplayName,  bool localAudioEnabled,  bool localVideoEnabled,  List<ChatMessageEntity> chatMessages,  String? statusMessage)  $default,) {final _that = this;
switch (_that) {
case _CallSessionEntity():
return $default(_that.status,_that.localPeerId,_that.remotePeerId,_that.localDisplayName,_that.remoteDisplayName,_that.localAudioEnabled,_that.localVideoEnabled,_that.chatMessages,_that.statusMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallConnectionStatus status,  String? localPeerId,  String? remotePeerId,  String? localDisplayName,  String? remoteDisplayName,  bool localAudioEnabled,  bool localVideoEnabled,  List<ChatMessageEntity> chatMessages,  String? statusMessage)?  $default,) {final _that = this;
switch (_that) {
case _CallSessionEntity() when $default != null:
return $default(_that.status,_that.localPeerId,_that.remotePeerId,_that.localDisplayName,_that.remoteDisplayName,_that.localAudioEnabled,_that.localVideoEnabled,_that.chatMessages,_that.statusMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CallSessionEntity implements CallSessionEntity {
  const _CallSessionEntity({this.status = CallConnectionStatus.idle, this.localPeerId, this.remotePeerId, this.localDisplayName, this.remoteDisplayName, this.localAudioEnabled = true, this.localVideoEnabled = true, final  List<ChatMessageEntity> chatMessages = const <ChatMessageEntity>[], this.statusMessage}): _chatMessages = chatMessages;
  

@override@JsonKey() final  CallConnectionStatus status;
@override final  String? localPeerId;
@override final  String? remotePeerId;
@override final  String? localDisplayName;
@override final  String? remoteDisplayName;
@override@JsonKey() final  bool localAudioEnabled;
@override@JsonKey() final  bool localVideoEnabled;
 final  List<ChatMessageEntity> _chatMessages;
@override@JsonKey() List<ChatMessageEntity> get chatMessages {
  if (_chatMessages is EqualUnmodifiableListView) return _chatMessages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chatMessages);
}

@override final  String? statusMessage;

/// Create a copy of CallSessionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallSessionEntityCopyWith<_CallSessionEntity> get copyWith => __$CallSessionEntityCopyWithImpl<_CallSessionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallSessionEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.localPeerId, localPeerId) || other.localPeerId == localPeerId)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.localDisplayName, localDisplayName) || other.localDisplayName == localDisplayName)&&(identical(other.remoteDisplayName, remoteDisplayName) || other.remoteDisplayName == remoteDisplayName)&&(identical(other.localAudioEnabled, localAudioEnabled) || other.localAudioEnabled == localAudioEnabled)&&(identical(other.localVideoEnabled, localVideoEnabled) || other.localVideoEnabled == localVideoEnabled)&&const DeepCollectionEquality().equals(other._chatMessages, _chatMessages)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,localPeerId,remotePeerId,localDisplayName,remoteDisplayName,localAudioEnabled,localVideoEnabled,const DeepCollectionEquality().hash(_chatMessages),statusMessage);

@override
String toString() {
  return 'CallSessionEntity(status: $status, localPeerId: $localPeerId, remotePeerId: $remotePeerId, localDisplayName: $localDisplayName, remoteDisplayName: $remoteDisplayName, localAudioEnabled: $localAudioEnabled, localVideoEnabled: $localVideoEnabled, chatMessages: $chatMessages, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class _$CallSessionEntityCopyWith<$Res> implements $CallSessionEntityCopyWith<$Res> {
  factory _$CallSessionEntityCopyWith(_CallSessionEntity value, $Res Function(_CallSessionEntity) _then) = __$CallSessionEntityCopyWithImpl;
@override @useResult
$Res call({
 CallConnectionStatus status, String? localPeerId, String? remotePeerId, String? localDisplayName, String? remoteDisplayName, bool localAudioEnabled, bool localVideoEnabled, List<ChatMessageEntity> chatMessages, String? statusMessage
});




}
/// @nodoc
class __$CallSessionEntityCopyWithImpl<$Res>
    implements _$CallSessionEntityCopyWith<$Res> {
  __$CallSessionEntityCopyWithImpl(this._self, this._then);

  final _CallSessionEntity _self;
  final $Res Function(_CallSessionEntity) _then;

/// Create a copy of CallSessionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? localPeerId = freezed,Object? remotePeerId = freezed,Object? localDisplayName = freezed,Object? remoteDisplayName = freezed,Object? localAudioEnabled = null,Object? localVideoEnabled = null,Object? chatMessages = null,Object? statusMessage = freezed,}) {
  return _then(_CallSessionEntity(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallConnectionStatus,localPeerId: freezed == localPeerId ? _self.localPeerId : localPeerId // ignore: cast_nullable_to_non_nullable
as String?,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,localDisplayName: freezed == localDisplayName ? _self.localDisplayName : localDisplayName // ignore: cast_nullable_to_non_nullable
as String?,remoteDisplayName: freezed == remoteDisplayName ? _self.remoteDisplayName : remoteDisplayName // ignore: cast_nullable_to_non_nullable
as String?,localAudioEnabled: null == localAudioEnabled ? _self.localAudioEnabled : localAudioEnabled // ignore: cast_nullable_to_non_nullable
as bool,localVideoEnabled: null == localVideoEnabled ? _self.localVideoEnabled : localVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,chatMessages: null == chatMessages ? _self._chatMessages : chatMessages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageEntity>,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
