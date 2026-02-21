# 3-navigation: News Reader — Flutter Navigation Tutorial

A News Reader app teaching three Flutter navigation approaches side by side:
**Default Navigator**, **GoRouter**, and **auto_route**.

## Navigation Approach Comparison

| Feature | Default Navigator | GoRouter | auto_route |
|---------|-------------------|----------|------------|
| **Style** | Imperative (push/pop) | Declarative (URL-based) | Code-generated (type-safe) |
| **Route definition** | `onGenerateRoute` callback | `GoRoute` tree in config | `@AutoRouterConfig` + annotations |
| **Navigation call** | `Navigator.push(context, route)` | `context.go('/path')` | `context.pushRoute(MyRoute())` |
| **Arguments** | `settings.arguments` (untyped) | Path/query params (strings) | Generated args classes (typed) |
| **Deep linking** | Manual URL parsing | Built-in path matching | Built-in code-generated matchers |
| **Auth guards** | Manual `if` checks before push | `redirect` callback in config | `AutoRouteGuard` / `guards` getter |
| **Nested navigation** | Nested `Navigator` widget | `ShellRoute` / `StatefulShellRoute` | `AutoTabsRouter` / nested routes |
| **Back button** | Automatic stack-based | `go()` = hierarchy, `push()` = stack | Automatic stack-based |
| **Code generation** | None | None | Required (`build_runner`) |
| **URL sync** | No (manual) | Yes (automatic) | Yes (automatic) |
| **Type safety** | Low (dynamic arguments) | Medium (string path params) | High (generated typed args) |
| **Boilerplate** | Medium | Low | Low (after setup) |
| **Learning curve** | Low | Medium | Medium |
| **Package** | Built-in Flutter SDK | `go_router` | `auto_route` |

## Key Concepts Demonstrated

### Default Navigator
- `Navigator.push()` and `Navigator.pushNamed()`
- `onGenerateRoute` for dynamic route matching
- `RouteSettings` for passing arguments
- Nested `Navigator` for tab-scoped navigation stacks
- `PopScope` (replaces deprecated `WillPopScope`)

### GoRouter
- `GoRoute` with path and query parameters
- `ShellRoute` for persistent bottom navigation
- `redirect` guard for authentication
- `go()` vs `push()` -- different back-button behavior
- URL-based deep linking

### auto_route
- `@RoutePage()` annotation on screen widgets
- `@AutoRouterConfig` for route tree definition
- `@pathParam` / `@queryParam` for URL parameter extraction
- `AutoRouteGuard` for authentication guards
- Type-safe route arguments (compile-time checked)

### Deep Linking
- Concept explanation in `main.dart` comments
- iOS/Android configuration reference
- `app_links` package integration guide
- How each router handles incoming URLs

## Project Structure

```
lib/
├── l10n/                          # Localization
│   ├── app_en.arb                 # English strings
│   ├── app_es.arb                 # Spanish strings
│   └── generated/                 # Auto-generated l10n code
├── models/
│   ├── article.dart               # @freezed Article model
│   ├── category.dart              # NewsCategory enum with metadata
│   ├── article_failure.dart       # Freezed union failure type
│   └── models.dart                # Barrel export
├── data/
│   └── mock_data.dart             # Hard-coded articles for demo
├── navigation/
│   ├── default_navigator.dart     # Traditional Navigator approach
│   ├── go_router_config.dart      # GoRouter setup with ShellRoute
│   └── auto_router_config.dart    # auto_route setup with guards
├── screens/
│   ├── home_screen.dart           # Tab switcher for 3 approaches
│   ├── category_list_screen.dart  # News category listing
│   ├── article_list_screen.dart   # Articles per category
│   ├── article_detail_screen.dart # Full article view (deep link target)
│   ├── search_screen.dart         # Search with query params
│   ├── profile_screen.dart        # Auth-protected profile
│   └── login_screen.dart          # Login for auth guard demos
├── widgets/
│   ├── article_card.dart          # Article preview card
│   └── category_tile.dart         # Category list tile
└── main.dart                      # App entry point with l10n
```

## Dependencies

- **go_router** -- Declarative URL-based routing
- **auto_route** -- Code-generated type-safe routing
- **freezed** -- Immutable data classes with union types
- **json_serializable** -- JSON serialization code generation
- **dartz** -- Functional programming (Either type for error handling)
- **flutter_localizations** + **intl** -- Multi-language support (EN/ES)

## Running the App

```bash
# Install dependencies
flutter pub get

# Generate code (freezed, json_serializable, auto_route)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Analyze for issues
flutter analyze
```

## When to Use Each Approach

- **Default Navigator**: Simple apps, prototypes, or when you need full control over transitions
- **GoRouter**: Web-focused apps needing URL sync, or apps with complex redirect logic
- **auto_route**: Large apps where type-safe arguments and refactoring safety matter most
