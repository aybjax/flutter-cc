// Basic smoke test for the Flutter Basics app.
//
// This test verifies that the app launches without errors.
// More comprehensive tests would test individual screens and providers.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics/main.dart';

void main() {
  testWidgets('App launches without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterBasicsApp());

    // Verify the app builds successfully by checking for any widget.
    expect(find.byType(FlutterBasicsApp), findsOneWidget);
  });
}
