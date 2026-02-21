// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      body: json['body'] as String,
      category: $enumDecode(_$NewsCategoryEnumMap, json['category']),
      author: json['author'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      imageUrl: json['image_url'] as String?,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      readTimeMinutes: (json['read_time_minutes'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'body': instance.body,
      'category': _$NewsCategoryEnumMap[instance.category]!,
      'author': instance.author,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'image_url': instance.imageUrl,
      'isBookmarked': instance.isBookmarked,
      'read_time_minutes': instance.readTimeMinutes,
    };

const _$NewsCategoryEnumMap = {
  NewsCategory.tech: 'tech',
  NewsCategory.sports: 'sports',
  NewsCategory.science: 'science',
  NewsCategory.health: 'health',
  NewsCategory.business: 'business',
  NewsCategory.entertainment: 'entertainment',
};
