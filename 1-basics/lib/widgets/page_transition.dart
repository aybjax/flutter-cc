// =============================================================================
// Custom Page Transition
// =============================================================================
// Concepts demonstrated:
// - PageRouteBuilder — creating custom route transitions
// - Tween + CurvedAnimation for slide/fade transitions
// - transitionDuration and reverseTransitionDuration
// - SlideTransition, FadeTransition as transition widgets
// - Combining multiple transitions
// =============================================================================

import 'package:flutter/material.dart';

/// A custom page transition that fades and slides in the new page.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   FadeSlidePageRoute(page: const MyScreen()),
/// );
/// ```
///
/// [PageRouteBuilder] lets you define custom animations for route transitions.
/// You provide [pageBuilder] (the destination page) and [transitionsBuilder]
/// (the animation applied during the transition).
class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  /// The page widget to transition to.
  final Widget page;

  /// Creates a fade + slide page transition.
  FadeSlidePageRoute({required this.page})
      : super(
          // pageBuilder returns the destination page.
          pageBuilder: (context, animation, secondaryAnimation) => page,

          // transitionDuration: how long the enter transition takes.
          transitionDuration: const Duration(milliseconds: 400),

          // reverseTransitionDuration: how long the exit transition takes.
          reverseTransitionDuration: const Duration(milliseconds: 300),

          // transitionsBuilder defines the animation.
          // Parameters:
          // - context: BuildContext
          // - animation: the primary animation (0.0 → 1.0 on enter)
          // - secondaryAnimation: animation for when this route is being
          //   covered by another route (used for exit transitions)
          // - child: the page widget from pageBuilder
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Combine fade + slide transitions.

            // Fade: opacity goes from 0 to 1.
            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            // Slide: page slides up from bottom.
            // Tween maps 0..1 to an Offset range.
            // Offset(0, 0.3) means start 30% below the final position.
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0, 0.3), // Start position (30% below)
              end: Offset.zero, // End position (normal)
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ));

            // FadeTransition wraps the child with animated opacity.
            // SlideTransition wraps it with animated position.
            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            );
          },

          // opaque: whether this route is opaque (fully covers the previous route).
          // opaque: true,

          // barrierColor: color of the barrier behind the route.
          // barrierColor: null,

          // barrierDismissible: whether tapping the barrier closes the route.
          // barrierDismissible: false,

          // maintainState: whether the previous route stays in memory.
          // maintainState: true,

          // fullscreenDialog: if true, the route animates from the bottom
          // (like a modal) and shows a close button instead of a back arrow.
          // fullscreenDialog: false,
        );
}
