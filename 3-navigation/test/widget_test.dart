import 'package:flutter_test/flutter_test.dart';

import 'package:navigation_tutorial/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsReaderApp());

    // Verify that the app title is shown
    expect(find.text('News Reader'), findsOneWidget);

    // Verify that the three navigation tabs are present
    expect(find.text('Navigator'), findsOneWidget);
    expect(find.text('GoRouter'), findsOneWidget);
    expect(find.text('AutoRoute'), findsOneWidget);
  });
}
