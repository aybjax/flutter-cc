// =============================================================================
// Lifecycle Demo Screen
// =============================================================================
// Concepts demonstrated:
// - Widget lifecycle (StatefulWidget):
//   1. createState()        — creates the mutable State object
//   2. initState()          — called once when State is inserted into the tree
//   3. didChangeDependencies() — called after initState and when InheritedWidget changes
//   4. build()              — called whenever the UI needs to be drawn
//   5. didUpdateWidget()    — called when parent rebuilds with a new widget config
//   6. deactivate()         — called when State is removed from the tree (may reinsert)
//   7. dispose()            — called when State is permanently removed
//
// - App lifecycle (WidgetsBindingObserver):
//   • resumed   — app is visible and responding to user input
//   • inactive  — app is visible but not responding (e.g., phone call overlay)
//   • paused    — app is not visible (in background)
//   • detached  — app is still running but detached from any view
//   • hidden    — app is transitioning to/from being hidden
//
// ASCII Lifecycle Diagram:
// ┌──────────────────────────────────────────────────────────────────────┐
// │                     WIDGET LIFECYCLE                                │
// │                                                                      │
// │  Constructor → createState() → initState() → didChangeDependencies() │
// │                                                    ↓                 │
// │                                                 build()              │
// │                                                    ↓                 │
// │                          ┌── didUpdateWidget() ←── (parent rebuilds) │
// │                          ↓                                           │
// │                       build() (rebuild)                              │
// │                          ↓                                           │
// │                     deactivate() → dispose()                         │
// └──────────────────────────────────────────────────────────────────────┘
//
// ┌──────────────────────────────────────────────────────────────────────┐
// │                       APP LIFECYCLE                                  │
// │                                                                      │
// │  resumed ←→ inactive ←→ hidden ←→ paused                           │
// │                                      ↓                               │
// │                                   detached                           │
// └──────────────────────────────────────────────────────────────────────┘
// =============================================================================

import 'package:flutter/material.dart';

/// Demonstrates widget and app lifecycle events with an on-screen log.
///
/// Implements [WidgetsBindingObserver] to receive app lifecycle callbacks.
/// All lifecycle events are timestamped and displayed in a scrollable log.
class LifecycleDemoScreen extends StatefulWidget {
  /// Creates the lifecycle demo screen.
  const LifecycleDemoScreen({super.key});

  @override
  State<LifecycleDemoScreen> createState() {
    // This is step 1: createState()
    // Called by the framework to create the State object.
    return _LifecycleDemoScreenState();
  }
}

class _LifecycleDemoScreenState extends State<LifecycleDemoScreen>
    with WidgetsBindingObserver {
  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  /// Log of lifecycle events with timestamps.
  final List<String> _lifecycleLog = [];

  /// Counter to demonstrate didUpdateWidget.
  int _buildCount = 0;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Adds a timestamped entry to the lifecycle log.
  void _log(String event) {
    final now = DateTime.now();
    final timestamp = '${now.hour}:${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    setState(() {
      _lifecycleLog.insert(0, '[$timestamp] $event');
      if (_lifecycleLog.length > 50) _lifecycleLog.removeLast();
    });
  }

  // ---------------------------------------------------------------------------
  // Widget Lifecycle Methods
  // ---------------------------------------------------------------------------

  /// Step 2: initState()
  ///
  /// Called exactly ONCE when the State is first inserted into the tree.
  /// Use for:
  /// - Initializing controllers
  /// - Subscribing to streams
  /// - Starting async operations
  ///
  /// Do NOT call Provider.of or Theme.of here — use didChangeDependencies.
  @override
  void initState() {
    super.initState(); // Always call super first
    // Register as an observer to receive app lifecycle callbacks.
    WidgetsBinding.instance.addObserver(this);
    _log('initState()');
  }

  /// Step 3: didChangeDependencies()
  ///
  /// Called immediately after initState() and whenever an InheritedWidget
  /// (Theme, MediaQuery, Provider) that this State depends on changes.
  ///
  /// Safe to call Theme.of, MediaQuery.of, Provider.of here.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _log('didChangeDependencies()');
  }

  /// Step 5: didUpdateWidget()
  ///
  /// Called when the parent widget rebuilds and passes a new configuration
  /// to this widget. The old widget is passed as a parameter so you can
  /// compare old vs new configuration.
  ///
  /// Common use: update controllers when widget properties change.
  @override
  void didUpdateWidget(covariant LifecycleDemoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _log('didUpdateWidget()');
  }

  /// Step 6: deactivate()
  ///
  /// Called when the State is removed from the tree. The State might be
  /// reinserted later (e.g., when using GlobalKey to move widgets).
  ///
  /// Rarely used — most cleanup goes in dispose().
  @override
  void deactivate() {
    // Can't call _log here because setState is not safe during deactivate.
    super.deactivate();
  }

  /// Step 7: dispose()
  ///
  /// Called when the State is permanently removed. Clean up here:
  /// - Dispose controllers
  /// - Cancel subscriptions
  /// - Remove observers
  ///
  /// After dispose(), the State cannot be used again.
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Can't call _log because the State is being destroyed.
    super.dispose(); // Always call super last in dispose
  }

  // ---------------------------------------------------------------------------
  // App Lifecycle (WidgetsBindingObserver)
  // ---------------------------------------------------------------------------

  /// Called when the app lifecycle state changes.
  ///
  /// [AppLifecycleState] values:
  /// - [resumed] — visible and interactive (foreground)
  /// - [inactive] — visible but not interactive (e.g., incoming call)
  /// - [hidden] — transitioning to/from hidden
  /// - [paused] — not visible (background)
  /// - [detached] — still running but no view attached
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _log('AppLifecycle: ${state.name}');
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  /// Step 4: build()
  ///
  /// Called whenever the UI needs to be drawn — after initState,
  /// after setState, after didUpdateWidget, etc.
  ///
  /// Should be PURE — no side effects. Don't call setState here.
  /// build() can be called many times, so keep it efficient.
  @override
  Widget build(BuildContext context) {
    _buildCount++;

    return Scaffold(
      appBar: AppBar(title: const Text('Lifecycle Demo')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Info card --
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Widget Lifecycle',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Build count: $_buildCount',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Try: rotating device, pressing home, opening another app, '
                      'then returning. Watch the log below.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            // -- Trigger buttons --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // setState triggers a rebuild → build() is called again.
                      setState(() {});
                      _log('setState() called → rebuild');
                    },
                    child: const Text('Trigger Rebuild'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _lifecycleLog.clear();
                      });
                    },
                    child: const Text('Clear Log'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // -- Lifecycle log --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Event Log',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),

            // Scrollable log list.
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _lifecycleLog.length,
                  itemBuilder: (context, index) {
                    final entry = _lifecycleLog[index];
                    // Color-code different event types.
                    Color textColor;
                    if (entry.contains('AppLifecycle')) {
                      textColor = Theme.of(context).colorScheme.tertiary;
                    } else if (entry.contains('initState') ||
                        entry.contains('dispose')) {
                      textColor = Theme.of(context).colorScheme.error;
                    } else {
                      textColor = Theme.of(context).colorScheme.onSurface;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        entry,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: textColor),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
