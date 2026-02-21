// =============================================================================
// Budget Screen
// =============================================================================
//
// Manages budgets stored in Isar. Demonstrates:
// - Isar links (Budget -> Category)
// - Creating/editing budgets with category association
// - Isar watchLazy() for reactive updates
// - Budget period selection (weekly/monthly/yearly)
// =============================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../models/models.dart';
import '../storage/isar/category_dao.dart';
import '../storage/hive/settings_box.dart';
import '../widgets/budget_progress.dart';

// ---------------------------------------------------------------------------
// Budget Screen
// ---------------------------------------------------------------------------

/// Screen for managing category budgets stored in Isar.
///
/// Each budget is linked to a category via Isar links.
/// Budget progress is calculated from SQLite expense totals.
class BudgetScreen extends StatefulWidget {
  /// Settings box for currency symbol
  final SettingsBox settingsBox;

  /// Called when budgets change
  final VoidCallback? onChanged;

  const BudgetScreen({
    super.key,
    required this.settingsBox,
    this.onChanged,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final CategoryDao _categoryDao = CategoryDao();
  List<Budget> _budgets = [];
  List<Category> _categories = [];
  bool _isLoading = true;
  StreamSubscription<void>? _watchSubscription;

  @override
  void initState() {
    super.initState();
    _loadData();

    // Watch for budget changes via Isar watchLazy()
    _watchSubscription = _categoryDao.watchBudgets().listen((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _watchSubscription?.cancel();
    super.dispose();
  }

  /// Loads budgets and categories from Isar.
  Future<void> _loadData() async {
    final results = await Future.wait([
      _categoryDao.getAllBudgets(),
      _categoryDao.getAllCategories(),
    ]);

    if (!mounted) return;

    setState(() {
      _budgets = results[0] as List<Budget>;
      _categories = results[1] as List<Category>;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settingsBox.getSettings();

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: _budgets.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  const Text('No budgets set. Create one to track spending!'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _showBudgetDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Budget'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _budgets.length,
              itemBuilder: (context, index) {
                final budget = _budgets[index];
                final category = budget.loadedCategory;

                return InkWell(
                  onTap: () => _showBudgetDialog(
                    budget: budget,
                    categoryId: category?.id,
                  ),
                  onLongPress: () => _deleteBudget(budget),
                  child: BudgetProgress(
                    categoryName: category?.name ?? 'Unknown',
                    budgetAmount: budget.amount,
                    spentAmount: budget.spent,
                    currencySymbol: settings.currencySymbol,
                    categoryColor: category != null
                        ? Color(category.colorValue)
                        : null,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBudgetDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Shows a dialog for creating or editing a budget.
  Future<void> _showBudgetDialog({
    Budget? budget,
    int? categoryId,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final settings = widget.settingsBox.getSettings();
    final isEditing = budget != null;

    final amountController = TextEditingController(
      text: budget?.amount.toStringAsFixed(2) ?? '',
    );
    var selectedCategoryId = categoryId;
    var selectedPeriod = budget?.period ?? BudgetPeriod.monthly;

    // Filter out categories that already have budgets (unless editing)
    final budgetedCategoryIds = _budgets
        .where((b) => b.loadedCategory != null)
        .map((b) => b.loadedCategory!.id)
        .toSet();

    final availableCategories = _categories.where((c) {
      if (isEditing && c.id == categoryId) return true;
      return !budgetedCategoryIds.contains(c.id);
    }).toList();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Budget' : 'Add Budget'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Category dropdown
                    DropdownButtonFormField<int>(
                      initialValue: selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: l10n.expenseCategory,
                        border: const OutlineInputBorder(),
                      ),
                      items: availableCategories.map((cat) {
                        return DropdownMenuItem<int>(
                          value: cat.id,
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Color(cat.colorValue),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(cat.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(
                          () => selectedCategoryId = value,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Amount field
                    TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: l10n.budgetAmount,
                        border: const OutlineInputBorder(),
                        prefixText: settings.currencySymbol,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Period selection
                    DropdownButtonFormField<BudgetPeriod>(
                      initialValue: selectedPeriod,
                      decoration: InputDecoration(
                        labelText: l10n.budgetPeriod,
                        border: const OutlineInputBorder(),
                      ),
                      items: BudgetPeriod.values.map((period) {
                        String label;
                        switch (period) {
                          case BudgetPeriod.weekly:
                            label = l10n.weekly;
                          case BudgetPeriod.monthly:
                            label = l10n.monthly;
                          case BudgetPeriod.yearly:
                            label = l10n.yearly;
                        }
                        return DropdownMenuItem<BudgetPeriod>(
                          value: period,
                          child: Text(label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => selectedPeriod = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(l10n.save),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true &&
        selectedCategoryId != null &&
        amountController.text.isNotEmpty) {
      final amount = double.tryParse(amountController.text);
      if (amount == null || amount <= 0) return;

      final now = DateTime.now();
      final newBudget = budget ?? Budget();
      newBudget
        ..amount = amount
        ..period = selectedPeriod
        ..startDate = DateTime(now.year, now.month, 1)
        ..endDate = DateTime(now.year, now.month + 1, 0);

      if (isEditing) {
        newBudget.id = budget.id;
      }

      await _categoryDao.saveBudget(newBudget, selectedCategoryId!);
      widget.onChanged?.call();
    }

    amountController.dispose();
  }

  /// Deletes a budget after confirmation.
  Future<void> _deleteBudget(Budget budget) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(l10n.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _categoryDao.deleteBudget(budget.id);
      widget.onChanged?.call();
    }
  }
}
