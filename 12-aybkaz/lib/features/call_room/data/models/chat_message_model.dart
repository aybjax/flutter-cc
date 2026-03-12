import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_message_entity.dart';
import '../dtos/signaling_message_dto.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
abstract class ChatMessageModel with _$ChatMessageModel {
  const ChatMessageModel._();

  const factory ChatMessageModel({
    required String id,
    required String text,
    required String senderName,
    @Default(false) bool isLocal,
    required DateTime sentAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      text: entity.text,
      senderName: entity.senderName,
      isLocal: entity.isLocal,
      sentAt: entity.sentAt,
    );
  }

  factory ChatMessageModel.fromSignal(SignalingMessageDto dto) {
    return ChatMessageModel(
      id:
          dto.id ??
          '${dto.from ?? 'remote'}-${DateTime.now().millisecondsSinceEpoch}',
      text: dto.text ?? '',
      senderName: dto.senderName ?? 'Peer',
      isLocal: false,
      sentAt: dto.sentAt ?? DateTime.now(),
    );
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id,
      text: text,
      senderName: senderName,
      isLocal: isLocal,
      sentAt: sentAt,
    );
  }
}
