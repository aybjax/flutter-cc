// =============================================================================
// room.go — Chat room logic: tracks members, stores message history
// =============================================================================

package main

import (
	"sync"
	"time"
)

// ---------------------------------------------------------------------------
// Room — Represents a single chat room
// ---------------------------------------------------------------------------

// MaxHistory is the maximum number of messages kept in a room's history.
// Older messages are discarded when this limit is reached.
const MaxHistory = 100

/// Room manages a single chat room, tracking its members and message history.
type Room struct {
	Name    string
	members map[*Client]bool
	history []ChatMessage
	mu      sync.RWMutex
}

/// NewRoom creates a new Room with the given name.
func NewRoom(name string) *Room {
	return &Room{
		Name:    name,
		members: make(map[*Client]bool),
		history: make([]ChatMessage, 0),
	}
}

// ---------------------------------------------------------------------------
// Member management
// ---------------------------------------------------------------------------

/// AddMember registers a client as a member of this room.
func (r *Room) AddMember(c *Client) {
	r.mu.Lock()
	defer r.mu.Unlock()
	r.members[c] = true
}

/// RemoveMember unregisters a client from this room.
func (r *Room) RemoveMember(c *Client) {
	r.mu.Lock()
	defer r.mu.Unlock()
	delete(r.members, c)
}

/// GetMembers returns a snapshot of all current members in the room.
func (r *Room) GetMembers() []*Client {
	r.mu.RLock()
	defer r.mu.RUnlock()
	members := make([]*Client, 0, len(r.members))
	for c := range r.members {
		members = append(members, c)
	}
	return members
}

/// GetUsernames returns the usernames of all members currently in the room.
func (r *Room) GetUsernames() []string {
	r.mu.RLock()
	defer r.mu.RUnlock()
	// Use a set to deduplicate in case a user has multiple connections
	seen := make(map[string]bool)
	usernames := make([]string, 0, len(r.members))
	for c := range r.members {
		if !seen[c.username] {
			seen[c.username] = true
			usernames = append(usernames, c.username)
		}
	}
	return usernames
}

/// MemberCount returns the number of members in this room.
func (r *Room) MemberCount() int {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return len(r.members)
}

// ---------------------------------------------------------------------------
// Message history
// ---------------------------------------------------------------------------

/// AddMessage appends a message to the room's history, trimming old messages
/// if the history exceeds MaxHistory.
func (r *Room) AddMessage(user, content string) ChatMessage {
	r.mu.Lock()
	defer r.mu.Unlock()

	msg := ChatMessage{
		User:      user,
		Content:   content,
		Timestamp: time.Now(),
	}
	r.history = append(r.history, msg)

	// Trim history to keep memory bounded
	if len(r.history) > MaxHistory {
		r.history = r.history[len(r.history)-MaxHistory:]
	}

	return msg
}

/// GetHistory returns the last N messages from the room's history.
/// If n <= 0 or n > len(history), all messages are returned.
func (r *Room) GetHistory(n int) []ChatMessage {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if n <= 0 || n > len(r.history) {
		// Return a copy to avoid data races
		result := make([]ChatMessage, len(r.history))
		copy(result, r.history)
		return result
	}

	start := len(r.history) - n
	result := make([]ChatMessage, n)
	copy(result, r.history[start:])
	return result
}
