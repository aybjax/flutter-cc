// =============================================================================
// Animation Demo Screen
// =============================================================================
// Concepts demonstrated:
// - AnimationController — drives animations (vsync, duration, forward, reverse)
// - TickerProviderStateMixin — provides multiple Tickers for multiple controllers
// - AnimatedBuilder — rebuilds when animation value changes
// - FadeTransition — animates opacity
// - Matrix4 — 3D transformations (rotateZ, rotateX, rotateY)
// - Color.fromRGBO — dynamic colors based on animation value
// - Tween — maps animation value (0..1) to a custom range
// - CurvedAnimation — applies easing curves to animations
// - Curves — built-in easing curves (bounceOut, elasticIn, easeInOut)
// - forward, reverse, repeat, reset — controlling animation playback
// - addStatusListener — reacting to animation completion
// - Cascade operator (..) for Matrix4 operations
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Demonstrates animation fundamentals with three independent controllers.
///
/// 1. Fade animation — opacity transitions
/// 2. Rotation animation — Matrix4 rotations with curves
/// 3. Color animation — dynamic color changes
class AnimationDemoScreen extends StatefulWidget {
  /// Creates the animation demo screen.
  const AnimationDemoScreen({super.key});

  @override
  State<AnimationDemoScreen> createState() => _AnimationDemoScreenState();
}

/// Uses [TickerProviderStateMixin] (not Single) because we have 3 controllers.
///
/// [SingleTickerProviderStateMixin] — for exactly 1 AnimationController.
/// [TickerProviderStateMixin] — for 2+ AnimationControllers.
class _AnimationDemoScreenState extends State<AnimationDemoScreen>
    with TickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Animation controllers
  // ---------------------------------------------------------------------------

  /// Controls the fade animation.
  ///
  /// AnimationController has a value from 0.0 to 1.0 (or lowerBound/upperBound).
  /// It ticks every frame, calling listeners to update the UI.
  late final AnimationController _fadeController;

  /// Controls the rotation animation.
  late final AnimationController _rotationController;

  /// Controls the color animation.
  late final AnimationController _colorController;

  // ---------------------------------------------------------------------------
  // Animations (Tweens + Curves)
  // ---------------------------------------------------------------------------

  /// The fade animation with easing.
  late final Animation<double> _fadeAnimation;

  /// The rotation animation with a bounce curve.
  late final Animation<double> _rotationAnimation;

  /// The color animation value.
  late final Animation<double> _colorAnimation;

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  /// Log of animation status changes.
  final List<String> _statusLog = [];

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    // -- Fade Controller --
    _fadeController = AnimationController(
      vsync: this, // Ticker from TickerProviderStateMixin
      duration: const Duration(milliseconds: 1500),
      // lowerBound: 0.0,    // Minimum value (default)
      // upperBound: 1.0,    // Maximum value (default)
      // value: 0.0,         // Initial value (defaults to lowerBound)
      // debugLabel: 'fade', // Label for debugging
    );

    // CurvedAnimation wraps a controller and applies an easing curve.
    // Curves change the *speed* of the animation over time.
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn, // Starts slow, speeds up
      // reverseCurve: Curves.easeOut, // Different curve for reverse
    );

    // addStatusListener fires when the animation starts, ends, etc.
    _fadeController.addStatusListener((status) {
      // AnimationStatus values:
      // - dismissed: at the start (value == lowerBound)
      // - forward: animating toward upperBound
      // - reverse: animating toward lowerBound
      // - completed: at the end (value == upperBound)
      setState(() {
        _statusLog.insert(0, 'Fade: $status');
        if (_statusLog.length > 10) _statusLog.removeLast();
      });
    });

    // -- Rotation Controller --
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Tween maps the controller's 0..1 range to a custom range.
    // Here we map to 0..2π (full rotation in radians).
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi, // Full 360° rotation
    ).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.bounceOut, // Bouncy ending
        // Other interesting curves:
        // Curves.elasticIn     — elastic stretch at start
        // Curves.elasticOut    — elastic stretch at end
        // Curves.easeInOutBack — overshoots then settles
        // Curves.decelerate    — fast start, slow end
        // Curves.linear        — constant speed
      ),
    );

    // -- Color Controller --
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _colorAnimation = CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    );

    // Start the color animation on repeat (back and forth).
    _colorController.repeat(reverse: true);
    // repeat() plays the animation in a loop:
    // - reverse: true — alternates forward/reverse
    // - reverse: false — always plays forward (jumps back to start)
  }

  @override
  void dispose() {
    // MUST dispose all controllers to prevent memory leaks.
    _fadeController.dispose();
    _rotationController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================================
            // Section 1: Fade Animation
            // =================================================================
            Text('1. Fade Animation',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'FadeTransition animates the opacity of its child.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),

            Center(
              // FadeTransition is a built-in widget that animates opacity.
              // It takes an Animation<double> (not AnimationController directly).
              child: FadeTransition(
                opacity: _fadeAnimation,
                // alwaysIncludeSemantics: false, // Include in accessibility tree
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Fade Me',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Control buttons for fade animation.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // forward() plays from current value to upperBound.
                ElevatedButton(
                  onPressed: () => _fadeController.forward(),
                  child: const Text('Fade In'),
                ),
                const SizedBox(width: 8),
                // reverse() plays from current value to lowerBound.
                OutlinedButton(
                  onPressed: () => _fadeController.reverse(),
                  child: const Text('Fade Out'),
                ),
                const SizedBox(width: 8),
                // reset() jumps to lowerBound without animation.
                TextButton(
                  onPressed: () => _fadeController.reset(),
                  child: const Text('Reset'),
                ),
              ],
            ),

            const Divider(height: 32),

            // =================================================================
            // Section 2: Rotation Animation
            // =================================================================
            Text('2. Rotation (Matrix4)',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'AnimatedBuilder + Matrix4.rotateZ for 3D transforms.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),

            Center(
              // AnimatedBuilder rebuilds its child on every animation frame.
              // More efficient than using setState because it limits rebuilds
              // to just this subtree.
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                // child: passed to builder for optimization.
                // If you have static content, pass it as child and reference
                // it in builder — this prevents recreating the widget each frame.
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Spin',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                builder: (context, child) {
                  return Transform(
                    // Matrix4 represents a 4x4 transformation matrix.
                    // The cascade operator (..) chains method calls:
                    //   Matrix4.identity()
                    //     ..rotateZ(angle)    — rotate around Z axis
                    //
                    // Other rotation axes:
                    //   ..rotateX(angle)  — rotate around X (tilts forward/back)
                    //   ..rotateY(angle)  — rotate around Y (tilts left/right)
                    //
                    // The cascade (..) is syntactic sugar for:
                    //   var m = Matrix4.identity();
                    //   m.rotateZ(angle);
                    //   return m;
                    transform: Matrix4.identity()
                      ..rotateZ(_rotationAnimation.value),
                    alignment: Alignment.center, // Rotate around center
                    child: child, // The static child from above
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _rotationController.forward(from: 0),
                  child: const Text('Spin'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => _rotationController.repeat(),
                  child: const Text('Loop'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => _rotationController.stop(),
                  child: const Text('Stop'),
                ),
              ],
            ),

            const Divider(height: 32),

            // =================================================================
            // Section 3: Color Animation
            // =================================================================
            Text('3. Color Animation',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Color.fromRGBO with dynamic values from animation.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),

            Center(
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  // Color.fromRGBO creates a color from Red, Green, Blue, Opacity.
                  // Each RGB value is 0-255, opacity is 0.0-1.0.
                  // By multiplying animation value (0..1) by 255, we get
                  // a smooth color transition.
                  final color = Color.fromRGBO(
                    (255 * _colorAnimation.value).toInt(), // Red varies
                    100, // Green stays constant
                    (255 * (1 - _colorAnimation.value)).toInt(), // Blue varies inversely
                    1.0, // Fully opaque
                  );

                  return Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'R:${(255 * _colorAnimation.value).toInt()} '
                        'G:100 '
                        'B:${(255 * (1 - _colorAnimation.value)).toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 32),

            // =================================================================
            // Status Log
            // =================================================================
            Text('Animation Status Log',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_statusLog.isEmpty)
                    Text(
                      'Interact with animations to see status changes',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ..._statusLog.map(
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
