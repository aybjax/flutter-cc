// =============================================================================
// chat_cubit.dart — Business logic for the chat feature
// =============================================================================

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';
import '../services/websocket_service.dart';
import 'chat_state.dart';

// ---------------------------------------------------------------------------
// ChatCubit — Manages chat state and WebSocket interactions
// ---------------------------------------------------------------------------

/// Cubit that orchestrates the chat feature.
///
/// Responsibilities:
/// - Connect/disconnect the WebSocket
/// - Join/leave rooms
/// - Send messages and typing indicators
/// - React to incoming WebSocket events and update state
class ChatCubit extends Cubit<ChatState> {
  final WebSocketService _wsService;

  StreamSubscription<WsEvent>? _eventSub;
  StreamSubscription<WsConnectionState>? _connectionSub;

  // Debounce timer for typing indicators
  Timer? _typingTimer;

  /// Creates a [ChatCubit] backed by the given [WebSocketService].
  ChatCubit({required WebSocketService wsService})
      : _wsService = wsService,
        super(const ChatState()) {
    _listenToWebSocket();
  }

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Sets the username and connects to the WebSocket server.
  void setUsername(String username) {
    emit(state.copyWith(username: username));
    _wsService.connect();
  }

  /// Joins a chat room.
  ///
  /// Sends a join event to the server and adds the room to joined rooms.
  void joinRoom(String roomName) {
    final username = state.username;
    if (username == null) return;

    _wsService.sendEvent(WsEvent.join(room: roomName, user: username));
    emit(state.copyWith(
      currentRoom: roomName,
      joinedRooms: {...state.joinedRooms, roomName},
    ));
  }

  /// Leaves the current chat room.
  void leaveRoom(String roomName) {
    _wsService.sendEvent(WsEvent.leave(room: roomName, user: state.username ?? ''));

    final updatedJoined = Set<String>.from(state.joinedRooms)..remove(roomName);

    emit(state.copyWith(
      joinedRooms: updatedJoined,
      currentRoom: state.currentRoom == roomName ? null : state.currentRoom,
    ));
  }

  /// Sends a chat message to the current room.
  void sendMessage(String content) {
    final room = state.currentRoom;
    final user = state.username;
    if (room == null || user == null || content.trim().isEmpty) return;

    _wsService.sendEvent(WsEvent.message(
      room: room,
      user: user,
      content: content.trim(),
    ));
  }

  /// Sends a typing indicator to the current room.
  ///
  /// Debounced to avoid flooding the server — only sends once per second.
  void sendTyping() {
    final room = state.currentRoom;
    final user = state.username;
    if (room == null || user == null) return;

    // Only send if we haven't sent one recently
    if (_typingTimer?.isActive ?? false) return;

    _wsService.sendEvent(WsEvent.typing(room: room, user: user));

    // Prevent sending another typing event for 1 second
    _typingTimer = Timer(const Duration(seconds: 1), () {});
  }

  /// Sets the currently viewed room (without joining).
  void setCurrentRoom(String roomName) {
    emit(state.copyWith(currentRoom: roomName));
  }

  /// Disconnects from the server.
  void disconnectFromServer() {
    _wsService.disconnect();
  }

  // ---------------------------------------------------------------------------
  // WebSocket event handling
  // ---------------------------------------------------------------------------

  /// Subscribes to WebSocket events and connection state changes.
  void _listenToWebSocket() {
    _eventSub = _wsService.events.listen(_handleEvent);
    _connectionSub = _wsService.connectionState.listen((connectionState) {
      emit(state.copyWith(connectionState: connectionState));

      // Re-join rooms on reconnect
      if (connectionState == WsConnectionState.connected &&
          state.username != null) {
        for (final room in state.joinedRooms) {
          _wsService.sendEvent(
              WsEvent.join(room: room, user: state.username!));
        }
      }
    });
  }

  /// Dispatches an incoming [WsEvent] to the appropriate handler.
  void _handleEvent(WsEvent event) {
    switch (event) {
      case WsJoinEvent(:final room, :final user):
        _handleJoin(room, user);
      case WsLeaveEvent(:final room, :final user):
        _handleLeave(room, user);
      case WsMessageEvent(:final room, :final user, :final content, :final timestamp):
        _handleMessage(room, user, content, timestamp);
      case WsTypingEvent(:final room, :final user):
        _handleTyping(room, user);
      case WsPresenceEvent(:final room, :final users):
        _handlePresence(room, users);
      case WsRoomListEvent(:final rooms):
        _handleRoomList(rooms);
      case WsErrorEvent():
        // Errors are logged but not surfaced to the user in this tutorial
        // Alternative: could show a snackbar or error banner
        break;
    }
  }

  /// Handles a join event — adds a system message to the room.
  void _handleJoin(String room, String user) {
    // Don't show join message for ourselves
    if (user == state.username) return;

    _addSystemMessage(room, '$user joined the room');
  }

  /// Handles a leave event — adds a system message to the room.
  void _handleLeave(String room, String user) {
    if (user == state.username) return;

    _addSystemMessage(room, '$user left the room');

    // Remove from typing users
    _removeTypingUser(room, user);
  }

  /// Handles a chat message — adds it to the room's message list.
  void _handleMessage(
      String room, String user, String content, String? timestamp) {
    final messages =
        Map<String, List<ChatMessage>>.from(state.messagesByRoom);
    final roomMessages = List<ChatMessage>.from(messages[room] ?? []);

    roomMessages.add(ChatMessage(
      user: user,
      content: content,
      timestamp: timestamp,
    ));

    messages[room] = roomMessages;
    emit(state.copyWith(messagesByRoom: messages));

    // Clear typing indicator when a message arrives from that user
    _removeTypingUser(room, user);
  }

  /// Handles a typing indicator — adds the user to the typing set,
  /// then auto-removes after 3 seconds.
  void _handleTyping(String room, String user) {
    // Don't show our own typing indicator
    if (user == state.username) return;

    final typingUsers =
        Map<String, Set<String>>.from(state.typingUsersByRoom);
    final roomTyping = Set<String>.from(typingUsers[room] ?? {});
    roomTyping.add(user);
    typingUsers[room] = roomTyping;

    emit(state.copyWith(typingUsersByRoom: typingUsers));

    // Auto-remove typing indicator after 3 seconds
    Timer(const Duration(seconds: 3), () {
      _removeTypingUser(room, user);
    });
  }

  /// Handles a presence update — replaces the online user list for the room.
  void _handlePresence(String room, List<String> users) {
    final onlineUsers =
        Map<String, List<String>>.from(state.onlineUsersByRoom);
    onlineUsers[room] = users;
    emit(state.copyWith(onlineUsersByRoom: onlineUsers));
  }

  /// Handles a room list event — updates the available rooms.
  void _handleRoomList(List<String> rooms) {
    emit(state.copyWith(availableRooms: rooms));
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Adds a system message (join/leave notification) to a room.
  void _addSystemMessage(String room, String text) {
    final messages =
        Map<String, List<ChatMessage>>.from(state.messagesByRoom);
    final roomMessages = List<ChatMessage>.from(messages[room] ?? []);

    // System messages use a special 'system' user
    roomMessages.add(ChatMessage(user: 'system', content: text));

    messages[room] = roomMessages;
    emit(state.copyWith(messagesByRoom: messages));
  }

  /// Removes a user from the typing set for a room.
  void _removeTypingUser(String room, String user) {
    final typingUsers =
        Map<String, Set<String>>.from(state.typingUsersByRoom);
    final roomTyping = Set<String>.from(typingUsers[room] ?? {});

    if (roomTyping.remove(user)) {
      typingUsers[room] = roomTyping;
      emit(state.copyWith(typingUsersByRoom: typingUsers));
    }
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  Future<void> close() {
    _eventSub?.cancel();
    _connectionSub?.cancel();
    _typingTimer?.cancel();
    _wsService.dispose();
    return super.close();
  }
}
