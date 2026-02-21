// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WsJoinEventImpl _$$WsJoinEventImplFromJson(Map<String, dynamic> json) =>
    _$WsJoinEventImpl(
      room: json['room'] as String,
      user: json['user'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WsJoinEventImplToJson(_$WsJoinEventImpl instance) =>
    <String, dynamic>{
      'room': instance.room,
      'user': instance.user,
      'runtimeType': instance.$type,
    };

_$WsLeaveEventImpl _$$WsLeaveEventImplFromJson(Map<String, dynamic> json) =>
    _$WsLeaveEventImpl(
      room: json['room'] as String,
      user: json['user'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WsLeaveEventImplToJson(_$WsLeaveEventImpl instance) =>
    <String, dynamic>{
      'room': instance.room,
      'user': instance.user,
      'runtimeType': instance.$type,
    };

_$WsMessageEventImpl _$$WsMessageEventImplFromJson(Map<String, dynamic> json) =>
    _$WsMessageEventImpl(
      room: json['room'] as String,
      user: json['user'] as String,
      content: json['content'] as String,
      timestamp: json['timestamp'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WsMessageEventImplToJson(
  _$WsMessageEventImpl instance,
) => <String, dynamic>{
  'room': instance.room,
  'user': instance.user,
  'content': instance.content,
  'timestamp': instance.timestamp,
  'runtimeType': instance.$type,
};

_$WsTypingEventImpl _$$WsTypingEventImplFromJson(Map<String, dynamic> json) =>
    _$WsTypingEventImpl(
      room: json['room'] as String,
      user: json['user'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WsTypingEventImplToJson(_$WsTypingEventImpl instance) =>
    <String, dynamic>{
      'room': instance.room,
      'user': instance.user,
      'runtimeType': instance.$type,
    };

_$WsPresenceEventImpl _$$WsPresenceEventImplFromJson(
  Map<String, dynamic> json,
) => _$WsPresenceEventImpl(
  room: json['room'] as String,
  users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$WsPresenceEventImplToJson(
  _$WsPresenceEventImpl instance,
) => <String, dynamic>{
  'room': instance.room,
  'users': instance.users,
  'runtimeType': instance.$type,
};

_$WsRoomListEventImpl _$$WsRoomListEventImplFromJson(
  Map<String, dynamic> json,
) => _$WsRoomListEventImpl(
  rooms: (json['rooms'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$WsRoomListEventImplToJson(
  _$WsRoomListEventImpl instance,
) => <String, dynamic>{'rooms': instance.rooms, 'runtimeType': instance.$type};

_$WsErrorEventImpl _$$WsErrorEventImplFromJson(Map<String, dynamic> json) =>
    _$WsErrorEventImpl(
      content: json['content'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WsErrorEventImplToJson(_$WsErrorEventImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'runtimeType': instance.$type,
    };
