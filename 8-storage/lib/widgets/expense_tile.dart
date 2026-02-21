// =============================================================================
// Expense Tile Widget
// =============================================================================
//
// A list tile that displays a single expense with category icon,
// amount, and date. Supports swipe-to-delete and tap-to-edit.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

// ---------------------------------------------------------------------------
// Expense Tile
// ---------------------------------------------------------------------------

/// Displays a single expense as a dismissible list tile.
///
/// Shows the expense title, amount, date, and category indicator.
/// Swipe left to delete, tap to edit.
class ExpenseTile extends StatelessWidget {
  /// The expense to display
  final Expense expense;

  /// Currency symbol for formatting the amount
  final String currencySymbol;

  /// Date format string (e.g., "yyyy-MM-dd")
  final String dateFormat;

  /// Called when the tile is tapped (navigate to edit)
  final VoidCallback? onTap;

  /// Called when the tile is swiped to dismiss (delete)
  final VoidCallback? onDismissed;

  /// Category color for the leading indicator
  final Color? categoryColor;

  /// Category icon code point
  final int? categoryIconCode;

  const ExpenseTile({
    super.key,
    required this.expense,
    this.currencySymbol = '\$',
    this.dateFormat = 'yyyy-MM-dd',
    this.onTap,
    this.onDismissed,
    this.categoryColor,
    this.categoryIconCode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat(dateFormat).format(expense.date);
    final formattedAmount = expense.amount.toStringAsFixed(2);

    return Dismissible(
      key: Key('expense_${expense.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: theme.colorScheme.error,
        child: Icon(
          Icons.delete_outline,
          color: theme.colorScheme.onError,
        ),
      ),
      onDismissed: (_) => onDismissed?.call(),
      child: ListTile(
        // Category color indicator
        leading: CircleAvatar(
          backgroundColor: categoryColor ?? theme.colorScheme.primaryContainer,
          child: Icon(
            IconData(
              categoryIconCode ?? Icons.receipt_long.codePoint,
              fontFamily: 'MaterialIcons',
            ),
            color: categoryColor != null
                ? Colors.white
                : theme.colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        // Expense title with optional recurring indicator
        title: Row(
          children: [
            Expanded(
              child: Text(
                expense.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (expense.isRecurring)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.repeat,
                  size: 16,
                  color: theme.colorScheme.secondary,
                ),
              ),
          ],
        ),
        // Date and category name
        subtitle: Text(
          expense.categoryName != null
              ? '$formattedDate - ${expense.categoryName}'
              : formattedDate,
          style: theme.textTheme.bodySmall,
        ),
        // Amount
        trailing: Text(
          '$currencySymbol$formattedAmount',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
