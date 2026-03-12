import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRtcDataSource {
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  bool _renderersInitialized = false;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  RTCPeerConnection? _peerConnection;
  Future<void> Function(RTCSessionDescription description)? _onLocalDescription;
  Future<void> Function(RTCIceCandidate candidate)? _onIceCandidate;
  void Function()? _onRemoteStream;
  void Function(RTCPeerConnectionState state)? _onConnectionStateChanged;

  Future<void> initialize({
    required bool startWithVideo,
    required Future<void> Function(RTCSessionDescription description)
    onLocalDescription,
    required Future<void> Function(RTCIceCandidate candidate) onIceCandidate,
    required void Function() onRemoteStream,
    required void Function(RTCPeerConnectionState state)
    onConnectionStateChanged,
  }) async {
    await _ensureRenderers();

    _onLocalDescription = onLocalDescription;
    _onIceCandidate = onIceCandidate;
    _onRemoteStream = onRemoteStream;
    _onConnectionStateChanged = onConnectionStateChanged;

    await reset();
    await _openLocalMedia(startWithVideo: startWithVideo);
    await _createPeerConnection();
  }

  Future<void> _ensureRenderers() async {
    if (_renderersInitialized) {
      return;
    }

    await localRenderer.initialize();
    await remoteRenderer.initialize();
    _renderersInitialized = true;
  }

  Future<void> _openLocalMedia({required bool startWithVideo}) async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {'facingMode': 'user'},
    });

    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isNotEmpty) {
      videoTracks.first.enabled = startWithVideo;
    }

    localRenderer.srcObject = _localStream;
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(
      {
        'sdpSemantics': 'unified-plan',
        'iceServers': const [
          {'urls': 'stun:stun.l.google.com:19302'},
          {'urls': 'stun:stun1.l.google.com:19302'},
        ],
      },
      {
        'optional': const [
          {'DtlsSrtpKeyAgreement': true},
        ],
      },
    );

    _peerConnection!.onIceCandidate = (candidate) async {
      final candidateValue = candidate.candidate;
      if (candidateValue == null || candidateValue.isEmpty) {
        return;
      }

      await _onIceCandidate?.call(candidate);
    };

    _peerConnection!.onTrack = (event) {
      if (event.streams.isEmpty) {
        return;
      }

      _remoteStream = event.streams.first;
      remoteRenderer.srcObject = _remoteStream;
      _onRemoteStream?.call();
    };

    _peerConnection!.onConnectionState = (state) {
      _onConnectionStateChanged?.call(state);
    };

    final localStream = _localStream;
    if (localStream == null) {
      return;
    }

    for (final track in localStream.getTracks()) {
      await _peerConnection!.addTrack(track, localStream);
    }
  }

  Future<void> createOffer() async {
    final peerConnection = _peerConnection;
    if (peerConnection == null) {
      throw StateError('Peer connection is not ready.');
    }

    final offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);
    await _onLocalDescription?.call(offer);
  }

  Future<void> applyRemoteOffer({
    required String sdp,
    required String type,
  }) async {
    final peerConnection = _peerConnection;
    if (peerConnection == null) {
      throw StateError('Peer connection is not ready.');
    }

    final remoteOffer = RTCSessionDescription(sdp, type);
    await peerConnection.setRemoteDescription(remoteOffer);

    final answer = await peerConnection.createAnswer();
    await peerConnection.setLocalDescription(answer);
    await _onLocalDescription?.call(answer);
  }

  Future<void> applyRemoteAnswer({
    required String sdp,
    required String type,
  }) async {
    final peerConnection = _peerConnection;
    if (peerConnection == null) {
      throw StateError('Peer connection is not ready.');
    }

    final remoteAnswer = RTCSessionDescription(sdp, type);
    await peerConnection.setRemoteDescription(remoteAnswer);
  }

  Future<void> addIceCandidate({
    required String candidate,
    required String? sdpMid,
    required int? sdpMLineIndex,
  }) async {
    final peerConnection = _peerConnection;
    if (peerConnection == null) {
      return;
    }

    await peerConnection.addCandidate(
      RTCIceCandidate(candidate, sdpMid, sdpMLineIndex),
    );
  }

  Future<bool> toggleMicrophone() async {
    final audioTracks = _localStream?.getAudioTracks() ?? [];
    if (audioTracks.isEmpty) {
      return false;
    }

    final nextEnabled = !audioTracks.first.enabled;
    for (final track in audioTracks) {
      track.enabled = nextEnabled;
    }

    return nextEnabled;
  }

  Future<bool> toggleCamera() async {
    final videoTracks = _localStream?.getVideoTracks() ?? [];
    if (videoTracks.isEmpty) {
      return false;
    }

    final nextEnabled = !videoTracks.first.enabled;
    for (final track in videoTracks) {
      track.enabled = nextEnabled;
    }

    return nextEnabled;
  }

  Future<void> clearRemoteStream() async {
    remoteRenderer.srcObject = null;
    await _remoteStream?.dispose();
    _remoteStream = null;
  }

  Future<void> reset() async {
    await _peerConnection?.close();
    _peerConnection = null;

    await clearRemoteStream();

    final localStream = _localStream;
    if (localStream != null) {
      for (final track in localStream.getTracks()) {
        track.stop();
      }
      await localStream.dispose();
    }

    _localStream = null;
    localRenderer.srcObject = null;
  }

  Future<void> dispose() async {
    await reset();

    if (_renderersInitialized) {
      await localRenderer.dispose();
      await remoteRenderer.dispose();
      _renderersInitialized = false;
    }
  }
}
