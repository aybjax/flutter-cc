// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallSessionModel {

 CallConnectionStatus get status; String? get localPeerId; String? get remotePeerId; String? get localDisplayName; String? get remoteDisplayName; bool get localAudioEnabled; bool get localVideoEnabled; List<ChatMessageModel> get chatMessages; String? get statusMessage;
/// Create a copy of CallSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallSessionModelCopyWith<CallSessionModel> get copyWith => _$CallSessionModelCopyWithImpl<CallSessionModel>(this as CallSessionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallSessionModel&&(identical(other.status, status) || other.status == status)&&(identical(other.localPeerId, localPeerId) || other.localPeerId == localPeerId)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.localDisplayName, localDisplayName) || other.localDisplayName == localDisplayName)&&(identical(other.remoteDisplayName, remoteDisplayName) || other.remoteDisplayName == remoteDisplayName)&&(identical(other.localAudioEnabled, localAudioEnabled) || other.localAudioEnabled == localAudioEnabled)&&(identical(other.localVideoEnabled, localVideoEnabled) || other.localVideoEnabled == localVideoEnabled)&&const DeepCollectionEquality().equals(other.chatMessages, chatMessages)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,localPeerId,remotePeerId,localDisplayName,remoteDisplayName,localAudioEnabled,localVideoEnabled,const DeepCollectionEquality().hash(chatMessages),statusMessage);

@override
String toString() {
  return 'CallSessionModel(status: $status, localPeerId: $localPeerId, remotePeerId: $remotePeerId, localDisplayName: $localDisplayName, remoteDisplayName: $remoteDisplayName, localAudioEnabled: $localAudioEnabled, localVideoEnabled: $localVideoEnabled, chatMessages: $chatMessages, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class $CallSessionModelCopyWith<$Res>  {
  factory $CallSessionModelCopyWith(CallSessionModel value, $Res Function(CallSessionModel) _then) = _$CallSessionModelCopyWithImpl;
@useResult
$Res call({
 CallConnectionStatus status, String? localPeerId, String? remotePeerId, String? localDisplayName, String? remoteDisplayName, bool localAudioEnabled, bool localVideoEnabled, List<ChatMessageModel> chatMessages, String? statusMessage
});




}
/// @nodoc
class _$CallSessionModelCopyWithImpl<$Res>
    implements $CallSessionModelCopyWith<$Res> {
  _$CallSessionModelCopyWithImpl(this._self, this._then);

  final CallSessionModel _self;
  final $Res Function(CallSessionModel) _then;

/// Create a copy of CallSessionModel
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
as List<ChatMessageModel>,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallSessionModel].
extension CallSessionModelPatterns on CallSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _CallSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallConnectionStatus status,  String? localPeerId,  String? remotePeerId,  String? localDisplayName,  String? remoteDisplayName,  bool localAudioEnabled,  bool localVideoEnabled,  List<ChatMessageModel> chatMessages,  String? statusMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallSessionModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallConnectionStatus status,  String? localPeerId,  String? remotePeerId,  String? localDisplayName,  String? remoteDisplayName,  bool localAudioEnabled,  bool localVideoEnabled,  List<ChatMessageModel> chatMessages,  String? statusMessage)  $default,) {final _that = this;
switch (_that) {
case _CallSessionModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallConnectionStatus status,  String? localPeerId,  String? remotePeerId,  String? localDisplayName,  String? remoteDisplayName,  bool localAudioEnabled,  bool localVideoEnabled,  List<ChatMessageModel> chatMessages,  String? statusMessage)?  $default,) {final _that = this;
switch (_that) {
case _CallSessionModel() when $default != null:
return $default(_that.status,_that.localPeerId,_that.remotePeerId,_that.localDisplayName,_that.remoteDisplayName,_that.localAudioEnabled,_that.localVideoEnabled,_that.chatMessages,_that.statusMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CallSessionModel extends CallSessionModel {
  const _CallSessionModel({this.status = CallConnectionStatus.idle, this.localPeerId, this.remotePeerId, this.localDisplayName, this.remoteDisplayName, this.localAudioEnabled = true, this.localVideoEnabled = true, final  List<ChatMessageModel> chatMessages = const <ChatMessageModel>[], this.statusMessage}): _chatMessages = chatMessages,super._();
  

@override@JsonKey() final  CallConnectionStatus status;
@override final  String? localPeerId;
@override final  String? remotePeerId;
@override final  String? localDisplayName;
@override final  String? remoteDisplayName;
@override@JsonKey() final  bool localAudioEnabled;
@override@JsonKey() final  bool localVideoEnabled;
 final  List<ChatMessageModel> _chatMessages;
@override@JsonKey() List<ChatMessageModel> get chatMessages {
  if (_chatMessages is EqualUnmodifiableListView) return _chatMessages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chatMessages);
}

@override final  String? statusMessage;

/// Create a copy of CallSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallSessionModelCopyWith<_CallSessionModel> get copyWith => __$CallSessionModelCopyWithImpl<_CallSessionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallSessionModel&&(identical(other.status, status) || other.status == status)&&(identical(other.localPeerId, localPeerId) || other.localPeerId == localPeerId)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.localDisplayName, localDisplayName) || other.localDisplayName == localDisplayName)&&(identical(other.remoteDisplayName, remoteDisplayName) || other.remoteDisplayName == remoteDisplayName)&&(identical(other.localAudioEnabled, localAudioEnabled) || other.localAudioEnabled == localAudioEnabled)&&(identical(other.localVideoEnabled, localVideoEnabled) || other.localVideoEnabled == localVideoEnabled)&&const DeepCollectionEquality().equals(other._chatMessages, _chatMessages)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,localPeerId,remotePeerId,localDisplayName,remoteDisplayName,localAudioEnabled,localVideoEnabled,const DeepCollectionEquality().hash(_chatMessages),statusMessage);

@override
String toString() {
  return 'CallSessionModel(status: $status, localPeerId: $localPeerId, remotePeerId: $remotePeerId, localDisplayName: $localDisplayName, remoteDisplayName: $remoteDisplayName, localAudioEnabled: $localAudioEnabled, localVideoEnabled: $localVideoEnabled, chatMessages: $chatMessages, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class _$CallSessionModelCopyWith<$Res> implements $CallSessionModelCopyWith<$Res> {
  factory _$CallSessionModelCopyWith(_CallSessionModel value, $Res Function(_CallSessionModel) _then) = __$CallSessionModelCopyWithImpl;
@override @useResult
$Res call({
 CallConnectionStatus status, String? localPeerId, String? remotePeerId, String? localDisplayName, String? remoteDisplayName, bool localAudioEnabled, bool localVideoEnabled, List<ChatMessageModel> chatMessages, String? statusMessage
});




}
/// @nodoc
class __$CallSessionModelCopyWithImpl<$Res>
    implements _$CallSessionModelCopyWith<$Res> {
  __$CallSessionModelCopyWithImpl(this._self, this._then);

  final _CallSessionModel _self;
  final $Res Function(_CallSessionModel) _then;

/// Create a copy of CallSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? localPeerId = freezed,Object? remotePeerId = freezed,Object? localDisplayName = freezed,Object? remoteDisplayName = freezed,Object? localAudioEnabled = null,Object? localVideoEnabled = null,Object? chatMessages = null,Object? statusMessage = freezed,}) {
  return _then(_CallSessionModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallConnectionStatus,localPeerId: freezed == localPeerId ? _self.localPeerId : localPeerId // ignore: cast_nullable_to_non_nullable
as String?,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,localDisplayName: freezed == localDisplayName ? _self.localDisplayName : localDisplayName // ignore: cast_nullable_to_non_nullable
as String?,remoteDisplayName: freezed == remoteDisplayName ? _self.remoteDisplayName : remoteDisplayName // ignore: cast_nullable_to_non_nullable
as String?,localAudioEnabled: null == localAudioEnabled ? _self.localAudioEnabled : localAudioEnabled // ignore: cast_nullable_to_non_nullable
as bool,localVideoEnabled: null == localVideoEnabled ? _self.localVideoEnabled : localVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,chatMessages: null == chatMessages ? _self._chatMessages : chatMessages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageModel>,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
