// =============================================================================
// Widgets Demo Tab
// =============================================================================
// Concepts demonstrated:
// - Container — the Swiss Army knife widget (width, height, margin, padding,
//   decoration with BoxDecoration: color, gradient, borderRadius, border,
//   boxShadow, shape, image)
// - Row — horizontal layout (mainAxisAlignment, crossAxisAlignment, mainAxisSize)
// - Column — vertical layout (same axis properties as Row)
// - Flexible — gives a child a fractional share of remaining space
// - Expanded — shorthand for Flexible with fit: FlexFit.tight
// - Stack — layers widgets on top of each other (alignment, fit, Positioned)
// - const optimization — compile-time constant widgets for performance
// - SingleChildScrollView — makes the whole page scrollable
// =============================================================================

import 'package:flutter/material.dart';

/// A showcase of fundamental Flutter layout and styling widgets.
///
/// Organized into five sections, each wrapped in a Card for visual separation.
/// Every widget field is specified or commented out with an explanation.
class WidgetsDemoTab extends StatelessWidget {
  /// Creates the widgets demo tab.
  const WidgetsDemoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================================
          // Section 1: Container
          // ===================================================================
          _buildSectionTitle(context, '1. Container'),
          _buildContainerDemo(context),
          const SizedBox(height: 24),

          // ===================================================================
          // Section 2: Row (horizontal layout)
          // ===================================================================
          _buildSectionTitle(context, '2. Row — MainAxisAlignment'),
          _buildRowDemo(context),
          const SizedBox(height: 24),

          // ===================================================================
          // Section 3: Column (vertical layout)
          // ===================================================================
          _buildSectionTitle(context, '3. Column — CrossAxisAlignment'),
          _buildColumnDemo(context),
          const SizedBox(height: 24),

          // ===================================================================
          // Section 4: Flexible vs Expanded
          // ===================================================================
          _buildSectionTitle(context, '4. Flexible vs Expanded'),
          _buildFlexDemo(context),
          const SizedBox(height: 24),

          // ===================================================================
          // Section 5: Stack
          // ===================================================================
          _buildSectionTitle(context, '5. Stack & Positioned'),
          _buildStackDemo(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section title helper
  // ---------------------------------------------------------------------------

  /// Builds a section title.
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: Container
  // ---------------------------------------------------------------------------

  /// Demonstrates Container with BoxDecoration and its many fields.
  Widget _buildContainerDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Container is the most versatile widget. It combines sizing, '
              'padding, margin, decoration, and transformations.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                // -- Sizing --
                width: 200, // Fixed width in logical pixels
                height: 120, // Fixed height in logical pixels
                // constraints: BoxConstraints(      // Alternative to width/height
                //   minWidth: 100,
                //   maxWidth: 300,
                //   minHeight: 50,
                //   maxHeight: 200,
                // ),

                // -- Spacing --
                padding: const EdgeInsets.all(16), // Inner space
                margin: const EdgeInsets.all(8), // Outer space
                // Note: margin is actually implemented by wrapping in Padding.

                // -- Visual decoration --
                decoration: BoxDecoration(
                  // color: a solid background color.
                  // Cannot use both color and gradient.
                  // color: Theme.of(context).colorScheme.primaryContainer,

                  // gradient: a color gradient background.
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.topLeft, // Gradient start
                    end: Alignment.bottomRight, // Gradient end
                    // stops: [0.0, 1.0],         // Color stop positions
                    // tileMode: TileMode.clamp,  // How to fill beyond stops
                  ),
                  // Other gradient types:
                  // RadialGradient(center, radius, colors, stops)
                  // SweepGradient(center, startAngle, endAngle, colors)

                  // borderRadius: rounds the corners.
                  borderRadius: BorderRadius.circular(16),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(16),
                  //   topRight: Radius.circular(0),
                  //   bottomLeft: Radius.circular(0),
                  //   bottomRight: Radius.circular(16),
                  // ),

                  // border: draws a border around the container.
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 2,
                    // strokeAlign: BorderSide.strokeAlignInside, // inside/center/outside
                  ),

                  // boxShadow: adds shadows.
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8, // How blurry the shadow is
                      spreadRadius: 2, // How far the shadow spreads
                      offset: const Offset(2, 4), // Shadow offset (x, y)
                    ),
                    // You can add multiple shadows for layered effects.
                  ],

                  // shape: BoxShape.rectangle (default) or BoxShape.circle.
                  // When using circle, don't set borderRadius.
                  // shape: BoxShape.circle,

                  // image: a background image.
                  // image: DecorationImage(
                  //   image: NetworkImage('https://...'),
                  //   fit: BoxFit.cover,
                  //   opacity: 0.5,
                  //   colorFilter: ColorFilter.mode(Colors.blue, BlendMode.overlay),
                  // ),
                ),

                // -- Transform --
                // transform: Matrix4.rotationZ(0.05), // Rotate slightly
                // transformAlignment: Alignment.center,

                // -- Alignment --
                alignment: Alignment.center, // Where to place the child
                // alignment: Alignment.topLeft,
                // alignment: Alignment.bottomRight,
                // alignment: Alignment(-0.5, 0.5),  // Custom: -1..1 range

                // -- Clipping --
                // clipBehavior: Clip.none,            // Don't clip children

                // -- Child --
                child: const Text(
                  'Container',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: Row
  // ---------------------------------------------------------------------------

  /// Demonstrates Row with all MainAxisAlignment values.
  Widget _buildRowDemo(BuildContext context) {
    // The 6 MainAxisAlignment values:
    final alignments = [
      ('start', MainAxisAlignment.start),
      ('end', MainAxisAlignment.end),
      ('center', MainAxisAlignment.center),
      ('spaceBetween', MainAxisAlignment.spaceBetween),
      ('spaceAround', MainAxisAlignment.spaceAround),
      ('spaceEvenly', MainAxisAlignment.spaceEvenly),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MainAxisAlignment controls how children are positioned '
              'along the main axis (horizontal for Row).',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            ...alignments.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.$1,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        // mainAxisAlignment: how to distribute children.
                        mainAxisAlignment: entry.$2,
                        // crossAxisAlignment: vertical alignment of children.
                        // crossAxisAlignment: CrossAxisAlignment.center, // default
                        // crossAxisAlignment: CrossAxisAlignment.start,  // top
                        // crossAxisAlignment: CrossAxisAlignment.end,    // bottom
                        // crossAxisAlignment: CrossAxisAlignment.stretch, // fill height
                        // crossAxisAlignment: CrossAxisAlignment.baseline, // align baselines
                        // mainAxisSize: MainAxisSize.max,  // Take full width (default)
                        // mainAxisSize: MainAxisSize.min,  // Shrink to fit children
                        // textDirection: TextDirection.ltr, // Override text direction
                        // verticalDirection: VerticalDirection.down, // Override vertical direction
                        children: [
                          _buildSmallBox(context, 'A'),
                          _buildSmallBox(context, 'B'),
                          _buildSmallBox(context, 'C'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3: Column
  // ---------------------------------------------------------------------------

  /// Demonstrates Column with CrossAxisAlignment.
  Widget _buildColumnDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CrossAxisAlignment controls positioning along the cross axis '
              '(horizontal for Column).',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CrossAxisAlignment.start
                Expanded(
                  child: _buildAlignedColumn(
                    context,
                    'start',
                    CrossAxisAlignment.start,
                  ),
                ),
                const SizedBox(width: 8),
                // CrossAxisAlignment.center
                Expanded(
                  child: _buildAlignedColumn(
                    context,
                    'center',
                    CrossAxisAlignment.center,
                  ),
                ),
                const SizedBox(width: 8),
                // CrossAxisAlignment.end
                Expanded(
                  child: _buildAlignedColumn(
                    context,
                    'end',
                    CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: builds a Column with a specific CrossAxisAlignment.
  Widget _buildAlignedColumn(
    BuildContext context,
    String label,
    CrossAxisAlignment alignment,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 4),
          _buildSmallBox(context, 'A'),
          const SizedBox(height: 4),
          _buildSmallBox(context, 'B'),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Flexible vs Expanded
  // ---------------------------------------------------------------------------

  /// Side-by-side comparison of Flexible and Expanded.
  Widget _buildFlexDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flexible: child CAN be smaller than its share.\n'
              'Expanded: child MUST fill its share (Flexible with FlexFit.tight).',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),

            // -- Flexible example --
            Text('Flexible (fit: loose)', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  flex: 2, // Gets 2/3 of available space
                  fit: FlexFit.loose, // Can be smaller than allocated space
                  child: Container(
                    height: 40,
                    color: Theme.of(context).colorScheme.primary,
                    child: const Center(child: Text('flex: 2', style: TextStyle(color: Colors.white))),
                  ),
                ),
                Flexible(
                  flex: 1, // Gets 1/3 of available space
                  fit: FlexFit.loose,
                  child: Container(
                    height: 40,
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Center(child: Text('flex: 1', style: TextStyle(color: Colors.white))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // -- Expanded example --
            Text('Expanded (Flexible with FlexFit.tight)', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  flex: 2, // Gets 2/3 and fills it completely
                  child: Container(
                    height: 40,
                    color: Theme.of(context).colorScheme.primary,
                    child: const Center(child: Text('flex: 2', style: TextStyle(color: Colors.white))),
                  ),
                ),
                Expanded(
                  flex: 1, // Gets 1/3 and fills it completely
                  child: Container(
                    height: 40,
                    color: Theme.of(context).colorScheme.tertiary,
                    child: const Center(child: Text('flex: 1', style: TextStyle(color: Colors.white))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5: Stack
  // ---------------------------------------------------------------------------

  /// Demonstrates Stack with Positioned children.
  Widget _buildStackDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stack layers widgets on top of each other. '
              'Positioned sets exact coordinates within the Stack.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: 250,
                height: 180,
                child: Stack(
                  // alignment: where to place non-Positioned children.
                  alignment: Alignment.center,
                  // fit: StackFit.loose,         // Children choose own size (default)
                  // fit: StackFit.expand,        // Children expand to fill Stack
                  // fit: StackFit.passthrough,   // Pass parent constraints through
                  // clipBehavior: Clip.hardEdge,  // Clip overflowing children
                  children: [
                    // Bottom layer — background.
                    Container(
                      width: 250,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('Background')),
                    ),

                    // Middle layer — non-positioned (uses Stack.alignment).
                    Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Text('Centered')),
                    ),

                    // Top layer — Positioned in the top-left corner.
                    Positioned(
                      top: 8, // Distance from top of Stack
                      left: 8, // Distance from left of Stack
                      // right: ...,   // Distance from right
                      // bottom: ...,  // Distance from bottom
                      // width: ...,   // Fixed width
                      // height: ...,  // Fixed height
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'TOP LEFT',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),

                    // Positioned in the bottom-right corner.
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'BOTTOM RIGHT',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Builds a small colored box for layout demonstrations.
  Widget _buildSmallBox(BuildContext context, String label) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
