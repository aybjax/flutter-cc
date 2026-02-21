# 4-state-cubit: Cubit State Management Tutorial

A Todo app that teaches **Cubit state management** with `flutter_bloc`, connecting to the existing Go backend at `localhost:8080`.

## What This App Teaches

### Core Concepts
- **`Cubit<State>`** — lightweight state management (simpler than Bloc)
- **`emit()`** — the only way to change state (replaces `notifyListeners`)
- **`BlocProvider`** — provides a Cubit to the widget tree
- **`BlocBuilder`** — rebuilds UI when state changes
- **`BlocListener`** — executes side effects (navigation, snackbars)
- **`BlocConsumer`** — combines BlocBuilder + BlocListener
- **`MultiBlocProvider`** — provides multiple Cubits at once

### The 4-State Pattern
Every Cubit uses **freezed sealed unions** with four states:
1. **Initial** — no operation has started
2. **Loading** — an async operation is in progress
3. **Loaded** — data is available
4. **Error** — an error occurred

This eliminates "impossible states" (can't be loading AND error simultaneously).

### Additional Patterns
- **dartz `Either`** — functional error handling in the repository layer
- **freezed union types** — typed error variants (`TodoFailure`)
- **Repository pattern** — HTTP calls abstracted behind typed interfaces
- **Cubit vs ChangeNotifier** — comparison comments throughout

## Architecture

```
UI (Screens)  →  Cubits  →  Repositories  →  HTTP  →  Go Backend
   ↑                ↑            ↑
BlocBuilder    emit(State)    Either<Failure, Success>
BlocListener
BlocConsumer
```

## File Structure

```
lib/
├── l10n/                         # Localization
│   ├── app_en.arb                # English translations
│   └── app_es.arb                # Spanish translations
├── models/
│   ├── todo.dart                 # @freezed TodoSummary & TodoDetail
│   ├── todo_failure.dart         # Freezed union failure type
│   ├── user.dart                 # @freezed User model
│   └── models.dart               # Barrel export
├── repositories/
│   ├── auth_repository.dart      # Login/register with Either
│   └── todo_repository.dart      # CRUD with Either + Bearer auth
├── cubits/
│   ├── auth/
│   │   ├── auth_cubit.dart       # Login, register, logout
│   │   └── auth_state.dart       # Initial, Loading, Authenticated, Error
│   └── todo/
│       ├── todo_list_cubit.dart   # Load, refresh, paginate, delete
│       ├── todo_list_state.dart   # Initial, Loading, Loaded, Error
│       ├── todo_detail_cubit.dart # Load, create, update, toggle
│       └── todo_detail_state.dart # Initial, Loading, Loaded, Saved, Error
├── screens/
│   ├── login_screen.dart         # BlocConsumer for auth
│   ├── register_screen.dart      # BlocConsumer for registration
│   ├── todo_list_screen.dart     # BlocBuilder with pagination
│   ├── todo_detail_screen.dart   # BlocBuilder for single todo
│   └── todo_form_screen.dart     # BlocConsumer for create/edit
├── widgets/
│   └── todo_tile.dart            # "Dumb" presentational widget
└── main.dart                     # MultiBlocProvider + auth routing
```

## Prerequisites

The Go backend must be running:
```bash
cd ../backend && go run .
```

## Setup

```bash
# Install dependencies
flutter pub get

# Generate freezed + json_serializable code
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Backend API

| Endpoint | Method | Auth | Request | Response |
|----------|--------|------|---------|----------|
| `/register` | POST | No | `{email, password}` | `{user, token}` |
| `/login` | POST | No | `{email, password}` | `{user, token}` |
| `/todos` | GET | Bearer | `?page=1&page_size=10` | `{todos[], total, page, page_size}` |
| `/todos/{id}` | GET | Bearer | - | TodoDetail |
| `/todos` | POST | Bearer | `{title, description}` | TodoDetail |
| `/todos/{id}` | PATCH | Bearer | `{title?, description?, checked?}` | TodoDetail |
| `/todos/{id}` | DELETE | Bearer | - | `{status: "deleted"}` |

## Key Comparisons

### Cubit vs ChangeNotifier
| Feature | ChangeNotifier | Cubit |
|---------|---------------|-------|
| State | Mutable fields + `notifyListeners()` | Immutable union + `emit()` |
| Error handling | try/catch + String messages | Either + typed failures |
| Exhaustive | No (easy to miss states) | Yes (compiler enforces) |
| Testing | Check multiple fields | Assert single state value |
| Impossible states | Possible (loading + error) | Impossible (sealed union) |

### Cubit vs Bloc
| Feature | Cubit | Bloc |
|---------|-------|------|
| API | Methods then `emit()` | Events then `on<Event>` then `emit()` |
| Complexity | Simpler | More boilerplate |
| Event transforms | No | Yes (debounce, throttle) |
| Event replay | No | Yes |
| Use when | Most cases | Complex event logic |

## Testing Cubits

```dart
blocTest<AuthCubit, AuthState>(
  'emits [loading, authenticated] when login succeeds',
  build: () => AuthCubit(authRepository: mockAuthRepo),
  act: (cubit) => cubit.login('test@test.com', 'password'),
  expect: () => [
    const AuthState.loading(),
    isA<AuthAuthenticated>(),
  ],
);
```
