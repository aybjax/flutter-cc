// =============================================================================
// Summary Card Widget
// =============================================================================
//
// A card that displays a financial summary metric (total expenses,
// budget remaining, etc.) with an icon and formatted amount.
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Summary Card
// ---------------------------------------------------------------------------

/// Displays a financial summary metric in a styled card.
///
/// Used on the dashboard to show:
/// - Total expenses this month
/// - Monthly budget remaining
/// - Number of transactions
class SummaryCard extends StatelessWidget {
  /// Title label (e.g., "Total Expenses")
  final String title;

  /// Formatted value to display (e.g., "\$1,234.56")
  final String value;

  /// Icon to show alongside the metric
  final IconData icon;

  /// Background color of the icon circle
  final Color? iconColor;

  /// Optional subtitle text
  final String? subtitle;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = iconColor ?? theme.colorScheme.primary;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: effectiveColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: effectiveColor,
                    size: 24,
                  ),
                ),
                const Spacer(),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 4),

            // Value
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            // Optional subtitle
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
