// =============================================================================
// main.go — Entry point for the Task Board gRPC server
// =============================================================================
//
// Starts a gRPC server on port 50051 that provides the TaskBoardService.
// The server uses in-memory storage with pre-seeded sample data.
//
// Usage:
//   go run .
//
// The server logs all RPC calls for debugging. In production you would add:
//   - TLS configuration
//   - Authentication interceptors
//   - Graceful shutdown handling
//   - Metrics/tracing (OpenTelemetry)
// =============================================================================

package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"
	"syscall"

	pb "backend-grpc/pb"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	// defaultPort is the port the gRPC server listens on.
	// Override with the PORT environment variable.
	defaultPort = "50051"
)

func main() {
	// ---------------------------------------------------------------------------
	// Determine the port
	// ---------------------------------------------------------------------------
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	// ---------------------------------------------------------------------------
	// Create the TCP listener
	// ---------------------------------------------------------------------------
	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", port))
	if err != nil {
		log.Fatalf("Failed to listen on port %s: %v", port, err)
	}

	// ---------------------------------------------------------------------------
	// Create and configure the gRPC server
	// ---------------------------------------------------------------------------
	grpcServer := grpc.NewServer(
	// In production, add interceptors here:
	// grpc.UnaryInterceptor(loggingInterceptor),
	// grpc.StreamInterceptor(streamLoggingInterceptor),
	//
	// For TLS:
	// grpc.Creds(credentials.NewTLS(tlsConfig)),
	)

	// Register our service implementation
	taskBoardServer := NewTaskBoardServer()
	pb.RegisterTaskBoardServiceServer(grpcServer, taskBoardServer)

	// Enable server reflection for debugging with grpcurl
	// In production, you might want to disable this
	reflection.Register(grpcServer)

	// ---------------------------------------------------------------------------
	// Graceful shutdown on SIGINT/SIGTERM
	// ---------------------------------------------------------------------------
	go func() {
		sigChan := make(chan os.Signal, 1)
		signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
		sig := <-sigChan
		log.Printf("Received signal %v, shutting down gracefully...", sig)
		grpcServer.GracefulStop()
	}()

	// ---------------------------------------------------------------------------
	// Start serving
	// ---------------------------------------------------------------------------
	log.Printf("Task Board gRPC server listening on :%s", port)
	log.Println("Pre-seeded with 'Project Alpha' board (4 columns, 4 cards)")
	log.Println("Use grpcurl or the Flutter client to interact with the server")

	if err := grpcServer.Serve(listener); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
