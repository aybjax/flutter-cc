# Todo Backend API

A JWT-authorized todo app written in Go with in-memory storage.

All API responses are delayed by 2 seconds to simulate network latency.

## Running

```bash
cd backend
go run .
```

Server starts on `http://localhost:8080`.

## Authentication

Protected endpoints require a `Bearer` token in the `Authorization` header:

```
Authorization: Bearer <token>
```

Tokens are returned by the register and login endpoints.

## API Endpoints

### POST /register

Create a new user account.

**Request:**

```json
{
  "email": "user@example.com",
  "password": "secret123"
}
```

**Response (201):**

```json
{
  "user": { "id": 1, "email": "user@example.com" },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Errors:**

- `400` — missing email or password
- `409` — email already registered

---

### POST /login

Sign in with existing credentials.

**Request:**

```json
{
  "email": "user@example.com",
  "password": "secret123"
}
```

**Response (200):**

```json
{
  "user": { "id": 1, "email": "user@example.com" },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Errors:**

- `401` — invalid credentials

---

### POST /todos (Auth required)

Create a new todo item.

**Request:**

```json
{
  "title": "Buy groceries",
  "description": "Milk, eggs, bread, and butter"
}
```

**Response (201):**

```json
{
  "id": 1,
  "user_id": 1,
  "title": "Buy groceries",
  "description": "Milk, eggs, bread, and butter",
  "checked": false
}
```

**Errors:**

- `400` — missing title

---

### GET /todos (Auth required)

List the authenticated user's todos with pagination.

**Query parameters:**

| Param     | Default | Description              |
|-----------|---------|--------------------------|
| page      | 1       | Page number (1-based)    |
| page_size | 10      | Items per page (max 100) |

**Example:** `GET /todos?page=1&page_size=5`

**Response (200):**

```json
{
  "todos": [
    {
      "id": 1,
      "user_id": 1,
      "title": "Buy groceries",
      "description": "Milk, eggs, bread, and butter",
      "checked": false
    }
  ],
  "total": 1,
  "page": 1,
  "page_size": 5
}
```

---

### PATCH /todos/{id} (Auth required)

Mark a todo as checked/completed.

**Response (200):**

```json
{
  "id": 1,
  "user_id": 1,
  "title": "Buy groceries",
  "description": "Milk, eggs, bread, and butter",
  "checked": true
}
```

**Errors:**

- `400` — invalid id
- `404` — todo not found

---

### DELETE /todos/{id} (Auth required)

Delete a todo item.

**Response (200):**

```json
{
  "status": "deleted"
}
```

**Errors:**

- `400` — invalid id
- `404` — todo not found
