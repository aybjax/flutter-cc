# 9 - WebSocket: Live Chat Room

A real-time multi-room chat app built with Flutter and a Go WebSocket backend.

## What This App Teaches

- **web_socket_channel**: connect, `sink.add`, `stream.listen`, reconnection logic
- **Stream-based UI**: `BlocBuilder`, `BlocConsumer`, lifecycle handling
- **Message serialization**: freezed union types for type-safe WebSocket events
- **Chat room management**: join/leave rooms, presence tracking, typing indicators

## Running

### 1. Start the Go Backend

```bash
cd ../backend-ws
go run .
# Server starts on ws://localhost:8081/ws
```

### 2. Run the Flutter App

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Architecture

```
lib/
  main.dart                     # App entry, theme, BlocProvider
  l10n/                         # Localization (English + Spanish)
  models/
    chat_message.dart           # @freezed message model
    chat_room.dart              # @freezed room model
    chat_user.dart              # @freezed user model
    ws_event.dart               # @freezed union type for WS events
  services/
    websocket_service.dart      # WebSocket connection + reconnection
  cubits/
    chat_cubit.dart             # Business logic
    chat_state.dart             # Immutable state
  screens/
    username_screen.dart        # Enter username
    room_list_screen.dart       # Browse and join rooms
    chat_screen.dart            # Chat interface
  widgets/
    message_bubble.dart         # Message display
    typing_indicator.dart       # Animated typing dots
    online_users.dart           # Drawer with online users
```

## WebSocket vs Polling vs SSE

| Feature              | WebSocket                  | HTTP Polling               | Server-Sent Events (SSE)   |
|----------------------|----------------------------|----------------------------|----------------------------|
| **Direction**        | Full-duplex (bidirectional)| Client-initiated only      | Server-to-client only      |
| **Latency**          | Very low (persistent conn) | High (request interval)    | Low (persistent conn)      |
| **Connection**       | Single persistent TCP      | New HTTP request each poll | Single persistent HTTP     |
| **Protocol**         | ws:// / wss://             | HTTP/HTTPS                 | HTTP/HTTPS                 |
| **Browser support**  | All modern browsers        | Universal                  | All modern (no IE)         |
| **Overhead**         | Low (small frames)         | High (HTTP headers/poll)   | Medium (HTTP headers once) |
| **Use cases**        | Chat, gaming, live collab  | Dashboards, simple updates | Notifications, feeds       |
| **Reconnection**     | Manual (custom logic)      | Built-in (next poll)       | Built-in (auto-reconnect)  |
| **Scalability**      | Stateful (sticky sessions) | Stateless (easy to scale)  | Stateful (moderate)        |
| **Firewall/proxy**   | May need special config    | Works everywhere           | Works over standard HTTP   |

### When to Use Each

- **WebSocket**: Real-time bidirectional communication (chat, multiplayer games, collaborative editing).
  The client and server both send messages at any time.

- **HTTP Polling**: Simple periodic data fetching where slight delays are acceptable
  (checking for new emails, dashboard refresh). Easy to implement but wastes bandwidth.

- **Long Polling**: A variant where the server holds the request open until new data is available.
  Better latency than regular polling but still creates new connections.

- **SSE (Server-Sent Events)**: One-way server-to-client streaming (live scores, news feeds,
  stock tickers). Simpler than WebSocket when you only need server push.

### In This App

We use **WebSocket** because chat requires bidirectional real-time communication:
- The client sends messages, typing indicators, and join/leave events
- The server broadcasts messages, presence updates, and typing notifications
- Low latency is critical for a responsive chat experience
