// =============================================================================
// chat_state.dart — State for the ChatCubit
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/models.dart';
import '../services/websocket_service.dart' show WsConnectionState;

part 'chat_state.freezed.dart';

// ---------------------------------------------------------------------------
// ChatState — Immutable state managed by ChatCubit
// ---------------------------------------------------------------------------

/// The complete state for the chat feature.
///
/// Tracks the current user, available rooms, messages per room,
/// online users per room, typing indicators, and connection status.
@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    /// The current user's username. Null before the user has set one.
    String? username,

    /// The name of the room the user is currently viewing.
    String? currentRoom,

    /// List of available chat rooms.
    @Default([]) List<String> availableRooms,

    /// Messages per room, keyed by room name.
    @Default({}) Map<String, List<ChatMessage>> messagesByRoom,

    /// Online users per room, keyed by room name.
    @Default({}) Map<String, List<String>> onlineUsersByRoom,

    /// Set of users currently typing in each room, keyed by room name.
    @Default({}) Map<String, Set<String>> typingUsersByRoom,

    /// Current WebSocket connection state.
    @Default(WsConnectionState.disconnected) WsConnectionState connectionState,

    /// Set of room names the user has joined.
    @Default({}) Set<String> joinedRooms,

    // Alternative: could separate into multiple sub-states for
    // more granular rebuilds, but a single state is simpler for this tutorial.
  }) = _ChatState;
}
