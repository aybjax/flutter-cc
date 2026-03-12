import 'package:freezed_annotation/freezed_annotation.dart';

part 'signaling_message_dto.freezed.dart';
part 'signaling_message_dto.g.dart';

@freezed
abstract class SignalingMessageDto with _$SignalingMessageDto {
  const factory SignalingMessageDto({
    required String type,
    String? id,
    String? from,
    String? to,
    String? sdp,
    String? candidate,
    String? sdpMid,
    int? sdpMLineIndex,
    String? senderName,
    String? text,
    DateTime? sentAt,
    List<String>? peers,
    String? message,
  }) = _SignalingMessageDto;

  factory SignalingMessageDto.fromJson(Map<String, dynamic> json) =>
      _$SignalingMessageDtoFromJson(json);
}
