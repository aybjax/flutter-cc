// =============================================================================
// Isar Helper - Database Initialization
// =============================================================================
//
// This file demonstrates Isar database setup and lifecycle management.
//
// Isar is a high-performance NoSQL database for Flutter that offers:
// - Type-safe query builders (no raw strings)
// - Automatic indexing and query optimization
// - ACID transactions
// - Reactive watchers (watchLazy, watchObject)
// - Links between collections (like foreign keys)
// - Full-text search support
// - Synchronous and asynchronous APIs
//
// Isar vs SQLite:
// - Isar: NoSQL, type-safe queries, better Dart integration
// - SQLite: SQL queries, more mature, broader community support
//
// NOTE: Isar 3.x requires native libraries. If running on a platform
// without Isar support, the app will fall back gracefully.
// =============================================================================

import 'package:flutter/foundation.dart' hide Category;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/category.dart';
import '../../models/budget.dart';

// ---------------------------------------------------------------------------
// Isar Helper
// ---------------------------------------------------------------------------

/// Manages Isar database initialization and lifecycle.
///
/// Isar instances are expensive to create, so we use a singleton pattern.
/// The instance is shared across the entire app.
///
/// Usage:
/// ```dart
/// await IsarHelper.instance.initialize();
/// final isar = IsarHelper.instance.isar;
/// final categories = await isar.categorys.where().findAll();
/// ```
class IsarHelper {
  IsarHelper._();

  /// Singleton instance
  static final IsarHelper instance = IsarHelper._();

  /// The Isar database instance
  Isar? _isar;

  /// Gets the Isar instance, throwing if not initialized.
  Isar get isar {
    final db = _isar;
    if (db == null) {
      throw StateError(
        'Isar not initialized. Call initialize() first.',
      );
    }
    return db;
  }

  /// Whether Isar has been initialized
  bool get isInitialized => _isar != null;

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  /// Initializes the Isar database with all collection schemas.
  ///
  /// Must be called before any Isar operations.
  /// Typically called in main() before runApp().
  ///
  /// Isar automatically handles:
  /// - Schema creation for new collections
  /// - Schema migration when collection definitions change
  /// - Index creation and maintenance
  Future<void> initialize() async {
    if (_isar != null) return;

    try {
      // Get the application documents directory for database storage
      final dir = await getApplicationDocumentsDirectory();

      _isar = await Isar.open(
        // List ALL collection schemas that this database manages
        // Order doesn't matter -- Isar handles dependencies
        [CategorySchema, BudgetSchema],
        directory: dir.path,
        // Name allows multiple Isar instances (e.g., per user)
        name: 'finance_tracker',
        // Inspector enables the Isar Inspector tool in debug mode
        inspector: kDebugMode,
      );

      if (kDebugMode) {
        print('[IsarHelper] Database opened at ${dir.path}');
      }

      // Seed default categories if this is a fresh database
      await _seedDefaultCategories();
    } catch (e) {
      if (kDebugMode) {
        print('[IsarHelper] Failed to initialize Isar: $e');
        print('[IsarHelper] Isar features will be unavailable.');
        print('[IsarHelper] This may happen if Isar native libraries '
            'are not available for this platform.');
      }
      // Don't rethrow -- allow the app to function without Isar
      // The UI will show appropriate fallback states
    }
  }

  // ---------------------------------------------------------------------------
  // Seed Data
  // ---------------------------------------------------------------------------

  /// Seeds default categories if the database is empty.
  ///
  /// This runs inside a write transaction for atomicity.
  /// If any insert fails, none are committed.
  Future<void> _seedDefaultCategories() async {
    final db = _isar;
    if (db == null) return;

    final count = await db.categorys.count();
    if (count > 0) return; // Already seeded

    // Default categories with Material Icons code points and colors
    final defaults = [
      _createCategory('Food', 0xe57a, 0xFF4CAF50),       // restaurant icon, green
      _createCategory('Transport', 0xe1d5, 0xFF2196F3),   // directions_car, blue
      _createCategory('Shopping', 0xe59c, 0xFFFF9800),     // shopping_cart, orange
      _createCategory('Bills', 0xef63, 0xFFF44336),        // receipt, red
      _createCategory('Entertainment', 0xe40f, 0xFF9C27B0), // movie, purple
      _createCategory('Health', 0xe3f3, 0xFF00BCD4),       // local_hospital, cyan
      _createCategory('Education', 0xe80c, 0xFF3F51B5),    // school, indigo
      _createCategory('Other', 0xe5f9, 0xFF607D8B),        // more_horiz, blue-grey
    ];

    await db.writeTxn(() async {
      await db.categorys.putAll(defaults);
    });

    if (kDebugMode) {
      print('[IsarHelper] Seeded ${defaults.length} default categories');
    }
  }

  /// Helper to create a Category instance.
  Category _createCategory(String name, int iconCode, int colorValue) {
    return Category()
      ..name = name
      ..iconCode = iconCode
      ..colorValue = colorValue
      ..sortKey = name;
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Closes the Isar database and releases resources.
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}

// ---------------------------------------------------------------------------
// Isar Concepts Reference
// ---------------------------------------------------------------------------
//
// COLLECTIONS (@collection):
// - Equivalent to tables in SQL
// - Must have an Id field
// - Can have indexes, links, and computed properties
//
// SCHEMAS:
// - Generated at build time from @collection classes
// - Define the binary format for serialization
// - Schema changes are handled automatically (unlike SQLite migrations)
//
// INDEXES (@Index):
// - Single-field: @Index() on a property
// - Composite: @Index(composite: [CompositeIndex('field2')])
// - Unique: @Index(unique: true)
// - Hash: @Index(type: IndexType.hash) for string equality checks
//
// LINKS (IsarLink / IsarLinks):
// - IsarLink<T>: One-to-one relationship
// - IsarLinks<T>: One-to-many relationship
// - @Backlink: Reverse side of a link
// - Links are lazy-loaded: await link.load()
//
// QUERIES:
// - Type-safe builder: isar.collection.where().filter().findAll()
// - Sorting: .sortByField() / .sortByFieldDesc()
// - Aggregation: .count(), .sum(), .average(), .min(), .max()
// - Pagination: .offset(10).limit(20)
//
// WATCHERS:
// - watchLazy(): Emits when collection changes (no data)
// - watchObject(id): Emits when specific object changes
// - watch(): Emits with query results when data changes
