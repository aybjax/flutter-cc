# Flutter Basics — Tutorial Todo App

A comprehensive Flutter tutorial app that teaches Flutter/Dart fundamentals through a functional todo client. Every class, method, field, and widget parameter is documented with `///` doc comments or `//` inline comments. Each file starts with a multi-line block summarizing the concepts demonstrated.

**Environment:** Flutter 3.38.9, Dart 3.10.8, Xcode 26.2 (iOS ready)

**Backend:** Go server at `localhost:8080` (see `../backend/`)

---

## Table of Contents

- [Quick Start](#quick-start)
- [Folder Structure](#folder-structure)
- [Feature Map](#feature-map)
- [Dependencies](#dependencies)
- [Platform Configuration](#platform-configuration)
- [Flutter CLI Commands](#flutter-cli-commands)
- [Architecture Overview](#architecture-overview)
- [Concepts by File](#concepts-by-file)

---

## Quick Start

```bash
# 1. Start the Go backend
cd ../backend && go run .

# 2. Get Flutter dependencies
cd ../1-basics && flutter pub get

# 3. Run on iOS Simulator
flutter run

# 3b. Or run on Chrome (web)
flutter run -d chrome

# 4. In the app: Register → Login → Create todos → Explore tabs and demos
```

---

## Folder Structure

```
1-basics/lib/
├── main.dart                              # Entry point, MultiProvider, MaterialApp, routes
├── config/
│   ├── api_constants.dart                 # Base URL, endpoint strings, pagination defaults
│   └── route_names.dart                   # Named route constants
├── theme/
│   ├── app_theme.dart                     # ThemeData (light+dark), 15+ component themes
│   └── theme_provider.dart                # ChangeNotifier for dark mode, SharedPreferences
├── models/
│   ├── user.dart                          # User model, factory fromJson
│   ├── todo_summary.dart                  # List item model, nullable thumbnail
│   ├── todo_detail.dart                   # Full model, getters/setters, copyWith
│   └── todo_list_response.dart            # Pagination wrapper, computed getters
├── services/
│   ├── api_service.dart                   # HTTP: register, login, CRUD todos
│   ├── auth_service.dart                  # Token storage (SharedPreferences)
│   ├── location_service.dart              # Geolocator: permissions + GPS position
│   └── file_service.dart                  # File picker + HTTP file download
├── providers/
│   ├── auth_provider.dart                 # Login/register/logout, token, auto-login
│   └── todo_provider.dart                 # CRUD, pagination, optimistic updates
├── screens/
│   ├── splash_screen.dart                 # Animated splash, Hero, auto-navigate
│   ├── auth/
│   │   ├── login_screen.dart              # Form, TextField (all fields), FocusNode, validation
│   │   └── register_screen.dart           # Confirm password, cross-field validation
│   ├── home/
│   │   ├── home_screen.dart               # TabController, Drawer, adaptive FAB
│   │   └── tabs/
│   │       ├── todo_list_tab.dart         # ListView.separated, ScrollController, pagination
│   │       ├── todo_grid_tab.dart         # GridView.builder, SliverGridDelegate
│   │       ├── widgets_demo_tab.dart      # Container, Row, Column, Flexible, Expanded, Stack
│   │       └── settings_tab.dart          # SwitchListTile, theme toggle, GPS, logout
│   ├── todo/
│   │   ├── todo_detail_screen.dart        # Hero image, AlertDialog delete, Navigator.pop result
│   │   └── todo_form_screen.dart          # Dual-purpose create/edit, file picker, form validation
│   ├── demos/
│   │   ├── sliver_demo_screen.dart        # CustomScrollView, SliverAppBar, SliverList/Grid
│   │   ├── animation_demo_screen.dart     # AnimationController, FadeTransition, Matrix4, Curves
│   │   ├── gestures_demo_screen.dart      # GestureDetector, InkWell, draggable box
│   │   ├── media_query_demo_screen.dart   # Device size, orientation, keyboard, pixel ratio
│   │   └── lifecycle_demo_screen.dart     # Widget + app lifecycle with on-screen log
│   └── not_found_screen.dart              # 404 via onGenerateRoute
└── widgets/
    ├── app_drawer.dart                    # Drawer with demo navigation links
    ├── todo_list_item.dart                # ListTile-based row with Hero thumbnail
    ├── todo_grid_item.dart                # Card + GridTile cell
    ├── loading_overlay.dart               # Stack + AbsorbPointer overlay
    ├── custom_snackbar.dart               # SnackBar helper (info, error, success)
    ├── error_dialog.dart                  # AlertDialog wrapper + confirmation dialog
    └── page_transition.dart               # Custom PageRouteBuilder (fade + slide)
```

---

## Feature Map

### Core App Features

| Feature | Files | What It Does |
|---------|-------|-------------|
| **User Registration** | `api_service.dart`, `auth_provider.dart`, `register_screen.dart` | POST /register, auto-login on success, token persistence |
| **User Login** | `api_service.dart`, `auth_provider.dart`, `login_screen.dart` | POST /login, JWT token storage via SharedPreferences |
| **Auto-Login** | `auth_service.dart`, `auth_provider.dart`, `splash_screen.dart` | Checks saved token on app start, skips login if valid |
| **Logout** | `auth_provider.dart`, `settings_tab.dart` | Clears token + state, navigates to login |
| **Todo List (paginated)** | `todo_provider.dart`, `todo_list_tab.dart` | GET /todos with infinite scroll, pull-to-refresh |
| **Todo Grid** | `todo_grid_tab.dart`, `todo_grid_item.dart` | GridView.builder with Card/GridTile layout |
| **Todo Detail** | `todo_detail_screen.dart` | GET /todos/{id}, Hero image, checked toggle |
| **Create Todo** | `todo_form_screen.dart`, `todo_provider.dart` | POST /todos with title, description, optional icon URL |
| **Edit Todo** | `todo_form_screen.dart`, `todo_provider.dart` | PATCH /todos/{id}, pre-populated form |
| **Delete Todo** | `todo_detail_screen.dart`, `todo_provider.dart` | DELETE /todos/{id} with AlertDialog confirmation |
| **Toggle Checked** | `todo_provider.dart`, `todo_list_item.dart` | Optimistic update with rollback on error |
| **Dark Mode** | `theme_provider.dart`, `settings_tab.dart`, `app_theme.dart` | Toggle persisted via SharedPreferences, applies instantly |
| **GPS Location** | `location_service.dart`, `settings_tab.dart` | Permission check → request → fetch lat/lng |
| **File Picker** | `file_service.dart`, `todo_form_screen.dart` | Native file dialog for image selection |
| **404 Not Found** | `not_found_screen.dart`, `main.dart` | onGenerateRoute fallback for unknown routes |

### Demo Screens (accessed via Drawer)

| Demo | File | Concepts Taught |
|------|------|----------------|
| **Sliver Demo** | `sliver_demo_screen.dart` | CustomScrollView, SliverAppBar (floating/pinned/snap/stretch), SliverList, SliverGrid, SliverToBoxAdapter, SliverChildBuilderDelegate vs SliverChildListDelegate |
| **Animation Demo** | `animation_demo_screen.dart` | 3 AnimationControllers (fade, rotation, color), FadeTransition, AnimatedBuilder, Matrix4.rotateZ, Tween, CurvedAnimation, Curves (bounceOut, elasticIn, easeInOut), forward/reverse/repeat/reset/stop, addStatusListener |
| **Gestures Demo** | `gestures_demo_screen.dart` | GestureDetector (onTap, onDoubleTap, onLongPress, onPanUpdate, onTapDown/Up/Cancel), HitTestBehavior, InkWell (splashColor, highlightColor, borderRadius, Material ancestor requirement), draggable box |
| **MediaQuery Demo** | `media_query_demo_screen.dart` | MediaQuery.of — size, orientation, viewInsets (keyboard), padding (safe area), devicePixelRatio, platformBrightness, textScaler, boldText, highContrast, responsive layout switching |
| **Lifecycle Demo** | `lifecycle_demo_screen.dart` | Widget lifecycle (initState, didChangeDependencies, build, didUpdateWidget, deactivate, dispose), App lifecycle via WidgetsBindingObserver (resumed, inactive, hidden, paused, detached), timestamped on-screen log |

### Widget Concepts (Widgets Demo Tab)

| Section | Concepts |
|---------|----------|
| **Container** | width, height, padding, margin, BoxDecoration (color, gradient, borderRadius, border, boxShadow, shape), alignment, transform |
| **Row** | All 6 MainAxisAlignment values (start, end, center, spaceBetween, spaceAround, spaceEvenly), crossAxisAlignment, mainAxisSize |
| **Column** | CrossAxisAlignment (start, center, end), visual comparison side-by-side |
| **Flexible vs Expanded** | Flexible (FlexFit.loose — can be smaller), Expanded (FlexFit.tight — must fill), flex ratios |
| **Stack** | Alignment, Positioned (top, left, right, bottom), layering order, clipBehavior |

### Theme Coverage

The theme in `app_theme.dart` configures these component themes (with all fields specified or commented):

| Component Theme | Key Fields |
|----------------|------------|
| **ColorScheme** | fromSeed, brightness, surface, onSurface, primary, secondary, error |
| **AppBarTheme** | centerTitle, elevation, scrolledUnderElevation, backgroundColor, foregroundColor |
| **CardThemeData** | elevation, shadowColor, shape, margin, clipBehavior |
| **ElevatedButtonTheme** | foregroundColor, backgroundColor, padding, shape, elevation |
| **TextButtonTheme** | foregroundColor, padding, shape |
| **OutlinedButtonTheme** | foregroundColor, padding, shape, side |
| **InputDecorationTheme** | filled, fillColor, border/enabledBorder/focusedBorder/errorBorder |
| **TextTheme** | All 15 text styles (display, headline, title, body, label) |
| **FloatingActionButtonTheme** | backgroundColor, foregroundColor, elevation, shape |
| **DividerTheme** | color, thickness, space |
| **SnackBarTheme** | behavior (floating), shape |
| **DialogThemeData** | shape, elevation |
| **ListTileTheme** | contentPadding, shape |
| **TabBarThemeData** | labelColor, unselectedLabelColor, indicatorColor, indicatorSize |
| **DrawerTheme** | elevation, shape, backgroundColor |

Additional themes shown in comments: CheckboxTheme, SwitchTheme, BottomNavigationBarTheme, TooltipTheme, ProgressIndicatorTheme.

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `provider` | ^6.1.2 | State management (ChangeNotifier + Consumer pattern) |
| `http` | ^1.4.0 | HTTP client for REST API calls (GET, POST, PATCH, DELETE) |
| `shared_preferences` | ^2.5.3 | Persistent key-value storage (auth token, theme preference) |
| `file_picker` | ^10.1.7 | Native file selection dialog (images for todo icons) |
| `geolocator` | ^14.0.0 | GPS location services (permissions + position) |
| `path_provider` | ^2.1.5 | Platform-specific directories (documents dir for downloads) |
| `cupertino_icons` | ^1.0.8 | iOS-style icons (CupertinoIcons class) |

---

## Platform Configuration

### iOS (`ios/Runner/Info.plist`)

Two keys were added to the Info.plist to request user permissions:

| Key | Value | Why |
|-----|-------|-----|
| `NSLocationWhenInUseUsageDescription` | "This app uses your location to demonstrate GPS features in the tutorial." | **Required by geolocator.** iOS will show this string in the permission dialog when the app requests location access. Without it, the app crashes on location request. |
| `NSPhotoLibraryUsageDescription` | "This app accesses your photo library to select images for todo icons." | **Required by file_picker.** iOS shows this when the file picker tries to access photos. Without it, the picker may fail silently or crash. |

These keys are part of Apple's **privacy manifest** — every iOS app that accesses sensitive data (location, photos, camera, contacts, etc.) must declare a usage description string. The string is shown to the user in a system dialog so they understand *why* the app needs access.

### Android (`android/app/src/main/AndroidManifest.xml`)

Three permissions were added to the AndroidManifest:

| Permission | Why |
|-----------|-----|
| `ACCESS_FINE_LOCATION` | **Required by geolocator.** Grants access to precise GPS location (within ~10m). Used on the Settings tab to fetch lat/lng coordinates. |
| `ACCESS_COARSE_LOCATION` | **Required by geolocator.** Grants access to approximate location (within ~3km via cell towers/WiFi). Acts as a fallback when fine location isn't available. |
| `INTERNET` | **Required for HTTP calls.** Android blocks all network access by default in release builds. This permission allows the app to communicate with the Go backend at localhost:8080. Debug builds include this automatically, but it's best practice to declare it explicitly. |

Android permissions work differently from iOS:
- **Normal permissions** (like `INTERNET`) are granted automatically at install time.
- **Dangerous permissions** (like `ACCESS_FINE_LOCATION`) require a runtime prompt — the geolocator package handles this via `Geolocator.requestPermission()`.
- No usage description strings are needed in the manifest (unlike iOS), but you can add `<uses-feature>` tags to indicate that your app requires GPS hardware.

---

## Flutter CLI Commands

### Project Setup

| Command | What It Does |
|---------|-------------|
| `flutter create --project-name my_app .` | Creates a new Flutter project in the current directory. The `--project-name` flag sets the Dart package name (must be lowercase_with_underscores). Also generates `android/`, `ios/`, `web/`, `test/`, `pubspec.yaml`, and a default `lib/main.dart`. |
| `flutter create --org com.example --platforms ios,android my_app` | Creates a project with a custom organization domain (used as the iOS bundle ID and Android package name) and only generates platform folders for the specified platforms. Other options: `web`, `linux`, `macos`, `windows`. |
| `flutter pub get` | Downloads all dependencies listed in `pubspec.yaml` and generates `pubspec.lock`. Run this after cloning a project, editing pubspec.yaml, or when you see "package not found" errors. Also runs `flutter pub` codegen for packages that need it. |
| `flutter pub add provider` | Adds a package to `pubspec.yaml` dependencies and runs `pub get`. Shortcut instead of manually editing the file. Use `--dev` to add to dev_dependencies. |
| `flutter pub remove provider` | Removes a package from `pubspec.yaml` and runs `pub get`. |
| `flutter pub upgrade` | Upgrades all dependencies to the latest versions allowed by the version constraints in pubspec.yaml. |
| `flutter pub upgrade --major-versions` | Upgrades dependencies to the latest major versions, updating the constraint ranges in pubspec.yaml. Can introduce breaking changes — review changelogs before running. |
| `flutter pub outdated` | Shows which dependencies have newer versions available, including major and minor updates. Helps you decide what to upgrade. |
| `flutter pub deps` | Displays the dependency tree — shows all packages and their transitive dependencies. Useful for debugging version conflicts. |

### Running & Building

| Command | What It Does |
|---------|-------------|
| `flutter run` | Builds and runs the app on the default connected device (or asks you to choose). Starts in debug mode with hot reload enabled. Press `r` for hot reload, `R` for hot restart, `q` to quit. |
| `flutter run -d chrome` | Runs the app in Chrome (web). Useful when no mobile device/simulator is available. |
| `flutter run -d <device_id>` | Runs on a specific device. Get device IDs from `flutter devices`. |
| `flutter run --release` | Runs in release mode — no debug banner, full optimizations, no hot reload. Use for performance testing. |
| `flutter run --profile` | Runs in profile mode — optimized like release but with profiling tools enabled. Use with `flutter run --profile --trace-startup` for startup performance analysis. |
| `flutter build ios` | Builds an iOS app bundle (.app). Requires Xcode. Use `--release` for App Store builds. Outputs to `build/ios/`. |
| `flutter build apk` | Builds an Android APK. Outputs to `build/app/outputs/flutter-apk/`. Use `--split-per-abi` to generate separate APKs for each CPU architecture (smaller file sizes). |
| `flutter build appbundle` | Builds an Android App Bundle (.aab) for Google Play Store upload. More efficient than APK because the Play Store generates optimized APKs per device. |
| `flutter build web` | Builds a web deployment. Outputs to `build/web/`. Can be served with any static file server. Use `--web-renderer canvaskit` for better rendering (larger download) or `--web-renderer html` for smaller size. |

### Analysis & Testing

| Command | What It Does |
|---------|-------------|
| `flutter analyze` | Runs the Dart analyzer on the entire project. Checks for errors, warnings, and lint violations defined in `analysis_options.yaml`. **Run this before every commit** — zero errors should be the goal. |
| `flutter test` | Runs all tests in the `test/` directory. Supports unit tests, widget tests, and integration tests. Use `flutter test test/widget_test.dart` to run a single file. |
| `flutter test --coverage` | Runs tests and generates a coverage report in `coverage/lcov.info`. View it with `genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html`. |
| `dart fix --apply` | Automatically fixes lint issues that have automated fixes. Run after upgrading Dart/Flutter to fix deprecated API usage. |
| `dart format .` | Formats all Dart files according to the standard Dart style guide (line length 80, consistent indentation). Use `dart format --set-exit-if-changed .` in CI to enforce formatting. |

### Device & Environment

| Command | What It Does |
|---------|-------------|
| `flutter devices` | Lists all connected devices and emulators (physical phones, simulators, Chrome, etc.). Shows device IDs used with `flutter run -d <id>`. |
| `flutter emulators` | Lists available emulators/simulators. Use `flutter emulators --launch <name>` to start one. |
| `flutter doctor` | Checks your Flutter installation and reports issues: Dart SDK, Android SDK, Xcode, connected devices, IDE plugins. **Run this first** when something isn't working. |
| `flutter doctor -v` | Verbose version of `flutter doctor` — shows detailed information about each check, useful for debugging setup issues. |
| `flutter --version` | Shows the installed Flutter version, Dart version, channel, and engine revision. |
| `flutter channel` | Shows the current Flutter channel (stable, beta, dev, master). Use `flutter channel stable` to switch. Stable is recommended for production. |
| `flutter upgrade` | Upgrades Flutter to the latest version on the current channel. Also upgrades the Dart SDK. |
| `flutter downgrade` | Downgrades Flutter to the previous version. Useful if an upgrade breaks your project. |

### Code Generation & Cleaning

| Command | What It Does |
|---------|-------------|
| `flutter clean` | Deletes the `build/` directory and `.dart_tool/` cache. Fixes many mysterious build errors. **Try this first** when builds fail for no obvious reason. Requires `flutter pub get` afterward. |
| `flutter pub run build_runner build` | Runs code generation for packages that need it (json_serializable, freezed, etc.). Not used in this project but common in larger apps. |
| `flutter gen-l10n` | Generates localization files from `.arb` translation files. Used for internationalization (i18n). |

### Debugging & Profiling

| Command | What It Does |
|---------|-------------|
| `flutter logs` | Shows real-time logs from the connected device. Useful for seeing print statements and crash logs. |
| `flutter screenshot` | Takes a screenshot of the running app on the connected device. Saves to the current directory. |
| `flutter attach` | Attaches to an already-running Flutter app (useful for debugging apps launched outside the CLI). Enables hot reload on an existing process. |
| `open -a Simulator` | (macOS) Opens the iOS Simulator app. Flutter will auto-detect it. |
| `flutter run --observatory-port=8888` | Starts the Dart DevTools server on a specific port. Open it in a browser to inspect the widget tree, view timelines, debug memory, and profile performance. |

### Useful `flutter run` Keyboard Shortcuts

While `flutter run` is active in the terminal:

| Key | Action |
|-----|--------|
| `r` | **Hot reload** — injects updated code without restarting the app. Preserves state. ~1 second. Works for most UI changes. |
| `R` | **Hot restart** — restarts the app from main(). Resets all state. ~3 seconds. Required for changes to initState, static fields, or main(). |
| `q` | Quit the running app. |
| `d` | Detach — stops the CLI but keeps the app running on the device. |
| `p` | Toggle debug painting — shows widget boundaries, padding, and alignment guides. |
| `o` | Toggle platform — switches between Material (Android) and Cupertino (iOS) rendering. |
| `s` | Take a screenshot (saved as `flutter_01.png` in project root). |
| `w` | Dump the widget tree to the console (shows the entire widget hierarchy). |
| `t` | Dump the render tree (shows layout information: sizes, positions, constraints). |
| `L` | Dump the layer tree (shows the compositing layers — for advanced rendering debugging). |

---

## Architecture Overview

```
┌─────────────┐     ┌──────────────┐     ┌──────────────┐
│   Screens   │────>│  Providers   │────>│   Services   │
│  (Widgets)  │<────│(ChangeNotify)│<────│  (HTTP/IO)   │
└─────────────┘     └──────────────┘     └──────────────┘
       │                   │                     │
       │              notifyListeners()     async/await
       │                   │                     │
  Consumer/              State              ApiService
  Provider.of         management           AuthService
                                          LocationService
                                           FileService
```

**Screens** display UI and call provider methods.
**Providers** hold state, call services, and notify the UI via `notifyListeners()`.
**Services** handle external I/O (HTTP, SharedPreferences, GPS, file system).
**Models** are plain Dart classes with `fromJson` factories for JSON deserialization.

The app uses **named routes** for main navigation (splash, login, register, home) and **non-named routes** (`Navigator.push(MaterialPageRoute(...))`) for demo screens from the drawer — demonstrating both patterns.

---

## Concepts by File

| File | Dart/Flutter Concepts |
|------|----------------------|
| `main.dart` | runApp, MultiProvider, ChangeNotifierProvider, MaterialApp, named routes, onGenerateRoute, Consumer, initialRoute |
| `api_constants.dart` | abstract final class, static const, static method, string interpolation |
| `route_names.dart` | abstract final class, static const strings |
| `user.dart` | final fields, factory constructor, fromJson, toJson, required named parameters |
| `todo_summary.dart` | nullable types (String?), ternary operator, computed getter |
| `todo_detail.dart` | explicit getters/setters, private fields (\_), null-coalescing (??), copyWith pattern |
| `todo_list_response.dart` | List.map, .toList(), integer division (~/), computed getters |
| `app_theme.dart` | ThemeData, ColorScheme.fromSeed, 15+ component themes, const, light/dark variants |
| `theme_provider.dart` | ChangeNotifier, notifyListeners, SharedPreferences, async init, ThemeMode |
| `api_service.dart` | http package (get/post/patch/delete), jsonEncode/Decode, Bearer token, null-aware elements |
| `auth_service.dart` | SharedPreferences CRUD, Future.wait for parallel async |
| `auth_provider.dart` | ChangeNotifier, try/catch, auto-login, error handling, private state + public getters |
| `todo_provider.dart` | Complex ChangeNotifier, pagination, optimistic updates, rollback, list manipulation |
| `splash_screen.dart` | StatefulWidget lifecycle (initState/dispose), AnimationController, FadeTransition, Hero, Navigator.pushReplacementNamed, SafeArea |
| `login_screen.dart` | Form, TextFormField (all fields), GlobalKey, FocusNode, validator, SingleChildScrollView, ElevatedButton |
| `register_screen.dart` | Cross-field validation, OutlinedButton, confirm password pattern |
| `home_screen.dart` | TabController, SingleTickerProviderStateMixin, TabBar, TabBarView, Drawer, adaptive FAB (Platform check) |
| `todo_list_tab.dart` | ListView.separated, ScrollController (infinite scroll), RefreshIndicator, AlwaysScrollableScrollPhysics, Consumer |
| `todo_grid_tab.dart` | GridView.builder, SliverGridDelegateWithFixedCrossAxisCount, childAspectRatio |
| `widgets_demo_tab.dart` | Container (BoxDecoration, gradient, boxShadow), Row (6 alignments), Column, Flexible vs Expanded, Stack + Positioned |
| `settings_tab.dart` | SwitchListTile, Consumer for multiple providers, showAboutDialog, geolocator integration, logout flow |
| `todo_detail_screen.dart` | Hero animation, AlertDialog (confirmation), Navigator.pop with result, Chip, conditional UI |
| `todo_form_screen.dart` | Dual-purpose form (create/edit), pre-populate fields, file picker, multi-line TextField |
| `sliver_demo_screen.dart` | CustomScrollView, SliverAppBar, FlexibleSpaceBar, SliverList, SliverGrid, SliverToBoxAdapter, BouncingScrollPhysics |
| `animation_demo_screen.dart` | 3 AnimationControllers, TickerProviderStateMixin, FadeTransition, AnimatedBuilder, Matrix4.rotateZ, Color.fromRGBO, Tween, CurvedAnimation, Curves, cascade operator (..) |
| `gestures_demo_screen.dart` | GestureDetector (tap/double/long/pan), HitTestBehavior, InkWell (splash/highlight), Material ancestor, draggable box |
| `media_query_demo_screen.dart` | MediaQuery.of, size, orientation, viewInsets, padding, devicePixelRatio, platformBrightness, textScaler, responsive layout |
| `lifecycle_demo_screen.dart` | Widget lifecycle (7 methods), WidgetsBindingObserver, AppLifecycleState (5 states), timestamped log |
| `not_found_screen.dart` | onGenerateRoute fallback, Navigator.canPop, Navigator.pop |
| `app_drawer.dart` | Drawer, DrawerHeader, ListTile, Navigator.push (non-named routes), FadeSlidePageRoute, Divider |
| `todo_list_item.dart` | ListTile (all fields), Hero on thumbnail, Image.network (loading/error builders), Checkbox |
| `todo_grid_item.dart` | Card (all fields), GridTile (header/footer), InkWell, Image.network |
| `loading_overlay.dart` | Stack, Positioned.fill, AbsorbPointer, CircularProgressIndicator |
| `custom_snackbar.dart` | SnackBar, ScaffoldMessenger, SnackBarAction, static helper pattern |
| `error_dialog.dart` | AlertDialog, showDialog, Navigator.pop, confirmation dialog returning bool |
| `page_transition.dart` | PageRouteBuilder, FadeTransition + SlideTransition combo, Tween, CurvedAnimation |
| `location_service.dart` | Geolocator, LocationPermission, getCurrentPosition, LocationAccuracy, openSettings |
| `file_service.dart` | FilePicker, FileType, PlatformFile, path_provider, File I/O, HTTP download |
