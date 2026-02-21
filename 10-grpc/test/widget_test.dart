// =============================================================================
// widget_test.dart — Basic smoke test for the Task Board app
// =============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc_tutorial/main.dart';
import 'package:grpc_tutorial/repositories/board_repository.dart';
import 'package:grpc_tutorial/services/grpc_service.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    final grpcService = GrpcService(host: 'localhost', port: 50051);
    final repository = BoardRepository(grpcService);

    await tester.pumpWidget(TaskBoardApp(boardRepository: repository));

    // The app should show the board list title
    expect(find.text('My Boards'), findsOneWidget);

    await grpcService.shutdown();
  });
}
