// =============================================================================
// Article Failure — Freezed Union Types
// =============================================================================
// Concepts demonstrated:
// - Freezed union types (sealed classes) for exhaustive error handling
// - Multiple factory constructors — each is a distinct failure variant
// - when() / map() for pattern matching on union variants
// - How to combine with dartz Either<Failure, Success>
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_failure.freezed.dart';

// =============================================================================
// Union Types with Freezed
// =============================================================================
// A "union type" lets you represent all the ways an operation can fail.
// Each variant can carry different data, and pattern matching with when()
// forces you to handle every case — no forgotten error paths.

/// Represents all the ways an article operation can fail.
///
/// Usage with dartz:
/// ```dart
/// Either<ArticleFailure, List<Article>> result = fetchArticles();
/// result.fold(
///   (failure) => failure.when(
///     notFound: (id) => 'Article $id not found',
///     networkError: (message) => 'Network: $message',
///     unexpected: (error) => 'Unexpected: $error',
///   ),
///   (articles) => 'Found ${articles.length} articles',
/// );
/// ```
@freezed
sealed class ArticleFailure with _$ArticleFailure {
  /// The requested article ID was not found.
  const factory ArticleFailure.notFound({required String id}) = _NotFound;

  /// A network request failed.
  const factory ArticleFailure.networkError({required String message}) =
      _NetworkError;

  /// A catch-all for unexpected errors.
  const factory ArticleFailure.unexpected({required Object error}) =
      _Unexpected;
}

// =============================================================================
// Pattern Matching with when() and map()
// =============================================================================
//
// Freezed generates two pattern-matching methods:
//
// 1. when() — destructures the FIELDS of each variant:
//    failure.when(
//      notFound: (id) => 'Not found: $id',
//      networkError: (message) => 'Network: $message',
//      unexpected: (error) => 'Error: $error',
//    );
//
// 2. maybeWhen() — same but with an orElse fallback:
//    failure.maybeWhen(
//      notFound: (id) => 'Not found: $id',
//      orElse: () => 'Something went wrong',
//    );
//
// Both are EXHAUSTIVE — adding a new variant forces handling everywhere.
