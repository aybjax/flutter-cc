import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_entity.freezed.dart';

@freezed
abstract class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    required String id,
    required String text,
    required String senderName,
    @Default(false) bool isLocal,
    required DateTime sentAt,
  }) = _ChatMessageEntity;
}
