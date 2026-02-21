// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: $enumDecode(_$ProductCategoryEnumMap, json['category']),
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'category': _$ProductCategoryEnumMap[instance.category]!,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };

const _$ProductCategoryEnumMap = {
  ProductCategory.electronics: 'electronics',
  ProductCategory.clothing: 'clothing',
  ProductCategory.books: 'books',
  ProductCategory.home: 'home',
  ProductCategory.sports: 'sports',
};
