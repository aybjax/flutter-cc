# Weather Dashboard -- Riverpod State Management Tutorial

A Flutter app that teaches **Riverpod** through a mock Weather Dashboard. Search cities, view current weather and 5-day forecasts, manage favourites, and toggle temperature units -- all powered by mock data with simulated network latency.

## Getting Started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## What This App Teaches

| Concept | Where to find it |
|---|---|
| `ProviderScope` | `lib/main.dart` -- wraps the entire app |
| `ConsumerWidget` | Every screen and most widgets |
| `ConsumerStatefulWidget` | `lib/screens/home_screen.dart`, `lib/screens/city_search_screen.dart` |
| `ref.watch` | Reactive reads throughout all screens |
| `ref.read` | One-shot writes in callbacks (settings, favourites) |
| `ref.listen` | Snackbar side-effects in `home_screen.dart` |
| `ref.invalidate` / `ref.refresh` | Pull-to-refresh and retry buttons |
| `Provider` | Repository injection (`weatherRepositoryProvider`) |
| `StateProvider` | Temperature unit, search query, selected city |
| `StateNotifierProvider` | Favourite cities list |
| `FutureProvider` | Weather fetch, forecast fetch, search results |
| `StreamProvider` | Live-updating weather temperature |
| `NotifierProvider` | Recent cities list |
| `AsyncNotifierProvider` | City weather with refresh capability |
| `autoDispose` | Weather/forecast providers auto-cleanup on navigation |
| `family` | Parameterised providers by city ID |
| `@riverpod` annotation | `lib/providers/generated_providers.dart` |
| `@freezed` models | All models in `lib/models/` |
| `Either<Failure, T>` | Repository returns from `dartz` |
| Provider overrides | Commented patterns in `main.dart` and tests |

## Project Structure

```
lib/
+-- l10n/                          # Localisation (English + Spanish)
|   +-- app_en.arb
|   +-- app_es.arb
|   +-- app_localizations.dart     # Generated
+-- models/
|   +-- city.dart                  # @freezed City model
|   +-- weather.dart               # @freezed Weather model + enums
|   +-- forecast.dart              # @freezed DailyForecast model
|   +-- weather_failure.dart       # Freezed union failure type
|   +-- models.dart                # Barrel export
+-- data/
|   +-- mock_weather.dart          # Static mock data
+-- repositories/
|   +-- weather_repository.dart    # Either-based data access
+-- providers/
|   +-- weather_providers.dart     # Provider, StateProvider, FutureProvider, StreamProvider
|   +-- weather_notifiers.dart     # StateNotifierProvider, NotifierProvider, AsyncNotifierProvider
|   +-- generated_providers.dart   # @riverpod annotated providers
|   +-- generated_providers.g.dart # Generated
+-- screens/
|   +-- home_screen.dart           # Dashboard with weather cards
|   +-- city_search_screen.dart    # City search with reactive results
|   +-- weather_detail_screen.dart # Full weather + live stream + forecast
|   +-- favorites_screen.dart      # Swipe-to-remove favourites
|   +-- settings_screen.dart       # Unit + language preferences
+-- widgets/
|   +-- weather_card.dart          # City weather summary card
|   +-- forecast_list.dart         # Horizontal 5-day forecast
|   +-- temperature_display.dart   # Unit-aware temperature text
+-- main.dart                      # ProviderScope + MaterialApp
```

## State Management Comparison Table

| Feature | Provider (pkg) | Cubit (flutter_bloc) | BLoC (flutter_bloc) | Riverpod |
|---|---|---|---|---|
| **Core idea** | InheritedWidget wrapper | Stream-less state holder | Event-driven state machine | Compile-safe DI + reactive state |
| **Boilerplate** | Low | Low-Medium | Medium-High | Low (especially with codegen) |
| **State declaration** | `ChangeNotifier` / `ValueNotifier` | `Cubit<State>` subclass | `Bloc<Event, State>` subclass | `Provider`, `Notifier`, `AsyncNotifier` |
| **State access** | `context.watch<T>()` / `context.read<T>()` | `BlocBuilder` / `context.watch` | `BlocBuilder` / `BlocListener` | `ref.watch` / `ref.read` / `ref.listen` |
| **Dependency injection** | `ProxyProvider` | `RepositoryProvider` | `RepositoryProvider` | `Provider` + `ref.watch` (automatic) |
| **Async support** | Manual (`FutureBuilder`) | `emit()` after await | `emit()` inside event handler | `FutureProvider`, `AsyncNotifier` |
| **Stream support** | `StreamProvider` | N/A (Cubit is sync) | Built-in via events | `StreamProvider` |
| **Code generation** | No | `freezed` for states | `freezed` for events/states | `riverpod_generator` + `freezed` |
| **Testing** | Mock via `Provider.value` | Instantiate + call methods | `blocTest()` utility | `ProviderScope(overrides: [...])` |
| **Auto-dispose** | Manual | `BlocProvider` auto-closes | `BlocProvider` auto-closes | `.autoDispose` modifier |
| **Family / parameterised** | Not built-in | Not built-in | Not built-in | `.family` modifier |
| **Compile-time safety** | Runtime errors possible | Type-safe | Type-safe | Fully compile-safe (no context needed) |
| **Global access** | Requires `BuildContext` | Requires `BuildContext` | Requires `BuildContext` | No `BuildContext` needed |
| **Combining state** | `ProxyProvider` | Manual composition | Manual composition | Automatic via `ref.watch` in providers |
| **DevTools support** | Flutter DevTools | Bloc DevTools | Bloc DevTools | Riverpod DevTools |
| **Learning curve** | Gentle | Moderate | Steep | Moderate |
| **When to use** | Small apps, simple DI | Medium apps, straightforward state | Complex apps, event-driven flows | Any size; best for DI-heavy architectures |

### Quick Decision Guide

- **Just need DI?** Riverpod's `Provider` is the simplest.
- **Simple toggle/counter?** Riverpod's `StateProvider` or Cubit.
- **Complex business logic?** BLoC (event-driven) or Riverpod's `Notifier`.
- **Async data fetching?** Riverpod's `FutureProvider` / `AsyncNotifier` -- no boilerplate loading/error handling.
- **Real-time streams?** Riverpod's `StreamProvider` or BLoC (built on streams).
- **Need parameterised providers?** Only Riverpod has `.family` built-in.
- **Testing without BuildContext?** Only Riverpod supports this natively.
