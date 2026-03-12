import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/chat_message_entity.dart';

class ChatPanel extends StatelessWidget {
  const ChatPanel({
    super.key,
    required this.messages,
    required this.controller,
    required this.title,
    required this.hint,
    required this.emptyLabel,
    required this.onSend,
  });

  final List<ChatMessageEntity> messages;
  final TextEditingController controller;
  final String title;
  final String hint;
  final String emptyLabel;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.Hm();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF0B1633),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      emptyLabel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF6E7C97),
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: messages.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      return Align(
                        alignment: message.isLocal
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 320),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: message.isLocal
                                  ? const Color(0xFF2B6EF2)
                                  : const Color(0xFFF1F3F8),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.senderName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: message.isLocal
                                              ? Colors.white70
                                              : const Color(0xFF0B1633),
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    message.text,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: message.isLocal
                                              ? Colors.white
                                              : const Color(0xFF0B1633),
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    timeFormat.format(message.sentAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: message.isLocal
                                              ? Colors.white70
                                              : const Color(0xFF6E7C97),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    prefixIcon: const Icon(Icons.chat_bubble_outline_rounded),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: onSend,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(60, 60),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
