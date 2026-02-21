// =============================================================================
// Expense Model - SQLite Entity
// =============================================================================
//
// This model represents an expense stored in SQLite. We use freezed for
// immutability and json_serializable for Map<String, dynamic> conversion,
// which is exactly what SQLite's toMap/fromMap pattern needs.
//
// WHY SQLite for expenses?
// - Relational data with JOINs (expense -> category)
// - Complex queries (SUM, GROUP BY, date ranges)
// - Transactions for batch operations
// - Well-established migration patterns (v1 -> v2 -> v3)
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

// ---------------------------------------------------------------------------
// Expense Model
// ---------------------------------------------------------------------------

/// Represents a single expense entry stored in SQLite.
///
/// Uses freezed for immutable data classes with copyWith, ==, hashCode.
/// The [toJson]/[fromJson] methods map directly to SQLite row operations.
@freezed
abstract class Expense with _$Expense {
  /// Creates an [Expense] instance.
  ///
  /// [id] is nullable because SQLite auto-generates it on INSERT.
  /// [categoryId] links to the Isar category collection -- demonstrating
  /// cross-storage references (SQLite -> Isar).
  const factory Expense({
    // SQLite auto-increment primary key -- null for new records
    int? id,

    /// Display title for the expense
    required String title,

    /// Amount in the user's selected currency
    required double amount,

    /// When the expense occurred (stored as ISO8601 string in SQLite)
    required DateTime date,

    /// Foreign key to category (stored in Isar, referenced by ID here)
    int? categoryId,

    /// Optional name cached from category for display without JOIN
    String? categoryName,

    /// Free-form notes about the expense
    @Default('') String notes,

    // ---------------------------------------------------------------------------
    // v2 migration fields -- added in database version 2
    // ---------------------------------------------------------------------------

    /// Whether this is a recurring expense (added in v2 migration)
    @Default(false) bool isRecurring,

    /// Tags for filtering, stored as comma-separated string in SQLite
    /// Alternative: use a separate tags table with many-to-many relationship
    @Default('') String tags,
  }) = _Expense;

  /// Deserialize from a Map (used by SQLite row mapping).
  ///
  /// SQLite stores booleans as integers (0/1), so we handle conversion
  /// in the DAO layer rather than here.
  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}

// ---------------------------------------------------------------------------
// SQLite Table Schema (for reference)
// ---------------------------------------------------------------------------
//
// CREATE TABLE expenses (
//   id INTEGER PRIMARY KEY AUTOINCREMENT,
//   title TEXT NOT NULL,
//   amount REAL NOT NULL,
//   date TEXT NOT NULL,           -- ISO8601 string
//   categoryId INTEGER,
//   categoryName TEXT,
//   notes TEXT DEFAULT '',
//   isRecurring INTEGER DEFAULT 0,  -- v2 migration
//   tags TEXT DEFAULT ''             -- v2 migration
// );
//
// -- Performance index on date for range queries
// CREATE INDEX idx_expenses_date ON expenses(date);
//
// -- Composite index for category + date queries
// CREATE INDEX idx_expenses_category_date ON expenses(categoryId, date);
//
// Alternative: Use a separate table for tags (normalized form)
// CREATE TABLE expense_tags (
//   expense_id INTEGER REFERENCES expenses(id),
//   tag TEXT NOT NULL,
//   PRIMARY KEY (expense_id, tag)
// );
