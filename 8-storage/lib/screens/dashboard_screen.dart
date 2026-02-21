// =============================================================================
// Dashboard Screen
// =============================================================================
//
// The main screen showing financial overview:
// - Total expenses summary cards
// - Budget progress bars
// - Recent transactions
//
// This screen pulls data from ALL THREE storage solutions:
// - SQLite: expense totals and recent transactions
// - Isar: categories and budgets
// - Hive: currency symbol and date format settings
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../models/models.dart';
import '../storage/sqlite/expense_dao.dart';
import '../storage/hive/settings_box.dart';
import '../storage/isar/category_dao.dart';
import '../widgets/summary_card.dart';
import '../widgets/budget_progress.dart';
import '../widgets/expense_tile.dart';
import 'expense_list_screen.dart';
import 'expense_form_screen.dart';
import 'category_screen.dart';
import 'budget_screen.dart';
import 'settings_screen.dart';

// ---------------------------------------------------------------------------
// Dashboard Screen
// ---------------------------------------------------------------------------

/// Main dashboard showing financial overview.
///
/// Demonstrates reading from multiple storage backends:
/// - [ExpenseDao] for SQLite expense data
/// - [CategoryDao] for Isar categories/budgets
/// - [SettingsBox] for Hive settings
class DashboardScreen extends StatefulWidget {
  /// Settings box for reading user preferences
  final SettingsBox settingsBox;

  const DashboardScreen({
    super.key,
    required this.settingsBox,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ExpenseDao _expenseDao = ExpenseDao();
  final CategoryDao _categoryDao = CategoryDao();

  // Dashboard data
  double _totalExpenses = 0;
  List<Expense> _recentExpenses = [];
  List<Category> _categories = [];
  List<Budget> _budgets = [];
  Map<int, double> _categoryTotals = {};

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  /// Loads all dashboard data from the three storage backends.
  Future<void> _loadDashboardData() async {
    // Load data in parallel for better performance
    final results = await Future.wait([
      _expenseDao.getTotalExpenses(),
      _expenseDao.getAllExpenses(),
      _categoryDao.getAllCategories(),
      _categoryDao.getAllBudgets(),
      _expenseDao.getExpenseTotalsByCategory(),
    ]);

    if (!mounted) return;

    setState(() {
      _totalExpenses = results[0] as double;
      _recentExpenses = (results[1] as List<Expense>).take(5).toList();
      _categories = results[2] as List<Category>;
      _budgets = results[3] as List<Budget>;
      _categoryTotals = results[4] as Map<int, double>;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = widget.settingsBox.getSettings();

    // Build the screens for bottom navigation
    final screens = [
      _buildDashboardBody(l10n, settings),
      ExpenseListScreen(
        settingsBox: widget.settingsBox,
        onChanged: _loadDashboardData,
      ),
      CategoryScreen(onChanged: _loadDashboardData),
      BudgetScreen(
        settingsBox: widget.settingsBox,
        onChanged: _loadDashboardData,
      ),
      SettingsScreen(settingsBox: widget.settingsBox),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      body: screens[_selectedIndex],
      // FAB for quick expense entry
      floatingActionButton: _selectedIndex <= 1
          ? FloatingActionButton(
              onPressed: () => _navigateToExpenseForm(context),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          // Refresh data when switching to dashboard
          if (index == 0) _loadDashboardData();
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: l10n.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(Icons.receipt_long),
            label: l10n.expenses,
          ),
          NavigationDestination(
            icon: const Icon(Icons.category_outlined),
            selectedIcon: const Icon(Icons.category),
            label: l10n.categories,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: const Icon(Icons.account_balance_wallet),
            label: l10n.budgets,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }

  /// Builds the dashboard body with summary cards and recent transactions.
  Widget _buildDashboardBody(AppLocalizations l10n, AppSettings settings) {
    final currency = settings.currencySymbol;

    // Calculate total budget
    final totalBudget = _budgets.fold<double>(
      0,
      (sum, b) => sum + b.amount,
    );
    final totalRemaining = totalBudget - _totalExpenses;

    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Summary cards in a grid
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: [
              // Total expenses card (data from SQLite)
              SummaryCard(
                title: l10n.totalExpenses,
                value: '$currency${_totalExpenses.toStringAsFixed(2)}',
                icon: Icons.trending_up,
                iconColor: Colors.red,
                subtitle: l10n.expenseCount(_recentExpenses.length),
              ),
              // Monthly budget card (data from Isar)
              SummaryCard(
                title: l10n.monthlyBudget,
                value: '$currency${totalBudget.toStringAsFixed(2)}',
                icon: Icons.account_balance_wallet,
                iconColor: Colors.blue,
              ),
              // Remaining budget
              SummaryCard(
                title: l10n.remaining,
                value: '$currency${totalRemaining.toStringAsFixed(2)}',
                icon: totalRemaining >= 0
                    ? Icons.check_circle_outline
                    : Icons.warning_amber,
                iconColor: totalRemaining >= 0 ? Colors.green : Colors.orange,
              ),
              // Spent amount
              SummaryCard(
                title: l10n.spent,
                value: '$currency${_totalExpenses.toStringAsFixed(2)}',
                icon: Icons.shopping_cart,
                iconColor: Colors.purple,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Budget progress section
          if (_budgets.isNotEmpty) ...[
            Text(
              l10n.budgets,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ..._budgets.map((budget) {
              // Find the category for this budget
              Category? category;
              try {
                category = _categories.firstWhere(
                  (c) => budget.loadedCategory?.id == c.id,
                );
              } catch (_) {
                // Category not found -- may have been deleted
              }

              // Get spending for this category from SQLite totals
              final spent = category != null
                  ? _categoryTotals[category.id] ?? 0.0
                  : budget.spent;

              return BudgetProgress(
                categoryName: category?.name ?? 'Unknown',
                budgetAmount: budget.amount,
                spentAmount: spent,
                currencySymbol: currency,
                categoryColor:
                    category != null ? Color(category.colorValue) : null,
              );
            }),
            const SizedBox(height: 24),
          ],

          // Recent transactions section
          Text(
            l10n.expenses,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          if (_recentExpenses.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  l10n.noExpenses,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            ..._recentExpenses.map((expense) {
              // Find category info for display
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
                currencySymbol: currency,
                dateFormat: settings.dateFormat,
                categoryColor:
                    category != null ? Color(category.colorValue) : null,
                categoryIconCode: category?.iconCode,
                onTap: () => _navigateToExpenseForm(context, expense: expense),
                onDismissed: () => _deleteExpense(expense),
              );
            }),
        ],
      ),
    );
  }

  /// Navigates to the expense form for creating or editing an expense.
  Future<void> _navigateToExpenseForm(
    BuildContext context, {
    Expense? expense,
  }) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ExpenseFormScreen(
          expense: expense,
          settingsBox: widget.settingsBox,
        ),
      ),
    );

    // Refresh dashboard if an expense was saved
    if (result == true) {
      _loadDashboardData();
    }
  }

  /// Deletes an expense and refreshes the dashboard.
  Future<void> _deleteExpense(Expense expense) async {
    if (expense.id != null) {
      await _expenseDao.deleteExpense(expense.id!);
      _loadDashboardData();
    }
  }
}
