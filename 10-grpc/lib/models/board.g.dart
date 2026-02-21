// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  columns:
      (json['columns'] as List<dynamic>?)
          ?.map((e) => BoardColumn.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'columns': instance.columns,
    };
