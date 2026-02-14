package main

import "sync"

type User struct {
	ID       int    `json:"id"`
	Email    string `json:"email"`
	Password string `json:"-"`
}

type Todo struct {
	ID      int    `json:"id"`
	UserID  int    `json:"user_id"`
	Title   string `json:"title"`
	Checked bool   `json:"checked"`
}

type Store struct {
	mu      sync.RWMutex
	users   []User
	todos   []Todo
	nextUID int
	nextTID int
}

func NewStore() *Store {
	return &Store{nextUID: 1, nextTID: 1}
}

func (s *Store) CreateUser(email, hashedPassword string) User {
	s.mu.Lock()
	defer s.mu.Unlock()
	u := User{ID: s.nextUID, Email: email, Password: hashedPassword}
	s.nextUID++
	s.users = append(s.users, u)
	return u
}

func (s *Store) FindUserByEmail(email string) *User {
	s.mu.RLock()
	defer s.mu.RUnlock()
	for _, u := range s.users {
		if u.Email == email {
			return &u
		}
	}
	return nil
}

func (s *Store) CreateTodo(userID int, title string) Todo {
	s.mu.Lock()
	defer s.mu.Unlock()
	t := Todo{ID: s.nextTID, UserID: userID, Title: title}
	s.nextTID++
	s.todos = append(s.todos, t)
	return t
}

func (s *Store) GetTodos(userID int) []Todo {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var result []Todo
	for _, t := range s.todos {
		if t.UserID == userID {
			result = append(result, t)
		}
	}
	return result
}

func (s *Store) CheckTodo(userID, todoID int) *Todo {
	s.mu.Lock()
	defer s.mu.Unlock()
	for i := range s.todos {
		if s.todos[i].ID == todoID && s.todos[i].UserID == userID {
			s.todos[i].Checked = true
			t := s.todos[i]
			return &t
		}
	}
	return nil
}
