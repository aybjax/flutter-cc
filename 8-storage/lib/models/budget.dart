// =============================================================================
// Budget Model - Isar Collection
// =============================================================================
//
// Budgets are stored in Isar alongside categories. This demonstrates:
// - Multiple Isar collections in one database
// - Enum indexing in Isar
// - watchLazy() for reactive budget progress updates
// - Foreign key pattern with categoryId
//
// A budget defines a spending limit for a category over a time period.
//
// NOTE on Isar Links vs Foreign Keys:
// Isar supports IsarLink/IsarLinks for relationships, but in practice
// a simple foreign key (categoryId) is often simpler and more portable.
// Links are demonstrated conceptually in comments throughout.
//
// If you want to use Isar Links:
//   @Backlink(to: 'budgets')
//   final category = IsarLink<Category>();
// This requires both collections in the same Isar instance and
// careful link lifecycle management (load/save/reset).
// =============================================================================

import 'package:isar/isar.dart';

import 'category.dart';

part 'budget.g.dart';

// ---------------------------------------------------------------------------
// Budget Period Enum
// ---------------------------------------------------------------------------

/// Time period for budget tracking.
///
/// Isar can index enums by storing their index (ordinal value).
/// The @enumerated annotation tells Isar to store this as an int.
enum BudgetPeriod {
  weekly,
  monthly,
  yearly,
}

// ---------------------------------------------------------------------------
// Budget Collection
// ---------------------------------------------------------------------------

/// Represents a spending budget for a category, stored in Isar.
///
/// Uses a foreign key pattern (categoryId) to reference the Category
/// collection, rather than Isar links, for simplicity.
@collection
class Budget {
  /// Isar auto-incremented ID.
  Id id = Isar.autoIncrement;

  /// Foreign key to the Category this budget belongs to.
  ///
  /// This is a simpler alternative to Isar's IsarLink relationship.
  /// We query the category separately when needed.
  @Index()
  late int categoryId;

  /// The spending limit for this budget period
  late double amount;

  /// How much has been spent so far in the current period.
  ///
  /// This is a denormalized field updated when expenses are added/removed.
  /// Alternative: Calculate this on-the-fly by querying expenses,
  /// but caching it here avoids repeated expensive queries.
  //
  // Note: Isar doesn't use @Default -- that's a freezed annotation.
  // Instead, just assign a default value directly.
  double spent = 0.0;

  /// The budget period (weekly, monthly, yearly).
  ///
  /// Isar stores enums as their index (0, 1, 2).
  /// Use @enumerated for explicit enum storage.
  @enumerated
  BudgetPeriod period = BudgetPeriod.monthly;

  /// Start date of the current budget period
  late DateTime startDate;

  /// End date of the current budget period
  late DateTime endDate;

  // ---------------------------------------------------------------------------
  // Computed Properties (ignored by Isar)
  // ---------------------------------------------------------------------------

  /// How much budget remains (can be negative if over budget)
  @ignore
  double get remaining => amount - spent;

  /// Progress as a fraction (0.0 to 1.0+)
  @ignore
  double get progress => amount > 0 ? spent / amount : 0.0;

  /// Whether spending has exceeded the budget
  @ignore
  bool get isOverBudget => spent > amount;

  // ---------------------------------------------------------------------------
  // Transient field for loaded category (not stored in Isar)
  // ---------------------------------------------------------------------------

  /// Cached category reference, loaded separately.
  /// Annotated with @ignore so Isar doesn't try to store it.
  @ignore
  Category? loadedCategory;

  @override
  String toString() =>
      'Budget(id: $id, categoryId: $categoryId, amount: $amount, spent: $spent)';
}

// ---------------------------------------------------------------------------
// Isar Query Examples for Budget
// ---------------------------------------------------------------------------
//
// // Find all budgets for a category
// final budgets = await isar.budgets
//     .filter()
//     .categoryIdEqualTo(categoryId)
//     .findAll();
//
// // Find budget for a specific period
// final monthlyBudgets = await isar.budgets
//     .filter()
//     .periodEqualTo(BudgetPeriod.monthly)
//     .findAll();
//
// // Watch budget changes for reactive UI
// isar.budgets.watchLazy().listen((_) {
//   // Refresh budget display
// });
//
// // Alternative: Use Isar's built-in aggregation
// final totalBudget = await isar.budgets
//     .where()
//     .amountProperty()
//     .sum();
