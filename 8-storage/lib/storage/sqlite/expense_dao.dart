// =============================================================================
// Expense Data Access Object (DAO) - SQLite CRUD Operations
// =============================================================================
//
// This DAO encapsulates all SQLite operations for expenses, providing:
// - Full CRUD (Create, Read, Update, Delete)
// - Batch inserts for performance
// - Transactions for atomic operations
// - JOINs for related data
// - Aggregation queries (SUM, GROUP BY)
// - Parameterized queries to prevent SQL injection
//
// The DAO pattern separates data access logic from business logic,
// making the code testable and maintainable.
// =============================================================================

import 'package:sqflite/sqflite.dart';
import '../../models/expense.dart';
import 'database_helper.dart';

// ---------------------------------------------------------------------------
// Expense DAO
// ---------------------------------------------------------------------------

/// Data Access Object for expense CRUD operations.
///
/// All methods use parameterized queries (?) instead of string interpolation
/// to prevent SQL injection attacks.
///
/// Usage:
/// ```dart
/// final dao = ExpenseDao();
/// final expenses = await dao.getAllExpenses();
/// await dao.insertExpense(Expense(title: 'Coffee', amount: 4.50, date: DateTime.now()));
/// ```
class ExpenseDao {
  /// Reference to the database helper singleton
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  /// Inserts a new expense into the database.
  ///
  /// Returns the auto-generated ID of the inserted row.
  /// SQLite auto-increment assigns IDs starting from 1.
  ///
  /// The [conflictAlgorithm] determines behavior on constraint violations:
  /// - replace: Overwrite the existing row
  /// - ignore: Silently skip the insert
  /// - abort (default): Throw an error
  Future<int> insertExpense(Expense expense) async {
    final db = await _dbHelper.database;

    // Convert Expense to Map for SQLite
    final map = _expenseToMap(expense);

    // Remove id so SQLite auto-generates it
    map.remove('id');

    return db.insert(
      tableExpenses,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Alternative: Use raw SQL for more control
    // return db.rawInsert(
    //   'INSERT INTO $tableExpenses (title, amount, date) VALUES (?, ?, ?)',
    //   [expense.title, expense.amount, expense.date.toIso8601String()],
    // );
  }

  /// Inserts multiple expenses in a single transaction (batch insert).
  ///
  /// Batch operations are MUCH faster than individual inserts because:
  /// 1. Only one transaction is opened (instead of N transactions)
  /// 2. The WAL journal is written once (instead of N times)
  /// 3. SQLite's fsync is called once (the slowest part)
  ///
  /// For 1000 inserts: Individual ~5s, Batch ~0.1s (50x faster!)
  Future<List<int>> batchInsertExpenses(List<Expense> expenses) async {
    final db = await _dbHelper.database;
    final ids = <int>[];

    // Use a transaction for atomic batch insert
    await db.transaction((txn) async {
      final batch = txn.batch();

      for (final expense in expenses) {
        final map = _expenseToMap(expense);
        map.remove('id');
        batch.insert(tableExpenses, map);
      }

      // commit returns a list of results (inserted IDs)
      final results = await batch.commit();
      ids.addAll(results.cast<int>());
    });

    return ids;

    // Alternative: Use batch without transaction (auto-commits)
    // final batch = db.batch();
    // for (final expense in expenses) {
    //   batch.insert(tableExpenses, _expenseToMap(expense)..remove('id'));
    // }
    // return (await batch.commit()).cast<int>();
  }

  // ---------------------------------------------------------------------------
  // READ
  // ---------------------------------------------------------------------------

  /// Gets all expenses, ordered by date descending (newest first).
  ///
  /// Uses the date index for efficient sorting.
  Future<List<Expense>> getAllExpenses() async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      tableExpenses,
      orderBy: '${ExpenseColumns.date} DESC',
    );

    return maps.map(_mapToExpense).toList();
  }

  /// Gets a single expense by ID.
  ///
  /// Returns null if not found.
  Future<Expense?> getExpenseById(int id) async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      tableExpenses,
      where: '${ExpenseColumns.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return _mapToExpense(maps.first);
  }

  /// Gets expenses within a date range.
  ///
  /// Uses the date index for efficient range scanning.
  /// Dates are stored as ISO8601 strings, which sort lexicographically.
  Future<List<Expense>> getExpensesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      tableExpenses,
      where: '${ExpenseColumns.date} BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: '${ExpenseColumns.date} DESC',
    );

    return maps.map(_mapToExpense).toList();

    // Alternative: Use rawQuery for complex queries
    // final maps = await db.rawQuery(
    //   'SELECT * FROM $tableExpenses WHERE date >= ? AND date <= ? ORDER BY date DESC',
    //   [start.toIso8601String(), end.toIso8601String()],
    // );
  }

  /// Gets expenses for a specific category.
  ///
  /// Uses the composite index (categoryId, date) for efficient filtering.
  Future<List<Expense>> getExpensesByCategory(int categoryId) async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      tableExpenses,
      where: '${ExpenseColumns.categoryId} = ?',
      whereArgs: [categoryId],
      orderBy: '${ExpenseColumns.date} DESC',
    );

    return maps.map(_mapToExpense).toList();
  }

  // ---------------------------------------------------------------------------
  // Aggregation Queries
  // ---------------------------------------------------------------------------

  /// Gets the total amount of all expenses.
  ///
  /// Uses SQL SUM() aggregate function for efficiency --
  /// much faster than loading all rows and summing in Dart.
  Future<double> getTotalExpenses() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery(
      'SELECT SUM(${ExpenseColumns.amount}) as total FROM $tableExpenses',
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  /// Gets expense totals grouped by category.
  ///
  /// Demonstrates SQL GROUP BY with aggregate functions.
  /// Returns a map of categoryId -> total amount.
  Future<Map<int, double>> getExpenseTotalsByCategory() async {
    final db = await _dbHelper.database;

    final results = await db.rawQuery('''
      SELECT ${ExpenseColumns.categoryId},
             ${ExpenseColumns.categoryName},
             SUM(${ExpenseColumns.amount}) as total,
             COUNT(*) as count
      FROM $tableExpenses
      WHERE ${ExpenseColumns.categoryId} IS NOT NULL
      GROUP BY ${ExpenseColumns.categoryId}
      ORDER BY total DESC
    ''');

    final totals = <int, double>{};
    for (final row in results) {
      final categoryId = row[ExpenseColumns.categoryId] as int?;
      if (categoryId != null) {
        totals[categoryId] = (row['total'] as num).toDouble();
      }
    }
    return totals;
  }

  /// Gets monthly expense totals for charting.
  ///
  /// Uses SQLite's strftime for date grouping.
  Future<Map<String, double>> getMonthlyTotals({int months = 6}) async {
    final db = await _dbHelper.database;
    final cutoff = DateTime.now().subtract(Duration(days: months * 30));

    final results = await db.rawQuery('''
      SELECT strftime('%Y-%m', ${ExpenseColumns.date}) as month,
             SUM(${ExpenseColumns.amount}) as total
      FROM $tableExpenses
      WHERE ${ExpenseColumns.date} >= ?
      GROUP BY month
      ORDER BY month ASC
    ''', [cutoff.toIso8601String()]);

    return {
      for (final row in results)
        row['month'] as String: (row['total'] as num).toDouble(),
    };
  }

  /// Gets the total spent for a category in a date range.
  ///
  /// Used for budget tracking -- compare this against the budget limit.
  Future<double> getCategorySpentInRange(
    int categoryId,
    DateTime start,
    DateTime end,
  ) async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT SUM(${ExpenseColumns.amount}) as total
      FROM $tableExpenses
      WHERE ${ExpenseColumns.categoryId} = ?
        AND ${ExpenseColumns.date} BETWEEN ? AND ?
    ''', [categoryId, start.toIso8601String(), end.toIso8601String()]);

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  /// Updates an existing expense.
  ///
  /// Returns the number of rows affected (should be 1).
  Future<int> updateExpense(Expense expense) async {
    final db = await _dbHelper.database;

    return db.update(
      tableExpenses,
      _expenseToMap(expense),
      where: '${ExpenseColumns.id} = ?',
      whereArgs: [expense.id],
    );

    // Alternative: Use rawUpdate for partial updates
    // return db.rawUpdate(
    //   'UPDATE $tableExpenses SET amount = ?, title = ? WHERE id = ?',
    //   [expense.amount, expense.title, expense.id],
    // );
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  /// Deletes an expense by ID.
  ///
  /// Returns the number of rows deleted (should be 0 or 1).
  Future<int> deleteExpense(int id) async {
    final db = await _dbHelper.database;

    return db.delete(
      tableExpenses,
      where: '${ExpenseColumns.id} = ?',
      whereArgs: [id],
    );
  }

  /// Deletes all expenses for a category.
  ///
  /// Useful when deleting a category -- clean up orphaned expenses.
  Future<int> deleteExpensesByCategory(int categoryId) async {
    final db = await _dbHelper.database;

    return db.delete(
      tableExpenses,
      where: '${ExpenseColumns.categoryId} = ?',
      whereArgs: [categoryId],
    );
  }

  /// Deletes all expenses (use with caution!).
  ///
  /// Wraps in a transaction for atomicity.
  Future<void> deleteAllExpenses() async {
    final db = await _dbHelper.database;

    await db.transaction((txn) async {
      await txn.delete(tableExpenses);
      // Alternative: TRUNCATE equivalent in SQLite
      // await txn.execute('DELETE FROM $tableExpenses');
      // await txn.execute("DELETE FROM sqlite_sequence WHERE name='$tableExpenses'");
    });
  }

  // ---------------------------------------------------------------------------
  // Transaction Example
  // ---------------------------------------------------------------------------

  /// Transfers budget between categories atomically.
  ///
  /// This demonstrates SQLite transactions for ensuring data consistency.
  /// If any step fails, ALL changes are rolled back.
  Future<void> transferBetweenCategories({
    required int fromCategoryId,
    required int toCategoryId,
  }) async {
    final db = await _dbHelper.database;

    await db.transaction((txn) async {
      // Update all expenses from one category to another
      await txn.rawUpdate('''
        UPDATE $tableExpenses
        SET ${ExpenseColumns.categoryId} = ?
        WHERE ${ExpenseColumns.categoryId} = ?
      ''', [toCategoryId, fromCategoryId]);

      // If this throws, the category update above is also rolled back
      // This ensures atomic consistency
    });
  }

  // ---------------------------------------------------------------------------
  // Map Conversion Helpers
  // ---------------------------------------------------------------------------

  /// Converts an [Expense] to a SQLite-compatible Map.
  ///
  /// Handles type conversions:
  /// - DateTime -> ISO8601 String
  /// - bool -> int (0/1)
  Map<String, dynamic> _expenseToMap(Expense expense) {
    return {
      if (expense.id != null) ExpenseColumns.id: expense.id,
      ExpenseColumns.title: expense.title,
      ExpenseColumns.amount: expense.amount,
      // SQLite doesn't have a DATE type; store as ISO8601 string
      ExpenseColumns.date: expense.date.toIso8601String(),
      ExpenseColumns.categoryId: expense.categoryId,
      ExpenseColumns.categoryName: expense.categoryName,
      ExpenseColumns.notes: expense.notes,
      // SQLite stores booleans as integers (0 = false, 1 = true)
      ExpenseColumns.isRecurring: expense.isRecurring ? 1 : 0,
      ExpenseColumns.tags: expense.tags,
    };
  }

  /// Converts a SQLite row Map to an [Expense].
  ///
  /// Handles type conversions:
  /// - ISO8601 String -> DateTime
  /// - int (0/1) -> bool
  Expense _mapToExpense(Map<String, dynamic> map) {
    return Expense(
      id: map[ExpenseColumns.id] as int?,
      title: map[ExpenseColumns.title] as String,
      amount: (map[ExpenseColumns.amount] as num).toDouble(),
      date: DateTime.parse(map[ExpenseColumns.date] as String),
      categoryId: map[ExpenseColumns.categoryId] as int?,
      categoryName: map[ExpenseColumns.categoryName] as String?,
      notes: (map[ExpenseColumns.notes] as String?) ?? '',
      // Convert SQLite integer back to bool
      isRecurring: (map[ExpenseColumns.isRecurring] as int?) == 1,
      tags: (map[ExpenseColumns.tags] as String?) ?? '',
    );
  }
}
