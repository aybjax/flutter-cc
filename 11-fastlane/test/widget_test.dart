// =============================================================================
// File: widget_test.dart
// Purpose: Basic smoke test for the Fastlane tutorial app.
// =============================================================================

import 'package:flutter_test/flutter_test.dart';

import 'package:fastlane_tutorial/main.dart';
import 'package:fastlane_tutorial/models/models.dart';

void main() {
  testWidgets('FlavorApp renders home screen with config info',
      (WidgetTester tester) async {
    // Build the app with a test configuration
    final config = AppConfig(
      appName: 'Test App',
      environment: 'Development',
      apiUrl: 'http://localhost:8080',
      version: '1.0.0+1',
      buildMode: 'Debug',
    );

    await tester.pumpWidget(FlavorApp(config: config));
    await tester.pumpAndSettle();

    // Verify that the environment name is displayed
    expect(find.text('Development'), findsWidgets);

    // Verify that the API URL is displayed
    expect(find.text('http://localhost:8080'), findsOneWidget);
  });
}
