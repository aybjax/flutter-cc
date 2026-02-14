// =============================================================================
// Custom SnackBar Helper
// =============================================================================
// Concepts demonstrated:
// - SnackBar — a brief message shown at the bottom of the screen
// - ScaffoldMessenger — the modern way to show SnackBars
// - Static methods — utility functions that don't need instance state
// - Named parameters with defaults
// - SnackBarAction — an optional action button in the SnackBar
// =============================================================================

import 'package:flutter/material.dart';

/// Helper class for showing themed [SnackBar] messages.
///
/// Uses static methods so you don't need to create an instance:
/// ```dart
/// CustomSnackBar.show(context, message: 'Saved!');
/// CustomSnackBar.showError(context, message: 'Something went wrong');
/// ```
///
/// [ScaffoldMessenger.of(context)] finds the nearest [ScaffoldMessenger]
/// ancestor, which manages SnackBars for its Scaffold. This replaced the
/// older `Scaffold.of(context).showSnackBar(...)` pattern.
abstract final class CustomSnackBar {
  /// Shows a standard informational SnackBar.
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    // Remove any currently showing SnackBar before showing a new one.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        // behavior: SnackBarBehavior.floating,  // Set in theme
        // shape: ...,                            // Set in theme
        // margin: ...,                           // Margin when floating
        // padding: ...,                          // Internal padding
        // width: ...,                            // Fixed width (floating only)
        // elevation: ...,                        // Shadow depth
        // backgroundColor: ...,                  // Uses theme default
        // clipBehavior: Clip.hardEdge,           // How to clip content
        // dismissDirection: DismissDirection.down, // Swipe to dismiss
        // showCloseIcon: false,                  // X button
        // closeIconColor: ...,                   // X button color

        // SnackBarAction — an optional button inside the SnackBar.
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction ?? () {},
                // textColor: ...,                // Action text color
                // disabledTextColor: ...,        // When disabled
                // backgroundColor: ...,          // Action button background
              )
            : null,
      ),
    );
  }

  /// Shows an error-styled SnackBar with a red background.
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: duration,
      ),
    );
  }

  /// Shows a success-styled SnackBar with a green background.
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: duration,
      ),
    );
  }
}
