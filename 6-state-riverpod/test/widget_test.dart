// =============================================================================
// Basic smoke test for the Weather Dashboard app
// =============================================================================
//
// Demonstrates ProviderScope override for testing — the app is wrapped in a
// ProviderScope so that providers can be overridden with test doubles.
// =============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Wrap in ProviderScope just like main.dart does
    await tester.pumpWidget(
      const ProviderScope(child: WeatherApp()),
    );

    // Verify the app title is present
    expect(find.text('Weather Dashboard'), findsOneWidget);
  });
}
