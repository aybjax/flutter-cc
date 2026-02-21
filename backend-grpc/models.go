// =============================================================================
// models.go — In-memory data storage for the Task Board gRPC server
// =============================================================================
//
// This file manages thread-safe in-memory storage for boards, columns, and
// cards. It uses sync.RWMutex for concurrent access and provides a pre-seeded
// default board so the app has data to display immediately.
//
// In production, you would replace this with a database layer (PostgreSQL,
// MongoDB, etc.) behind a repository interface.
// =============================================================================

package main

import (
	"fmt"
	"sync"

	pb "backend-grpc/pb"
)

// ---------------------------------------------------------------------------
// Store — thread-safe in-memory storage
// ---------------------------------------------------------------------------

// Store holds all boards and provides thread-safe CRUD operations.
type Store struct {
	mu     sync.RWMutex
	boards map[string]*pb.Board
	// cardIndex maps card_id -> (board_id, column_id) for fast lookups
	cardIndex map[string][2]string
	// nextID is a simple auto-incrementing counter for generating unique IDs
	nextID int
}

// NewStore creates a Store pre-seeded with a default Kanban board.
func NewStore() *Store {
	s := &Store{
		boards:    make(map[string]*pb.Board),
		cardIndex: make(map[string][2]string),
		nextID:    100, // Start at 100 to distinguish from seed IDs
	}
	s.seed()
	return s
}

// generateID produces a simple unique ID string.
func (s *Store) generateID() string {
	s.nextID++
	return fmt.Sprintf("id_%d", s.nextID)
}

// ---------------------------------------------------------------------------
// seed — populate default board with sample data
// ---------------------------------------------------------------------------

func (s *Store) seed() {
	board := &pb.Board{
		Id:   "board_1",
		Name: "Project Alpha",
		Columns: []*pb.Column{
			{
				Id:       "col_todo",
				Name:     "To Do",
				Position: 0,
				Cards: []*pb.Card{
					{
						Id:          "card_1",
						Title:       "Design landing page",
						Description: "Create mockups for the new landing page",
						ColumnId:    "col_todo",
						Position:    0,
					},
					{
						Id:          "card_2",
						Title:       "Write API docs",
						Description: "Document all REST endpoints",
						ColumnId:    "col_todo",
						Position:    1,
					},
				},
			},
			{
				Id:       "col_progress",
				Name:     "In Progress",
				Position: 1,
				Cards: []*pb.Card{
					{
						Id:          "card_3",
						Title:       "Implement auth",
						Description: "Add JWT-based authentication",
						ColumnId:    "col_progress",
						Position:    0,
					},
				},
			},
			{
				Id:       "col_review",
				Name:     "Review",
				Position: 2,
				Cards:    []*pb.Card{},
			},
			{
				Id:       "col_done",
				Name:     "Done",
				Position: 3,
				Cards: []*pb.Card{
					{
						Id:          "card_4",
						Title:       "Set up CI/CD",
						Description: "Configure GitHub Actions pipeline",
						ColumnId:    "col_done",
						Position:    0,
					},
				},
			},
		},
	}

	s.boards[board.Id] = board

	// Build the card index for fast lookups
	for _, col := range board.Columns {
		for _, card := range col.Cards {
			s.cardIndex[card.Id] = [2]string{board.Id, col.Id}
		}
	}
}

// ---------------------------------------------------------------------------
// Read operations
// ---------------------------------------------------------------------------

// GetAllBoards returns a snapshot of all boards (without deep copy for simplicity).
func (s *Store) GetAllBoards() []*pb.Board {
	s.mu.RLock()
	defer s.mu.RUnlock()

	boards := make([]*pb.Board, 0, len(s.boards))
	for _, b := range s.boards {
		boards = append(boards, b)
	}
	return boards
}

// GetBoard returns a single board by ID, or nil if not found.
func (s *Store) GetBoard(boardID string) *pb.Board {
	s.mu.RLock()
	defer s.mu.RUnlock()

	return s.boards[boardID]
}

// ---------------------------------------------------------------------------
// Write operations
// ---------------------------------------------------------------------------

// CreateCard adds a new card to the specified board/column.
// Returns the new card, or an error if the board/column doesn't exist.
func (s *Store) CreateCard(boardID, columnID, title, description string) (*pb.Card, error) {
	s.mu.Lock()
	defer s.mu.Unlock()

	board, ok := s.boards[boardID]
	if !ok {
		return nil, fmt.Errorf("board %q not found", boardID)
	}

	// Find the target column
	for _, col := range board.Columns {
		if col.Id == columnID {
			card := &pb.Card{
				Id:          s.generateID(),
				Title:       title,
				Description: description,
				ColumnId:    columnID,
				Position:    int32(len(col.Cards)), // Append to end
			}
			col.Cards = append(col.Cards, card)
			s.cardIndex[card.Id] = [2]string{boardID, columnID}
			return card, nil
		}
	}

	return nil, fmt.Errorf("column %q not found in board %q", columnID, boardID)
}

// MoveCard relocates a card to a new column/position.
// Returns the updated card, or an error if the card/column doesn't exist.
func (s *Store) MoveCard(cardID, targetColumnID string, targetPosition int32) (*pb.Card, error) {
	s.mu.Lock()
	defer s.mu.Unlock()

	// Look up which board/column the card is currently in
	loc, ok := s.cardIndex[cardID]
	if !ok {
		return nil, fmt.Errorf("card %q not found", cardID)
	}

	boardID := loc[0]
	sourceColumnID := loc[1]
	board := s.boards[boardID]

	var card *pb.Card
	var sourceCol, targetCol *pb.Column

	// Find source and target columns, and the card itself
	for _, col := range board.Columns {
		if col.Id == sourceColumnID {
			sourceCol = col
		}
		if col.Id == targetColumnID {
			targetCol = col
		}
	}

	if sourceCol == nil {
		return nil, fmt.Errorf("source column %q not found", sourceColumnID)
	}
	if targetCol == nil {
		return nil, fmt.Errorf("target column %q not found", targetColumnID)
	}

	// Remove card from source column
	for i, c := range sourceCol.Cards {
		if c.Id == cardID {
			card = c
			sourceCol.Cards = append(sourceCol.Cards[:i], sourceCol.Cards[i+1:]...)
			break
		}
	}

	if card == nil {
		return nil, fmt.Errorf("card %q not found in column %q", cardID, sourceColumnID)
	}

	// Reindex source column positions
	for i, c := range sourceCol.Cards {
		c.Position = int32(i)
	}

	// Clamp target position
	if targetPosition < 0 {
		targetPosition = 0
	}
	if int(targetPosition) > len(targetCol.Cards) {
		targetPosition = int32(len(targetCol.Cards))
	}

	// Insert card at target position
	card.ColumnId = targetColumnID
	card.Position = targetPosition

	// Splice the card into the target column at the right position
	newCards := make([]*pb.Card, 0, len(targetCol.Cards)+1)
	newCards = append(newCards, targetCol.Cards[:targetPosition]...)
	newCards = append(newCards, card)
	newCards = append(newCards, targetCol.Cards[targetPosition:]...)
	targetCol.Cards = newCards

	// Reindex target column positions
	for i, c := range targetCol.Cards {
		c.Position = int32(i)
	}

	// Update card index
	s.cardIndex[cardID] = [2]string{boardID, targetColumnID}

	return card, nil
}

// DeleteCard removes a card by ID. Returns an error if not found.
func (s *Store) DeleteCard(cardID string) error {
	s.mu.Lock()
	defer s.mu.Unlock()

	loc, ok := s.cardIndex[cardID]
	if !ok {
		return fmt.Errorf("card %q not found", cardID)
	}

	boardID := loc[0]
	columnID := loc[1]
	board := s.boards[boardID]

	for _, col := range board.Columns {
		if col.Id == columnID {
			for i, c := range col.Cards {
				if c.Id == cardID {
					col.Cards = append(col.Cards[:i], col.Cards[i+1:]...)
					// Reindex positions
					for j, remaining := range col.Cards {
						remaining.Position = int32(j)
					}
					break
				}
			}
			break
		}
	}

	delete(s.cardIndex, cardID)
	return nil
}

// FindCardBoardID returns the board ID that contains the given card.
func (s *Store) FindCardBoardID(cardID string) (string, bool) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	loc, ok := s.cardIndex[cardID]
	if !ok {
		return "", false
	}
	return loc[0], true
}
