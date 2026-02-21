// =============================================================================
// chat_message.dart — Freezed model for a single chat message
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

// ---------------------------------------------------------------------------
// ChatMessage — Represents a message in a chat room
// ---------------------------------------------------------------------------

/// A single chat message with sender, content, and timestamp.
///
/// Uses `@freezed` for immutable value semantics and automatic
/// JSON serialization via `json_serializable`.
@freezed
abstract class ChatMessage with _$ChatMessage {
  /// Creates a [ChatMessage] with the required fields.
  const factory ChatMessage({
    /// The username of the message sender.
    required String user,

    /// The text content of the message.
    required String content,

    /// ISO 8601 timestamp of when the message was sent.
    /// Nullable because system messages may not have a timestamp.
    String? timestamp,

    // Alternative: could use DateTime directly, but String is simpler
    // for JSON serialization across the WebSocket boundary.
  }) = _ChatMessage;

  /// Deserializes a [ChatMessage] from a JSON map.
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
