// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskCardImpl _$$TaskCardImplFromJson(Map<String, dynamic> json) =>
    _$TaskCardImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      columnId: json['columnId'] as String,
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$$TaskCardImplToJson(_$TaskCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'columnId': instance.columnId,
      'position': instance.position,
    };
