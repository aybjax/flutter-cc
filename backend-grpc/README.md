# Task Board gRPC Backend

A Go gRPC server for the Task Board (Kanban) application. Provides real-time board updates via server-streaming RPCs.

## Prerequisites

- Go 1.21+
- Protocol Buffer compiler (`protoc`) v3.x+
- Go plugins for protoc:
  ```bash
  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
  ```

## Generating Protobuf Code

The `pb/` directory currently contains a hand-written stub. To generate the real protobuf code:

```bash
# From the backend-grpc/ directory:
protoc \
  --go_out=. \
  --go_opt=paths=source_relative \
  --go-grpc_out=. \
  --go-grpc_opt=paths=source_relative \
  proto/taskboard.proto
```

This generates two files in `pb/`:
- `taskboard.pb.go` — Message types and serialization
- `taskboard_grpc.pb.go` — Service interface, client/server stubs

**After generating**, delete the stub file `pb/taskboard.go`.

## Running the Server

```bash
# Install dependencies
go mod tidy

# Generate protobuf code (see above)

# Run the server
go run .
```

The server starts on port **50051** by default. Override with the `PORT` environment variable:

```bash
PORT=8080 go run .
```

## Testing with grpcurl

```bash
# Install grpcurl
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

# List services
grpcurl -plaintext localhost:50051 list

# Get all boards
grpcurl -plaintext localhost:50051 taskboard.TaskBoardService/GetBoards

# Get a specific board
grpcurl -plaintext -d '{"board_id": "board_1"}' localhost:50051 taskboard.TaskBoardService/GetBoard

# Create a card
grpcurl -plaintext -d '{
  "board_id": "board_1",
  "column_id": "col_todo",
  "title": "New Task",
  "description": "A new task"
}' localhost:50051 taskboard.TaskBoardService/CreateCard

# Move a card
grpcurl -plaintext -d '{
  "card_id": "card_1",
  "target_column_id": "col_progress",
  "target_position": 0
}' localhost:50051 taskboard.TaskBoardService/MoveCard

# Delete a card
grpcurl -plaintext -d '{"card_id": "card_1"}' localhost:50051 taskboard.TaskBoardService/DeleteCard

# Watch a board for changes (streaming)
grpcurl -plaintext -d '{"board_id": "board_1"}' localhost:50051 taskboard.TaskBoardService/WatchBoard
```

## Pre-seeded Data

The server starts with a "Project Alpha" board containing:

| Column       | Cards                        |
|-------------|------------------------------|
| To Do       | Design landing page, Write API docs |
| In Progress | Implement auth               |
| Review      | (empty)                      |
| Done        | Set up CI/CD                 |

## Architecture

```
main.go     → Server entry point, listener setup, graceful shutdown
server.go   → TaskBoardServiceServer implementation (all RPCs)
models.go   → In-memory Store with thread-safe CRUD operations
proto/      → Protocol Buffer definitions (source of truth)
pb/         → Generated Go code (or stub until protoc is run)
```
