package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	store := NewStore()
	images := NewImageStore()
	srv := NewServer(store, images)

	mux := http.NewServeMux()

	mux.HandleFunc("POST /register", srv.Register)
	mux.HandleFunc("POST /login", srv.Login)

	protected := http.NewServeMux()
	protected.HandleFunc("POST /todos", srv.CreateTodo)
	protected.HandleFunc("GET /todos", srv.ListTodos)
	protected.HandleFunc("GET /todos/{id}", srv.GetTodo)
	protected.HandleFunc("PATCH /todos/{id}", srv.UpdateTodo)
	protected.HandleFunc("DELETE /todos/{id}", srv.DeleteTodo)

	mux.Handle("/images/", http.StripPrefix("/images/", http.FileServer(http.Dir(dataDir))))
	mux.Handle("/", AuthMiddleware(protected))

	addr := ":8080"
	fmt.Printf("Server listening on %s\n", addr)
	log.Fatal(http.ListenAndServe(addr, mux))
}
