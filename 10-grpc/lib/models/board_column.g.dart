// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_column.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardColumnImpl _$$BoardColumnImplFromJson(Map<String, dynamic> json) =>
    _$BoardColumnImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      position: (json['position'] as num).toInt(),
      cards:
          (json['cards'] as List<dynamic>?)
              ?.map((e) => TaskCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BoardColumnImplToJson(_$BoardColumnImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'cards': instance.cards,
    };
