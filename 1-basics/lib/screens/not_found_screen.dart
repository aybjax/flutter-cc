// =============================================================================
// Not Found Screen (404)
// =============================================================================
// Concepts demonstrated:
// - onGenerateRoute fallback — catching unknown route names
// - Navigator.pop — going back to the previous screen
// - Simple StatelessWidget for static content
// - Theme access via Theme.of(context)
// =============================================================================

import 'package:flutter/material.dart';

/// A 404 screen shown when navigating to an unknown route.
///
/// This screen is used as the fallback in [MaterialApp.onGenerateRoute].
/// When the user (or code) navigates to a route that doesn't exist in
/// the routes map and isn't handled by onGenerateRoute, this screen
/// is displayed.
class NotFoundScreen extends StatelessWidget {
  /// The route name that was not found.
  final String? routeName;

  /// Creates the 404 screen.
  const NotFoundScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Large 404 icon
              Icon(
                Icons.error_outline,
                size: 100,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),

              // Error title
              Text(
                '404',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Error description
              Text(
                'The page you are looking for does not exist.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              // Show the route name if available
              if (routeName != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Route: $routeName',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
              const SizedBox(height: 32),

              // Go back button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.pop returns to the previous screen.
                  // If there's no previous screen (e.g., deep link),
                  // this will close the app — canPop() checks first.
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
