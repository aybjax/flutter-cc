package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"time"

	"golang.org/x/crypto/bcrypt"
)

type Server struct {
	store *Store
}

func NewServer(store *Store) *Server {
	return &Server{store: store}
}

func writeJSON(w http.ResponseWriter, status int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(v)
}

func (s *Server) Register(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	var req struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "invalid body"})
		return
	}
	if req.Email == "" || req.Password == "" {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "email and password required"})
		return
	}
	if s.store.FindUserByEmail(req.Email) != nil {
		writeJSON(w, http.StatusConflict, map[string]string{"error": "email already registered"})
		return
	}

	hashed, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		writeJSON(w, http.StatusInternalServerError, map[string]string{"error": "internal error"})
		return
	}

	user := s.store.CreateUser(req.Email, string(hashed))
	token, _ := GenerateToken(user.ID)

	writeJSON(w, http.StatusCreated, map[string]any{
		"user":  user,
		"token": token,
	})
}

func (s *Server) Login(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	var req struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "invalid body"})
		return
	}

	user := s.store.FindUserByEmail(req.Email)
	if user == nil {
		writeJSON(w, http.StatusUnauthorized, map[string]string{"error": "invalid credentials"})
		return
	}
	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		writeJSON(w, http.StatusUnauthorized, map[string]string{"error": "invalid credentials"})
		return
	}

	token, _ := GenerateToken(user.ID)
	writeJSON(w, http.StatusOK, map[string]any{
		"user":  user,
		"token": token,
	})
}

func (s *Server) CreateTodo(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	userID := r.Context().Value(userIDKey).(int)

	var req struct {
		Title       string `json:"title"`
		Description string `json:"description"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil || req.Title == "" {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "title required"})
		return
	}

	todo := s.store.CreateTodo(userID, req.Title, req.Description)
	writeJSON(w, http.StatusCreated, todo)
}

func (s *Server) ListTodos(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	userID := r.Context().Value(userIDKey).(int)

	page, _ := strconv.Atoi(r.URL.Query().Get("page"))
	if page < 1 {
		page = 1
	}
	pageSize, _ := strconv.Atoi(r.URL.Query().Get("page_size"))
	if pageSize < 1 || pageSize > 100 {
		pageSize = 10
	}

	todos, total := s.store.GetTodos(userID, page, pageSize)
	writeJSON(w, http.StatusOK, map[string]any{
		"todos":     todos,
		"total":     total,
		"page":      page,
		"page_size": pageSize,
	})
}

func (s *Server) GetTodo(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	userID := r.Context().Value(userIDKey).(int)
	idStr := r.PathValue("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "invalid id"})
		return
	}

	todo := s.store.GetTodo(userID, id)
	if todo == nil {
		writeJSON(w, http.StatusNotFound, map[string]string{"error": "todo not found"})
		return
	}
	writeJSON(w, http.StatusOK, todo)
}

func (s *Server) UpdateTodo(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	userID := r.Context().Value(userIDKey).(int)
	idStr := r.PathValue("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "invalid id"})
		return
	}

	var upd TodoUpdate
	if err := json.NewDecoder(r.Body).Decode(&upd); err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "invalid body"})
		return
	}

	todo := s.store.UpdateTodo(userID, id, upd)
	if todo == nil {
		writeJSON(w, http.StatusNotFound, map[string]string{"error": "todo not found"})
		return
	}
	writeJSON(w, http.StatusOK, todo)
}

func (s *Server) DeleteTodo(w http.ResponseWriter, r *http.Request) {
	time.Sleep(2 * time.Second)

	userID := r.Context().Value(userIDKey).(int)
	idStr := r.PathValue("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "invalid id"})
		return
	}

	if !s.store.DeleteTodo(userID, id) {
		writeJSON(w, http.StatusNotFound, map[string]string{"error": "todo not found"})
		return
	}
	writeJSON(w, http.StatusOK, map[string]string{"status": "deleted"})
}
