// =============================================================================
// ws_event.dart — Freezed union type for WebSocket events
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_event.freezed.dart';
part 'ws_event.g.dart';

// ---------------------------------------------------------------------------
// WsEvent — Union type representing all possible WebSocket events
// ---------------------------------------------------------------------------

/// A union type covering every WebSocket event the app sends or receives.
///
/// Uses freezed's union/sealed class support so we can pattern-match
/// on the event type in a type-safe way.
///
/// Alternative: could use a single flat class with nullable fields
/// (like the Go side), but the union approach is more idiomatic Dart.
@freezed
sealed class WsEvent with _$WsEvent {
  /// A user joining a room.
  const factory WsEvent.join({
    required String room,
    required String user,
  }) = WsJoinEvent;

  /// A user leaving a room.
  const factory WsEvent.leave({
    required String room,
    required String user,
  }) = WsLeaveEvent;

  /// A chat message sent to a room.
  const factory WsEvent.message({
    required String room,
    required String user,
    required String content,
    String? timestamp,
  }) = WsMessageEvent;

  /// A typing indicator from a user.
  const factory WsEvent.typing({
    required String room,
    required String user,
  }) = WsTypingEvent;

  /// A presence update listing all online users in a room.
  const factory WsEvent.presence({
    required String room,
    required List<String> users,
  }) = WsPresenceEvent;

  /// The server-sent list of available rooms.
  const factory WsEvent.roomList({
    required List<String> rooms,
  }) = WsRoomListEvent;

  /// An error message from the server.
  const factory WsEvent.error({
    required String content,
  }) = WsErrorEvent;

  /// Deserializes a [WsEvent] from a JSON map, dispatching on the `type` field.
  ///
  /// We use a custom factory instead of the generated one because the
  /// server sends a flat `{"type": "..."}` discriminator that doesn't
  /// match freezed's default `runtimeType` key.
  factory WsEvent.fromServerJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    switch (type) {
      case 'join':
        return WsEvent.join(
          room: json['room'] as String? ?? '',
          user: json['user'] as String? ?? '',
        );
      case 'leave':
        return WsEvent.leave(
          room: json['room'] as String? ?? '',
          user: json['user'] as String? ?? '',
        );
      case 'message':
        return WsEvent.message(
          room: json['room'] as String? ?? '',
          user: json['user'] as String? ?? '',
          content: json['content'] as String? ?? '',
          timestamp: json['timestamp'] as String?,
        );
      case 'typing':
        return WsEvent.typing(
          room: json['room'] as String? ?? '',
          user: json['user'] as String? ?? '',
        );
      case 'presence':
        return WsEvent.presence(
          room: json['room'] as String? ?? '',
          users: (json['users'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
        );
      case 'room_list':
        return WsEvent.roomList(
          rooms: (json['rooms'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
        );
      case 'error':
        return WsEvent.error(
          content: json['content'] as String? ?? 'Unknown error',
        );
      default:
        return WsEvent.error(content: 'Unknown event type: $type');
    }
  }

  /// Serializes this event to JSON for sending to the server.
  factory WsEvent.fromJson(Map<String, dynamic> json) =>
      _$WsEventFromJson(json);
}

// ---------------------------------------------------------------------------
// Extension — Convert WsEvent to server-compatible JSON
// ---------------------------------------------------------------------------

/// Extension to serialize [WsEvent] into the flat JSON format expected
/// by the Go WebSocket server.
extension WsEventToServerJson on WsEvent {
  /// Converts this event to the server's expected JSON format.
  Map<String, dynamic> toServerJson() {
    return switch (this) {
      WsJoinEvent(:final room, :final user) => {
        'type': 'join',
        'room': room,
        'user': user,
      },
      WsLeaveEvent(:final room, :final user) => {
        'type': 'leave',
        'room': room,
        'user': user,
      },
      WsMessageEvent(:final room, :final user, :final content) => {
        'type': 'message',
        'room': room,
        'user': user,
        'content': content,
      },
      WsTypingEvent(:final room, :final user) => {
        'type': 'typing',
        'room': room,
        'user': user,
      },
      WsPresenceEvent(:final room, :final users) => {
        'type': 'presence',
        'room': room,
        'users': users,
      },
      WsRoomListEvent(:final rooms) => {
        'type': 'room_list',
        'rooms': rooms,
      },
      WsErrorEvent(:final content) => {
        'type': 'error',
        'content': content,
      },
    };
  }
}
