// =============================================================================
// SQLite Database Helper
// =============================================================================
//
// This file demonstrates SQLite database setup, migrations, and best practices.
//
// KEY CONCEPTS:
// 1. Singleton pattern for database access
// 2. Schema versioning and migrations (v1 -> v2)
// 3. Index creation for query performance
// 4. Transaction support for atomic operations
// 5. Proper database lifecycle management
//
// SQLite is ideal for:
// - Relational data with foreign keys and JOINs
// - Complex aggregation queries (SUM, AVG, GROUP BY)
// - ACID transactions
// - Large datasets that need indexing
// =============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

// ---------------------------------------------------------------------------
// Database Constants
// ---------------------------------------------------------------------------

/// Current database version. Increment when schema changes.
///
/// Migration path:
/// - v1: Initial schema (expenses table)
/// - v2: Added isRecurring and tags columns to expenses
const int _databaseVersion = 2;

/// Database file name
const String _databaseName = 'finance_tracker.db';

// ---------------------------------------------------------------------------
// Table and Column Constants
// ---------------------------------------------------------------------------

/// Table name for expenses
const String tableExpenses = 'expenses';

/// Column names -- using constants prevents typos in SQL strings.
///
/// Alternative: Use an enum or sealed class for column names.
class ExpenseColumns {
  static const String id = 'id';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String date = 'date';
  static const String categoryId = 'categoryId';
  static const String categoryName = 'categoryName';
  static const String notes = 'notes';
  static const String isRecurring = 'isRecurring'; // v2
  static const String tags = 'tags'; // v2
}

// ---------------------------------------------------------------------------
// Database Helper (Singleton)
// ---------------------------------------------------------------------------

/// Singleton helper for SQLite database operations.
///
/// Uses the singleton pattern to ensure only one database connection
/// exists throughout the app lifecycle. This prevents:
/// - Multiple connections competing for the file lock
/// - Inconsistent reads during writes
/// - Resource leaks from unclosed connections
///
/// Usage:
/// ```dart
/// final db = await DatabaseHelper.instance.database;
/// final rows = await db.query('expenses');
/// ```
class DatabaseHelper {
  // Private constructor prevents external instantiation
  DatabaseHelper._init();

  /// Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Alternative: Use a factory constructor
  // factory DatabaseHelper() => instance;

  /// Cached database reference
  Database? _database;

  /// Gets the database instance, creating it if necessary.
  ///
  /// This lazy initialization pattern ensures the database is only
  /// created when first accessed, not at app startup.
  Future<Database> get database async {
    // Return cached instance if available
    if (_database != null) return _database!;

    // Create and cache the database
    _database = await _initDatabase();
    return _database!;
  }

  // ---------------------------------------------------------------------------
  // Database Initialization
  // ---------------------------------------------------------------------------

  /// Initializes the SQLite database with schema and migrations.
  ///
  /// The [openDatabase] function handles:
  /// - Creating the database file if it doesn't exist
  /// - Running onCreate for new databases
  /// - Running onUpgrade for version changes
  /// - Running onOpen after the database is ready
  Future<Database> _initDatabase() async {
    // Get the platform-specific database directory
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      // Called only when database is created for the first time
      onCreate: _onCreate,
      // Called when version number increases
      onUpgrade: _onUpgrade,
      // Called every time database is opened
      onOpen: _onOpen,
      // Alternative: onDowngrade for handling version decreases
      // onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // ---------------------------------------------------------------------------
  // Schema Creation (v1)
  // ---------------------------------------------------------------------------

  /// Creates the initial database schema.
  ///
  /// This is called only once, when the database file is first created.
  /// All tables, indexes, and initial data should be set up here.
  Future<void> _onCreate(Database db, int version) async {
    // Use a batch for atomic multi-statement execution
    final batch = db.batch();

    // Create the expenses table
    batch.execute('''
      CREATE TABLE $tableExpenses (
        ${ExpenseColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ExpenseColumns.title} TEXT NOT NULL,
        ${ExpenseColumns.amount} REAL NOT NULL,
        ${ExpenseColumns.date} TEXT NOT NULL,
        ${ExpenseColumns.categoryId} INTEGER,
        ${ExpenseColumns.categoryName} TEXT,
        ${ExpenseColumns.notes} TEXT DEFAULT '',
        ${ExpenseColumns.isRecurring} INTEGER DEFAULT 0,
        ${ExpenseColumns.tags} TEXT DEFAULT ''
      )
    ''');

    // Create indexes for common query patterns
    // Index on date for range queries (WHERE date BETWEEN ... AND ...)
    batch.execute('''
      CREATE INDEX idx_expenses_date
      ON $tableExpenses(${ExpenseColumns.date})
    ''');

    // Composite index for category + date filtering
    // Useful for: "Show me all Food expenses this month"
    batch.execute('''
      CREATE INDEX idx_expenses_category_date
      ON $tableExpenses(${ExpenseColumns.categoryId}, ${ExpenseColumns.date})
    ''');

    // Alternative: Create a full-text search virtual table
    // batch.execute('''
    //   CREATE VIRTUAL TABLE expenses_fts USING fts5(
    //     title, notes, content=expenses, content_rowid=id
    //   )
    // ''');

    await batch.commit(noResult: true);
  }

  // ---------------------------------------------------------------------------
  // Schema Migration (v1 -> v2)
  // ---------------------------------------------------------------------------

  /// Handles database schema migrations.
  ///
  /// IMPORTANT migration rules:
  /// 1. Never remove columns (SQLite doesn't support DROP COLUMN before 3.35)
  /// 2. Always add columns with DEFAULT values
  /// 3. Use transactions to ensure atomic migrations
  /// 4. Test migrations thoroughly -- data loss is permanent!
  ///
  /// Alternative migration strategies:
  /// - Copy-and-rename: Create new table, copy data, drop old, rename
  /// - Migration files: Store SQL in separate .sql files
  /// - Migration framework: Use a package like `drift` for type-safe migrations
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Run migrations sequentially for each version bump
    if (oldVersion < 2) {
      await _migrateV1ToV2(db);
    }

    // Future migrations would follow the same pattern:
    // if (oldVersion < 3) {
    //   await _migrateV2ToV3(db);
    // }
  }

  /// Migration from v1 to v2: Add recurring expense support.
  ///
  /// ALTER TABLE is safe for adding columns with defaults.
  /// SQLite doesn't support adding NOT NULL columns without defaults.
  Future<void> _migrateV1ToV2(Database db) async {
    await db.transaction((txn) async {
      // Add isRecurring column (boolean stored as integer)
      await txn.execute('''
        ALTER TABLE $tableExpenses
        ADD COLUMN ${ExpenseColumns.isRecurring} INTEGER DEFAULT 0
      ''');

      // Add tags column (comma-separated string)
      await txn.execute('''
        ALTER TABLE $tableExpenses
        ADD COLUMN ${ExpenseColumns.tags} TEXT DEFAULT ''
      ''');

      // Alternative: Instead of comma-separated tags, create a junction table:
      // await txn.execute('''
      //   CREATE TABLE expense_tags (
      //     expense_id INTEGER REFERENCES expenses(id) ON DELETE CASCADE,
      //     tag TEXT NOT NULL,
      //     PRIMARY KEY (expense_id, tag)
      //   )
      // ''');
    });
  }

  // ---------------------------------------------------------------------------
  // Database Lifecycle
  // ---------------------------------------------------------------------------

  /// Called every time the database is opened.
  ///
  /// Good place for:
  /// - Enabling foreign keys (disabled by default in SQLite)
  /// - Running PRAGMA optimizations
  /// - Verifying data integrity
  Future<void> _onOpen(Database db) async {
    // Enable foreign key constraints (disabled by default in SQLite!)
    await db.execute('PRAGMA foreign_keys = ON');

    // Alternative performance optimizations:
    // await db.execute('PRAGMA journal_mode = WAL'); // Write-Ahead Logging
    // await db.execute('PRAGMA synchronous = NORMAL'); // Faster but less safe
    // await db.execute('PRAGMA cache_size = -8000'); // 8MB cache
  }

  /// Closes the database connection.
  ///
  /// Call this when the app is being disposed to free resources.
  /// After closing, [database] will create a new connection.
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
