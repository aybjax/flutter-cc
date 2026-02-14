// =============================================================================
// Splash Screen
// =============================================================================
// Concepts demonstrated:
// - StatefulWidget vs StatelessWidget
//   • StatelessWidget: immutable, rebuild via parent. Use when UI depends
//     only on constructor args and inherited data (Provider, Theme).
//   • StatefulWidget: has mutable State. Use when the widget needs to
//     manage local state (animations, form input, controllers).
// - Widget lifecycle: initState → didChangeDependencies → build → dispose
// - Hero animation — shared-element transition between screens
// - Navigator.pushReplacementNamed — replaces current route (no back button)
// - Auto-login flow using AuthProvider.tryAutoLogin()
// - Animated splash with fade-in effect
// - SafeArea — respects notches, status bar, home indicator
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/route_names.dart';
import '../providers/auth_provider.dart';

/// The first screen shown on app launch.
///
/// Shows an animated logo while checking for a saved auth token.
/// If a token is found, navigates to home; otherwise, navigates to login.
///
/// This is a [StatefulWidget] because it needs:
/// 1. An [AnimationController] (requires dispose)
/// 2. initState to kick off the auto-login check
class SplashScreen extends StatefulWidget {
  /// Creates the splash screen.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// The mutable state for [SplashScreen].
///
/// Mixes in [SingleTickerProviderStateMixin] to provide a [Ticker]
/// for the animation controller. A Ticker fires once per frame and
/// drives animations.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Animation fields
  // ---------------------------------------------------------------------------

  /// Controls the fade-in animation.
  ///
  /// Must be disposed in [dispose] to prevent memory leaks.
  late final AnimationController _fadeController;

  /// The fade animation value (0.0 → 1.0).
  late final Animation<double> _fadeAnimation;

  // ---------------------------------------------------------------------------
  // Lifecycle: initState
  // ---------------------------------------------------------------------------

  /// Called once when the State is created.
  ///
  /// This is the place to:
  /// - Initialize controllers (animation, text editing, scroll)
  /// - Start async operations that don't depend on inherited widgets
  /// - Subscribe to streams
  ///
  /// Do NOT call Provider.of here — the widget isn't fully in the tree yet.
  /// Use [didChangeDependencies] for that.
  @override
  void initState() {
    super.initState(); // Always call super first

    // Create the animation controller.
    // `vsync: this` refers to the SingleTickerProviderStateMixin.
    // `duration` sets how long the animation takes.
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // CurvedAnimation adds easing (Curves.easeIn starts slow, speeds up).
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Start the fade-in animation.
    _fadeController.forward();

    // After a delay, check for auto-login.
    _navigateAfterDelay();
  }

  // ---------------------------------------------------------------------------
  // Lifecycle: didChangeDependencies
  // ---------------------------------------------------------------------------

  /// Called after initState and whenever an InheritedWidget changes.
  ///
  /// Safe to call Provider.of, Theme.of, MediaQuery.of here.
  /// Called more often than initState — use a flag if you only want
  /// to run logic once.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Example: you could pre-cache images here with precacheImage()
  }

  // ---------------------------------------------------------------------------
  // Lifecycle: dispose
  // ---------------------------------------------------------------------------

  /// Called when the State is permanently removed from the tree.
  ///
  /// MUST dispose all controllers to prevent memory leaks:
  /// - AnimationController
  /// - TextEditingController
  /// - FocusNode
  /// - ScrollController
  /// - StreamSubscription
  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose(); // Always call super last in dispose
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  /// Waits briefly, then navigates based on auth state.
  Future<void> _navigateAfterDelay() async {
    // Wait for the splash animation to play.
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still mounted (not disposed).
    // This prevents errors if the user navigated away during the delay.
    if (!mounted) return;

    // Try auto-login using the saved token.
    // listen: false because we're in a method, not in build().
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isLoggedIn = await authProvider.tryAutoLogin();

    if (!mounted) return;

    // pushReplacementNamed replaces the splash screen so the user
    // can't press Back to return to it.
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, RouteNames.home);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea insets its child to avoid system UI:
      // - Status bar at the top
      // - Home indicator / navigation bar at the bottom
      // - Notch / Dynamic Island on modern iPhones
      body: SafeArea(
        child: Center(
          // FadeTransition animates the opacity of its child.
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hero widget — creates a shared-element transition.
                // When navigating to another screen that has a Hero with
                // the same `tag`, the widget animates between positions.
                Hero(
                  tag: 'app_logo', // Must match on the destination screen
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Flutter Basics',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'A tutorial todo app',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 48),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
