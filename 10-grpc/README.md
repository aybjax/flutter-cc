# 10-grpc: Task Board (Kanban) with gRPC

A Flutter Kanban board app that communicates with a Go backend via gRPC. Demonstrates unary RPCs, server-streaming for real-time updates, Protocol Buffers, and drag-and-drop UI.

## Quick Start

```bash
# 1. Start the Go backend (see ../backend-grpc/README.md)
cd ../backend-grpc
go run .

# 2. Run the Flutter app
cd ../10-grpc
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Architecture

```
proto/        -> gRPC message types (hand-written equivalent of protoc output)
services/     -> gRPC channel management, raw RPC calls
repositories/ -> Either-based error handling, proto-to-model conversion
cubits/       -> BLoC/Cubit state management
screens/      -> Full-page views (board list, board detail, card form)
widgets/      -> Reusable components (kanban column, card, draggable card)
models/       -> Freezed domain models (Board, BoardColumn, TaskCard)
l10n/         -> Localization (English, Spanish)
```

## gRPC Concepts Demonstrated

| Concept | Where |
|---------|-------|
| Client channel setup | `services/grpc_service.dart` |
| Unary RPC | GetBoards, GetBoard, CreateCard, MoveCard, DeleteCard |
| Server streaming | WatchBoard for real-time board updates |
| Deadlines/timeouts | `_defaultOptions()` in GrpcService |
| Error handling | gRPC status codes mapped to BoardFailure |
| Metadata | Commented examples for auth tokens |
| Proto messages | `proto/taskboard.dart` (hand-written equivalents) |

## gRPC vs REST vs GraphQL — Decision Guide

### When to choose gRPC

- **High-performance microservices**: Binary protobuf serialization is 5-10x smaller and faster than JSON
- **Streaming requirements**: Native support for server streaming, client streaming, and bidirectional streaming
- **Strongly-typed contracts**: `.proto` files serve as the single source of truth for the API
- **Code generation**: Auto-generated client/server stubs in 10+ languages
- **Low latency**: HTTP/2 multiplexing, header compression, persistent connections
- **Internal services**: Ideal for service-to-service communication

### When to choose REST

- **Public APIs**: Universal HTTP support, easy to consume from any client
- **Simple CRUD**: When your API maps cleanly to resources and HTTP verbs
- **Browser-first**: Native browser support without special libraries
- **Caching**: HTTP caching (ETags, Cache-Control) works out of the box
- **Tooling**: Widest ecosystem of tools (Postman, curl, OpenAPI/Swagger)
- **Team familiarity**: Most developers already know REST

### When to choose GraphQL

- **Flexible queries**: Clients request exactly the fields they need
- **Multiple data sources**: Aggregate data from multiple backends in one query
- **Rapidly evolving frontends**: UI teams can iterate without backend changes
- **Avoiding over/under-fetching**: Precise data loading per component
- **Subscriptions**: Built-in real-time support (though less efficient than gRPC streaming)
- **Introspection**: Self-documenting API schema

### Summary Table

| Factor | gRPC | REST | GraphQL |
|--------|------|------|---------|
| Performance | Best | Good | Good |
| Streaming | Native | Workarounds (SSE, WS) | Subscriptions |
| Browser support | Needs grpc-web | Native | Native |
| Type safety | Strong (proto) | Weak (OpenAPI optional) | Strong (schema) |
| Learning curve | Medium | Low | Medium-High |
| Tooling | Growing | Mature | Growing |
| File upload | Limited | Native | Needs multipart spec |
| Caching | Manual | HTTP native | Manual (normalized) |

## Switching to Real Protoc-Generated Code

1. Install the Dart protoc plugin:
   ```bash
   dart pub global activate protoc_plugin
   ```

2. Generate Dart code:
   ```bash
   protoc --dart_out=grpc:lib/proto ../backend-grpc/proto/taskboard.proto
   ```

3. Replace imports of `proto/taskboard.dart` with the generated files:
   - `proto/taskboard.pb.dart` (message types)
   - `proto/taskboard.pbgrpc.dart` (client stub)

4. Update `GrpcService` to use the generated client stub instead of throwing stubs.
