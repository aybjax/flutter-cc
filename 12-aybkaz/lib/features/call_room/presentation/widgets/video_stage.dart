import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoStage extends StatelessWidget {
  const VideoStage({
    super.key,
    required this.localRenderer,
    required this.remoteRenderer,
    required this.localLabel,
    required this.remoteLabel,
    required this.waitingLabel,
    required this.videoOffLabel,
    required this.isLocalVideoEnabled,
    required this.hasRemoteStream,
  });

  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final String localLabel;
  final String remoteLabel;
  final String waitingLabel;
  final String videoOffLabel;
  final bool isLocalVideoEnabled;
  final bool hasRemoteStream;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF111827), Color(0xFF1F2937)],
                ),
              ),
              child: hasRemoteStream
                  ? RTCVideoView(
                      remoteRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : _VideoPlaceholder(
                      label: waitingLabel,
                      icon: Icons.groups_2_outlined,
                    ),
            ),
          ),
          Positioned(top: 16, left: 16, child: _VideoTag(label: remoteLabel)),
          Positioned(
            right: 16,
            bottom: 16,
            child: SizedBox(
              width: 140,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Color(0xFF0F172A)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child:
                            isLocalVideoEnabled &&
                                localRenderer.srcObject != null
                            ? RTCVideoView(
                                localRenderer,
                                mirror: true,
                                objectFit: RTCVideoViewObjectFit
                                    .RTCVideoViewObjectFitCover,
                              )
                            : _VideoPlaceholder(
                                label: videoOffLabel,
                                icon: Icons.videocam_off_outlined,
                              ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: _VideoTag(label: localLabel),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoTag extends StatelessWidget {
  const _VideoTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xAA0F172A),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: Colors.white70),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
