# 8-Storage: Personal Finance Tracker

A Flutter tutorial app teaching three local storage solutions: **SQLite**, **Hive**, and **Isar**.

## What This App Teaches

This offline-first Personal Finance Tracker demonstrates when and how to use each storage backend:

- **Add/edit/delete expenses** (stored in SQLite)
- **Manage expense categories and budgets** (stored in Isar)
- **App settings** like currency, theme, date format (stored in Hive)
- **Dashboard** with expense totals and budget progress

## Storage Comparison

| Feature | SQLite (sqflite) | Hive | Isar |
|---|---|---|---|
| **Type** | Relational (SQL) | Key-Value (NoSQL) | Document (NoSQL) |
| **Used For** | Expenses | App Settings | Categories, Budgets |
| **Query Language** | Raw SQL strings | Key-based get/put | Type-safe query builder |
| **Schema** | Manual CREATE TABLE | Type adapters (@HiveType) | @collection annotation |
| **Migrations** | Manual ALTER TABLE | Add new @HiveField | Automatic schema migration |
| **Relationships** | JOINs, foreign keys | None (flat key-value) | Links (IsarLink/IsarLinks) |
| **Transactions** | db.transaction() | Not needed (atomic writes) | isar.writeTxn() |
| **Reactive** | Manual (poll) | box.watch() | watchLazy(), watchObject() |
| **Encryption** | Not built-in | HiveAesCipher | Not built-in (3.x) |
| **Performance** | Good for complex queries | Fastest reads (in-memory) | Fast with auto-indexing |
| **Indexes** | Manual CREATE INDEX | N/A | @Index, composite indexes |
| **Aggregation** | SUM, AVG, GROUP BY | Manual in Dart | Property queries (.sum()) |
| **Batch Ops** | db.batch() | putAll() | putAll() in writeTxn |
| **Code Gen** | None | hive_generator | isar_generator |
| **Dart Typing** | Map\<String, dynamic\> | Custom objects | Custom objects |

## When to Use Each

| Scenario | Recommended |
|---|---|
| Relational data with JOINs | **SQLite** |
| Complex aggregation queries | **SQLite** |
| Large datasets (10k+ rows) | **SQLite** |
| Schema migrations needed | **SQLite** |
| App settings / preferences | **Hive** |
| Cache with fast reads | **Hive** |
| Encrypted storage | **Hive** |
| Reactive key-value updates | **Hive** |
| Type-safe queries (no SQL strings) | **Isar** |
| Object relationships | **Isar** |
| Full-text search | **Isar** |
| Reactive collection watching | **Isar** |

## Project Structure

```
lib/
+-- l10n/                           # Localization (English + Spanish)
|   +-- app_en.arb
|   +-- app_es.arb
+-- models/
|   +-- expense.dart                # Freezed model for SQLite
|   +-- category.dart               # Isar @collection
|   +-- budget.dart                 # Isar @collection with enum
|   +-- app_settings.dart           # Hive @HiveType with type adapter
|   +-- models.dart                 # Barrel file
+-- storage/
|   +-- sqlite/
|   |   +-- database_helper.dart    # Singleton, migrations v1->v2, indexes
|   |   +-- expense_dao.dart        # Full CRUD, batch inserts, aggregation
|   +-- hive/
|   |   +-- hive_helper.dart        # Init, type adapters, encrypted boxes
|   |   +-- settings_box.dart       # Type-safe wrapper, box.watch() streams
|   +-- isar/
|       +-- isar_helper.dart        # Init, schema registration, seeding
|       +-- category_dao.dart       # Query builder, watchLazy(), fallbacks
+-- screens/
|   +-- dashboard_screen.dart       # Reads from all 3 storage backends
|   +-- expense_list_screen.dart    # SQLite list with swipe-to-delete
|   +-- expense_form_screen.dart    # SQLite INSERT/UPDATE + Isar categories
|   +-- category_screen.dart        # Isar CRUD with reactive updates
|   +-- budget_screen.dart          # Isar budgets with category links
|   +-- settings_screen.dart        # Hive settings with reactive theme
+-- widgets/
|   +-- expense_tile.dart           # Dismissible list tile
|   +-- budget_progress.dart        # Linear progress with color states
|   +-- summary_card.dart           # Dashboard metric card
+-- main.dart                       # Storage initialization, theming
```

## Key Concepts Demonstrated

### SQLite (sqflite)
- **Singleton database helper** with lazy initialization
- **Schema migrations** from v1 to v2 (ALTER TABLE)
- **Indexes** for date range and category queries
- **Batch inserts** (50x faster than individual inserts)
- **Transactions** for atomic multi-statement operations
- **Aggregation** queries (SUM, GROUP BY, strftime)
- **Parameterized queries** to prevent SQL injection

### Hive
- **Type adapters** with @HiveType and @HiveField annotations
- **Regular boxes** (in-memory) vs **lazy boxes** (on-demand)
- **Encrypted boxes** with AES-256 cipher
- **box.watch()** for reactive settings changes
- **HiveObject** for in-place saves
- **Compaction** for reclaiming disk space

### Isar
- **@collection** annotation with auto-generated schemas
- **Type-safe query builder** (no raw SQL strings)
- **Composite indexes** for multi-field queries
- **@enumerated** for enum storage
- **watchLazy()** for reactive collection updates
- **watchObject()** for individual object changes
- **Foreign key pattern** with categoryId
- **Fallback data** when Isar is unavailable

## Setup

```bash
# Install dependencies
flutter pub get

# Generate code (freezed, json_serializable, hive, isar)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Isar Note

Isar 3.x requires platform-specific native libraries. If Isar is not available
on your platform, the app gracefully falls back to in-memory category data.
All Isar-related code and comments remain educational even without the native
libraries running.

## Dependencies

- `sqflite` - SQLite database for Flutter
- `hive` / `hive_flutter` - Fast key-value storage
- `isar` / `isar_flutter_libs` - High-performance NoSQL database
- `freezed` / `json_serializable` - Immutable models with serialization
- `flutter_bloc` - State management (available for extension)
- `dartz` - Functional programming utilities
- `intl` - Internationalization and formatting
- `path_provider` - Platform-specific file paths
