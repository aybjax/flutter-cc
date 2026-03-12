// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    _ChatMessageModel(
      id: json['id'] as String,
      text: json['text'] as String,
      senderName: json['senderName'] as String,
      isLocal: json['isLocal'] as bool? ?? false,
      sentAt: DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$ChatMessageModelToJson(_ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'senderName': instance.senderName,
      'isLocal': instance.isLocal,
      'sentAt': instance.sentAt.toIso8601String(),
    };
