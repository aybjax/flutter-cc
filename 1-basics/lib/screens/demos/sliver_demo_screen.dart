// =============================================================================
// Sliver Demo Screen
// =============================================================================
// Concepts demonstrated:
// - CustomScrollView — a scroll view built from slivers
// - SliverAppBar — a collapsible/expandable app bar
//   • expandedHeight, floating, pinned, snap, stretch
//   • flexibleSpace — content that scales/collapses
// - SliverList — a list built from a sliver delegate
//   • SliverChildBuilderDelegate — lazy item builder
//   • SliverChildListDelegate — explicit list of children
// - SliverGrid — a grid built from a sliver delegate
// - SliverToBoxAdapter — wraps a regular widget as a sliver
// - Scroll physics: BouncingScrollPhysics, ClampingScrollPhysics
//
// What are Slivers?
// -----------------
// Slivers are scrollable pieces of a layout. While ListView and GridView
// use slivers internally, CustomScrollView lets you compose multiple
// slivers into a single scroll view. This is powerful for:
// - Collapsible app bars
// - Mixed lists and grids in one scroll view
// - Custom scroll effects
// =============================================================================

import 'package:flutter/material.dart';

/// Demonstrates [CustomScrollView] with various sliver widgets.
///
/// Shows how slivers compose together to create complex scrolling layouts
/// that would be impossible with regular widgets.
class SliverDemoScreen extends StatelessWidget {
  /// Creates the sliver demo screen.
  const SliverDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // CustomScrollView is a ScrollView that creates custom scroll effects
    // using slivers. Unlike ListView or GridView, you can mix different
    // types of scrollable content.
    return Scaffold(
      body: CustomScrollView(
        // physics: controls scroll behavior.
        // BouncingScrollPhysics — iOS-style bounce at edges.
        // ClampingScrollPhysics — Android-style hard stop at edges.
        // NeverScrollableScrollPhysics — disables scrolling.
        // AlwaysScrollableScrollPhysics — always allows scrolling.
        physics: const BouncingScrollPhysics(),

        // slivers: the list of sliver widgets that make up this scroll view.
        // Each sliver handles its own portion of the scrollable area.
        slivers: [
          // ===================================================================
          // SliverAppBar — Collapsible App Bar
          // ===================================================================
          SliverAppBar(
            // expandedHeight: the height when fully expanded.
            // The app bar collapses as the user scrolls down.
            expandedHeight: 250.0,

            // floating: if true, the app bar reappears as soon as the user
            // scrolls up (even a little). If false, it only reappears when
            // scrolled all the way to the top.
            floating: false,

            // pinned: if true, the collapsed app bar remains visible at the
            // top. If false, it scrolls completely out of view.
            pinned: true,

            // snap: if true (requires floating: true), the app bar snaps
            // open/closed rather than partially showing. Provides a more
            // decisive feel.
            // snap: false,

            // stretch: if true, the app bar stretches when over-scrolled
            // (pulling down past the top). Creates an elastic effect.
            stretch: true,

            // stretchTriggerOffset: how far to over-scroll before triggering
            // onStretchTrigger.
            // stretchTriggerOffset: 100.0,
            // onStretchTrigger: () async { /* refresh data */ },

            // forceElevated: forces a shadow even when not scrolled under.
            // forceElevated: false,

            // elevation: shadow depth when scrolled under.
            // elevation: 4.0,

            // backgroundColor: app bar background color.
            // backgroundColor: Theme.of(context).colorScheme.primary,

            // foregroundColor: icon and text color.
            // foregroundColor: Colors.white,

            // flexibleSpace: the content that scales and collapses.
            flexibleSpace: FlexibleSpaceBar(
              // title: collapses into the app bar title area.
              title: const Text('Sliver Demo'),
              // titlePadding: EdgeInsetsDirectional.only(start: 72, bottom: 16),
              // centerTitle: true,

              // background: the content behind the title, visible when expanded.
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.view_list,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),

              // collapseMode: how the background behaves during collapse.
              // CollapseMode.parallax — background scrolls slower (parallax)
              // CollapseMode.pin — background stays fixed
              // CollapseMode.none — background scrolls normally
              collapseMode: CollapseMode.parallax,

              // stretchModes: effects applied when over-scrolling.
              stretchModes: const [
                StretchMode.zoomBackground, // Zoom the background image
                StretchMode.fadeTitle, // Fade the title
                // StretchMode.blurBackground, // Blur the background
              ],
            ),

            // actions: buttons on the right side of the app bar.
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This is a SliverAppBar demo!'),
                    ),
                  );
                },
              ),
            ],
          ),

          // ===================================================================
          // SliverToBoxAdapter — Regular Widget in a Sliver
          // ===================================================================
          // SliverToBoxAdapter wraps a regular (non-sliver) widget so it
          // can be used inside a CustomScrollView. Use it for one-off
          // widgets like headers, banners, or spacing.
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SliverToBoxAdapter',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is a regular widget wrapped in SliverToBoxAdapter '
                        'so it can live inside a CustomScrollView alongside '
                        'other slivers.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ===================================================================
          // SliverList — Sliver-based List
          // ===================================================================
          // SliverList builds a linear list of items as a sliver.
          // It uses a delegate to build items lazily or from a fixed list.

          // Header for the list section.
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'SliverList (builder delegate)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          // SliverList with SliverChildBuilderDelegate — lazy builder.
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Sliver List Item ${index + 1}'),
                  subtitle: const Text('Built lazily by SliverChildBuilderDelegate'),
                );
              },
              childCount: 5, // How many items to build
              // addAutomaticKeepAlives: true,   // Keep items alive when off-screen
              // addRepaintBoundaries: true,     // Isolate repaints
              // addSemanticIndexes: true,       // For accessibility
            ),
          ),

          // ===================================================================
          // SliverGrid — Sliver-based Grid
          // ===================================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'SliverGrid',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          // SliverGrid combines a delegate (for items) with a gridDelegate
          // (for layout). Same delegates as GridView.builder.
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0, // Square cells
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                );
              },
              childCount: 9,
            ),
          ),

          // ===================================================================
          // SliverList with SliverChildListDelegate — explicit children
          // ===================================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'SliverList (explicit children)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          // SliverChildListDelegate takes an explicit list of widgets.
          // Use this when you have a small, fixed number of children.
          SliverList(
            delegate: SliverChildListDelegate([
              const ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Explicit item 1'),
              ),
              const ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Explicit item 2'),
              ),
              const ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Explicit item 3'),
              ),
            ]),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }
}
