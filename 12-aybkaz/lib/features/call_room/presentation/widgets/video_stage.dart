import 'dart:ui';

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
    required this.statusLabel,
    required this.filterOverlay,
  });

  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final String localLabel;
  final String remoteLabel;
  final String waitingLabel;
  final String videoOffLabel;
  final bool isLocalVideoEnabled;
  final bool hasRemoteStream;
  final String statusLabel;
  final Color filterOverlay;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final previewWidth = size.width >= 720 ? 240.0 : 168.0;
    final previewHeight = size.width >= 720 ? 300.0 : 220.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: hasRemoteStream
                ? RTCVideoView(
                    remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : _BackdropPlaceholder(
                    remoteLabel: remoteLabel,
                    waitingLabel: waitingLabel,
                  ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.12),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.42),
                  ],
                  stops: const [0, 0.34, 1],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    filterOverlay.withValues(alpha: 0.24),
                    Colors.transparent,
                    filterOverlay.withValues(alpha: 0.18),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 26,
            right: 24,
            child: _LocalPreview(
              width: previewWidth,
              height: previewHeight,
              localRenderer: localRenderer,
              isLocalVideoEnabled: isLocalVideoEnabled,
              videoOffLabel: videoOffLabel,
              localLabel: localLabel,
            ),
          ),
          Positioned(
            left: 24,
            bottom: 28,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        remoteLabel,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        statusLabel,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
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

class _LocalPreview extends StatelessWidget {
  const _LocalPreview({
    required this.width,
    required this.height,
    required this.localRenderer,
    required this.isLocalVideoEnabled,
    required this.videoOffLabel,
    required this.localLabel,
  });

  final double width;
  final double height;
  final RTCVideoRenderer localRenderer;
  final bool isLocalVideoEnabled;
  final String videoOffLabel;
  final String localLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF46577B), width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF101823), Color(0xFF1B2638)],
              ),
            ),
            child: isLocalVideoEnabled && localRenderer.srcObject != null
                ? RTCVideoView(
                    localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : _PreviewPlaceholder(label: videoOffLabel),
          ),
          Positioned(
            left: 14,
            bottom: 14,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.38),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  localLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w800,
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

class _PreviewPlaceholder extends StatelessWidget {
  const _PreviewPlaceholder({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.videocam_off_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _BackdropPlaceholder extends StatelessWidget {
  const _BackdropPlaceholder({
    required this.remoteLabel,
    required this.waitingLabel,
  });

  final String remoteLabel;
  final String waitingLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFDFD9D0), Color(0xFFD1D3D5), Color(0xFFBBC4CF)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -60,
            bottom: -100,
            child: Container(
              width: 420,
              height: 420,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFF2D7C6), Color(0xFFD2B29B)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 120,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: 260,
                  height: 340,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -40,
            top: -20,
            child: Container(
              width: 220,
              height: 520,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x80FFFFFF), Color(0x00FFFFFF)],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.26),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _initials(remoteLabel),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFF39485B),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  waitingLabel,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF39485B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((part) => part.isNotEmpty);
    final letters = parts.take(2).map((part) => part[0]).join();
    return letters.isEmpty ? 'R' : letters.toUpperCase();
  }
}
