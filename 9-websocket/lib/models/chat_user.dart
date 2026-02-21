// =============================================================================
// chat_user.dart — Freezed model for a chat user
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_user.freezed.dart';
part 'chat_user.g.dart';

// ---------------------------------------------------------------------------
// ChatUser — Represents a user in the chat system
// ---------------------------------------------------------------------------

/// A chat user identified by their username.
///
/// In a production app this would include authentication tokens,
/// avatar URLs, etc. For this tutorial, username is sufficient.
@freezed
abstract class ChatUser with _$ChatUser {
  /// Creates a [ChatUser] with the given username.
  const factory ChatUser({
    /// The unique username for this user.
    required String username,

    /// Whether the user is currently online.
    @Default(true) bool isOnline,

    // Alternative: could add avatarUrl, displayName, etc.
  }) = _ChatUser;

  /// Deserializes a [ChatUser] from a JSON map.
  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
}
