// =============================================================================
// Budget Progress Widget
// =============================================================================
//
// A visual indicator showing budget progress with a linear progress bar
// and spent/remaining amounts. Changes color based on spending level.
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Budget Progress
// ---------------------------------------------------------------------------

/// Displays budget progress as a labeled linear progress bar.
///
/// The bar color changes based on spending level:
/// - Green: Under 60% of budget
/// - Orange: 60-90% of budget
/// - Red: Over 90% of budget (or over budget)
class BudgetProgress extends StatelessWidget {
  /// Category name displayed above the bar
  final String categoryName;

  /// Total budget amount
  final double budgetAmount;

  /// Amount spent so far
  final double spentAmount;

  /// Currency symbol for formatting
  final String currencySymbol;

  /// Optional category color for the leading indicator
  final Color? categoryColor;

  const BudgetProgress({
    super.key,
    required this.categoryName,
    required this.budgetAmount,
    required this.spentAmount,
    this.currencySymbol = '\$',
    this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Clamp progress to 0.0-1.0 for the bar, but show actual percentage
    final progress = budgetAmount > 0 ? spentAmount / budgetAmount : 0.0;
    final clampedProgress = progress.clamp(0.0, 1.0);
    final remaining = budgetAmount - spentAmount;
    final isOverBudget = spentAmount > budgetAmount;

    // Color based on spending level
    final progressColor = _getProgressColor(progress);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: category name + percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (categoryColor != null)
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: categoryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      categoryName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: progressColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: clampedProgress,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 8,
              ),
            ),

            const SizedBox(height: 8),

            // Footer row: spent / budget amounts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$currencySymbol${spentAmount.toStringAsFixed(2)} spent',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  isOverBudget
                      ? '$currencySymbol${(-remaining).toStringAsFixed(2)} over'
                      : '$currencySymbol${remaining.toStringAsFixed(2)} left',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isOverBudget
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the progress bar color based on spending percentage.
  ///
  /// - Under 60%: green (safe)
  /// - 60-90%: orange (warning)
  /// - Over 90%: red (danger)
  Color _getProgressColor(double progress) {
    if (progress >= 0.9) return Colors.red;
    if (progress >= 0.6) return Colors.orange;
    return Colors.green;

    // Alternative: Use a gradient for smoother transitions
    // return Color.lerp(Colors.green, Colors.red, progress) ?? Colors.green;
  }
}
