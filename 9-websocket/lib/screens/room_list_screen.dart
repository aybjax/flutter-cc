// =============================================================================
// room_list_screen.dart — Lists available chat rooms
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/generated/app_localizations.dart';

import '../cubits/chat_cubit.dart';
import '../cubits/chat_state.dart';
import '../services/websocket_service.dart' show WsConnectionState;
import 'chat_screen.dart';

// ---------------------------------------------------------------------------
// RoomListScreen — Displays available rooms and connection status
// ---------------------------------------------------------------------------

/// Shows a list of available chat rooms and the current connection status.
///
/// Tapping a room joins it (if not already joined) and navigates to the
/// chat screen for that room.
class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chatRooms),
        actions: [
          // Connection status indicator
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (prev, curr) =>
                prev.connectionState != curr.connectionState,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _ConnectionIndicator(state: state.connectionState),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (prev, curr) =>
            prev.availableRooms != curr.availableRooms ||
            prev.joinedRooms != curr.joinedRooms ||
            prev.onlineUsersByRoom != curr.onlineUsersByRoom,
        builder: (context, state) {
          final rooms = state.availableRooms;

          if (rooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.connecting),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: rooms.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final roomName = rooms[index];
              final isJoined = state.joinedRooms.contains(roomName);
              final memberCount =
                  state.onlineUsersByRoom[roomName]?.length ?? 0;

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isJoined
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.tag,
                      color: isJoined
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  title: Text(
                    roomName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight:
                          isJoined ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: isJoined
                      ? Text(l10n.members(memberCount))
                      : null,
                  trailing: isJoined
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _openRoom(context, roomName),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Joins the room (if needed) and navigates to the chat screen.
  void _openRoom(BuildContext context, String roomName) {
    final cubit = context.read<ChatCubit>();
    cubit.joinRoom(roomName);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChatScreen(roomName: roomName),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ConnectionIndicator — Shows connection status as a colored dot + label
// ---------------------------------------------------------------------------

class _ConnectionIndicator extends StatelessWidget {
  final WsConnectionState state;

  const _ConnectionIndicator({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final (color, label) = switch (state) {
      WsConnectionState.connected => (Colors.green, l10n.connected),
      WsConnectionState.connecting => (Colors.orange, l10n.connecting),
      WsConnectionState.reconnecting => (Colors.orange, l10n.reconnecting),
      WsConnectionState.disconnected => (Colors.red, l10n.disconnected),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
