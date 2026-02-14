package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	store := NewStore()
	srv := NewServer(store)

	mux := http.NewServeMux()

	mux.HandleFunc("POST /register", srv.Register)
	mux.HandleFunc("POST /login", srv.Login)

	protected := http.NewServeMux()
	protected.HandleFunc("POST /todos", srv.CreateTodo)
	protected.HandleFunc("GET /todos", srv.ListTodos)
	protected.HandleFunc("PATCH /todos/{id}", srv.CheckTodo)

	mux.Handle("/", AuthMiddleware(protected))

	addr := ":8080"
	fmt.Printf("Server listening on %s\n", addr)
	log.Fatal(http.ListenAndServe(addr, mux))
}
