// =============================================================================
// hub.go — Central hub managing rooms, clients, and broadcasts
// =============================================================================

package main

import (
	"encoding/json"
	"log"
	"sync"
)

// ---------------------------------------------------------------------------
// Channel message types
// ---------------------------------------------------------------------------

/// RoomAction represents a client joining or leaving a room.
type RoomAction struct {
	client   *Client
	roomName string
}

/// BroadcastMessage represents a message to be broadcast to all members of a room.
type BroadcastMessage struct {
	roomName string
	event    WSEvent
}

// ---------------------------------------------------------------------------
// Hub — The central coordinator for all WebSocket connections
// ---------------------------------------------------------------------------

/// Hub maintains the set of active clients and rooms, and coordinates
/// message broadcasting. All room/client mutations flow through the hub's
/// event loop to avoid data races.
type Hub struct {
	// clients is the set of all connected clients.
	clients map[*Client]bool

	// rooms maps room names to Room instances.
	rooms map[string]*Room

	// register adds a new client to the hub.
	register chan *Client

	// unregister removes a client from the hub and all its rooms.
	unregister chan *Client

	// joinRoom processes a client joining a room.
	joinRoom chan *RoomAction

	// leaveRoom processes a client leaving a room.
	leaveRoom chan *RoomAction

	// broadcast sends a message to all members of a room.
	broadcast chan *BroadcastMessage

	mu sync.RWMutex
}

// DefaultRooms are created when the hub starts.
var DefaultRooms = []string{"general", "random", "tech"}

/// NewHub creates a new Hub with default rooms.
func NewHub() *Hub {
	h := &Hub{
		clients:    make(map[*Client]bool),
		rooms:      make(map[string]*Room),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		joinRoom:   make(chan *RoomAction),
		leaveRoom:  make(chan *RoomAction),
		broadcast:  make(chan *BroadcastMessage),
	}

	// Create default rooms
	for _, name := range DefaultRooms {
		h.rooms[name] = NewRoom(name)
	}

	return h
}

// ---------------------------------------------------------------------------
// Run — Main event loop (runs in its own goroutine)
// ---------------------------------------------------------------------------

/// Run starts the hub's main event loop. It must be called in a goroutine.
func (h *Hub) Run() {
	for {
		select {
		case client := <-h.register:
			h.clients[client] = true
			log.Printf("Client registered (total: %d)", len(h.clients))

			// Send the list of available rooms to the new client
			client.sendEvent(WSEvent{
				Type:  TypeRoomList,
				Rooms: h.getRoomNames(),
			})

		case client := <-h.unregister:
			if _, ok := h.clients[client]; ok {
				// Remove from all rooms before unregistering
				for roomName := range client.rooms {
					h.removeFromRoom(client, roomName)
				}
				delete(h.clients, client)
				close(client.send)
				log.Printf("Client %q unregistered (total: %d)", client.username, len(h.clients))
			}

		case action := <-h.joinRoom:
			h.handleJoinRoom(action.client, action.roomName)

		case action := <-h.leaveRoom:
			h.handleLeaveRoom(action.client, action.roomName)

		case msg := <-h.broadcast:
			h.broadcastToRoom(msg.roomName, msg.event)
		}
	}
}

// ---------------------------------------------------------------------------
// Room operations (called from the event loop — no locks needed for hub state)
// ---------------------------------------------------------------------------

/// handleJoinRoom adds a client to a room and broadcasts a presence update.
func (h *Hub) handleJoinRoom(client *Client, roomName string) {
	room, ok := h.rooms[roomName]
	if !ok {
		// Auto-create rooms on join
		// Alternative: could restrict to predefined rooms only
		room = NewRoom(roomName)
		h.rooms[roomName] = room
		log.Printf("Created new room: %s", roomName)
	}

	// Skip if already in the room
	if client.rooms[roomName] {
		return
	}

	client.rooms[roomName] = true
	room.AddMember(client)

	log.Printf("User %q joined room %q", client.username, roomName)

	// Notify the room about the new member
	h.broadcastToRoom(roomName, WSEvent{
		Type: TypeJoin,
		Room: roomName,
		User: client.username,
	})

	// Broadcast updated presence list
	h.broadcastPresence(roomName)
}

/// handleLeaveRoom removes a client from a room and broadcasts a presence update.
func (h *Hub) handleLeaveRoom(client *Client, roomName string) {
	h.removeFromRoom(client, roomName)
}

/// removeFromRoom is the shared implementation for leaving/disconnecting from a room.
func (h *Hub) removeFromRoom(client *Client, roomName string) {
	room, ok := h.rooms[roomName]
	if !ok {
		return
	}

	if !client.rooms[roomName] {
		return
	}

	delete(client.rooms, roomName)
	room.RemoveMember(client)

	log.Printf("User %q left room %q", client.username, roomName)

	// Notify remaining members
	h.broadcastToRoom(roomName, WSEvent{
		Type: TypeLeave,
		Room: roomName,
		User: client.username,
	})

	// Broadcast updated presence list
	h.broadcastPresence(roomName)
}

// ---------------------------------------------------------------------------
// Broadcasting
// ---------------------------------------------------------------------------

/// broadcastToRoom sends an event to all members of the given room.
func (h *Hub) broadcastToRoom(roomName string, event WSEvent) {
	room, ok := h.rooms[roomName]
	if !ok {
		return
	}

	data, err := json.Marshal(event)
	if err != nil {
		log.Printf("Failed to marshal broadcast event: %v", err)
		return
	}

	for _, client := range room.GetMembers() {
		select {
		case client.send <- data:
		default:
			// Client's send buffer is full — skip this message
			log.Printf("Dropped message for slow client %q", client.username)
		}
	}
}

/// broadcastToRoomExcept sends an event to all room members except the given client.
/// Used for typing indicators so the sender doesn't see their own typing event.
func (h *Hub) broadcastToRoomExcept(roomName string, exclude *Client, event WSEvent) {
	room, ok := h.rooms[roomName]
	if !ok {
		return
	}

	data, err := json.Marshal(event)
	if err != nil {
		log.Printf("Failed to marshal broadcast event: %v", err)
		return
	}

	for _, client := range room.GetMembers() {
		if client == exclude {
			continue
		}
		select {
		case client.send <- data:
		default:
			log.Printf("Dropped message for slow client %q", client.username)
		}
	}
}

/// broadcastPresence sends the current list of online users to all room members.
func (h *Hub) broadcastPresence(roomName string) {
	room, ok := h.rooms[roomName]
	if !ok {
		return
	}

	usernames := room.GetUsernames()

	h.broadcastToRoom(roomName, WSEvent{
		Type:  TypePresence,
		Room:  roomName,
		Users: usernames,
	})
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// addMessage stores a message in a room's history.
func (h *Hub) addMessage(roomName, user, content string) {
	h.mu.RLock()
	room, ok := h.rooms[roomName]
	h.mu.RUnlock()

	if ok {
		room.AddMessage(user, content)
	}
}

/// getRoomNames returns the names of all existing rooms.
func (h *Hub) getRoomNames() []string {
	names := make([]string, 0, len(h.rooms))
	for name := range h.rooms {
		names = append(names, name)
	}
	return names
}
