import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entities/call_session_entity.dart';
import '../../domain/repositories/call_room_repository.dart';
import '../../domain/params/join_call_params.dart';
import '../../domain/params/send_chat_message_params.dart';
import '../datasources/call_room_signaling_datasource.dart';
import '../datasources/webrtc_datasource.dart';
import '../dtos/signaling_message_dto.dart';
import '../models/call_session_model.dart';
import '../models/chat_message_model.dart';

class CallRoomRepositoryImpl implements CallRoomRepository {
  CallRoomRepositoryImpl({
    required CallRoomSignalingDataSource signalingDataSource,
    required WebRtcDataSource webRtcDataSource,
  }) : _signalingDataSource = signalingDataSource,
       _webRtcDataSource = webRtcDataSource;

  final CallRoomSignalingDataSource _signalingDataSource;
  final WebRtcDataSource _webRtcDataSource;
  final StreamController<CallSessionEntity> _sessionController =
      StreamController<CallSessionEntity>.broadcast();

  StreamSubscription<SignalingMessageDto>? _signalingSubscription;
  CallSessionModel _session = CallSessionModel.initial(
    localDisplayName: 'Guest',
    startWithVideo: true,
  );

  @override
  Stream<CallSessionEntity> watchSession() async* {
    yield _session.toEntity();
    yield* _sessionController.stream;
  }

  @override
  Future<Either<AppFailure, Unit>> join(JoinCallParams params) async {
    try {
      await leave();

      _session = CallSessionModel.initial(
        localDisplayName: params.displayName,
        startWithVideo: params.startWithVideo,
      ).copyWith(status: CallConnectionStatus.connecting);
      _emit();

      _signalingSubscription = _signalingDataSource.messages.listen(
        _handleSignalingMessage,
        onError: (Object error, StackTrace stackTrace) {
          _session = _session.copyWith(
            status: CallConnectionStatus.failure,
            statusMessage: 'Signaling error: $error',
          );
          _emit();
        },
      );

      await _webRtcDataSource.initialize(
        startWithVideo: params.startWithVideo,
        onLocalDescription: _sendLocalDescription,
        onIceCandidate: _sendIceCandidate,
        onRemoteStream: _handleRemoteStream,
        onConnectionStateChanged: _handlePeerConnectionState,
      );

      await _signalingDataSource.connect(params.signalingUrl);

      _session = _session.copyWith(
        status: CallConnectionStatus.waitingPeer,
        statusMessage: null,
      );
      _emit();

      return right(unit);
    } catch (error) {
      return left(
        AppFailure.webrtc(message: 'Unable to join the call: $error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, Unit>> leave() async {
    try {
      await _signalingSubscription?.cancel();
      _signalingSubscription = null;
      await _signalingDataSource.disconnect();
      await _webRtcDataSource.reset();

      _session = CallSessionModel.initial(
        localDisplayName: _session.localDisplayName ?? 'Guest',
        startWithVideo: true,
      );
      _emit();

      return right(unit);
    } catch (error) {
      return left(
        AppFailure.unknown(message: 'Unable to leave the call: $error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, Unit>> sendChatMessage(
    SendChatMessageParams params,
  ) async {
    final trimmedText = params.text.trim();
    if (trimmedText.isEmpty) {
      return left(
        const AppFailure.validation(message: 'Message cannot be empty.'),
      );
    }

    try {
      final message = ChatMessageModel(
        id: 'local-${DateTime.now().microsecondsSinceEpoch}-${trimmedText.length}',
        text: trimmedText,
        senderName: _session.localDisplayName ?? 'Me',
        isLocal: true,
        sentAt: DateTime.now(),
      );

      _appendChatMessage(message);

      await _signalingDataSource.send(
        SignalingMessageDto(
          type: 'chat',
          id: message.id,
          to: _session.remotePeerId,
          senderName: message.senderName,
          text: message.text,
          sentAt: message.sentAt,
        ),
      );

      return right(unit);
    } catch (error) {
      return left(
        AppFailure.network(message: 'Unable to send message: $error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, bool>> toggleMicrophone() async {
    try {
      final isEnabled = await _webRtcDataSource.toggleMicrophone();
      _session = _session.copyWith(localAudioEnabled: isEnabled);
      _emit();
      return right(isEnabled);
    } catch (error) {
      return left(
        AppFailure.webrtc(message: 'Unable to toggle microphone: $error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, bool>> toggleCamera() async {
    try {
      final isEnabled = await _webRtcDataSource.toggleCamera();
      _session = _session.copyWith(localVideoEnabled: isEnabled);
      _emit();
      return right(isEnabled);
    } catch (error) {
      return left(
        AppFailure.webrtc(message: 'Unable to toggle camera: $error'),
      );
    }
  }

  Future<void> _handleSignalingMessage(SignalingMessageDto message) async {
    switch (message.type) {
      case 'init':
        _session = _session.copyWith(
          localPeerId: message.id,
          remotePeerId: message.peers?.isNotEmpty == true
              ? message.peers!.first
              : _session.remotePeerId,
        );
        _emit();
        break;
      case 'id':
        _session = _session.copyWith(localPeerId: message.id);
        _emit();
        break;
      case 'peer-joined':
        if (message.id == _session.localPeerId) {
          return;
        }

        _session = _session.copyWith(
          remotePeerId: message.id ?? _session.remotePeerId,
          status: CallConnectionStatus.negotiating,
          statusMessage: null,
        );
        _emit();
        await _webRtcDataSource.createOffer();
        break;
      case 'offer':
        _session = _session.copyWith(
          remotePeerId: message.from ?? message.id ?? _session.remotePeerId,
          remoteDisplayName: message.senderName ?? _session.remoteDisplayName,
          status: CallConnectionStatus.negotiating,
        );
        _emit();

        if (message.sdp != null) {
          await _webRtcDataSource.applyRemoteOffer(
            sdp: message.sdp!,
            type: message.type,
          );
        }
        break;
      case 'answer':
        _session = _session.copyWith(
          remotePeerId: message.from ?? _session.remotePeerId,
          remoteDisplayName: message.senderName ?? _session.remoteDisplayName,
          status: CallConnectionStatus.negotiating,
        );
        _emit();

        if (message.sdp != null) {
          await _webRtcDataSource.applyRemoteAnswer(
            sdp: message.sdp!,
            type: message.type,
          );
        }
        break;
      case 'candidate':
        if (message.candidate != null) {
          await _webRtcDataSource.addIceCandidate(
            candidate: message.candidate!,
            sdpMid: message.sdpMid,
            sdpMLineIndex: message.sdpMLineIndex,
          );
        }
        break;
      case 'chat':
        _session = _session.copyWith(
          remoteDisplayName: message.senderName ?? _session.remoteDisplayName,
        );
        _appendChatMessage(ChatMessageModel.fromSignal(message));
        break;
      case 'peer-left':
        await _webRtcDataSource.clearRemoteStream();
        _session = _session.copyWith(
          remotePeerId: null,
          remoteDisplayName: null,
          status: CallConnectionStatus.waitingPeer,
          statusMessage: 'Peer disconnected.',
        );
        _emit();
        break;
      case 'full':
        _session = _session.copyWith(
          status: CallConnectionStatus.roomFull,
          statusMessage: message.message ?? 'Room is full.',
        );
        _emit();
        break;
      case 'socket-closed':
        _session = _session.copyWith(
          status: CallConnectionStatus.disconnected,
          statusMessage: 'Signaling connection closed.',
        );
        _emit();
        break;
    }
  }

  Future<void> _sendLocalDescription(RTCSessionDescription description) async {
    await _signalingDataSource.send(
      SignalingMessageDto(
        type: description.type ?? 'offer',
        sdp: description.sdp,
        to: _session.remotePeerId,
        senderName: _session.localDisplayName,
      ),
    );
  }

  Future<void> _sendIceCandidate(RTCIceCandidate candidate) async {
    await _signalingDataSource.send(
      SignalingMessageDto(
        type: 'candidate',
        to: _session.remotePeerId,
        candidate: candidate.candidate,
        sdpMid: candidate.sdpMid,
        sdpMLineIndex: candidate.sdpMLineIndex,
        senderName: _session.localDisplayName,
      ),
    );
  }

  void _handleRemoteStream() {
    _session = _session.copyWith(
      status: CallConnectionStatus.inCall,
      statusMessage: null,
    );
    _emit();
  }

  void _handlePeerConnectionState(RTCPeerConnectionState state) {
    switch (state) {
      case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
        _session = _session.copyWith(
          status: CallConnectionStatus.inCall,
          statusMessage: null,
        );
        break;
      case RTCPeerConnectionState.RTCPeerConnectionStateConnecting:
        _session = _session.copyWith(status: CallConnectionStatus.negotiating);
        break;
      case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
      case RTCPeerConnectionState.RTCPeerConnectionStateFailed:
        _session = _session.copyWith(
          status: CallConnectionStatus.disconnected,
          statusMessage: 'Peer connection lost.',
        );
        break;
      case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
        _session = _session.copyWith(status: CallConnectionStatus.waitingPeer);
        break;
      case RTCPeerConnectionState.RTCPeerConnectionStateNew:
        break;
    }

    _emit();
  }

  void _appendChatMessage(ChatMessageModel message) {
    final updatedMessages = List<ChatMessageModel>.from(_session.chatMessages)
      ..add(message);

    _session = _session.copyWith(chatMessages: updatedMessages);
    _emit();
  }

  void _emit() {
    if (_sessionController.isClosed) {
      return;
    }

    _sessionController.add(_session.toEntity());
  }
}
