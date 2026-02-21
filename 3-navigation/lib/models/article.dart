// ignore_for_file: invalid_annotation_target

// =============================================================================
// Article Model — Freezed + JSON Serializable
// =============================================================================
// Concepts demonstrated:
// - @freezed annotation — generates immutable data class
// - @JsonSerializable integration — fromJson/toJson via generated code
// - @JsonKey — customizes JSON field names
// - @Default — provides default values for optional fields
// - part directive — connects this file to generated *.freezed.dart and *.g.dart
// - copyWith — creates a modified copy of an immutable object
// - == and hashCode — generated for value equality
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';

// -- Part directives --
// These tell Dart that generated code lives in sibling files.
// `part 'article.freezed.dart'` — contains copyWith, ==, hashCode, toString
// `part 'article.g.dart'`       — contains _$ArticleFromJson, _$ArticleToJson
part 'article.freezed.dart';
part 'article.g.dart';

// =============================================================================
// The @freezed Annotation
// =============================================================================
// When you annotate a class with @freezed and run build_runner, it generates:
//   1. A private implementing class
//   2. copyWith() method for creating modified copies
//   3. == operator and hashCode for deep value equality
//   4. toString() for readable debug output
//   5. fromJson/toJson when you add the factory
//
// Why use freezed for a news article?
// - Articles fetched from an API should not be mutated
// - Value equality makes list diffing efficient
// - copyWith is handy for bookmarking (changing one field)

/// A single news article in the reader app.
///
/// Immutable by design — use [copyWith] to create modified versions:
/// ```dart
/// final bookmarked = article.copyWith(isBookmarked: true);
/// ```
@freezed
abstract class Article with _$Article {
  /// Creates an [Article] with all required and optional fields.
  const factory Article({
    /// Unique identifier for this article.
    required String id,

    /// Article headline/title.
    required String title,

    /// Brief summary shown in list views.
    required String summary,

    /// Full article body text.
    required String body,

    /// The category this article belongs to.
    ///
    /// Stored as the enum name in JSON (e.g., "tech", "sports").
    required NewsCategory category,

    /// Author name.
    required String author,

    /// Publication date.
    required DateTime publishedAt,

    /// URL to the article's header image.
    @JsonKey(name: 'image_url') String? imageUrl,

    /// Whether the user has bookmarked this article.
    @Default(false) bool isBookmarked,

    /// Estimated reading time in minutes.
    @JsonKey(name: 'read_time_minutes') @Default(5) int readTimeMinutes,
  }) = _Article;

  // ---------------------------------------------------------------------------
  // JSON serialization
  // ---------------------------------------------------------------------------
  // Connects to the generated _$ArticleFromJson function in article.g.dart.

  /// Deserializes an [Article] from a JSON map.
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
