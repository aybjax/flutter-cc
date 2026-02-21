// =============================================================================
// online_users.dart — Drawer showing online users in a room
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/generated/app_localizations.dart';

import '../cubits/chat_cubit.dart';
import '../cubits/chat_state.dart';

// ---------------------------------------------------------------------------
// OnlineUsers — Lists the currently online users in a room
// ---------------------------------------------------------------------------

/// A widget designed to be used inside a [Drawer], showing all users
/// currently online in the given room.
///
/// Each user is displayed with a green "online" indicator dot and
/// their username. The current user is highlighted.
class OnlineUsers extends StatelessWidget {
  /// The room to show online users for.
  final String roomName;

  const OnlineUsers({super.key, required this.roomName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.onlineUsers,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),

          // User list
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (prev, curr) =>
                  prev.onlineUsersByRoom[roomName] !=
                  curr.onlineUsersByRoom[roomName],
              builder: (context, state) {
                final users = state.onlineUsersByRoom[roomName] ?? [];
                final currentUser = state.username;

                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      'No users online',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final username = users[index];
                    final isCurrentUser = username == currentUser;

                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                theme.colorScheme.primaryContainer,
                            child: Text(
                              username[0].toUpperCase(),
                              style: TextStyle(
                                color:
                                    theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Online indicator dot
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        username,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: isCurrentUser
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: isCurrentUser
                          ? Text(
                              '(you)',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color:
                                    theme.colorScheme.onSurfaceVariant,
                              ),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
