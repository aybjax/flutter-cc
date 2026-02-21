# Product Catalog - BLoC Pattern Tutorial

A Flutter app demonstrating the full **BLoC (Business Logic Component)** pattern
with search, filtering, favorites, and a shopping cart.

## What This App Teaches

- `Bloc<Event, State>` with `on<Event>` handlers and `add(event)` dispatching
- **Event classes** with `freezed` unions for type-safe, exhaustive handling
- **EventTransformer** for debouncing search input (`stream_transform`)
- **bloc_concurrency** transformers: `droppable()`, `restartable()`, `sequential()`
- **BlocObserver** for global logging of all BLoC activity
- **HydratedBloc** for persisting state across app restarts (favorites)
- **BlocBuilder**, **BlocSelector**, `context.read()` for UI integration
- Functional error handling with `dartz` `Either<Failure, Success>`
- Localization with `flutter_localizations` (English + Spanish)

---

## Provider vs Cubit vs BLoC Decision Tree

Use this guide to choose the right state management approach:

```
Do you need to share state across multiple widgets?
|
+-- NO --> Use StatefulWidget + setState()
|          Simple, local state. No external packages needed.
|
+-- YES
    |
    +-- Is the state just a value/object with no complex logic?
    |   |
    |   +-- YES --> Use Provider (ChangeNotifier / ValueNotifier)
    |               Lightweight. Good for dependency injection.
    |               Example: Theme, locale, simple counters.
    |
    +-- NO (complex business logic involved)
        |
        +-- Are state changes triggered by simple method calls?
        |   |
        |   +-- YES --> Use Cubit
        |               - Simpler API: just call methods, emit states
        |               - Less boilerplate than BLoC
        |               - Good for: forms, toggles, CRUD, settings
        |               Example:
        |                 class CounterCubit extends Cubit<int> {
        |                   CounterCubit() : super(0);
        |                   void increment() => emit(state + 1);
        |                 }
        |
        +-- NO (need event-driven architecture)
            |
            +-- Use BLoC
                - Events are explicit, traceable, and loggable
                - EventTransformers for debounce, throttle, etc.
                - Better for: search, complex flows, analytics
                - Events can be replayed, logged, and tested
                Example:
                  class SearchBloc extends Bloc<SearchEvent, SearchState> {
                    SearchBloc() : super(const SearchState.initial()) {
                      on<SearchQueryChanged>(
                        _onQueryChanged,
                        transformer: debounce(Duration(milliseconds: 300)),
                      );
                    }
                  }
```

### Quick Reference Table

| Feature              | Provider       | Cubit          | BLoC           |
|----------------------|----------------|----------------|----------------|
| Complexity           | Low            | Medium         | High           |
| Boilerplate          | Minimal        | Low            | More           |
| Event traceability   | None           | None           | Full           |
| EventTransformers    | N/A            | N/A            | Yes            |
| Testability          | Manual         | Good           | Excellent      |
| State persistence    | Manual         | HydratedCubit  | HydratedBloc   |
| Global observation   | No             | BlocObserver    | BlocObserver   |
| Best for             | DI, simple     | CRUD, forms    | Search, flows  |

### When to Choose BLoC Over Cubit

Choose **BLoC** when you need:
1. **Debounced/throttled input** (search fields, typeahead)
2. **Event logging** for debugging or analytics
3. **Event replay** for undo/redo or time-travel debugging
4. **Complex event orchestration** (sequential, droppable, restartable)
5. **Multiple events mapping to the same state change** with different transforms

Choose **Cubit** when:
1. State changes are simple method calls
2. You don't need event transformers
3. You want less boilerplate
4. The interaction is straightforward (tap -> update)

---

## App Architecture

```
+----------------------------------------------+
|                    UI Layer                   |
|  Screens: ProductList, Detail, Favorites,    |
|           Cart, Search                        |
|  Widgets: ProductCard, CartBadge             |
|                                              |
|  BlocBuilder / BlocSelector / context.read   |
+----------------------------------------------+
|                  BLoC Layer                   |
|                                              |
|  ProductListBloc --- Events ---> States      |
|    on<LoadProducts>                          |
|    on<SearchProducts>  (debounced 300ms)     |
|    on<FilterByCategory> (restartable)        |
|                                              |
|  FavoritesBloc (HydratedBloc)                |
|    on<ToggleFavorite>  (sequential)          |
|    Persists to disk automatically            |
|                                              |
|  CartBloc                                    |
|    on<AddToCart>       (droppable)            |
|    on<UpdateQuantity>                        |
|                                              |
|  AppBlocObserver ---> logs all transitions   |
+----------------------------------------------+
|              Repository Layer                 |
|  ProductRepository                           |
|    Returns Either<ProductFailure, T>         |
+----------------------------------------------+
|                Data Layer                     |
|  Mock Products (in-memory)                   |
|  HydratedStorage (on-disk persistence)       |
+----------------------------------------------+
```

## Key Concepts Demonstrated

### 1. EventTransformer with Debounce (Search)
```dart
EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

on<SearchProducts>(
  _onSearchProducts,
  transformer: debounce(const Duration(milliseconds: 300)),
);
```

### 2. bloc_concurrency Transformers
```dart
// droppable: drops events while handler is busy (prevents double-tap)
on<AddToCart>(_onAddToCart, transformer: droppable());

// restartable: cancels previous handler when new event arrives
on<FilterByCategory>(_onFilter, transformer: restartable());

// sequential: processes events one at a time in order
on<ToggleFavorite>(_onToggle, transformer: sequential());
```

### 3. HydratedBloc (State Persistence)
```dart
class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  @override
  FavoritesState? fromJson(Map<String, dynamic> json) =>
      FavoritesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(FavoritesState state) =>
      state.toJson();
}
```

### 4. BlocObserver (Global Logging)
```dart
class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('${bloc.runtimeType}: ${transition.event} -> ${transition.nextState}');
  }
}

// In main():
Bloc.observer = AppBlocObserver();
```

## File Structure

```
lib/
├── l10n/                          # Localization
│   ├── app_en.arb                 # English strings
│   └── app_es.arb                 # Spanish strings
├── models/
│   ├── product.dart               # @freezed Product model
│   ├── cart_item.dart             # @freezed CartItem model
│   ├── product_failure.dart       # Freezed union failure types
│   └── models.dart                # Barrel export
├── data/
│   └── mock_products.dart         # 15 mock products, 5 categories
├── repositories/
│   └── product_repository.dart    # Data access with Either returns
├── blocs/
│   ├── product_list/
│   │   ├── product_list_bloc.dart # Search + filter BLoC
│   │   ├── product_list_event.dart
│   │   └── product_list_state.dart
│   ├── favorites/
│   │   ├── favorites_bloc.dart    # HydratedBloc for persistence
│   │   ├── favorites_event.dart
│   │   └── favorites_state.dart
│   ├── cart/
│   │   ├── cart_bloc.dart         # Shopping cart BLoC
│   │   ├── cart_event.dart
│   │   └── cart_state.dart
│   └── bloc_observer.dart         # Global BlocObserver
├── screens/
│   ├── product_list_screen.dart   # Main grid with filter
│   ├── product_detail_screen.dart # Full product details
│   ├── favorites_screen.dart      # Favorite products list
│   ├── cart_screen.dart           # Cart with quantity controls
│   └── search_screen.dart         # Debounced search
├── widgets/
│   ├── product_card.dart          # Product card with actions
│   └── cart_badge.dart            # Cart icon with item count
└── main.dart                      # Entry point, BLoC setup
```

## Running the App

```bash
# Install dependencies
flutter pub get

# Generate freezed/json_serializable code
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze
```
