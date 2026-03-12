import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/utils/build_context_x.dart';

class CallControls extends StatelessWidget {
  const CallControls({
    super.key,
    required this.isMuted,
    required this.isVideoEnabled,
    required this.onToggleMute,
    required this.onToggleCamera,
    required this.onShare,
    required this.onOpenFilters,
    required this.onOpenChat,
    required this.onLeave,
  });

  final bool isMuted;
  final bool isVideoEnabled;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleCamera;
  final VoidCallback onShare;
  final VoidCallback onOpenFilters;
  final VoidCallback onOpenChat;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 74, 18),
              decoration: BoxDecoration(
                color: const Color(0xCC162447),
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 28,
                    offset: Offset(0, 18),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _DockButton(
                      icon: isMuted ? Icons.mic_off_rounded : Icons.mic_none,
                      label: isMuted
                          ? context.l10n.unmuteAction
                          : context.l10n.muteAction,
                      onTap: onToggleMute,
                    ),
                  ),
                  Expanded(
                    child: _DockButton(
                      icon: isVideoEnabled
                          ? Icons.videocam_outlined
                          : Icons.videocam_off_outlined,
                      label: isVideoEnabled
                          ? context.l10n.cameraOffAction
                          : context.l10n.cameraOnAction,
                      onTap: onToggleCamera,
                    ),
                  ),
                  _DividerLine(),
                  Expanded(
                    child: _DockButton(
                      icon: Icons.ios_share_outlined,
                      label: context.l10n.shareAction,
                      onTap: onShare,
                    ),
                  ),
                  Expanded(
                    child: _DockButton(
                      icon: Icons.auto_awesome_outlined,
                      label: context.l10n.filtersAction,
                      onTap: onOpenFilters,
                    ),
                  ),
                  Expanded(
                    child: _DockButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: context.l10n.chatAction,
                      onTap: onOpenChat,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -16,
          top: 28,
          child: GestureDetector(
            onTap: onLeave,
            child: Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF94144),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x55F94144),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.call_end_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DockButton extends StatelessWidget {
  const _DockButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.11),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFD3DCF2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 68,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white.withValues(alpha: 0.14),
    );
  }
}
