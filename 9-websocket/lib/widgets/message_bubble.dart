// =============================================================================
// message_bubble.dart — Chat message bubble widget
// =============================================================================

import 'package:flutter/material.dart';

import '../models/chat_message.dart';

// ---------------------------------------------------------------------------
// MessageBubble — Renders a single chat message
// ---------------------------------------------------------------------------

/// Displays a chat message as a bubble.
///
/// Own messages are aligned to the right with the primary color.
/// Other users' messages are aligned to the left with a surface color.
/// System messages (join/leave) are centered with a muted style.
class MessageBubble extends StatelessWidget {
  /// The message to display.
  final ChatMessage message;

  /// Whether this message was sent by the current user.
  final bool isOwnMessage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isOwnMessage,
  });

  @override
  Widget build(BuildContext context) {
    // System messages (join/leave notifications) get special styling
    if (message.user == 'system') {
      return _buildSystemMessage(context);
    }

    return _buildUserMessage(context);
  }

  /// Builds a centered, muted system message.
  Widget _buildSystemMessage(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(128),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.content,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a left- or right-aligned chat bubble.
  Widget _buildUserMessage(BuildContext context) {
    final theme = Theme.of(context);

    // Own messages: right-aligned, primary color
    // Other messages: left-aligned, surface container color
    final alignment =
        isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isOwnMessage
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isOwnMessage
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;

    // Bubble border radius — rounded on all corners except the
    // corner closest to the sender's side
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isOwnMessage ? 16 : 4),
      bottomRight: Radius.circular(isOwnMessage ? 4 : 16),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          // Show the sender's name for other users' messages
          if (!isOwnMessage)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 2),
              child: Text(
                message.user,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          // Message bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
                ),
                // Timestamp (if available)
                if (message.timestamp != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      _formatTimestamp(message.timestamp!),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: textColor.withAlpha(179),
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Formats an ISO 8601 timestamp into a short time string (HH:mm).
  String _formatTimestamp(String iso8601) {
    try {
      final dateTime = DateTime.parse(iso8601).toLocal();
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (_) {
      // If parsing fails, return the raw string
      return iso8601;
    }
  }
}
