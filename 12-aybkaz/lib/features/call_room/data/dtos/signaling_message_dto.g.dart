// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signaling_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignalingMessageDto _$SignalingMessageDtoFromJson(Map<String, dynamic> json) =>
    _SignalingMessageDto(
      type: json['type'] as String,
      id: json['id'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      sdp: json['sdp'] as String?,
      candidate: json['candidate'] as String?,
      sdpMid: json['sdpMid'] as String?,
      sdpMLineIndex: (json['sdpMLineIndex'] as num?)?.toInt(),
      senderName: json['senderName'] as String?,
      text: json['text'] as String?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      peers: (json['peers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SignalingMessageDtoToJson(
  _SignalingMessageDto instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'from': instance.from,
  'to': instance.to,
  'sdp': instance.sdp,
  'candidate': instance.candidate,
  'sdpMid': instance.sdpMid,
  'sdpMLineIndex': instance.sdpMLineIndex,
  'senderName': instance.senderName,
  'text': instance.text,
  'sentAt': instance.sentAt?.toIso8601String(),
  'peers': instance.peers,
  'message': instance.message,
};
