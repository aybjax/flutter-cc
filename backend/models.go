package main

import "sync"

type User struct {
	ID       int    `json:"id"`
	Email    string `json:"email"`
	Password string `json:"-"`
}

type Todo struct {
	ID          int    `json:"id"`
	UserID      int    `json:"user_id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Checked     bool   `json:"checked"`
	IconHash    string `json:"-"`
}

type TodoSummary struct {
	ID        int    `json:"id"`
	Title     string `json:"title"`
	Checked   bool   `json:"checked"`
	Thumbnail string `json:"thumbnail,omitempty"`
}

type TodoDetail struct {
	ID          int    `json:"id"`
	UserID      int    `json:"user_id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Checked     bool   `json:"checked"`
	Image       string `json:"image,omitempty"`
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

func (s *Store) CreateTodo(userID int, title, description, iconHash string) Todo {
	s.mu.Lock()
	defer s.mu.Unlock()
	t := Todo{ID: s.nextTID, UserID: userID, Title: title, Description: description, IconHash: iconHash}
	s.nextTID++
	s.todos = append(s.todos, t)
	return t
}

func (s *Store) GetTodos(userID, page, pageSize int, images *ImageStore) ([]TodoSummary, int) {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var all []TodoSummary
	for _, t := range s.todos {
		if t.UserID == userID {
			summary := TodoSummary{ID: t.ID, Title: t.Title, Checked: t.Checked}
			if t.IconHash != "" {
				summary.Thumbnail = images.ThumbnailURL(t.IconHash)
			}
			all = append(all, summary)
		}
	}
	total := len(all)
	start := (page - 1) * pageSize
	if start >= total {
		return []TodoSummary{}, total
	}
	end := start + pageSize
	if end > total {
		end = total
	}
	return all[start:end], total
}

func (s *Store) GetTodo(userID, todoID int) *Todo {
	s.mu.RLock()
	defer s.mu.RUnlock()
	for _, t := range s.todos {
		if t.ID == todoID && t.UserID == userID {
			return &t
		}
	}
	return nil
}

func (s *Store) DeleteTodo(userID, todoID int) bool {
	s.mu.Lock()
	defer s.mu.Unlock()
	for i := range s.todos {
		if s.todos[i].ID == todoID && s.todos[i].UserID == userID {
			s.todos = append(s.todos[:i], s.todos[i+1:]...)
			return true
		}
	}
	return false
}

type TodoUpdate struct {
	Title       *string
	Description *string
	Checked     *bool
	IconHash    *string
}

func (s *Store) UpdateTodo(userID, todoID int, upd TodoUpdate) *Todo {
	s.mu.Lock()
	defer s.mu.Unlock()
	for i := range s.todos {
		if s.todos[i].ID == todoID && s.todos[i].UserID == userID {
			if upd.Title != nil {
				s.todos[i].Title = *upd.Title
			}
			if upd.Description != nil {
				s.todos[i].Description = *upd.Description
			}
			if upd.Checked != nil {
				s.todos[i].Checked = *upd.Checked
			}
			if upd.IconHash != nil {
				s.todos[i].IconHash = *upd.IconHash
			}
			t := s.todos[i]
			return &t
		}
	}
	return nil
}
