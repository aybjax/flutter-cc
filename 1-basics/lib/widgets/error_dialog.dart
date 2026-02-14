// =============================================================================
// Error Dialog Widget
// =============================================================================
// Concepts demonstrated:
// - AlertDialog — a modal dialog with title, content, and action buttons
// - showDialog — the function that displays a dialog
// - Navigator.pop — closing the dialog
// - Static helper pattern for showing dialogs
// - BuildContext — required to show dialogs and access theme
// =============================================================================

import 'package:flutter/material.dart';

/// Helper class for showing error dialogs.
///
/// Usage:
/// ```dart
/// ErrorDialog.show(
///   context,
///   title: 'Error',
///   message: 'Something went wrong. Please try again.',
/// );
/// ```
abstract final class ErrorDialog {
  /// Shows a modal error dialog with a title, message, and OK button.
  ///
  /// [showDialog] returns a Future that completes when the dialog is closed.
  /// The `<void>` generic means we don't expect a return value.
  static Future<void> show(
    BuildContext context, {
    String title = 'Error',
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      // barrierDismissible controls whether tapping outside closes the dialog.
      // For errors, we set it to true so the user can easily dismiss.
      barrierDismissible: true,
      // barrierColor: Colors.black54,           // Overlay color behind dialog
      // barrierLabel: 'Dismiss',                // Accessibility label
      // useRootNavigator: true,                 // Use root vs nearest navigator
      // routeSettings: ...,                     // Route name for analytics
      builder: (dialogContext) {
        return AlertDialog(
          // -- AlertDialog fields --
          title: Text(title),
          content: Text(message),
          // icon: Icon(Icons.error_outline),     // Icon above the title
          // iconColor: ...,                       // Icon color
          // iconPadding: ...,                     // Padding around icon
          // titlePadding: ...,                    // Padding around title
          // titleTextStyle: ...,                  // Override title style
          // contentPadding: ...,                  // Padding around content
          // contentTextStyle: ...,                // Override content style
          // actionsPadding: ...,                  // Padding around buttons
          // actionsAlignment: ...,                // MainAxisAlignment of buttons
          // actionsOverflowAlignment: ...,        // When buttons overflow
          // actionsOverflowDirection: ...,        // Overflow direction
          // actionsOverflowButtonSpacing: ...,    // Spacing in overflow
          // buttonPadding: ...,                   // Padding for each button
          // backgroundColor: ...,                 // Dialog background (from theme)
          // elevation: ...,                       // Shadow (from theme)
          // shadowColor: ...,                     // Shadow color
          // surfaceTintColor: ...,                // M3 surface tint
          // insetPadding: ...,                    // Distance from screen edges
          // clipBehavior: Clip.none,              // How to clip content
          // shape: ...,                           // Border shape (from theme)
          // alignment: ...,                       // Position on screen
          // scrollable: false,                    // Wrap content in scroll view

          actions: [
            TextButton(
              onPressed: () {
                // Navigator.pop closes the topmost route — in this case,
                // the dialog. Dialogs are pushed as routes internally.
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Shows a confirmation dialog with Cancel and Confirm buttons.
  ///
  /// Returns `true` if the user confirmed, `false` if they cancelled.
  /// The `<bool>` generic on showDialog sets the return type.
  static Future<bool> showConfirmation(
    BuildContext context, {
    String title = 'Confirm',
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Force user to choose an action
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(cancelLabel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );

    // If the dialog was dismissed without a result (shouldn't happen with
    // barrierDismissible: false), default to false.
    return result ?? false;
  }
}
