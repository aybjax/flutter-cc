// =============================================================================
// main.go — Server entry point and HTTP route configuration
// =============================================================================

package main

import (
	"log"
	"net/http"

	"github.com/gorilla/websocket"
)

// ---------------------------------------------------------------------------
// WebSocket upgrader
// ---------------------------------------------------------------------------

// upgrader handles HTTP → WebSocket protocol upgrade.
// CheckOrigin allows all origins for development convenience.
// In production, restrict this to your app's domain.
var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		// Allow all origins in development
		// Alternative: check r.Header.Get("Origin") against a whitelist
		return true
	},
}

// ---------------------------------------------------------------------------
// HTTP Handlers
// ---------------------------------------------------------------------------

/// serveWs handles WebSocket upgrade requests. It creates a new Client,
/// registers it with the hub, and starts its read/write pumps.
func serveWs(hub *Hub, w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Printf("WebSocket upgrade failed: %v", err)
		return
	}

	client := NewClient(hub, conn)
	hub.register <- client

	// Start read and write pumps in separate goroutines
	go client.WritePump()
	go client.ReadPump()
}

/// serveHealth returns a simple health check response.
func serveHealth(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(`{"status":"ok"}`))
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

func main() {
	hub := NewHub()
	go hub.Run()

	// Routes
	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		serveWs(hub, w, r)
	})
	http.HandleFunc("/health", serveHealth)

	addr := ":8081"
	log.Printf("WebSocket chat server starting on %s", addr)
	log.Printf("WebSocket endpoint: ws://localhost%s/ws", addr)
	log.Printf("Health check: http://localhost%s/health", addr)

	if err := http.ListenAndServe(addr, nil); err != nil {
		log.Fatalf("Server failed: %v", err)
	}
}
