// =============================================================================
// Loading Overlay Widget
// =============================================================================
// Concepts demonstrated:
// - Stack — layering widgets on top of each other
// - AbsorbPointer — blocking touch events on underlying widgets
// - CircularProgressIndicator — Material loading spinner
// - Conditional rendering with ternary operator in widget tree
// - Composing widgets: Stack + Positioned/Opacity + AbsorbPointer
// =============================================================================

import 'package:flutter/material.dart';

/// A semi-transparent overlay with a loading spinner.
///
/// Wraps a [child] widget. When [isLoading] is true, a dark overlay with
/// a [CircularProgressIndicator] covers the child, and [AbsorbPointer]
/// prevents the user from interacting with the widgets underneath.
///
/// Usage:
/// ```dart
/// LoadingOverlay(
///   isLoading: provider.isLoading,
///   child: MyForm(),
/// )
/// ```
class LoadingOverlay extends StatelessWidget {
  /// Whether to show the loading overlay.
  final bool isLoading;

  /// The widget to display underneath the overlay.
  final Widget child;

  /// Creates a [LoadingOverlay].
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Stack layers widgets on top of each other.
    // The first child is at the bottom; subsequent children overlay it.
    return Stack(
      children: [
        // The main content — always rendered.
        child,

        // The overlay — only rendered when loading.
        if (isLoading)
          // Positioned.fill makes this child cover the entire Stack.
          Positioned.fill(
            // AbsorbPointer swallows all touch events so the user
            // can't tap buttons while loading.
            child: AbsorbPointer(
              // absorbing: true is the default — included for clarity.
              absorbing: true,
              child: Container(
                // Semi-transparent black overlay.
                color: Colors.black.withValues(alpha: 0.3),
                // Center the spinner in the overlay.
                child: const Center(
                  child: CircularProgressIndicator(
                    // strokeWidth: 4.0,       // Thickness of the arc
                    // backgroundColor: ...,    // Track color behind the arc
                    // valueColor: ...,         // Animated color of the arc
                    // value: null,             // null = indeterminate (spinning)
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
