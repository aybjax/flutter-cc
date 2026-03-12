import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_message_entity.dart';

part 'call_session_entity.freezed.dart';

enum CallConnectionStatus {
  idle,
  connecting,
  waitingPeer,
  negotiating,
  inCall,
  disconnected,
  roomFull,
  failure,
}

@freezed
abstract class CallSessionEntity with _$CallSessionEntity {
  const factory CallSessionEntity({
    @Default(CallConnectionStatus.idle) CallConnectionStatus status,
    String? localPeerId,
    String? remotePeerId,
    String? localDisplayName,
    String? remoteDisplayName,
    @Default(true) bool localAudioEnabled,
    @Default(true) bool localVideoEnabled,
    @Default(<ChatMessageEntity>[]) List<ChatMessageEntity> chatMessages,
    String? statusMessage,
  }) = _CallSessionEntity;
}
