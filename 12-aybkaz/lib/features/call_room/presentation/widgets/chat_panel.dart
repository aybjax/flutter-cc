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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Text(
                        emptyLabel,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF64748B),
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
                                    ? const Color(0xFF0F766E)
                                    : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(18),
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
                                                : const Color(0xFF0F172A),
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      message.text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: message.isLocal
                                                ? Colors.white
                                                : const Color(0xFF0F172A),
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
                                                : const Color(0xFF64748B),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      prefixIcon: const Icon(Icons.chat_bubble_outline),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSend(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(onPressed: onSend, child: const Icon(Icons.send)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
