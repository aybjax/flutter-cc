// =============================================================================
// websocket_service.dart — WebSocket connection management
// =============================================================================

import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/ws_event.dart';

// ---------------------------------------------------------------------------
// Connection state enum
// ---------------------------------------------------------------------------

/// Represents the current state of the WebSocket connection.
enum WsConnectionState {
  /// Not connected, no reconnection in progress.
  disconnected,

  /// Actively attempting to connect.
  connecting,

  /// Connection established and healthy.
  connected,

  /// Connection lost, attempting to reconnect.
  reconnecting,
}

// ---------------------------------------------------------------------------
// WebSocketService — Manages the WebSocket lifecycle
// ---------------------------------------------------------------------------

/// Manages a single WebSocket connection to the chat server.
///
/// Handles:
/// - Connection and disconnection
/// - Automatic reconnection with exponential backoff
/// - Message serialization/deserialization
/// - Stream-based event delivery to consumers
///
/// Usage:
/// ```dart
/// final service = WebSocketService(serverUrl: 'ws://localhost:8081/ws');
/// service.connect();
/// service.events.listen((event) { ... });
/// service.sendEvent(WsEvent.join(room: 'general', user: 'alice'));
/// ```
class WebSocketService {
  /// The WebSocket server URL (e.g., 'ws://localhost:8081/ws').
  final String serverUrl;

  WebSocketService({required this.serverUrl});

  // ---------------------------------------------------------------------------
  // Private state
  // ---------------------------------------------------------------------------

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  Timer? _reconnectTimer;

  // Event stream controller — broadcasts events to multiple listeners
  final _eventController = StreamController<WsEvent>.broadcast();

  // Connection state stream
  final _connectionStateController =
      StreamController<WsConnectionState>.broadcast();

  WsConnectionState _currentState = WsConnectionState.disconnected;

  // Reconnection backoff
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _baseReconnectDelay = Duration(seconds: 1);

  // Whether the user explicitly disconnected (suppress auto-reconnect)
  bool _intentionalDisconnect = false;

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Stream of parsed [WsEvent]s from the server.
  Stream<WsEvent> get events => _eventController.stream;

  /// Stream of [WsConnectionState] changes.
  Stream<WsConnectionState> get connectionState =>
      _connectionStateController.stream;

  /// The current connection state.
  WsConnectionState get currentState => _currentState;

  /// Connects to the WebSocket server.
  ///
  /// If already connected, this is a no-op.
  void connect() {
    if (_currentState == WsConnectionState.connected ||
        _currentState == WsConnectionState.connecting) {
      return;
    }

    _intentionalDisconnect = false;
    _doConnect();
  }

  /// Disconnects from the WebSocket server.
  ///
  /// Cancels any pending reconnection attempts.
  void disconnect() {
    _intentionalDisconnect = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;
    _closeChannel();
    _updateState(WsConnectionState.disconnected);
  }

  /// Sends a [WsEvent] to the server.
  ///
  /// Silently drops the message if not connected.
  void sendEvent(WsEvent event) {
    if (_currentState != WsConnectionState.connected || _channel == null) {
      // Alternative: could queue messages and send them after reconnect
      return;
    }

    final json = jsonEncode(event.toServerJson());
    _channel!.sink.add(json);
  }

  /// Cleans up all resources. Call when the service is no longer needed.
  void dispose() {
    disconnect();
    _eventController.close();
    _connectionStateController.close();
  }

  // ---------------------------------------------------------------------------
  // Private implementation
  // ---------------------------------------------------------------------------

  /// Establishes the WebSocket connection.
  void _doConnect() {
    _updateState(_reconnectAttempts > 0
        ? WsConnectionState.reconnecting
        : WsConnectionState.connecting);

    try {
      final uri = Uri.parse(serverUrl);
      _channel = WebSocketChannel.connect(uri);

      // Listen for messages from the server
      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );

      // Mark as connected once the channel is ready
      // WebSocketChannel.connect doesn't throw on failure — errors come
      // through the stream. We optimistically set connected here.
      _updateState(WsConnectionState.connected);
      _reconnectAttempts = 0;
    } catch (e) {
      _onError(e);
    }
  }

  /// Handles an incoming raw message from the WebSocket.
  void _onMessage(dynamic rawMessage) {
    if (rawMessage is! String) return;

    // The server may batch multiple JSON objects separated by newlines
    final lines = rawMessage.split('\n');
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      try {
        final json = jsonDecode(trimmed) as Map<String, dynamic>;
        final event = WsEvent.fromServerJson(json);
        _eventController.add(event);
      } catch (e) {
        // Malformed JSON — skip this line
        // Alternative: could emit an error event
      }
    }
  }

  /// Handles a WebSocket error.
  void _onError(dynamic error) {
    _closeChannel();
    _scheduleReconnect();
  }

  /// Handles the WebSocket connection closing.
  void _onDone() {
    _closeChannel();
    if (!_intentionalDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Closes the current WebSocket channel and cancels the subscription.
  void _closeChannel() {
    _subscription?.cancel();
    _subscription = null;
    _channel?.sink.close();
    _channel = null;
  }

  /// Schedules a reconnection attempt with exponential backoff.
  void _scheduleReconnect() {
    if (_intentionalDisconnect) return;
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _updateState(WsConnectionState.disconnected);
      return;
    }

    _updateState(WsConnectionState.reconnecting);

    // Exponential backoff: 1s, 2s, 4s, 8s, ... capped at 30s
    final delay = _baseReconnectDelay * (1 << _reconnectAttempts);
    final cappedDelay =
        delay > const Duration(seconds: 30)
            ? const Duration(seconds: 30)
            : delay;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(cappedDelay, () {
      _reconnectAttempts++;
      _doConnect();
    });
  }

  /// Updates the connection state and notifies listeners.
  void _updateState(WsConnectionState newState) {
    if (_currentState == newState) return;
    _currentState = newState;
    _connectionStateController.add(newState);
  }
}
