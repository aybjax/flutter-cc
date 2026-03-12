import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/call_session_entity.dart';
import '../models/chat_message_model.dart';

part 'call_session_model.freezed.dart';

@freezed
abstract class CallSessionModel with _$CallSessionModel {
  const CallSessionModel._();

  const factory CallSessionModel({
    @Default(CallConnectionStatus.idle) CallConnectionStatus status,
    String? localPeerId,
    String? remotePeerId,
    String? localDisplayName,
    String? remoteDisplayName,
    @Default(true) bool localAudioEnabled,
    @Default(true) bool localVideoEnabled,
    @Default(<ChatMessageModel>[]) List<ChatMessageModel> chatMessages,
    String? statusMessage,
  }) = _CallSessionModel;

  factory CallSessionModel.initial({
    required String localDisplayName,
    required bool startWithVideo,
  }) {
    return CallSessionModel(
      localDisplayName: localDisplayName,
      localAudioEnabled: true,
      localVideoEnabled: startWithVideo,
    );
  }

  CallSessionEntity toEntity() {
    return CallSessionEntity(
      status: status,
      localPeerId: localPeerId,
      remotePeerId: remotePeerId,
      localDisplayName: localDisplayName,
      remoteDisplayName: remoteDisplayName,
      localAudioEnabled: localAudioEnabled,
      localVideoEnabled: localVideoEnabled,
      chatMessages: chatMessages.map((message) => message.toEntity()).toList(),
      statusMessage: statusMessage,
    );
  }
}
