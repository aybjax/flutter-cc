// =============================================================================
// Expense List Screen
// =============================================================================
//
// Displays all expenses from SQLite with filtering and search.
// Demonstrates:
// - Loading data from SQLite via ExpenseDao
// - Date range filtering
// - Swipe-to-delete with undo
// - Pull-to-refresh
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../models/models.dart';
import '../storage/sqlite/expense_dao.dart';
import '../storage/hive/settings_box.dart';
import '../storage/isar/category_dao.dart';
import '../widgets/expense_tile.dart';
import 'expense_form_screen.dart';

// ---------------------------------------------------------------------------
// Expense List Screen
// ---------------------------------------------------------------------------

/// Displays a scrollable list of all expenses from SQLite.
///
/// Features:
/// - Pull-to-refresh to reload from SQLite
/// - Swipe-to-delete with undo snackbar
/// - Tap to edit
/// - Category color indicators from Isar
class ExpenseListScreen extends StatefulWidget {
  /// Settings box for currency and date format
  final SettingsBox settingsBox;

  /// Called when expenses change (for parent refresh)
  final VoidCallback? onChanged;

  const ExpenseListScreen({
    super.key,
    required this.settingsBox,
    this.onChanged,
  });

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final ExpenseDao _expenseDao = ExpenseDao();
  final CategoryDao _categoryDao = CategoryDao();

  List<Expense> _expenses = [];
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Loads expenses from SQLite and categories from Isar.
  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final results = await Future.wait([
      _expenseDao.getAllExpenses(),
      _categoryDao.getAllCategories(),
    ]);

    if (!mounted) return;

    setState(() {
      _expenses = results[0] as List<Expense>;
      _categories = results[1] as List<Category>;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = widget.settingsBox.getSettings();

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_expenses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noExpenses,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          final expense = _expenses[index];

          // Find category info from Isar data
          Category? category;
          if (expense.categoryId != null) {
            try {
              category = _categories.firstWhere(
                (c) => c.id == expense.categoryId,
              );
            } catch (_) {}
          }

          return ExpenseTile(
            expense: expense,
            currencySymbol: settings.currencySymbol,
            dateFormat: settings.dateFormat,
            categoryColor:
                category != null ? Color(category.colorValue) : null,
            categoryIconCode: category?.iconCode,
            onTap: () => _editExpense(expense),
            onDismissed: () => _deleteExpense(expense, index),
          );
        },
      ),
    );
  }

  /// Navigates to edit an expense.
  Future<void> _editExpense(Expense expense) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ExpenseFormScreen(
          expense: expense,
          settingsBox: widget.settingsBox,
        ),
      ),
    );

    if (result == true) {
      _loadData();
      widget.onChanged?.call();
    }
  }

  /// Deletes an expense with undo support.
  ///
  /// Shows a snackbar with an undo action that re-inserts
  /// the expense if tapped.
  Future<void> _deleteExpense(Expense expense, int index) async {
    if (expense.id == null) return;

    // Delete from SQLite
    await _expenseDao.deleteExpense(expense.id!);

    // Remove from local list
    setState(() {
      _expenses.removeAt(index);
    });
    widget.onChanged?.call();

    // Show undo snackbar
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} deleted'),
        action: SnackBarAction(
          label: l10n.cancel,
          onPressed: () async {
            // Re-insert the expense (undo delete)
            await _expenseDao.insertExpense(expense);
            _loadData();
            widget.onChanged?.call();
          },
        ),
      ),
    );
  }
}
