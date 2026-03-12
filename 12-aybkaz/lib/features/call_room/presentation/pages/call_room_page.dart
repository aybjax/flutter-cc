import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  _CallFilter _selectedFilter = _CallFilter.none;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
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
        final remoteLabel =
            session.remoteDisplayName ?? context.l10n.remoteVideoLabel;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: VideoStage(
                  localRenderer: cubit.localRenderer,
                  remoteRenderer: cubit.remoteRenderer,
                  localLabel: context.l10n.localVideoLabel,
                  remoteLabel: remoteLabel,
                  waitingLabel: context.l10n.waitingPeerLabel,
                  videoOffLabel: context.l10n.videoOffLabel,
                  isLocalVideoEnabled: session.localVideoEnabled,
                  hasRemoteStream: cubit.remoteRenderer.srcObject != null,
                  statusLabel: statusNote,
                  filterOverlay: _selectedFilter.tint,
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _GlassIconButton(
                              icon: Icons.arrow_back_ios_new_rounded,
                              onTap: () async {
                                await cubit.leave();
                                if (context.mounted) {
                                  context.router.maybePop();
                                }
                              },
                            ),
                            const Spacer(),
                            _GlassIconButton(
                              icon: Icons.tune_rounded,
                              onTap: () {
                                _showFilterSheet(context);
                              },
                            ),
                            const SizedBox(width: 12),
                            _GlassIconButton(
                              icon: Icons.info_outline_rounded,
                              onTap: () {
                                _showDetailsSheet(context, state);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _TimerBadge(
                            elapsedLabel: _formatDuration(_elapsed),
                          ),
                        ),
                        const Spacer(),
                        if (session.status == CallConnectionStatus.failure ||
                            session.status ==
                                CallConnectionStatus.disconnected ||
                            session.status == CallConnectionStatus.roomFull)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: FilledButton.tonalIcon(
                                onPressed: state.isJoining ? null : cubit.retry,
                                icon: const Icon(Icons.refresh_rounded),
                                label: Text(context.l10n.retryAction),
                              ),
                            ),
                          ),
                        CallControls(
                          isMuted: !session.localAudioEnabled,
                          isVideoEnabled: session.localVideoEnabled,
                          onToggleMute: cubit.toggleMicrophone,
                          onToggleCamera: cubit.toggleCamera,
                          onShare: () => _copyPeerId(context, state),
                          onOpenFilters: () => _showFilterSheet(context),
                          onOpenChat: () => _showChatSheet(context, state),
                          onLeave: () async {
                            await cubit.leave();
                            if (context.mounted) {
                              context.router.maybePop();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.isJoining)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(),
                ),
              Positioned(
                top: 122,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: session.status == CallConnectionStatus.inCall
                          ? 0.0
                          : 1.0,
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          statusText,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _copyPeerId(BuildContext context, CallRoomState state) async {
    final value =
        state.session.localPeerId ?? state.settings?.signalingUrl ?? '';
    if (value.isEmpty) {
      return;
    }

    final copiedMessage = context.l10n.copyPeerIdSuccess;
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) {
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(copiedMessage)));
  }

  Future<void> _showChatSheet(BuildContext context, CallRoomState state) async {
    final cubit = context.read<CallRoomCubit>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: DraggableScrollableSheet(
            initialChildSize: 0.68,
            minChildSize: 0.46,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 60,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8DEEA),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ChatPanel(
                        messages: state.session.chatMessages,
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
                                SnackBar(
                                  content: Text(context.l10n.callEmptyMessage),
                                ),
                              );
                            return;
                          }

                          await cubit.sendMessage(text);
                          _messageController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showDetailsSheet(
    BuildContext context,
    CallRoomState state,
  ) async {
    final serverUrl = state.settings?.signalingUrl ?? 'ws://localhost:3000';
    final localId = state.session.localPeerId ?? '...';
    final remoteId = state.session.remotePeerId ?? '...';

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xE6142247),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.detailsAction,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 18),
                    _DetailRow(
                      label: context.l10n.displayNameLabel,
                      value: state.settings?.displayName ?? 'Guest',
                    ),
                    _DetailRow(
                      label: context.l10n.serverUrlLabel,
                      value: serverUrl,
                    ),
                    _DetailRow(label: 'Local peer ID', value: localId),
                    _DetailRow(label: 'Remote peer ID', value: remoteId),
                    _DetailRow(
                      label: context.l10n.callTitle,
                      value: _statusSubtitle(context, state.session.status),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showFilterSheet(BuildContext context) async {
    var tempFilter = _selectedFilter;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8DEEA),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l10n.callFiltersTitle,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: const Color(0xFF0B1633),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 162,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _CallFilter.values.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 18),
                        itemBuilder: (context, index) {
                          final filter = _CallFilter.values[index];
                          final isSelected = tempFilter == filter;

                          return InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: () {
                              setModalState(() {
                                tempFilter = filter;
                              });
                            },
                            child: SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 120,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF2B6EF2)
                                            : const Color(0xFFD8DEEA),
                                        width: isSelected ? 4 : 1.4,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: filter.preview,
                                      ),
                                    ),
                                    child: filter == _CallFilter.none
                                        ? const Icon(
                                            Icons.block_rounded,
                                            color: Color(0xFF2B6EF2),
                                            size: 42,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    filter.label(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: isSelected
                                              ? const Color(0xFF2B6EF2)
                                              : const Color(0xFF52627E),
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _selectedFilter = tempFilter;
                        });
                        Navigator.of(context).pop();
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(68),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(context.l10n.applyFilterAction),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
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

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Material(
          color: Colors.white.withValues(alpha: 0.14),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 58,
              height: 58,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerBadge extends StatelessWidget {
  const _TimerBadge({required this.elapsedLabel});

  final String elapsedLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4D4F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                elapsedLabel,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

enum _CallFilter {
  none(
    tint: Color(0xFF000000),
    preview: [Color(0xFFF5F7FB), Color(0xFFE3EAF6)],
  ),
  blur(
    tint: Color(0xFF9DB39A),
    preview: [Color(0xFFDDE7D9), Color(0xFF9FB495)],
  ),
  mono(
    tint: Color(0xFF50545E),
    preview: [Color(0xFF8D919B), Color(0xFF3D414A)],
  ),
  warm(
    tint: Color(0xFFBD8541),
    preview: [Color(0xFFF3D59B), Color(0xFFB8772C)],
  );

  const _CallFilter({required this.tint, required this.preview});

  final Color tint;
  final List<Color> preview;

  String label(BuildContext context) {
    return switch (this) {
      _CallFilter.none => context.l10n.filterNone,
      _CallFilter.blur => context.l10n.filterBlur,
      _CallFilter.mono => context.l10n.filterMono,
      _CallFilter.warm => context.l10n.filterWarm,
    };
  }
}
