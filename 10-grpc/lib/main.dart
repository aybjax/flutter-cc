// =============================================================================
// main.dart — Entry point for the Task Board (Kanban) gRPC app
// =============================================================================
//
// This app demonstrates gRPC communication between a Flutter client and a
// Go backend server. Key concepts covered:
//
//   - gRPC client channel setup (insecure for dev, TLS for production)
//   - Unary RPCs (request-response): GetBoards, GetBoard, CreateCard, etc.
//   - Server-streaming RPC: WatchBoard for real-time updates
//   - Protocol Buffer message types (hand-written equivalents)
//   - Freezed models for the app/domain layer
//   - Either-based error handling with dartz
//   - BLoC/Cubit state management with flutter_bloc
//   - Drag-and-drop Kanban board UI
//   - Localization (English + Spanish)
//
// Architecture layers:
//   proto/        -> Transport layer (gRPC message types)
//   services/     -> Network layer (channel management, raw RPC calls)
//   repositories/ -> Data layer (error handling, type conversion)
//   cubits/       -> Business logic layer (state management)
//   screens/      -> Presentation layer (full-page views)
//   widgets/      -> Presentation layer (reusable components)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_tutorial/l10n/app_localizations.dart';
import 'package:grpc_tutorial/cubits/board_cubit.dart';
import 'package:grpc_tutorial/repositories/board_repository.dart';
import 'package:grpc_tutorial/screens/board_list_screen.dart';
import 'package:grpc_tutorial/services/grpc_service.dart';

// ---------------------------------------------------------------------------
// App entry point
// ---------------------------------------------------------------------------

void main() {
  // Create the gRPC service connected to the Go backend
  //
  // For Android emulator, use host: '10.0.2.2'
  // For iOS simulator or desktop, use host: 'localhost'
  // For physical devices, use the machine's IP address
  final grpcService = GrpcService(
    host: 'localhost',
    port: 50051,
  );

  // Create the repository that wraps gRPC calls with error handling
  final boardRepository = BoardRepository(grpcService);

  runApp(
    TaskBoardApp(boardRepository: boardRepository),
  );
}

// ---------------------------------------------------------------------------
// TaskBoardApp — root widget
// ---------------------------------------------------------------------------

/// The root application widget.
///
/// Provides the [BoardRepository] to the widget tree via [RepositoryProvider]
/// and creates the [BoardListCubit] for the board list screen.
///
/// The gRPC service and repository are created once and shared across
/// the entire app. Individual board screens create their own
/// [BoardDetailCubit] scoped to their lifecycle.
class TaskBoardApp extends StatelessWidget {
  /// The repository instance shared across the app.
  final BoardRepository boardRepository;

  const TaskBoardApp({
    super.key,
    required this.boardRepository,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: boardRepository,
      child: BlocProvider(
        // BoardListCubit lives for the entire app lifetime
        create: (_) => BoardListCubit(boardRepository),
        child: MaterialApp(
          // -------------------------------------------------------------------
          // App title and theme
          // -------------------------------------------------------------------
          title: 'Task Board',

          // Using colorSchemeSeed instead of ColorScheme.fromSeed
          // This generates a full Material 3 color scheme from a single seed color
          theme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.light,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),

          // Alternative: use a custom color scheme for more control
          // theme: ThemeData(
          //   colorScheme: const ColorScheme.light(
          //     primary: Colors.indigo,
          //     secondary: Colors.amber,
          //   ),
          //   useMaterial3: true,
          // ),

          // -------------------------------------------------------------------
          // Localization
          // -------------------------------------------------------------------
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          // -------------------------------------------------------------------
          // Navigation
          // -------------------------------------------------------------------
          home: const BoardListScreen(),

          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
