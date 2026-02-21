// =============================================================================
// chat_screen.dart — The main chat interface for a single room
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/generated/app_localizations.dart';

import '../cubits/chat_cubit.dart';
import '../cubits/chat_state.dart';
import '../widgets/message_bubble.dart';
import '../widgets/online_users.dart';
import '../widgets/typing_indicator.dart';

// ---------------------------------------------------------------------------
// ChatScreen — Real-time chat interface for a room
// ---------------------------------------------------------------------------

/// Displays the message list, typing indicators, online users drawer,
/// and message input for a single chat room.
class ChatScreen extends StatefulWidget {
  /// The name of the room to display.
  final String roomName;

  const ChatScreen({super.key, required this.roomName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Set the current room so the cubit knows where to send messages
    context.read<ChatCubit>().setCurrentRoom(widget.roomName);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Sends the current message and clears the input field.
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(text);
    _messageController.clear();

    // Scroll to the bottom after sending
    _scrollToBottom();
  }

  /// Scrolls the message list to the bottom.
  void _scrollToBottom() {
    // Use a short delay to let the list rebuild with the new message
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('# ${widget.roomName}'),
        actions: [
          // Online users button — opens the end drawer
          IconButton(
            icon: const Icon(Icons.people_outline),
            tooltip: l10n.onlineUsers,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: OnlineUsers(roomName: widget.roomName),
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listenWhen: (prev, curr) {
                // Listen for new messages to auto-scroll
                final prevCount =
                    prev.messagesByRoom[widget.roomName]?.length ?? 0;
                final currCount =
                    curr.messagesByRoom[widget.roomName]?.length ?? 0;
                return currCount > prevCount;
              },
              listener: (context, state) => _scrollToBottom(),
              buildWhen: (prev, curr) =>
                  prev.messagesByRoom[widget.roomName] !=
                  curr.messagesByRoom[widget.roomName],
              builder: (context, state) {
                final messages =
                    state.messagesByRoom[widget.roomName] ?? [];
                final username = state.username ?? '';

                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet. Say hello!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(
                      message: message,
                      isOwnMessage: message.user == username,
                    );
                  },
                );
              },
            ),
          ),

          // Typing indicator
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (prev, curr) =>
                prev.typingUsersByRoom[widget.roomName] !=
                curr.typingUsersByRoom[widget.roomName],
            builder: (context, state) {
              final typingUsers =
                  state.typingUsersByRoom[widget.roomName] ?? {};
              return TypingIndicator(typingUsers: typingUsers.toList());
            },
          ),

          // Message input
          _MessageInput(
            controller: _messageController,
            onSend: _sendMessage,
            onTyping: () => context.read<ChatCubit>().sendTyping(),
            hintText: l10n.typeMessage,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _MessageInput — Text field and send button
// ---------------------------------------------------------------------------

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onTyping;
  final String hintText;

  const _MessageInput({
    required this.controller,
    required this.onSend,
    required this.onTyping,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        top: 8,
        // Account for bottom safe area (e.g., iPhone notch)
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              onChanged: (_) => onTyping(),
              maxLines: null,
              // Alternative: could limit to 5 lines with minLines/maxLines
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: onSend,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
