// =============================================================================
// main.dart — Entry point for the Live Chat Room app
// =============================================================================
//
// This app demonstrates real-time WebSocket communication in Flutter:
// - Connecting to a WebSocket server using web_socket_channel
// - Stream-based UI updates with BlocBuilder/BlocConsumer
// - Message serialization with freezed
// - Reconnection logic with exponential backoff
// - Multi-room chat with presence and typing indicators
//
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubits/chat_cubit.dart';
import 'screens/username_screen.dart';
import 'services/websocket_service.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/// The WebSocket server URL.
///
/// For iOS simulator, use 'localhost'.
/// For Android emulator, use '10.0.2.2' (the host machine's loopback).
/// For a real device, use the machine's LAN IP.
// const _wsUrl = 'ws://10.0.2.2:8081/ws'; // Android emulator
const _wsUrl = 'ws://localhost:8081/ws'; // iOS simulator / desktop

// Alternative: read from environment variable or config file
// const _wsUrl = String.fromEnvironment('WS_URL', defaultValue: 'ws://localhost:8081/ws');

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

void main() {
  runApp(const ChatApp());
}

// ---------------------------------------------------------------------------
// ChatApp — Root widget
// ---------------------------------------------------------------------------

/// The root widget for the Live Chat Room app.
///
/// Sets up:
/// - [WebSocketService] for the connection
/// - [ChatCubit] via [BlocProvider] for state management
/// - Material theming with `colorSchemeSeed`
/// - Localization (English + Spanish)
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the WebSocket service — shared across the app
    final wsService = WebSocketService(serverUrl: _wsUrl);

    return BlocProvider(
      create: (_) => ChatCubit(wsService: wsService),
      child: MaterialApp(
        title: 'Live Chat',
        debugShowCheckedModeBanner: false,

        // ---------------------------------------------------------------------------
        // Theme — uses colorSchemeSeed instead of ColorScheme.fromSeed
        // ---------------------------------------------------------------------------
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
        themeMode: ThemeMode.system,

        // ---------------------------------------------------------------------------
        // Localization
        // ---------------------------------------------------------------------------
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],

        home: const UsernameScreen(),
      ),
    );
  }
}
