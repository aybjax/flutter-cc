// =============================================================================
// Product Model - @freezed immutable product data class
// =============================================================================
// Demonstrates: freezed code generation, JSON serialization, immutable models
// Alternative: Manual implementation with copyWith (more boilerplate)
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

// ---------------------------------------------------------------------------
// Product categories as an enum for type safety
// ---------------------------------------------------------------------------

/// Available product categories for filtering.
enum ProductCategory {
  electronics,
  clothing,
  books,
  home,
  sports,
}

// ---------------------------------------------------------------------------
// Product model
// ---------------------------------------------------------------------------

/// Immutable product model using freezed for code generation.
///
/// Each product has a unique [id], [name], [price], [category],
/// [description], and an [imageUrl] placeholder.
@freezed
abstract class Product with _$Product {
  /// Creates a new [Product] instance.
  const factory Product({
    required String id,
    required String name,
    required double price,
    required ProductCategory category,
    required String description,
    required String imageUrl,
  }) = _Product;

  /// Creates a [Product] from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

// Alternative: You could use a sealed class hierarchy instead of freezed:
// sealed class Product {
//   final String id;
//   final String name;
//   ...
//   const Product({required this.id, required this.name, ...});
// }
