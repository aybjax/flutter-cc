# WebSocket Chat Server (Go)

A multi-room WebSocket chat server built with Go and gorilla/websocket.

## Architecture

```
main.go     — HTTP server, WebSocket upgrade handler
hub.go      — Central coordinator: manages clients, rooms, broadcasts
client.go   — Per-connection handler: read/write pumps, event dispatch
room.go     — Room state: members, message history
models.go   — Shared types: WSEvent, ChatMessage
```

## Running

```bash
go mod tidy
go run .
```

The server listens on **port 8081**.

- WebSocket endpoint: `ws://localhost:8081/ws`
- Health check: `http://localhost:8081/health`

## Protocol

All messages are JSON objects with a `type` field:

| Type       | Direction       | Fields                              |
|------------|-----------------|-------------------------------------|
| `join`     | client -> server | `type`, `room`, `user`             |
| `leave`    | client -> server | `type`, `room`                     |
| `message`  | bidirectional    | `type`, `room`, `user`, `content`, `timestamp` |
| `typing`   | bidirectional    | `type`, `room`, `user`             |
| `presence` | server -> client | `type`, `room`, `users`            |
| `room_list`| server -> client | `type`, `rooms`                    |
| `error`    | server -> client | `type`, `content`                  |

### Example flow

```
Client -> Server:  {"type":"join","room":"general","user":"alice"}
Server -> All:     {"type":"join","room":"general","user":"alice"}
Server -> All:     {"type":"presence","room":"general","users":["alice"]}
Client -> Server:  {"type":"message","room":"general","user":"alice","content":"Hello!"}
Server -> All:     {"type":"message","room":"general","user":"alice","content":"Hello!","timestamp":"..."}
Client -> Server:  {"type":"typing","room":"general","user":"alice"}
Server -> Others:  {"type":"typing","room":"general","user":"alice"}
```

## Default Rooms

The server creates three rooms on startup: `general`, `random`, `tech`.
New rooms are auto-created when a client joins a non-existent room.
