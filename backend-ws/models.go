// =============================================================================
// models.go — Message types, User, and Room structs for the WebSocket chat server
// =============================================================================

package main

import "time"

// ---------------------------------------------------------------------------
// Message Types — Constants for WebSocket event types
// ---------------------------------------------------------------------------

const (
	// TypeJoin is sent when a user joins a room.
	TypeJoin = "join"

	// TypeLeave is sent when a user leaves a room.
	TypeLeave = "leave"

	// TypeMessage is sent when a user sends a chat message.
	TypeMessage = "message"

	// TypeTyping is sent when a user is typing in a room.
	TypeTyping = "typing"

	// TypePresence is broadcast to inform clients of online users in a room.
	TypePresence = "presence"

	// TypeError is sent when the server encounters an error processing a request.
	TypeError = "error"

	// TypeRoomList is sent to provide the list of available rooms.
	TypeRoomList = "room_list"
)

// ---------------------------------------------------------------------------
// WSEvent — The top-level WebSocket message envelope
// ---------------------------------------------------------------------------

/// WSEvent represents a single WebSocket message exchanged between client and server.
/// All fields are optional depending on the message type.
type WSEvent struct {
	Type      string   `json:"type"`
	Room      string   `json:"room,omitempty"`
	User      string   `json:"user,omitempty"`
	Content   string   `json:"content,omitempty"`
	Users     []string `json:"users,omitempty"`
	Timestamp string   `json:"timestamp,omitempty"`
	Rooms     []string `json:"rooms,omitempty"`

	// Alternative: could use a more structured approach with separate
	// structs per message type and a discriminator field, but a flat
	// envelope is simpler for WebSocket JSON protocols.
}

// ---------------------------------------------------------------------------
// ChatMessage — A persisted chat message (kept in-memory per room)
// ---------------------------------------------------------------------------

/// ChatMessage represents a single chat message stored in a room's history.
type ChatMessage struct {
	User      string    `json:"user"`
	Content   string    `json:"content"`
	Timestamp time.Time `json:"timestamp"`
}
