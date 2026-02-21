// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WsEvent _$WsEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'join':
      return WsJoinEvent.fromJson(json);
    case 'leave':
      return WsLeaveEvent.fromJson(json);
    case 'message':
      return WsMessageEvent.fromJson(json);
    case 'typing':
      return WsTypingEvent.fromJson(json);
    case 'presence':
      return WsPresenceEvent.fromJson(json);
    case 'roomList':
      return WsRoomListEvent.fromJson(json);
    case 'error':
      return WsErrorEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'WsEvent',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$WsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this WsEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WsEventCopyWith<$Res> {
  factory $WsEventCopyWith(WsEvent value, $Res Function(WsEvent) then) =
      _$WsEventCopyWithImpl<$Res, WsEvent>;
}

/// @nodoc
class _$WsEventCopyWithImpl<$Res, $Val extends WsEvent>
    implements $WsEventCopyWith<$Res> {
  _$WsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WsJoinEventImplCopyWith<$Res> {
  factory _$$WsJoinEventImplCopyWith(
    _$WsJoinEventImpl value,
    $Res Function(_$WsJoinEventImpl) then,
  ) = __$$WsJoinEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String room, String user});
}

/// @nodoc
class __$$WsJoinEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsJoinEventImpl>
    implements _$$WsJoinEventImplCopyWith<$Res> {
  __$$WsJoinEventImplCopyWithImpl(
    _$WsJoinEventImpl _value,
    $Res Function(_$WsJoinEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = null, Object? user = null}) {
    return _then(
      _$WsJoinEventImpl(
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsJoinEventImpl implements WsJoinEvent {
  const _$WsJoinEventImpl({
    required this.room,
    required this.user,
    final String? $type,
  }) : $type = $type ?? 'join';

  factory _$WsJoinEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsJoinEventImplFromJson(json);

  @override
  final String room;
  @override
  final String user;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.join(room: $room, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsJoinEventImpl &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, room, user);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsJoinEventImplCopyWith<_$WsJoinEventImpl> get copyWith =>
      __$$WsJoinEventImplCopyWithImpl<_$WsJoinEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return join(room, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return join?.call(room, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (join != null) {
      return join(room, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return join(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return join?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (join != null) {
      return join(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsJoinEventImplToJson(this);
  }
}

abstract class WsJoinEvent implements WsEvent {
  const factory WsJoinEvent({
    required final String room,
    required final String user,
  }) = _$WsJoinEventImpl;

  factory WsJoinEvent.fromJson(Map<String, dynamic> json) =
      _$WsJoinEventImpl.fromJson;

  String get room;
  String get user;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsJoinEventImplCopyWith<_$WsJoinEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WsLeaveEventImplCopyWith<$Res> {
  factory _$$WsLeaveEventImplCopyWith(
    _$WsLeaveEventImpl value,
    $Res Function(_$WsLeaveEventImpl) then,
  ) = __$$WsLeaveEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String room, String user});
}

/// @nodoc
class __$$WsLeaveEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsLeaveEventImpl>
    implements _$$WsLeaveEventImplCopyWith<$Res> {
  __$$WsLeaveEventImplCopyWithImpl(
    _$WsLeaveEventImpl _value,
    $Res Function(_$WsLeaveEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = null, Object? user = null}) {
    return _then(
      _$WsLeaveEventImpl(
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsLeaveEventImpl implements WsLeaveEvent {
  const _$WsLeaveEventImpl({
    required this.room,
    required this.user,
    final String? $type,
  }) : $type = $type ?? 'leave';

  factory _$WsLeaveEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsLeaveEventImplFromJson(json);

  @override
  final String room;
  @override
  final String user;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.leave(room: $room, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsLeaveEventImpl &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, room, user);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsLeaveEventImplCopyWith<_$WsLeaveEventImpl> get copyWith =>
      __$$WsLeaveEventImplCopyWithImpl<_$WsLeaveEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return leave(room, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return leave?.call(room, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (leave != null) {
      return leave(room, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return leave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return leave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (leave != null) {
      return leave(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsLeaveEventImplToJson(this);
  }
}

abstract class WsLeaveEvent implements WsEvent {
  const factory WsLeaveEvent({
    required final String room,
    required final String user,
  }) = _$WsLeaveEventImpl;

  factory WsLeaveEvent.fromJson(Map<String, dynamic> json) =
      _$WsLeaveEventImpl.fromJson;

  String get room;
  String get user;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsLeaveEventImplCopyWith<_$WsLeaveEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WsMessageEventImplCopyWith<$Res> {
  factory _$$WsMessageEventImplCopyWith(
    _$WsMessageEventImpl value,
    $Res Function(_$WsMessageEventImpl) then,
  ) = __$$WsMessageEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String room, String user, String content, String? timestamp});
}

/// @nodoc
class __$$WsMessageEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsMessageEventImpl>
    implements _$$WsMessageEventImplCopyWith<$Res> {
  __$$WsMessageEventImplCopyWithImpl(
    _$WsMessageEventImpl _value,
    $Res Function(_$WsMessageEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? room = null,
    Object? user = null,
    Object? content = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$WsMessageEventImpl(
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsMessageEventImpl implements WsMessageEvent {
  const _$WsMessageEventImpl({
    required this.room,
    required this.user,
    required this.content,
    this.timestamp,
    final String? $type,
  }) : $type = $type ?? 'message';

  factory _$WsMessageEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsMessageEventImplFromJson(json);

  @override
  final String room;
  @override
  final String user;
  @override
  final String content;
  @override
  final String? timestamp;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.message(room: $room, user: $user, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsMessageEventImpl &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, room, user, content, timestamp);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsMessageEventImplCopyWith<_$WsMessageEventImpl> get copyWith =>
      __$$WsMessageEventImplCopyWithImpl<_$WsMessageEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return message(room, user, content, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return message?.call(room, user, content, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(room, user, content, timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return message(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return message?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsMessageEventImplToJson(this);
  }
}

abstract class WsMessageEvent implements WsEvent {
  const factory WsMessageEvent({
    required final String room,
    required final String user,
    required final String content,
    final String? timestamp,
  }) = _$WsMessageEventImpl;

  factory WsMessageEvent.fromJson(Map<String, dynamic> json) =
      _$WsMessageEventImpl.fromJson;

  String get room;
  String get user;
  String get content;
  String? get timestamp;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsMessageEventImplCopyWith<_$WsMessageEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WsTypingEventImplCopyWith<$Res> {
  factory _$$WsTypingEventImplCopyWith(
    _$WsTypingEventImpl value,
    $Res Function(_$WsTypingEventImpl) then,
  ) = __$$WsTypingEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String room, String user});
}

/// @nodoc
class __$$WsTypingEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsTypingEventImpl>
    implements _$$WsTypingEventImplCopyWith<$Res> {
  __$$WsTypingEventImplCopyWithImpl(
    _$WsTypingEventImpl _value,
    $Res Function(_$WsTypingEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = null, Object? user = null}) {
    return _then(
      _$WsTypingEventImpl(
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsTypingEventImpl implements WsTypingEvent {
  const _$WsTypingEventImpl({
    required this.room,
    required this.user,
    final String? $type,
  }) : $type = $type ?? 'typing';

  factory _$WsTypingEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsTypingEventImplFromJson(json);

  @override
  final String room;
  @override
  final String user;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.typing(room: $room, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsTypingEventImpl &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, room, user);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsTypingEventImplCopyWith<_$WsTypingEventImpl> get copyWith =>
      __$$WsTypingEventImplCopyWithImpl<_$WsTypingEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return typing(room, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return typing?.call(room, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (typing != null) {
      return typing(room, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return typing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return typing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (typing != null) {
      return typing(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsTypingEventImplToJson(this);
  }
}

abstract class WsTypingEvent implements WsEvent {
  const factory WsTypingEvent({
    required final String room,
    required final String user,
  }) = _$WsTypingEventImpl;

  factory WsTypingEvent.fromJson(Map<String, dynamic> json) =
      _$WsTypingEventImpl.fromJson;

  String get room;
  String get user;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsTypingEventImplCopyWith<_$WsTypingEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WsPresenceEventImplCopyWith<$Res> {
  factory _$$WsPresenceEventImplCopyWith(
    _$WsPresenceEventImpl value,
    $Res Function(_$WsPresenceEventImpl) then,
  ) = __$$WsPresenceEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String room, List<String> users});
}

/// @nodoc
class __$$WsPresenceEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsPresenceEventImpl>
    implements _$$WsPresenceEventImplCopyWith<$Res> {
  __$$WsPresenceEventImplCopyWithImpl(
    _$WsPresenceEventImpl _value,
    $Res Function(_$WsPresenceEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = null, Object? users = null}) {
    return _then(
      _$WsPresenceEventImpl(
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsPresenceEventImpl implements WsPresenceEvent {
  const _$WsPresenceEventImpl({
    required this.room,
    required final List<String> users,
    final String? $type,
  }) : _users = users,
       $type = $type ?? 'presence';

  factory _$WsPresenceEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsPresenceEventImplFromJson(json);

  @override
  final String room;
  final List<String> _users;
  @override
  List<String> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.presence(room: $room, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsPresenceEventImpl &&
            (identical(other.room, room) || other.room == room) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    room,
    const DeepCollectionEquality().hash(_users),
  );

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsPresenceEventImplCopyWith<_$WsPresenceEventImpl> get copyWith =>
      __$$WsPresenceEventImplCopyWithImpl<_$WsPresenceEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return presence(room, users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return presence?.call(room, users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (presence != null) {
      return presence(room, users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return presence(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return presence?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (presence != null) {
      return presence(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsPresenceEventImplToJson(this);
  }
}

abstract class WsPresenceEvent implements WsEvent {
  const factory WsPresenceEvent({
    required final String room,
    required final List<String> users,
  }) = _$WsPresenceEventImpl;

  factory WsPresenceEvent.fromJson(Map<String, dynamic> json) =
      _$WsPresenceEventImpl.fromJson;

  String get room;
  List<String> get users;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsPresenceEventImplCopyWith<_$WsPresenceEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WsRoomListEventImplCopyWith<$Res> {
  factory _$$WsRoomListEventImplCopyWith(
    _$WsRoomListEventImpl value,
    $Res Function(_$WsRoomListEventImpl) then,
  ) = __$$WsRoomListEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> rooms});
}

/// @nodoc
class __$$WsRoomListEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsRoomListEventImpl>
    implements _$$WsRoomListEventImplCopyWith<$Res> {
  __$$WsRoomListEventImplCopyWithImpl(
    _$WsRoomListEventImpl _value,
    $Res Function(_$WsRoomListEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rooms = null}) {
    return _then(
      _$WsRoomListEventImpl(
        rooms: null == rooms
            ? _value._rooms
            : rooms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsRoomListEventImpl implements WsRoomListEvent {
  const _$WsRoomListEventImpl({
    required final List<String> rooms,
    final String? $type,
  }) : _rooms = rooms,
       $type = $type ?? 'roomList';

  factory _$WsRoomListEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsRoomListEventImplFromJson(json);

  final List<String> _rooms;
  @override
  List<String> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.roomList(rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsRoomListEventImpl &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsRoomListEventImplCopyWith<_$WsRoomListEventImpl> get copyWith =>
      __$$WsRoomListEventImplCopyWithImpl<_$WsRoomListEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return roomList(rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return roomList?.call(rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (roomList != null) {
      return roomList(rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return roomList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return roomList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (roomList != null) {
      return roomList(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsRoomListEventImplToJson(this);
  }
}

abstract class WsRoomListEvent implements WsEvent {
  const factory WsRoomListEvent({required final List<String> rooms}) =
      _$WsRoomListEventImpl;

  factory WsRoomListEvent.fromJson(Map<String, dynamic> json) =
      _$WsRoomListEventImpl.fromJson;

  List<String> get rooms;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsRoomListEventImplCopyWith<_$WsRoomListEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WsErrorEventImplCopyWith<$Res> {
  factory _$$WsErrorEventImplCopyWith(
    _$WsErrorEventImpl value,
    $Res Function(_$WsErrorEventImpl) then,
  ) = __$$WsErrorEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$WsErrorEventImplCopyWithImpl<$Res>
    extends _$WsEventCopyWithImpl<$Res, _$WsErrorEventImpl>
    implements _$$WsErrorEventImplCopyWith<$Res> {
  __$$WsErrorEventImplCopyWithImpl(
    _$WsErrorEventImpl _value,
    $Res Function(_$WsErrorEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? content = null}) {
    return _then(
      _$WsErrorEventImpl(
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WsErrorEventImpl implements WsErrorEvent {
  const _$WsErrorEventImpl({required this.content, final String? $type})
    : $type = $type ?? 'error';

  factory _$WsErrorEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WsErrorEventImplFromJson(json);

  @override
  final String content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WsEvent.error(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WsErrorEventImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WsErrorEventImplCopyWith<_$WsErrorEventImpl> get copyWith =>
      __$$WsErrorEventImplCopyWithImpl<_$WsErrorEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String room, String user) join,
    required TResult Function(String room, String user) leave,
    required TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )
    message,
    required TResult Function(String room, String user) typing,
    required TResult Function(String room, List<String> users) presence,
    required TResult Function(List<String> rooms) roomList,
    required TResult Function(String content) error,
  }) {
    return error(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String room, String user)? join,
    TResult? Function(String room, String user)? leave,
    TResult? Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult? Function(String room, String user)? typing,
    TResult? Function(String room, List<String> users)? presence,
    TResult? Function(List<String> rooms)? roomList,
    TResult? Function(String content)? error,
  }) {
    return error?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String room, String user)? join,
    TResult Function(String room, String user)? leave,
    TResult Function(
      String room,
      String user,
      String content,
      String? timestamp,
    )?
    message,
    TResult Function(String room, String user)? typing,
    TResult Function(String room, List<String> users)? presence,
    TResult Function(List<String> rooms)? roomList,
    TResult Function(String content)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WsJoinEvent value) join,
    required TResult Function(WsLeaveEvent value) leave,
    required TResult Function(WsMessageEvent value) message,
    required TResult Function(WsTypingEvent value) typing,
    required TResult Function(WsPresenceEvent value) presence,
    required TResult Function(WsRoomListEvent value) roomList,
    required TResult Function(WsErrorEvent value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WsJoinEvent value)? join,
    TResult? Function(WsLeaveEvent value)? leave,
    TResult? Function(WsMessageEvent value)? message,
    TResult? Function(WsTypingEvent value)? typing,
    TResult? Function(WsPresenceEvent value)? presence,
    TResult? Function(WsRoomListEvent value)? roomList,
    TResult? Function(WsErrorEvent value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WsJoinEvent value)? join,
    TResult Function(WsLeaveEvent value)? leave,
    TResult Function(WsMessageEvent value)? message,
    TResult Function(WsTypingEvent value)? typing,
    TResult Function(WsPresenceEvent value)? presence,
    TResult Function(WsRoomListEvent value)? roomList,
    TResult Function(WsErrorEvent value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WsErrorEventImplToJson(this);
  }
}

abstract class WsErrorEvent implements WsEvent {
  const factory WsErrorEvent({required final String content}) =
      _$WsErrorEventImpl;

  factory WsErrorEvent.fromJson(Map<String, dynamic> json) =
      _$WsErrorEventImpl.fromJson;

  String get content;

  /// Create a copy of WsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WsErrorEventImplCopyWith<_$WsErrorEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
