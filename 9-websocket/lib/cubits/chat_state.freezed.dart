// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatState {
  /// The current user's username. Null before the user has set one.
  String? get username => throw _privateConstructorUsedError;

  /// The name of the room the user is currently viewing.
  String? get currentRoom => throw _privateConstructorUsedError;

  /// List of available chat rooms.
  List<String> get availableRooms => throw _privateConstructorUsedError;

  /// Messages per room, keyed by room name.
  Map<String, List<ChatMessage>> get messagesByRoom =>
      throw _privateConstructorUsedError;

  /// Online users per room, keyed by room name.
  Map<String, List<String>> get onlineUsersByRoom =>
      throw _privateConstructorUsedError;

  /// Set of users currently typing in each room, keyed by room name.
  Map<String, Set<String>> get typingUsersByRoom =>
      throw _privateConstructorUsedError;

  /// Current WebSocket connection state.
  WsConnectionState get connectionState => throw _privateConstructorUsedError;

  /// Set of room names the user has joined.
  Set<String> get joinedRooms => throw _privateConstructorUsedError;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call({
    String? username,
    String? currentRoom,
    List<String> availableRooms,
    Map<String, List<ChatMessage>> messagesByRoom,
    Map<String, List<String>> onlineUsersByRoom,
    Map<String, Set<String>> typingUsersByRoom,
    WsConnectionState connectionState,
    Set<String> joinedRooms,
  });
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? currentRoom = freezed,
    Object? availableRooms = null,
    Object? messagesByRoom = null,
    Object? onlineUsersByRoom = null,
    Object? typingUsersByRoom = null,
    Object? connectionState = null,
    Object? joinedRooms = null,
  }) {
    return _then(
      _value.copyWith(
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentRoom: freezed == currentRoom
                ? _value.currentRoom
                : currentRoom // ignore: cast_nullable_to_non_nullable
                      as String?,
            availableRooms: null == availableRooms
                ? _value.availableRooms
                : availableRooms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            messagesByRoom: null == messagesByRoom
                ? _value.messagesByRoom
                : messagesByRoom // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<ChatMessage>>,
            onlineUsersByRoom: null == onlineUsersByRoom
                ? _value.onlineUsersByRoom
                : onlineUsersByRoom // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            typingUsersByRoom: null == typingUsersByRoom
                ? _value.typingUsersByRoom
                : typingUsersByRoom // ignore: cast_nullable_to_non_nullable
                      as Map<String, Set<String>>,
            connectionState: null == connectionState
                ? _value.connectionState
                : connectionState // ignore: cast_nullable_to_non_nullable
                      as WsConnectionState,
            joinedRooms: null == joinedRooms
                ? _value.joinedRooms
                : joinedRooms // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
    _$ChatStateImpl value,
    $Res Function(_$ChatStateImpl) then,
  ) = __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? username,
    String? currentRoom,
    List<String> availableRooms,
    Map<String, List<ChatMessage>> messagesByRoom,
    Map<String, List<String>> onlineUsersByRoom,
    Map<String, Set<String>> typingUsersByRoom,
    WsConnectionState connectionState,
    Set<String> joinedRooms,
  });
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
    _$ChatStateImpl _value,
    $Res Function(_$ChatStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? currentRoom = freezed,
    Object? availableRooms = null,
    Object? messagesByRoom = null,
    Object? onlineUsersByRoom = null,
    Object? typingUsersByRoom = null,
    Object? connectionState = null,
    Object? joinedRooms = null,
  }) {
    return _then(
      _$ChatStateImpl(
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentRoom: freezed == currentRoom
            ? _value.currentRoom
            : currentRoom // ignore: cast_nullable_to_non_nullable
                  as String?,
        availableRooms: null == availableRooms
            ? _value._availableRooms
            : availableRooms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        messagesByRoom: null == messagesByRoom
            ? _value._messagesByRoom
            : messagesByRoom // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<ChatMessage>>,
        onlineUsersByRoom: null == onlineUsersByRoom
            ? _value._onlineUsersByRoom
            : onlineUsersByRoom // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        typingUsersByRoom: null == typingUsersByRoom
            ? _value._typingUsersByRoom
            : typingUsersByRoom // ignore: cast_nullable_to_non_nullable
                  as Map<String, Set<String>>,
        connectionState: null == connectionState
            ? _value.connectionState
            : connectionState // ignore: cast_nullable_to_non_nullable
                  as WsConnectionState,
        joinedRooms: null == joinedRooms
            ? _value._joinedRooms
            : joinedRooms // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl({
    this.username,
    this.currentRoom,
    final List<String> availableRooms = const [],
    final Map<String, List<ChatMessage>> messagesByRoom = const {},
    final Map<String, List<String>> onlineUsersByRoom = const {},
    final Map<String, Set<String>> typingUsersByRoom = const {},
    this.connectionState = WsConnectionState.disconnected,
    final Set<String> joinedRooms = const {},
  }) : _availableRooms = availableRooms,
       _messagesByRoom = messagesByRoom,
       _onlineUsersByRoom = onlineUsersByRoom,
       _typingUsersByRoom = typingUsersByRoom,
       _joinedRooms = joinedRooms;

  /// The current user's username. Null before the user has set one.
  @override
  final String? username;

  /// The name of the room the user is currently viewing.
  @override
  final String? currentRoom;

  /// List of available chat rooms.
  final List<String> _availableRooms;

  /// List of available chat rooms.
  @override
  @JsonKey()
  List<String> get availableRooms {
    if (_availableRooms is EqualUnmodifiableListView) return _availableRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableRooms);
  }

  /// Messages per room, keyed by room name.
  final Map<String, List<ChatMessage>> _messagesByRoom;

  /// Messages per room, keyed by room name.
  @override
  @JsonKey()
  Map<String, List<ChatMessage>> get messagesByRoom {
    if (_messagesByRoom is EqualUnmodifiableMapView) return _messagesByRoom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_messagesByRoom);
  }

  /// Online users per room, keyed by room name.
  final Map<String, List<String>> _onlineUsersByRoom;

  /// Online users per room, keyed by room name.
  @override
  @JsonKey()
  Map<String, List<String>> get onlineUsersByRoom {
    if (_onlineUsersByRoom is EqualUnmodifiableMapView)
      return _onlineUsersByRoom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_onlineUsersByRoom);
  }

  /// Set of users currently typing in each room, keyed by room name.
  final Map<String, Set<String>> _typingUsersByRoom;

  /// Set of users currently typing in each room, keyed by room name.
  @override
  @JsonKey()
  Map<String, Set<String>> get typingUsersByRoom {
    if (_typingUsersByRoom is EqualUnmodifiableMapView)
      return _typingUsersByRoom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typingUsersByRoom);
  }

  /// Current WebSocket connection state.
  @override
  @JsonKey()
  final WsConnectionState connectionState;

  /// Set of room names the user has joined.
  final Set<String> _joinedRooms;

  /// Set of room names the user has joined.
  @override
  @JsonKey()
  Set<String> get joinedRooms {
    if (_joinedRooms is EqualUnmodifiableSetView) return _joinedRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_joinedRooms);
  }

  @override
  String toString() {
    return 'ChatState(username: $username, currentRoom: $currentRoom, availableRooms: $availableRooms, messagesByRoom: $messagesByRoom, onlineUsersByRoom: $onlineUsersByRoom, typingUsersByRoom: $typingUsersByRoom, connectionState: $connectionState, joinedRooms: $joinedRooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.currentRoom, currentRoom) ||
                other.currentRoom == currentRoom) &&
            const DeepCollectionEquality().equals(
              other._availableRooms,
              _availableRooms,
            ) &&
            const DeepCollectionEquality().equals(
              other._messagesByRoom,
              _messagesByRoom,
            ) &&
            const DeepCollectionEquality().equals(
              other._onlineUsersByRoom,
              _onlineUsersByRoom,
            ) &&
            const DeepCollectionEquality().equals(
              other._typingUsersByRoom,
              _typingUsersByRoom,
            ) &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState) &&
            const DeepCollectionEquality().equals(
              other._joinedRooms,
              _joinedRooms,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    username,
    currentRoom,
    const DeepCollectionEquality().hash(_availableRooms),
    const DeepCollectionEquality().hash(_messagesByRoom),
    const DeepCollectionEquality().hash(_onlineUsersByRoom),
    const DeepCollectionEquality().hash(_typingUsersByRoom),
    connectionState,
    const DeepCollectionEquality().hash(_joinedRooms),
  );

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState({
    final String? username,
    final String? currentRoom,
    final List<String> availableRooms,
    final Map<String, List<ChatMessage>> messagesByRoom,
    final Map<String, List<String>> onlineUsersByRoom,
    final Map<String, Set<String>> typingUsersByRoom,
    final WsConnectionState connectionState,
    final Set<String> joinedRooms,
  }) = _$ChatStateImpl;

  /// The current user's username. Null before the user has set one.
  @override
  String? get username;

  /// The name of the room the user is currently viewing.
  @override
  String? get currentRoom;

  /// List of available chat rooms.
  @override
  List<String> get availableRooms;

  /// Messages per room, keyed by room name.
  @override
  Map<String, List<ChatMessage>> get messagesByRoom;

  /// Online users per room, keyed by room name.
  @override
  Map<String, List<String>> get onlineUsersByRoom;

  /// Set of users currently typing in each room, keyed by room name.
  @override
  Map<String, Set<String>> get typingUsersByRoom;

  /// Current WebSocket connection state.
  @override
  WsConnectionState get connectionState;

  /// Set of room names the user has joined.
  @override
  Set<String> get joinedRooms;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
