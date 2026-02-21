// =============================================================================
// Category Model - Isar Collection
// =============================================================================
//
// This model demonstrates Isar's @collection annotation, indexes,
// and basic CRUD patterns. Isar excels at:
// - Type-safe query builders (no raw SQL strings)
// - Reactive streams with watchLazy()
// - Composite indexes for complex queries
//
// WHY Isar for categories?
// - Demonstrates a different storage approach from SQLite
// - Shows Isar's query builder pattern
// - watchLazy() for reactive UI updates
//
// NOTE on Links:
// Isar supports IsarLink and IsarLinks for relationships between
// collections. In Isar 3.x, links require careful setup and both
// collections must be registered together. For simplicity in this
// tutorial, we use a categoryId foreign key pattern instead, and
// demonstrate links conceptually in comments.
// =============================================================================

import 'package:isar/isar.dart';

// Isar requires a generated file for each collection
part 'category.g.dart';

// ---------------------------------------------------------------------------
// Category Collection
// ---------------------------------------------------------------------------

/// Represents an expense category stored in Isar.
///
/// Isar collections must:
/// 1. Have an `Id` field (auto-incremented by default)
/// 2. Be annotated with `@collection` (or `@Collection()`)
/// 3. Have a corresponding `.g.dart` part file
///
/// Unlike SQLite where you write raw SQL, Isar generates type-safe
/// query methods from your model definition.
@collection
class Category {
  /// Isar auto-incremented ID.
  ///
  /// Set to [Isar.autoIncrement] for new objects.
  /// Isar uses `Id` type which is just a typedef for `int`.
  Id id = Isar.autoIncrement;

  /// Display name of the category (e.g., "Food", "Transport")
  @Index()
  late String name;

  /// Icon code point from Material Icons
  ///
  /// Stored as int because Isar doesn't support IconData directly.
  /// Usage: Icon(IconData(iconCode, fontFamily: 'MaterialIcons'))
  late int iconCode;

  /// Color value as an integer (Color.value)
  ///
  /// Stored as int because Isar doesn't support Color directly.
  /// Usage: Color(colorValue)
  late int colorValue;

  // ---------------------------------------------------------------------------
  // Composite Index
  // ---------------------------------------------------------------------------

  /// Sort key used for composite index demo.
  ///
  /// Isar composite indexes allow multi-field sorting and filtering:
  /// ```dart
  /// isar.categorys.where()
  ///   .sortKeyColorValueEqualTo('Food', 0xFF4CAF50)
  ///   .findAll();
  /// ```
  ///
  /// Alternative: Use @Index(composite: [CompositeIndex('colorValue')])
  /// on the name field for the same effect.
  @Index(composite: [CompositeIndex('colorValue')])
  late String sortKey; // Duplicate of name, used for composite index demo

  // ---------------------------------------------------------------------------
  // Isar Links (conceptual reference)
  // ---------------------------------------------------------------------------
  //
  // In a full Isar setup, you would link categories to budgets:
  //
  //   final budgets = IsarLinks<Budget>();
  //
  // This creates a one-to-many relationship where:
  // - Each category can have multiple budgets
  // - Links are lazy-loaded: await category.budgets.load()
  // - IsarLink<T> for one-to-one, IsarLinks<T> for one-to-many
  //
  // For this tutorial, we use a simpler foreign key approach
  // in the Budget collection (Budget.categoryId).

  @override
  String toString() => 'Category(id: $id, name: $name)';
}

// ---------------------------------------------------------------------------
// Isar Query Examples (for reference)
// ---------------------------------------------------------------------------
//
// // Find all categories sorted by name
// final categories = await isar.categorys
//     .where()
//     .sortByName()
//     .findAll();
//
// // Find category by exact name
// final food = await isar.categorys
//     .where()
//     .nameEqualTo('Food')
//     .findFirst();
//
// // Watch for changes (reactive)
// isar.categorys.watchLazy().listen((_) {
//   // Reload categories when any change occurs
//   refreshCategories();
// });
//
// // Alternative: watch with object changes
// isar.categorys.watchObject(categoryId).listen((category) {
//   // React to specific object changes
// });
