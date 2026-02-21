// =============================================================================
// Product Repository - Data access layer for products
// =============================================================================
// Abstracts data source from BLoCs. Uses dartz Either for error handling.
// In production, this would call a real API via the http package.
// =============================================================================

import 'package:dartz/dartz.dart';
import 'package:state_bloc_tutorial/data/mock_products.dart';
import 'package:state_bloc_tutorial/models/models.dart';

// ---------------------------------------------------------------------------
// ProductRepository
// ---------------------------------------------------------------------------

/// Repository that provides product data to BLoCs.
///
/// Uses [Either] from dartz for functional error handling:
/// - Left side: [ProductFailure] (typed error)
/// - Right side: Success value
///
/// This decouples data access from business logic, making BLoCs
/// easier to test by injecting a mock repository.
class ProductRepository {
  /// Simulated network delay duration.
  ///
  /// Set to a short duration for snappy UI; increase for testing
  /// loading states.
  static const _simulatedDelay = Duration(milliseconds: 500);

  // ---------------------------------------------------------------------------
  // Fetch all products
  // ---------------------------------------------------------------------------

  /// Fetches the complete product catalog.
  ///
  /// Returns [Right] with the list of products on success,
  /// or [Left] with a [ProductFailure] on error.
  Future<Either<ProductFailure, List<Product>>> getProducts() async {
    try {
      // Simulate network delay
      await Future<void>.delayed(_simulatedDelay);

      // In production: final response = await http.get(Uri.parse('...'));
      return Right(List.unmodifiable(mockProducts));
    } catch (e) {
      return Left(ProductFailure.unexpected(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Fetch single product
  // ---------------------------------------------------------------------------

  /// Fetches a single product by its [id].
  ///
  /// Returns [Right] with the product if found, or [Left] with
  /// [ProductFailure.notFound] if no product matches the given id.
  Future<Either<ProductFailure, Product>> getProductById(String id) async {
    try {
      await Future<void>.delayed(_simulatedDelay);

      final product = mockProducts.where((p) => p.id == id).firstOrNull;

      if (product == null) {
        return Left(ProductFailure.notFound(id));
      }

      return Right(product);
    } catch (e) {
      return Left(ProductFailure.unexpected(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Search products
  // ---------------------------------------------------------------------------

  /// Searches products by [query] string.
  ///
  /// Matches against product name and description (case-insensitive).
  /// Optionally filters by [category].
  Future<Either<ProductFailure, List<Product>>> searchProducts({
    required String query,
    ProductCategory? category,
  }) async {
    try {
      await Future<void>.delayed(_simulatedDelay);

      final lowerQuery = query.toLowerCase();

      var results = mockProducts.where((product) {
        // Match against name or description
        final matchesQuery = product.name.toLowerCase().contains(lowerQuery) ||
            product.description.toLowerCase().contains(lowerQuery);

        // Optionally filter by category
        final matchesCategory =
            category == null || product.category == category;

        return matchesQuery && matchesCategory;
      }).toList();

      return Right(results);
    } catch (e) {
      return Left(ProductFailure.unexpected(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Get products by category
  // ---------------------------------------------------------------------------

  /// Fetches products filtered by [category].
  Future<Either<ProductFailure, List<Product>>> getProductsByCategory(
    ProductCategory category,
  ) async {
    try {
      await Future<void>.delayed(_simulatedDelay);

      final results =
          mockProducts.where((p) => p.category == category).toList();

      return Right(results);
    } catch (e) {
      return Left(ProductFailure.unexpected(e.toString()));
    }
  }
}

// Alternative: You could define an abstract interface for the repository:
// abstract class ProductRepositoryInterface {
//   Future<Either<ProductFailure, List<Product>>> getProducts();
//   Future<Either<ProductFailure, Product>> getProductById(String id);
//   ...
// }
// class ProductRepository implements ProductRepositoryInterface { ... }
// This enables easier mocking in tests.
