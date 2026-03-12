import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/build_context_x.dart';
import '../../domain/entities/call_session_entity.dart';
import '../cubit/call_room_cubit.dart';
import '../cubit/call_room_state.dart';
import '../widgets/call_controls.dart';
import '../widgets/chat_panel.dart';
import '../widgets/video_stage.dart';

@RoutePage()
class CallRoomPage extends StatefulWidget implements AutoRouteWrapper {
  const CallRoomPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CallRoomCubit>()..initialize(),
      child: this,
    );
  }

  @override
  State<CallRoomPage> createState() => _CallRoomPageState();
}

class _CallRoomPageState extends State<CallRoomPage> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallRoomCubit, CallRoomState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<CallRoomCubit>().clearError();
        }
      },
      builder: (context, state) {
        final cubit = context.read<CallRoomCubit>();
        final session = state.session;
        final statusText = _statusText(context, session.status);
        final statusNote =
            session.statusMessage ?? _statusSubtitle(context, session.status);

        final videoStage = VideoStage(
          localRenderer: cubit.localRenderer,
          remoteRenderer: cubit.remoteRenderer,
          localLabel: context.l10n.localVideoLabel,
          remoteLabel:
              session.remoteDisplayName ?? context.l10n.remoteVideoLabel,
          waitingLabel: context.l10n.waitingPeerLabel,
          videoOffLabel: context.l10n.videoOffLabel,
          isLocalVideoEnabled: session.localVideoEnabled,
          hasRemoteStream: cubit.remoteRenderer.srcObject != null,
        );

        final controls = Column(
          children: [
            CallControls(
              statusText: statusText,
              statusNote: statusNote,
              isMuted: !session.localAudioEnabled,
              isVideoEnabled: session.localVideoEnabled,
              onToggleMute: cubit.toggleMicrophone,
              onToggleCamera: cubit.toggleCamera,
              onLeave: () async {
                await cubit.leave();
                if (context.mounted) {
                  context.router.maybePop();
                }
              },
            ),
            if (session.status == CallConnectionStatus.failure ||
                session.status == CallConnectionStatus.disconnected ||
                session.status == CallConnectionStatus.roomFull) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: state.isJoining ? null : cubit.retry,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.retryAction),
                ),
              ),
            ],
          ],
        );

        final chatPanel = ChatPanel(
          messages: session.chatMessages,
          controller: _messageController,
          title: context.l10n.chatTitle,
          hint: context.l10n.chatHint,
          emptyLabel: context.l10n.emptyChat,
          onSend: () async {
            final text = _messageController.text;
            if (text.trim().isEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(context.l10n.callEmptyMessage)),
                );
              return;
            }

            await cubit.sendMessage(text);
            _messageController.clear();
          },
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.callTitle),
            actions: [
              TextButton.icon(
                onPressed: () async {
                  await cubit.leave();
                  if (context.mounted) {
                    context.router.maybePop();
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: Text(context.l10n.backAction),
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 1024) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                children: [
                                  Expanded(child: videoStage),
                                  const SizedBox(height: 16),
                                  controls,
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(flex: 4, child: chatPanel),
                          ],
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        children: [
                          Expanded(flex: 5, child: videoStage),
                          const SizedBox(height: 16),
                          controls,
                          const SizedBox(height: 16),
                          Expanded(flex: 4, child: chatPanel),
                        ],
                      ),
                    );
                  },
                ),
                if (state.isJoining)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _statusText(BuildContext context, CallConnectionStatus status) {
    switch (status) {
      case CallConnectionStatus.idle:
        return context.l10n.statusIdle;
      case CallConnectionStatus.connecting:
        return context.l10n.statusConnecting;
      case CallConnectionStatus.waitingPeer:
        return context.l10n.statusWaitingPeer;
      case CallConnectionStatus.negotiating:
        return context.l10n.statusNegotiating;
      case CallConnectionStatus.inCall:
        return context.l10n.statusInCall;
      case CallConnectionStatus.disconnected:
        return context.l10n.statusDisconnected;
      case CallConnectionStatus.roomFull:
        return context.l10n.statusRoomFull;
      case CallConnectionStatus.failure:
        return context.l10n.statusFailure;
    }
  }

  String _statusSubtitle(BuildContext context, CallConnectionStatus status) {
    switch (status) {
      case CallConnectionStatus.idle:
        return context.l10n.statusIdle;
      case CallConnectionStatus.connecting:
        return context.l10n.callSubtitleConnecting;
      case CallConnectionStatus.waitingPeer:
        return context.l10n.callSubtitleWaiting;
      case CallConnectionStatus.negotiating:
        return context.l10n.callSubtitleNegotiating;
      case CallConnectionStatus.inCall:
        return context.l10n.callSubtitleInCall;
      case CallConnectionStatus.disconnected:
        return context.l10n.callSubtitleDisconnected;
      case CallConnectionStatus.roomFull:
        return context.l10n.callSubtitleRoomFull;
      case CallConnectionStatus.failure:
        return context.l10n.callSubtitleFailure;
    }
  }
}
