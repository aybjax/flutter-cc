import 'package:flutter_test/flutter_test.dart';
import 'package:codegen_tutorial/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CodegenTutorialApp());
    await tester.pumpAndSettle();
    expect(find.text('Contact Book'), findsOneWidget);
  });
}
