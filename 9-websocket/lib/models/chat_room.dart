// =============================================================================
// chat_room.dart — Freezed model for a chat room
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

// ---------------------------------------------------------------------------
// ChatRoom — Represents a chat room with its metadata
// ---------------------------------------------------------------------------

/// A chat room with a name and list of online members.
///
/// The room itself is a lightweight descriptor; actual message history
/// is managed by the [ChatCubit].
@freezed
abstract class ChatRoom with _$ChatRoom {
  /// Creates a [ChatRoom] with the given name and optional member list.
  const factory ChatRoom({
    /// The unique name of the chat room.
    required String name,

    /// List of usernames currently online in this room.
    @Default([]) List<String> members,

    // Alternative: could include unread count, last message preview, etc.
  }) = _ChatRoom;

  /// Deserializes a [ChatRoom] from a JSON map.
  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
