// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoSummaryImpl _$$TodoSummaryImplFromJson(Map<String, dynamic> json) =>
    _$TodoSummaryImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      checked: json['checked'] as bool? ?? false,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$$TodoSummaryImplToJson(_$TodoSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'checked': instance.checked,
      'thumbnail': instance.thumbnail,
    };

_$TodoDetailImpl _$$TodoDetailImplFromJson(Map<String, dynamic> json) =>
    _$TodoDetailImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      checked: json['checked'] as bool? ?? false,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$TodoDetailImplToJson(_$TodoDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'checked': instance.checked,
      'image': instance.image,
    };
