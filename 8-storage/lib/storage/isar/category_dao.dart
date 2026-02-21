// =============================================================================
// Category DAO - Isar Query Operations
// =============================================================================
//
// This DAO demonstrates Isar's type-safe query builder pattern.
// Unlike SQLite where you write raw SQL strings, Isar generates
// query methods from your collection definition.
//
// KEY CONCEPTS:
// - Type-safe queries (compile-time checked)
// - Composite filters
// - Foreign key lookups (categoryId)
// - Reactive streams with watchLazy()
// - Synchronous vs asynchronous APIs
// =============================================================================

import 'dart:async';

import 'package:flutter/foundation.dart' hide Category;
import 'package:isar/isar.dart';

import '../../models/category.dart';
import '../../models/budget.dart';
import 'isar_helper.dart';

// ---------------------------------------------------------------------------
// Category DAO
// ---------------------------------------------------------------------------

/// Data Access Object for Isar category and budget operations.
///
/// Demonstrates Isar's query builder and reactive watchers.
///
/// Usage:
/// ```dart
/// final dao = CategoryDao();
/// final categories = await dao.getAllCategories();
/// final food = await dao.getCategoryByName('Food');
/// ```
class CategoryDao {
  /// Gets the Isar instance from the helper
  Isar? get _isar {
    try {
      return IsarHelper.instance.isar;
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Category CRUD
  // ---------------------------------------------------------------------------

  /// Gets all categories sorted by name.
  ///
  /// Isar's where() starts a query builder chain.
  /// sortByName() is auto-generated from the @Index on name.
  Future<List<Category>> getAllCategories() async {
    final db = _isar;
    if (db == null) return _fallbackCategories();

    return db.categorys
        .where()
        .sortByName()
        .findAll();

    // Alternative: Use filter() for more complex conditions
    // return db.categorys
    //     .filter()
    //     .nameContains('food', caseSensitive: false)
    //     .findAll();
  }

  /// Gets a category by its ID.
  ///
  /// Isar's get() is a direct ID lookup -- O(1) performance.
  Future<Category?> getCategoryById(int id) async {
    final db = _isar;
    if (db == null) return null;

    return db.categorys.get(id);

    // Alternative: Synchronous get (blocks the isolate)
    // return db.categorys.getSync(id);
  }

  /// Gets a category by exact name match.
  ///
  /// Uses the name index for efficient lookup.
  Future<Category?> getCategoryByName(String name) async {
    final db = _isar;
    if (db == null) return null;

    return db.categorys
        .filter()
        .nameEqualTo(name)
        .findFirst();
  }

  /// Creates or updates a category.
  ///
  /// Isar's put() is an upsert operation:
  /// - If id == Isar.autoIncrement: inserts new record
  /// - If id matches existing: updates the record
  ///
  /// All write operations MUST be inside a writeTxn().
  Future<int> saveCategory(Category category) async {
    final db = _isar;
    if (db == null) return -1;

    return db.writeTxn(() async {
      return db.categorys.put(category);
    });

    // Alternative: Batch save multiple categories
    // return db.writeTxn(() async {
    //   return db.categorys.putAll(categories);
    // });
  }

  /// Deletes a category by ID.
  ///
  /// Returns true if the category was found and deleted.
  /// Also cleans up any budgets referencing this category.
  Future<bool> deleteCategory(int id) async {
    final db = _isar;
    if (db == null) return false;

    return db.writeTxn(() async {
      // Delete budgets for this category first (foreign key cleanup)
      final budgets = await db.budgets
          .filter()
          .categoryIdEqualTo(id)
          .findAll();
      for (final budget in budgets) {
        await db.budgets.delete(budget.id);
      }

      return db.categorys.delete(id);
    });
  }

  // ---------------------------------------------------------------------------
  // Budget Operations
  // ---------------------------------------------------------------------------

  /// Gets all budgets with their associated categories loaded.
  Future<List<Budget>> getAllBudgets() async {
    final db = _isar;
    if (db == null) return [];

    final budgets = await db.budgets.where().findAll();

    // Load the category for each budget using the foreign key
    for (final budget in budgets) {
      final category = await db.categorys.get(budget.categoryId);
      budget.loadedCategory = category;
    }

    return budgets;
  }

  /// Gets the budget for a specific category.
  Future<Budget?> getBudgetForCategory(int categoryId) async {
    final db = _isar;
    if (db == null) return null;

    final budget = await db.budgets
        .filter()
        .categoryIdEqualTo(categoryId)
        .findFirst();

    if (budget != null) {
      budget.loadedCategory = await db.categorys.get(categoryId);
    }

    return budget;
  }

  /// Creates or updates a budget for a category.
  ///
  /// Uses the foreign key pattern (categoryId) instead of Isar links.
  Future<int> saveBudget(Budget budget, int categoryId) async {
    final db = _isar;
    if (db == null) return -1;

    budget.categoryId = categoryId;

    return db.writeTxn(() async {
      // Remove existing budgets for this category (one budget per category)
      final existing = await db.budgets
          .filter()
          .categoryIdEqualTo(categoryId)
          .findAll();
      for (final old in existing) {
        if (old.id != budget.id) {
          await db.budgets.delete(old.id);
        }
      }

      return db.budgets.put(budget);
    });
  }

  /// Deletes a budget by ID.
  Future<bool> deleteBudget(int id) async {
    final db = _isar;
    if (db == null) return false;

    return db.writeTxn(() async {
      return db.budgets.delete(id);
    });
  }

  /// Updates the spent amount on a budget.
  ///
  /// This is called when expenses are added/removed to keep
  /// the budget's spent field in sync.
  Future<void> updateBudgetSpent(int budgetId, double spent) async {
    final db = _isar;
    if (db == null) return;

    await db.writeTxn(() async {
      final budget = await db.budgets.get(budgetId);
      if (budget != null) {
        budget.spent = spent;
        await db.budgets.put(budget);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Reactive Streams
  // ---------------------------------------------------------------------------

  /// Watches for any changes to categories.
  ///
  /// watchLazy() emits a void event whenever the collection changes.
  /// It's "lazy" because it doesn't include the changed data --
  /// you need to re-query to get the updated data.
  ///
  /// This is more efficient than watch() when you just need to
  /// know THAT something changed, not WHAT changed.
  Stream<void> watchCategories() {
    final db = _isar;
    if (db == null) return const Stream.empty();

    return db.categorys.watchLazy();

    // Alternative: Watch with data (less efficient but more convenient)
    // return db.categorys.where().watch(fireImmediately: true);
  }

  /// Watches for changes to budgets.
  Stream<void> watchBudgets() {
    final db = _isar;
    if (db == null) return const Stream.empty();

    return db.budgets.watchLazy();
  }

  /// Watches a specific category for changes.
  ///
  /// watchObject() emits the updated object whenever it changes.
  /// Emits null if the object is deleted.
  Stream<Category?> watchCategory(int id) {
    final db = _isar;
    if (db == null) return const Stream.empty();

    return db.categorys.watchObject(id);
  }

  // ---------------------------------------------------------------------------
  // Isar Query Examples
  // ---------------------------------------------------------------------------

  /// Demonstrates various Isar query patterns.
  ///
  /// These are for educational purposes -- showing the query builder API.
  Future<void> queryExamples() async {
    final db = _isar;
    if (db == null) return;

    // 1. Simple filter
    final greenCategories = await db.categorys
        .filter()
        .colorValueEqualTo(0xFF4CAF50)
        .findAll();

    // 2. String operations
    final foodRelated = await db.categorys
        .filter()
        .nameStartsWith('F')
        .findAll();

    // 3. Aggregation - count
    final totalCategories = await db.categorys.count();

    // 4. Pagination
    final page = await db.categorys
        .where()
        .offset(0)
        .limit(10)
        .findAll();

    // 5. Delete by query
    // await db.writeTxn(() async {
    //   await db.categorys.filter().nameEqualTo('Temp').deleteAll();
    // });

    if (kDebugMode) {
      print('Green categories: ${greenCategories.length}');
      print('Food-related: ${foodRelated.length}');
      print('Total: $totalCategories');
      print('Page: ${page.length}');
    }
  }

  // ---------------------------------------------------------------------------
  // Fallback Data
  // ---------------------------------------------------------------------------

  /// Provides fallback categories when Isar is unavailable.
  ///
  /// This ensures the app remains functional even if Isar
  /// native libraries aren't available on the current platform.
  List<Category> _fallbackCategories() {
    final names = [
      'Food', 'Transport', 'Shopping', 'Bills',
      'Entertainment', 'Health', 'Education', 'Other',
    ];
    final icons = [
      0xe57a, 0xe1d5, 0xe59c, 0xef63,
      0xe40f, 0xe3f3, 0xe80c, 0xe5f9,
    ];
    final colors = [
      0xFF4CAF50, 0xFF2196F3, 0xFFFF9800, 0xFFF44336,
      0xFF9C27B0, 0xFF00BCD4, 0xFF3F51B5, 0xFF607D8B,
    ];

    return List.generate(names.length, (i) {
      return Category()
        ..id = i + 1
        ..name = names[i]
        ..iconCode = icons[i]
        ..colorValue = colors[i]
        ..sortKey = names[i];
    });
  }
}
