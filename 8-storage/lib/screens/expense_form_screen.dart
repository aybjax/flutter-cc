// =============================================================================
// Expense Form Screen
// =============================================================================
//
// Form for creating and editing expenses. Demonstrates:
// - SQLite INSERT and UPDATE via ExpenseDao
// - Loading categories from Isar for the dropdown
// - Reading settings from Hive for currency display
// - Form validation
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../storage/sqlite/expense_dao.dart';
import '../storage/hive/settings_box.dart';
import '../storage/isar/category_dao.dart';

// ---------------------------------------------------------------------------
// Expense Form Screen
// ---------------------------------------------------------------------------

/// Form screen for creating or editing an expense.
///
/// When [expense] is null, creates a new expense.
/// When [expense] is provided, edits the existing expense.
///
/// Data flow:
/// 1. Categories loaded from Isar (for dropdown)
/// 2. Currency loaded from Hive (for display)
/// 3. Expense saved to SQLite (on submit)
class ExpenseFormScreen extends StatefulWidget {
  /// Existing expense to edit, or null for creating a new one
  final Expense? expense;

  /// Settings box for currency symbol
  final SettingsBox settingsBox;

  const ExpenseFormScreen({
    super.key,
    this.expense,
    required this.settingsBox,
  });

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ExpenseDao _expenseDao = ExpenseDao();
  final CategoryDao _categoryDao = CategoryDao();

  // Form controllers
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _notesController;

  // Form state
  DateTime _selectedDate = DateTime.now();
  int? _selectedCategoryId;
  String? _selectedCategoryName;
  bool _isRecurring = false;
  List<Category> _categories = [];
  bool _isSaving = false;

  /// Whether we are editing an existing expense
  bool get _isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing expense data or empty values
    final expense = widget.expense;
    _titleController = TextEditingController(text: expense?.title ?? '');
    _amountController = TextEditingController(
      text: expense != null ? expense.amount.toStringAsFixed(2) : '',
    );
    _notesController = TextEditingController(text: expense?.notes ?? '');

    if (expense != null) {
      _selectedDate = expense.date;
      _selectedCategoryId = expense.categoryId;
      _selectedCategoryName = expense.categoryName;
      _isRecurring = expense.isRecurring;
    }

    _loadCategories();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  /// Loads categories from Isar for the category dropdown.
  Future<void> _loadCategories() async {
    final categories = await _categoryDao.getAllCategories();
    if (!mounted) return;
    setState(() => _categories = categories);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = widget.settingsBox.getSettings();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editExpense : l10n.addExpense),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ---------------------------------------------------------------------------
            // Title field
            // ---------------------------------------------------------------------------
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.expenseTitle,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
            ),

            const SizedBox(height: 16),

            // ---------------------------------------------------------------------------
            // Amount field
            // ---------------------------------------------------------------------------
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: l10n.expenseAmount,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.attach_money),
                prefixText: settings.currencySymbol,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid positive amount';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // ---------------------------------------------------------------------------
            // Date picker
            // ---------------------------------------------------------------------------
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(l10n.expenseDate),
              subtitle: Text(
                DateFormat(settings.dateFormat).format(_selectedDate),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
              onTap: _pickDate,
            ),

            const SizedBox(height: 16),

            // ---------------------------------------------------------------------------
            // Category dropdown (data from Isar)
            // ---------------------------------------------------------------------------
            DropdownButtonFormField<int>(
              initialValue: _selectedCategoryId,
              decoration: InputDecoration(
                labelText: l10n.expenseCategory,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.category),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Color(category.colorValue),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                  // Cache the category name for display without JOIN
                  if (value != null) {
                    try {
                      _selectedCategoryName = _categories
                          .firstWhere((c) => c.id == value)
                          .name;
                    } catch (_) {
                      _selectedCategoryName = null;
                    }
                  }
                });
              },
              // Alternative: Use initialValue instead of value
              // initialValue: _selectedCategoryId,
            ),

            const SizedBox(height: 16),

            // ---------------------------------------------------------------------------
            // Notes field
            // ---------------------------------------------------------------------------
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: l10n.expenseNotes,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.notes),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),

            const SizedBox(height: 16),

            // ---------------------------------------------------------------------------
            // Recurring toggle
            // ---------------------------------------------------------------------------
            SwitchListTile(
              title: const Text('Recurring Expense'),
              subtitle: const Text('This expense repeats regularly'),
              value: _isRecurring,
              onChanged: (value) {
                setState(() => _isRecurring = value);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
            ),

            const SizedBox(height: 24),

            // ---------------------------------------------------------------------------
            // Save button
            // ---------------------------------------------------------------------------
            FilledButton.icon(
              onPressed: _isSaving ? null : _saveExpense,
              icon: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(l10n.save),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a date picker dialog.
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  /// Validates the form and saves the expense to SQLite.
  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final expense = Expense(
        id: widget.expense?.id,
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        categoryId: _selectedCategoryId,
        categoryName: _selectedCategoryName,
        notes: _notesController.text.trim(),
        isRecurring: _isRecurring,
      );

      if (_isEditing) {
        // UPDATE existing expense in SQLite
        await _expenseDao.updateExpense(expense);
      } else {
        // INSERT new expense into SQLite
        await _expenseDao.insertExpense(expense);
      }

      if (!mounted) return;
      Navigator.pop(context, true); // true = expense was saved
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving expense: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
