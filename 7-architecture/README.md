# 7 - Architecture Tutorial

A Todo app rebuilt with production-grade **Clean Architecture**, connecting to a Go backend at `localhost:8080`.

## Why Dependency Injection?

Dependency Injection (DI) is a design pattern where objects receive their dependencies from the outside rather than creating them internally. This tutorial uses **get_it** as a service locator for DI.

### The Problem Without DI

```dart
// Tightly coupled - hard to test, hard to change
class TodoCubit extends Cubit<TodoState> {
  final _repository = TodoRepositoryImpl(
    TodoRemoteDataSource(
      DioClient(),  // Creates its own HTTP client
    ),
  );
}
```

Every class creates its own dependencies. If you want to swap `TodoRepositoryImpl` for a mock in tests, you have to modify the class itself.

### The Solution With DI (get_it)

```dart
// Loosely coupled - easy to test, easy to swap implementations
class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;  // Depends on abstraction
  TodoCubit(this._repository);       // Receives dependency from outside
}

// Registration (injection_container.dart)
getIt.registerLazySingleton<TodoRepository>(
  () => TodoRepositoryImpl(getIt()),  // Wired up in one place
);

// In tests, swap the implementation:
getIt.registerLazySingleton<TodoRepository>(
  () => MockTodoRepository(),
);
```

### get_it Registration Types

| Method | When Created | Lifetime | Use For |
|--------|-------------|----------|---------|
| `registerSingleton` | Immediately | App lifetime | Services needed at startup |
| `registerLazySingleton` | First access | App lifetime | Services that may not be needed immediately |
| `registerFactory` | Every call | Per-use | Stateless objects (use cases) or per-screen state (cubits) |
| `registerSingletonAsync` | Immediately (async) | App lifetime | Services requiring async init (SharedPreferences) |

## Dio vs http Comparison

This tutorial uses **Dio** instead of the standard `http` package. Here is why:

### Feature Comparison

| Feature | http | Dio |
|---------|------|-----|
| Basic GET/POST | Yes | Yes |
| Interceptors | No (manual) | Built-in chain |
| Request cancellation | No | CancelToken |
| Timeout configuration | Per-request only | Global + per-request |
| Automatic JSON | No | Yes |
| File upload (multipart) | Manual FormData | Built-in FormData |
| Retry logic | Manual | Interceptor-based |
| Error transformation | Manual try/catch | Interceptor-based |
| Logging | Manual | Interceptor-based |
| Base URL | Manual concatenation | BaseOptions |

### Interceptor Chain (This App)

```
Request Flow:
  AuthInterceptor    --> Adds Bearer token
  LoggingInterceptor --> Logs method, URL, body
  ErrorInterceptor   --> Transforms errors to user-friendly messages

Response Flow (reverse):
  ErrorInterceptor   --> Catches DioException, normalizes message
  LoggingInterceptor --> Logs status code
  AuthInterceptor    --> (pass-through)
```

### http Example (What You Would Write Without Dio)

```dart
// Without Dio - manual everything
Future<List<Todo>> getTodos() async {
  final response = await http.get(
    Uri.parse('$baseUrl/todos?page=1&page_size=10'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 401) throw UnauthorizedException();
  if (response.statusCode != 200) throw ServerException(response.body);

  final json = jsonDecode(response.body);
  return (json['todos'] as List).map((e) => Todo.fromJson(e)).toList();
}
```

### Dio Example (What This App Uses)

```dart
// With Dio - interceptors handle auth, logging, errors
Future<List<Todo>> getTodos() async {
  final response = await dio.get(
    '/todos',
    queryParameters: {'page': 1, 'page_size': 10},
  );
  return (response.data['todos'] as List)
      .map((e) => Todo.fromJson(e))
      .toList();
}
```

## Architecture Overview

```
lib/
+-- core/          # Shared utilities (DI, networking, errors, constants)
+-- data/          # Models, data sources, repository implementations
+-- domain/        # Entities, repository interfaces, use cases
+-- presentation/  # Cubits, screens, widgets
+-- main.dart      # App entry point
```

### The Dependency Rule

Dependencies point inward. The domain layer knows nothing about the data or presentation layers:

```
Presentation --> Domain <-- Data
   (Cubits)     (Entities,    (Models,
                 UseCases,     DataSources,
                 Repo I/F)     Repo Impl)
```

### Key Concepts Demonstrated

- **get_it**: registerSingleton, registerLazySingleton, registerFactory, injection_container.dart
- **Dio**: BaseOptions, interceptors (auth, logging, error), CancelToken
- **flutter_dotenv**: .env files, `dotenv.env['KEY']`
- **freezed**: Union types for state and failure handling
- **flutter_bloc (Cubit)**: Reactive state management
- **dartz (Either)**: Functional error handling without exceptions
- **Localization**: English + Spanish via ARB files

## Running the App

1. Start the Go backend on port 8080
2. Run `flutter pub get`
3. Run `dart run build_runner build --delete-conflicting-outputs`
4. Run `flutter run -d macos`

## Environment Configuration

The `.env` file at the project root configures runtime values:

```
BASE_URL=http://localhost:8080
APP_NAME=Architecture Tutorial
```

These are loaded at startup via `flutter_dotenv` and accessed with `dotenv.env['BASE_URL']`.
