// =============================================================================
// MediaQuery Demo Screen
// =============================================================================
// Concepts demonstrated:
// - MediaQuery — accessing device information and screen properties
//   • size (width, height)
//   • orientation (portrait, landscape)
//   • viewInsets (keyboard height)
//   • padding (safe area insets — notch, status bar, home indicator)
//   • devicePixelRatio (screen density)
//   • platformBrightness (system light/dark mode)
//   • textScaler (user's text size preference)
// - MediaQuery.of(context) vs MediaQuery.sizeOf(context) — performance
// - Orientation-based layout switching (Row vs Column)
// - Responsive design principles
// =============================================================================

import 'package:flutter/material.dart';

/// Displays live [MediaQuery] data and demonstrates responsive layout.
///
/// All values update in real-time — try rotating the device or opening
/// the keyboard to see changes.
class MediaQueryDemoScreen extends StatelessWidget {
  /// Creates the media query demo screen.
  const MediaQueryDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context) returns the full MediaQueryData.
    // This causes the widget to rebuild when ANY MediaQuery property changes.
    //
    // For better performance, use specific methods:
    // - MediaQuery.sizeOf(context)         — only rebuilds on size changes
    // - MediaQuery.orientationOf(context)  — only rebuilds on orientation changes
    // - MediaQuery.paddingOf(context)      — only rebuilds on padding changes
    // - MediaQuery.viewInsetsOf(context)   — only rebuilds on keyboard changes
    //
    // Here we use .of() because we display all properties.
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('MediaQuery Demo')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Device Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // ===============================================================
              // Screen Size
              // ===============================================================
              _buildInfoCard(
                context,
                icon: Icons.aspect_ratio,
                title: 'Screen Size',
                items: [
                  'Width: ${mediaQuery.size.width.toStringAsFixed(1)} dp',
                  'Height: ${mediaQuery.size.height.toStringAsFixed(1)} dp',
                  'Aspect Ratio: ${(mediaQuery.size.width / mediaQuery.size.height).toStringAsFixed(2)}',
                ],
              ),

              // ===============================================================
              // Orientation
              // ===============================================================
              _buildInfoCard(
                context,
                icon: Icons.screen_rotation,
                title: 'Orientation',
                items: [
                  'Current: ${mediaQuery.orientation.name}',
                  'Is Portrait: ${mediaQuery.orientation == Orientation.portrait}',
                  'Is Landscape: ${mediaQuery.orientation == Orientation.landscape}',
                ],
              ),

              // ===============================================================
              // View Insets (keyboard)
              // ===============================================================
              _buildInfoCard(
                context,
                icon: Icons.keyboard,
                title: 'View Insets (Keyboard)',
                items: [
                  'Bottom: ${mediaQuery.viewInsets.bottom.toStringAsFixed(1)} dp',
                  'Top: ${mediaQuery.viewInsets.top.toStringAsFixed(1)} dp',
                  'Keyboard Open: ${mediaQuery.viewInsets.bottom > 0}',
                ],
              ),

              // ===============================================================
              // Padding (Safe Area)
              // ===============================================================
              _buildInfoCard(
                context,
                icon: Icons.crop_square,
                title: 'Padding (Safe Area)',
                items: [
                  'Top: ${mediaQuery.padding.top.toStringAsFixed(1)} dp (status bar)',
                  'Bottom: ${mediaQuery.padding.bottom.toStringAsFixed(1)} dp (home indicator)',
                  'Left: ${mediaQuery.padding.left.toStringAsFixed(1)} dp',
                  'Right: ${mediaQuery.padding.right.toStringAsFixed(1)} dp',
                ],
              ),

              // ===============================================================
              // Device Pixel Ratio
              // ===============================================================
              _buildInfoCard(
                context,
                icon: Icons.hd,
                title: 'Display',
                items: [
                  'Device Pixel Ratio: ${mediaQuery.devicePixelRatio.toStringAsFixed(1)}x',
                  'Physical Width: ${(mediaQuery.size.width * mediaQuery.devicePixelRatio).toStringAsFixed(0)} px',
                  'Physical Height: ${(mediaQuery.size.height * mediaQuery.devicePixelRatio).toStringAsFixed(0)} px',
                ],
              ),

              // ===============================================================
              // Platform Brightness & Text Scale
              // ===============================================================
              _buildInfoCard(
                context,
                icon: Icons.brightness_6,
                title: 'System Settings',
                items: [
                  'Platform Brightness: ${mediaQuery.platformBrightness.name}',
                  'Text Scale: ${mediaQuery.textScaler.scale(14).toStringAsFixed(2)}',
                  'Bold Text: ${mediaQuery.boldText}',
                  'High Contrast: ${mediaQuery.highContrast}',
                  // 'Accessible Navigation: ${mediaQuery.accessibleNavigation}',
                  // 'Invert Colors: ${mediaQuery.invertColors}',
                  // 'Disable Animations: ${mediaQuery.disableAnimations}',
                ],
              ),

              const SizedBox(height: 16),

              // ===============================================================
              // Responsive Layout Demo
              // ===============================================================
              Text(
                'Responsive Layout',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'This section changes layout based on orientation:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),

              // Switch between Row and Column based on orientation.
              _buildResponsiveLayout(context, mediaQuery.orientation),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds an info card with icon, title, and list of items.
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(item,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a layout that switches between Row and Column based on orientation.
  Widget _buildResponsiveLayout(
    BuildContext context,
    Orientation orientation,
  ) {
    final children = [
      _buildResponsiveBox(context, 'Box A', Colors.indigo),
      const SizedBox(width: 8, height: 8),
      _buildResponsiveBox(context, 'Box B', Colors.teal),
      const SizedBox(width: 8, height: 8),
      _buildResponsiveBox(context, 'Box C', Colors.orange),
    ];

    // In portrait: stack vertically (Column).
    // In landscape: lay out horizontally (Row).
    if (orientation == Orientation.portrait) {
      return Column(children: children);
    } else {
      return Row(
        children: children.map((child) {
          if (child is SizedBox) return child;
          return Expanded(child: child);
        }).toList(),
      );
    }
  }

  /// Builds a colored box for the responsive layout demo.
  Widget _buildResponsiveBox(
      BuildContext context, String label, Color color) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
