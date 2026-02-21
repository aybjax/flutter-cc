// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  /// Unique identifier for this article.
  String get id => throw _privateConstructorUsedError;

  /// Article headline/title.
  String get title => throw _privateConstructorUsedError;

  /// Brief summary shown in list views.
  String get summary => throw _privateConstructorUsedError;

  /// Full article body text.
  String get body => throw _privateConstructorUsedError;

  /// The category this article belongs to.
  ///
  /// Stored as the enum name in JSON (e.g., "tech", "sports").
  NewsCategory get category => throw _privateConstructorUsedError;

  /// Author name.
  String get author => throw _privateConstructorUsedError;

  /// Publication date.
  DateTime get publishedAt => throw _privateConstructorUsedError;

  /// URL to the article's header image.
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Whether the user has bookmarked this article.
  bool get isBookmarked => throw _privateConstructorUsedError;

  /// Estimated reading time in minutes.
  @JsonKey(name: 'read_time_minutes')
  int get readTimeMinutes => throw _privateConstructorUsedError;

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call({
    String id,
    String title,
    String summary,
    String body,
    NewsCategory category,
    String author,
    DateTime publishedAt,
    @JsonKey(name: 'image_url') String? imageUrl,
    bool isBookmarked,
    @JsonKey(name: 'read_time_minutes') int readTimeMinutes,
  });
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? summary = null,
    Object? body = null,
    Object? category = null,
    Object? author = null,
    Object? publishedAt = null,
    Object? imageUrl = freezed,
    Object? isBookmarked = null,
    Object? readTimeMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as NewsCategory,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String,
            publishedAt: null == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBookmarked: null == isBookmarked
                ? _value.isBookmarked
                : isBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            readTimeMinutes: null == readTimeMinutes
                ? _value.readTimeMinutes
                : readTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
    _$ArticleImpl value,
    $Res Function(_$ArticleImpl) then,
  ) = __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String summary,
    String body,
    NewsCategory category,
    String author,
    DateTime publishedAt,
    @JsonKey(name: 'image_url') String? imageUrl,
    bool isBookmarked,
    @JsonKey(name: 'read_time_minutes') int readTimeMinutes,
  });
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
    _$ArticleImpl _value,
    $Res Function(_$ArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? summary = null,
    Object? body = null,
    Object? category = null,
    Object? author = null,
    Object? publishedAt = null,
    Object? imageUrl = freezed,
    Object? isBookmarked = null,
    Object? readTimeMinutes = null,
  }) {
    return _then(
      _$ArticleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as NewsCategory,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String,
        publishedAt: null == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBookmarked: null == isBookmarked
            ? _value.isBookmarked
            : isBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        readTimeMinutes: null == readTimeMinutes
            ? _value.readTimeMinutes
            : readTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleImpl implements _Article {
  const _$ArticleImpl({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
    required this.category,
    required this.author,
    required this.publishedAt,
    @JsonKey(name: 'image_url') this.imageUrl,
    this.isBookmarked = false,
    @JsonKey(name: 'read_time_minutes') this.readTimeMinutes = 5,
  });

  factory _$ArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleImplFromJson(json);

  /// Unique identifier for this article.
  @override
  final String id;

  /// Article headline/title.
  @override
  final String title;

  /// Brief summary shown in list views.
  @override
  final String summary;

  /// Full article body text.
  @override
  final String body;

  /// The category this article belongs to.
  ///
  /// Stored as the enum name in JSON (e.g., "tech", "sports").
  @override
  final NewsCategory category;

  /// Author name.
  @override
  final String author;

  /// Publication date.
  @override
  final DateTime publishedAt;

  /// URL to the article's header image.
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// Whether the user has bookmarked this article.
  @override
  @JsonKey()
  final bool isBookmarked;

  /// Estimated reading time in minutes.
  @override
  @JsonKey(name: 'read_time_minutes')
  final int readTimeMinutes;

  @override
  String toString() {
    return 'Article(id: $id, title: $title, summary: $summary, body: $body, category: $category, author: $author, publishedAt: $publishedAt, imageUrl: $imageUrl, isBookmarked: $isBookmarked, readTimeMinutes: $readTimeMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.readTimeMinutes, readTimeMinutes) ||
                other.readTimeMinutes == readTimeMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    summary,
    body,
    category,
    author,
    publishedAt,
    imageUrl,
    isBookmarked,
    readTimeMinutes,
  );

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleImplToJson(this);
  }
}

abstract class _Article implements Article {
  const factory _Article({
    required final String id,
    required final String title,
    required final String summary,
    required final String body,
    required final NewsCategory category,
    required final String author,
    required final DateTime publishedAt,
    @JsonKey(name: 'image_url') final String? imageUrl,
    final bool isBookmarked,
    @JsonKey(name: 'read_time_minutes') final int readTimeMinutes,
  }) = _$ArticleImpl;

  factory _Article.fromJson(Map<String, dynamic> json) = _$ArticleImpl.fromJson;

  /// Unique identifier for this article.
  @override
  String get id;

  /// Article headline/title.
  @override
  String get title;

  /// Brief summary shown in list views.
  @override
  String get summary;

  /// Full article body text.
  @override
  String get body;

  /// The category this article belongs to.
  ///
  /// Stored as the enum name in JSON (e.g., "tech", "sports").
  @override
  NewsCategory get category;

  /// Author name.
  @override
  String get author;

  /// Publication date.
  @override
  DateTime get publishedAt;

  /// URL to the article's header image.
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Whether the user has bookmarked this article.
  @override
  bool get isBookmarked;

  /// Estimated reading time in minutes.
  @override
  @JsonKey(name: 'read_time_minutes')
  int get readTimeMinutes;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
