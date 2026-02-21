# 2-codegen — Code Generation & Functional Types

A **Contact Book** app that teaches Flutter code generation tools and functional programming patterns.

## What You'll Learn

| Topic | Key Concepts |
|-------|-------------|
| **build_runner** | `build` vs `watch`, `*.g.dart` / `*.freezed.dart`, `part` directive |
| **freezed** | `@freezed` classes, union types, `copyWith`, `when`/`map`, `@Default` |
| **json_serializable** | `@JsonSerializable`, `@JsonKey`, `fromJson`/`toJson`, nested models |
| **dartz** | `Either<Failure, Success>`, `Option<T>`, `fold`, `map`, `flatMap` |
| **l10n/intl** | `.arb` files, `AppLocalizations.of(context)`, plural rules, language switcher |

## Project Structure

```
lib/
├── l10n/
│   ├── app_en.arb              # English translations (template)
│   ├── app_es.arb              # Spanish translations
│   └── generated/              # Auto-generated localization code
├── models/
│   ├── contact.dart            # @freezed + @JsonSerializable model
│   ├── contact.freezed.dart    # Generated: copyWith, ==, hashCode
│   ├── contact.g.dart          # Generated: fromJson, toJson
│   ├── contact_category.dart   # Enum with extension methods
│   ├── contact_failure.dart    # Freezed union type for errors
│   └── models.dart             # Barrel file
├── repositories/
│   └── contact_repository.dart # CRUD with dartz Either/Option
├── screens/
│   ├── contact_list_screen.dart # Main list with search, filter, delete
│   └── contact_form_screen.dart # Create/edit form with validation
├── widgets/
│   └── contact_tile.dart       # List item widget
└── main.dart                   # App entry with l10n setup
```

## build_runner Pipeline

### One-time build
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Watch mode (auto-rebuild on save)
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### What gets generated

| Source File | Annotation | Generated File | Contents |
|------------|------------|---------------|----------|
| `contact.dart` | `@freezed` | `contact.freezed.dart` | `copyWith`, `==`, `hashCode`, `toString` |
| `contact.dart` | `@freezed` | `contact.g.dart` | `_$ContactFromJson`, `_$ContactToJson` |
| `contact_failure.dart` | `@freezed` | `contact_failure.freezed.dart` | Union type variants, `when`, `map` |

### How `part` directives work

```dart
// In contact.dart:
part 'contact.freezed.dart';  // "This file has a piece in contact.freezed.dart"
part 'contact.g.dart';        // "This file has a piece in contact.g.dart"

// In contact.freezed.dart (generated):
part of 'contact.dart';       // "I belong to contact.dart"
```

## dartz Cheat Sheet

### Either\<L, R\>
```dart
Either<Failure, Contact> result = repository.addContact(name: 'Alice');

// Pattern match with fold:
result.fold(
  (failure) => showError(failure),   // Left case
  (contact) => showSuccess(contact), // Right case
);

// Transform success value:
Either<Failure, String> name = result.map((c) => c.name);

// Chain operations:
result.flatMap((contact) => repository.toggleFavorite(contact.id));
```

### Option\<T\>
```dart
Option<Contact> found = repository.getContact(id);

found.fold(
  () => print('Not found'),           // None
  (contact) => print(contact.name),   // Some
);
```

## l10n Quick Reference

### ARB file format (app_en.arb)
```json
{
  "appTitle": "Contact Book",
  "@appTitle": { "description": "App title" },
  "contactsCount": "{count, plural, =0{No contacts} =1{1 contact} other{{count} contacts}}"
}
```

### Usage in widgets
```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.appTitle);              // Simple string
Text(l10n.contactsCount(5));      // Plural: "5 contacts"
Text(l10n.confirmDelete('Alice')); // Interpolation
```

## Running the App

```bash
cd 2-codegen
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

No backend needed — contacts are stored in memory.
