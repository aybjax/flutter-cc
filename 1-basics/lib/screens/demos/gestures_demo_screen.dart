// =============================================================================
// Gestures Demo Screen
// =============================================================================
// Concepts demonstrated:
// - GestureDetector — detects taps, swipes, drags, and scales
//   • onTap, onDoubleTap, onLongPress
//   • onPanUpdate (drag), onScaleUpdate (pinch)
//   • onTapDown/Up/Cancel
//   • HitTestBehavior — how gestures interact with child widgets
// - InkWell — GestureDetector with Material ripple effect
//   • splashColor, highlightColor, borderRadius
//   • Requires a Material ancestor (explained below)
// - Draggable box with GestureDetector.onPanUpdate
// =============================================================================

import 'package:flutter/material.dart';

/// Demonstrates gesture handling with [GestureDetector] and [InkWell].
class GesturesDemoScreen extends StatefulWidget {
  /// Creates the gestures demo screen.
  const GesturesDemoScreen({super.key});

  @override
  State<GesturesDemoScreen> createState() => _GesturesDemoScreenState();
}

class _GesturesDemoScreenState extends State<GesturesDemoScreen> {
  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  /// Log of gesture events.
  final List<String> _gestureLog = [];

  /// Position of the draggable box.
  Offset _boxPosition = const Offset(100, 100);

  /// Color of the draggable box (changes on gestures).
  Color _boxColor = Colors.indigo;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Adds a message to the gesture log.
  void _log(String message) {
    setState(() {
      _gestureLog.insert(0, message);
      if (_gestureLog.length > 15) _gestureLog.removeLast();
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestures Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================================
            // Section 1: GestureDetector — Tap Gestures
            // =================================================================
            Text('1. GestureDetector — Taps',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),

            Center(
              child: GestureDetector(
                // -- Tap callbacks --
                onTap: () => _log('onTap'),
                onDoubleTap: () => _log('onDoubleTap'),
                onLongPress: () => _log('onLongPress'),

                // -- Tap detail callbacks --
                onTapDown: (details) {
                  _log('onTapDown at ${details.localPosition}');
                },
                onTapUp: (details) {
                  _log('onTapUp at ${details.localPosition}');
                },
                onTapCancel: () => _log('onTapCancel'),

                // -- HitTestBehavior --
                // Controls how the GestureDetector participates in hit testing.
                // deferToChild: only detect gestures on the child widget (default)
                // opaque: detect gestures on the entire area, even transparent parts
                // translucent: detect gestures and let them pass through
                behavior: HitTestBehavior.opaque,

                // -- Other gesture callbacks (commented for reference) --
                // onDoubleTapDown: (details) {},
                // onDoubleTapCancel: () {},
                // onLongPressStart: (details) {},
                // onLongPressMoveUpdate: (details) {},
                // onLongPressEnd: (details) {},
                // onLongPressUp: () {},
                // onSecondaryTap: () {},          // Right-click (desktop)
                // onSecondaryTapDown: (details) {},
                // onForcePressStart: (details) {}, // 3D Touch (iOS)
                // onForcePressPeak: (details) {},

                child: Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('Tap / Double Tap / Long Press'),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =================================================================
            // Section 2: InkWell — Material Ripple
            // =================================================================
            Text('2. InkWell — Material Ripple',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'InkWell adds a Material ripple effect on tap. '
              'It MUST be inside a Material widget (Card, Scaffold body, etc.) '
              'for the ripple to render correctly.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),

            Center(
              // Material is the parent that renders the ink splash.
              // Without it, InkWell's ripple won't be visible.
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _log('InkWell tapped'),
                  onDoubleTap: () => _log('InkWell double-tapped'),
                  onLongPress: () => _log('InkWell long-pressed'),

                  // -- InkWell visual properties --
                  splashColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.3), // Ripple color
                  highlightColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1), // Highlight on press
                  borderRadius: BorderRadius.circular(12), // Ripple shape

                  // hoverColor: ...,           // Color on hover (desktop/web)
                  // focusColor: ...,           // Color when focused
                  // splashFactory: ...,        // InkSplash or InkRipple
                  // overlayColor: ...,         // WidgetStateProperty overlay
                  // enableFeedback: true,      // Haptic/sound feedback
                  // excludeFromSemantics: false, // Accessibility
                  // customBorder: ...,         // Custom border shape

                  child: Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('InkWell with Ripple'),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =================================================================
            // Section 3: Draggable Box
            // =================================================================
            Text('3. Draggable Box (onPanUpdate)',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'GestureDetector.onPanUpdate tracks drag movements.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),

            // The drag area.
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _boxPosition.dx,
                    top: _boxPosition.dy,
                    child: GestureDetector(
                      // onPanUpdate fires continuously during a drag.
                      // details.delta gives the change in position since
                      // the last update.
                      onPanUpdate: (details) {
                        setState(() {
                          _boxPosition = Offset(
                            _boxPosition.dx + details.delta.dx,
                            _boxPosition.dy + details.delta.dy,
                          );
                        });
                      },
                      onPanStart: (_) {
                        setState(() {
                          _boxColor = Colors.orange;
                        });
                        _log('Drag started');
                      },
                      onPanEnd: (_) {
                        setState(() {
                          _boxColor = Colors.indigo;
                        });
                        _log('Drag ended');
                      },
                      // onScaleUpdate: (details) {},  // Pinch-to-zoom
                      // onScaleStart: (details) {},
                      // onScaleEnd: (details) {},
                      // onHorizontalDragUpdate: ...,   // Horizontal only
                      // onVerticalDragUpdate: ...,     // Vertical only
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _boxColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _boxColor.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.drag_indicator, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =================================================================
            // Gesture Log
            // =================================================================
            Text('Gesture Log', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_gestureLog.isEmpty)
                    Text(
                      'Interact with widgets above to see events',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ..._gestureLog.map(
                    (log) => Text(log,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
