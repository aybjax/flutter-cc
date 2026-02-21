// =============================================================================
// client.go — WebSocket client connection handler
// =============================================================================

package main

import (
	"encoding/json"
	"log"
	"time"

	"github.com/gorilla/websocket"
)

// ---------------------------------------------------------------------------
// Tuning constants for WebSocket connections
// ---------------------------------------------------------------------------

const (
	// writeWait is the time allowed to write a message to the peer.
	writeWait = 10 * time.Second

	// pongWait is the time allowed to read the next pong message from the peer.
	pongWait = 60 * time.Second

	// pingPeriod sends pings to peer at this interval. Must be less than pongWait.
	pingPeriod = (pongWait * 9) / 10

	// maxMessageSize is the maximum message size allowed from the peer.
	maxMessageSize = 4096
)

// ---------------------------------------------------------------------------
// Client — Represents a single WebSocket connection
// ---------------------------------------------------------------------------

/// Client wraps a single WebSocket connection and its associated metadata.
/// Each client belongs to the hub and may be a member of multiple rooms.
type Client struct {
	hub      *Hub
	conn     *websocket.Conn
	send     chan []byte
	username string
	rooms    map[string]bool // set of room names the client has joined
}

/// NewClient creates a new Client for the given hub and WebSocket connection.
func NewClient(hub *Hub, conn *websocket.Conn) *Client {
	return &Client{
		hub:   hub,
		conn:  conn,
		send:  make(chan []byte, 256),
		rooms: make(map[string]bool),
	}
}

// ---------------------------------------------------------------------------
// ReadPump — reads messages from the WebSocket connection
// ---------------------------------------------------------------------------

/// ReadPump pumps messages from the WebSocket connection to the hub.
/// It runs in its own goroutine per client.
func (c *Client) ReadPump() {
	defer func() {
		// When the read pump exits, leave all rooms and unregister
		c.hub.unregister <- c
		c.conn.Close()
	}()

	c.conn.SetReadLimit(maxMessageSize)
	c.conn.SetReadDeadline(time.Now().Add(pongWait))
	c.conn.SetPongHandler(func(string) error {
		c.conn.SetReadDeadline(time.Now().Add(pongWait))
		return nil
	})

	for {
		_, rawMsg, err := c.conn.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseNormalClosure) {
				log.Printf("WebSocket error for user %q: %v", c.username, err)
			}
			break
		}

		// Parse the incoming event
		var event WSEvent
		if err := json.Unmarshal(rawMsg, &event); err != nil {
			log.Printf("Invalid JSON from %q: %v", c.username, err)
			c.sendError("invalid JSON format")
			continue
		}

		// Dispatch based on event type
		c.handleEvent(event)
	}
}

// ---------------------------------------------------------------------------
// WritePump — writes messages from the hub to the WebSocket connection
// ---------------------------------------------------------------------------

/// WritePump pumps messages from the hub to the WebSocket connection.
/// It runs in its own goroutine per client.
func (c *Client) WritePump() {
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		c.conn.Close()
	}()

	for {
		select {
		case message, ok := <-c.send:
			c.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				// The hub closed the channel — send a close frame
				c.conn.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}

			w, err := c.conn.NextWriter(websocket.TextMessage)
			if err != nil {
				return
			}
			w.Write(message)

			// Drain queued messages into the current write, separated by newlines
			// Alternative: could batch messages into a JSON array instead
			n := len(c.send)
			for i := 0; i < n; i++ {
				w.Write([]byte("\n"))
				w.Write(<-c.send)
			}

			if err := w.Close(); err != nil {
				return
			}

		case <-ticker.C:
			c.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := c.conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

// ---------------------------------------------------------------------------
// Event handling
// ---------------------------------------------------------------------------

/// handleEvent dispatches an incoming WSEvent to the appropriate handler.
func (c *Client) handleEvent(event WSEvent) {
	switch event.Type {
	case TypeJoin:
		c.handleJoin(event)
	case TypeLeave:
		c.handleLeave(event)
	case TypeMessage:
		c.handleMessage(event)
	case TypeTyping:
		c.handleTyping(event)
	default:
		c.sendError("unknown event type: " + event.Type)
	}
}

/// handleJoin processes a join event — sets the username, joins the room,
/// and broadcasts presence to other room members.
func (c *Client) handleJoin(event WSEvent) {
	if event.User == "" || event.Room == "" {
		c.sendError("join requires 'user' and 'room' fields")
		return
	}

	// Set username on first join
	if c.username == "" {
		c.username = event.User
	}

	c.hub.joinRoom <- &RoomAction{client: c, roomName: event.Room}
}

/// handleLeave processes a leave event — removes the client from the room
/// and broadcasts updated presence.
func (c *Client) handleLeave(event WSEvent) {
	if event.Room == "" {
		c.sendError("leave requires 'room' field")
		return
	}

	c.hub.leaveRoom <- &RoomAction{client: c, roomName: event.Room}
}

/// handleMessage processes a chat message — stores it in the room history
/// and broadcasts it to all room members.
func (c *Client) handleMessage(event WSEvent) {
	if event.Room == "" || event.Content == "" {
		c.sendError("message requires 'room' and 'content' fields")
		return
	}

	// Only allow messages to rooms the client has joined
	if !c.rooms[event.Room] {
		c.sendError("you must join the room before sending messages")
		return
	}

	c.hub.broadcast <- &BroadcastMessage{
		roomName: event.Room,
		event: WSEvent{
			Type:      TypeMessage,
			Room:      event.Room,
			User:      c.username,
			Content:   event.Content,
			Timestamp: time.Now().UTC().Format(time.RFC3339),
		},
	}

	// Store in room history
	c.hub.addMessage(event.Room, c.username, event.Content)
}

/// handleTyping processes a typing indicator — broadcasts it to room members
/// (except the sender).
func (c *Client) handleTyping(event WSEvent) {
	if event.Room == "" {
		c.sendError("typing requires 'room' field")
		return
	}

	if !c.rooms[event.Room] {
		return // silently ignore typing from non-members
	}

	c.hub.broadcastToRoomExcept(event.Room, c, WSEvent{
		Type:      TypeTyping,
		Room:      event.Room,
		User:      c.username,
		Timestamp: time.Now().UTC().Format(time.RFC3339),
	})
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// sendError sends an error message back to this client only.
func (c *Client) sendError(msg string) {
	event := WSEvent{
		Type:    TypeError,
		Content: msg,
	}
	data, err := json.Marshal(event)
	if err != nil {
		log.Printf("Failed to marshal error event: %v", err)
		return
	}

	select {
	case c.send <- data:
	default:
		// Channel full — drop the error message rather than blocking
	}
}

/// sendEvent sends a single event to this client.
func (c *Client) sendEvent(event WSEvent) {
	data, err := json.Marshal(event)
	if err != nil {
		log.Printf("Failed to marshal event: %v", err)
		return
	}

	select {
	case c.send <- data:
	default:
		// Channel full — drop the message
	}
}
