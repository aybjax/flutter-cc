import 'package:flutter/material.dart';

import '../../../../core/utils/build_context_x.dart';

class CallControls extends StatelessWidget {
  const CallControls({
    super.key,
    required this.statusText,
    required this.statusNote,
    required this.isMuted,
    required this.isVideoEnabled,
    required this.onToggleMute,
    required this.onToggleCamera,
    required this.onLeave,
  });

  final String statusText;
  final String? statusNote;
  final bool isMuted;
  final bool isVideoEnabled;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleCamera;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    statusText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF075985),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (statusNote != null && statusNote!.isNotEmpty)
                  Text(
                    statusNote!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF475569),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.tonalIcon(
                  onPressed: onToggleMute,
                  icon: Icon(isMuted ? Icons.mic_off : Icons.mic),
                  label: Text(
                    isMuted
                        ? context.l10n.unmuteAction
                        : context.l10n.muteAction,
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: onToggleCamera,
                  icon: Icon(
                    isVideoEnabled
                        ? Icons.videocam
                        : Icons.videocam_off_outlined,
                  ),
                  label: Text(
                    isVideoEnabled
                        ? context.l10n.cameraOffAction
                        : context.l10n.cameraOnAction,
                  ),
                ),
                FilledButton(
                  onPressed: onLeave,
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  child: Text(context.l10n.leaveAction),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
