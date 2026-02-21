// Basic smoke test for the Live Chat app.

import 'package:flutter_test/flutter_test.dart';

import 'package:websocket_tutorial/main.dart';

void main() {
  testWidgets('App renders username screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatApp());
    await tester.pumpAndSettle();

    // The username screen should show the join button
    expect(find.text('Join Chat'), findsOneWidget);
  });
}
