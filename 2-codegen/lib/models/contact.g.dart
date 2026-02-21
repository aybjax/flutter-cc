// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactImpl _$$ContactImplFromJson(Map<String, dynamic> json) =>
    _$ContactImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone_number'] as String?,
      notes: json['notes'] as String?,
      category:
          $enumDecodeNullable(_$ContactCategoryEnumMap, json['category']) ??
          ContactCategory.other,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ContactImplToJson(_$ContactImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phone,
      'notes': instance.notes,
      'category': _$ContactCategoryEnumMap[instance.category]!,
      'isFavorite': instance.isFavorite,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ContactCategoryEnumMap = {
  ContactCategory.family: 'family',
  ContactCategory.friend: 'friend',
  ContactCategory.work: 'work',
  ContactCategory.other: 'other',
};
