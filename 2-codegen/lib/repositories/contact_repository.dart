// =============================================================================
// Contact Repository — dartz Either for Error Handling
// =============================================================================
// Concepts demonstrated:
// - dartz Either<L, R> — a value that is EITHER a Left (failure) OR Right (success)
// - dartz Option<T> — a value that is EITHER Some(value) OR None (like nullable but FP)
// - fold() — pattern match on Either to handle both cases
// - map() / flatMap() — transform the success value while short-circuiting on failure
// - Why Either > exceptions: explicit error types, no try/catch, composable
// - In-memory storage with CRUD operations
// =============================================================================

import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

// =============================================================================
// dartz Primer
// =============================================================================
//
// Either<L, R> is a type that holds one of two values:
// - Left(value)  → conventionally the FAILURE/error case
// - Right(value) → conventionally the SUCCESS case
//
// Think of it like a Result type in Rust or Swift:
// - Right is "right" as in "correct" (success)
// - Left is the "other" case (failure)
//
// Key methods:
// - fold((l) => ..., (r) => ...)  — handle both cases, returns a value
// - map((r) => ...)               — transform Right, pass Left through
// - flatMap((r) => Either)        — chain operations that return Either
// - getOrElse(() => default)      — get Right value or fallback
// - isLeft / isRight              — check which side it is
//
// Option<T> is similar but for presence/absence:
// - Some(value) — the value exists
// - None()      — no value (like null, but explicit)
//
// Why use Either instead of exceptions?
// 1. EXPLICIT: the return type tells you the function can fail
// 2. EXHAUSTIVE: fold() forces you to handle both cases
// 3. COMPOSABLE: chain operations with map/flatMap
// 4. NO SURPRISES: no hidden throw/catch, everything is in the type signature

/// Repository for managing contacts with functional error handling.
///
/// Every operation returns [Either<ContactFailure, T>] — the caller
/// must handle both the failure case (Left) and success case (Right).
///
/// This pattern eliminates try/catch blocks and makes error handling
/// explicit in the type signature.
class ContactRepository {
  /// In-memory storage. In a real app, this would be a database.
  final Map<String, Contact> _contacts = {};

  /// UUID generator for creating unique contact IDs.
  final _uuid = const Uuid();

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  /// Adds a new contact to the repository.
  ///
  /// Returns [Either]:
  /// - Left([ContactFailure.validationError]) if name is empty
  /// - Right([Contact]) with the created contact (including generated ID)
  ///
  /// Example:
  /// ```dart
  /// final result = repository.addContact(name: 'Alice', email: 'a@b.com');
  /// result.fold(
  ///   (failure) => print('Error: $failure'),
  ///   (contact) => print('Created: ${contact.name}'),
  /// );
  /// ```
  Either<ContactFailure, Contact> addContact({
    required String name,
    String? email,
    String? phone,
    String? notes,
    ContactCategory category = ContactCategory.other,
  }) {
    // -- Validation --
    // Instead of throwing an exception, we return Left with a typed failure.
    // The caller MUST handle this — it's in the return type.
    if (name.trim().isEmpty) {
      return const Left(
        ContactFailure.validationError(
          field: 'name',
          message: 'Name cannot be empty',
        ),
      );
    }

    // Validate email format if provided
    if (email != null && email.isNotEmpty && !_isValidEmail(email)) {
      return const Left(
        ContactFailure.validationError(
          field: 'email',
          message: 'Invalid email format',
        ),
      );
    }

    // -- Create the contact --
    final contact = Contact(
      id: _uuid.v4(),
      name: name.trim(),
      email: email?.trim(),
      phone: phone?.trim(),
      notes: notes?.trim(),
      category: category,
      createdAt: DateTime.now(),
    );

    _contacts[contact.id] = contact;

    // Return Right with the created contact (success case)
    return Right(contact);
  }

  // ---------------------------------------------------------------------------
  // READ
  // ---------------------------------------------------------------------------

  /// Retrieves a contact by ID.
  ///
  /// Returns [Option<Contact>]:
  /// - Some(contact) if found
  /// - None() if not found
  ///
  /// Option vs nullable:
  /// ```dart
  /// // With nullable (easy to forget null check):
  /// Contact? contact = getContact(id);
  /// print(contact.name); // 💥 NullPointerException if null
  ///
  /// // With Option (forces handling):
  /// Option<Contact> contact = getContact(id);
  /// contact.fold(
  ///   () => print('Not found'),          // None case
  ///   (c) => print('Found: ${c.name}'),  // Some case
  /// );
  /// ```
  Option<Contact> getContact(String id) {
    final contact = _contacts[id];
    // optionOf converts nullable to Option: null → None, value → Some(value)
    return optionOf(contact);

    // Alternative: manual construction
    // if (contact == null) return const None();
    // return Some(contact);
  }

  /// Returns all contacts, optionally filtered.
  ///
  /// This always succeeds, so we return the list directly (no Either needed).
  /// Not every function needs Either — use it where failure is meaningful.
  List<Contact> getAllContacts({
    ContactCategory? category,
    bool? favoritesOnly,
    String? searchQuery,
  }) {
    var contacts = _contacts.values.toList();

    // -- Apply filters --
    if (category != null) {
      contacts = contacts.where((c) => c.category == category).toList();
    }
    if (favoritesOnly == true) {
      contacts = contacts.where((c) => c.isFavorite).toList();
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      contacts = contacts.where((c) {
        return c.name.toLowerCase().contains(query) ||
            (c.email?.toLowerCase().contains(query) ?? false) ||
            (c.phone?.contains(query) ?? false);
      }).toList();
    }

    // Sort by name
    contacts.sort((a, b) => a.name.compareTo(b.name));
    return contacts;
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  /// Updates an existing contact using [copyWith].
  ///
  /// Returns [Either]:
  /// - Left([ContactFailure.notFound]) if the contact doesn't exist
  /// - Left([ContactFailure.validationError]) if validation fails
  /// - Right([Contact]) with the updated contact
  ///
  /// Demonstrates freezed's [copyWith]:
  /// ```dart
  /// // copyWith creates a new instance with only the specified fields changed
  /// final updated = contact.copyWith(name: 'New Name');
  /// // All other fields (email, phone, etc.) are preserved
  /// ```
  Either<ContactFailure, Contact> updateContact({
    required String id,
    String? name,
    String? email,
    String? phone,
    String? notes,
    ContactCategory? category,
    bool? isFavorite,
  }) {
    final existing = _contacts[id];
    if (existing == null) {
      return Left(ContactFailure.notFound(id: id));
    }

    // Validate name if being updated
    if (name != null && name.trim().isEmpty) {
      return const Left(
        ContactFailure.validationError(
          field: 'name',
          message: 'Name cannot be empty',
        ),
      );
    }

    // Validate email if being updated
    if (email != null && email.isNotEmpty && !_isValidEmail(email)) {
      return const Left(
        ContactFailure.validationError(
          field: 'email',
          message: 'Invalid email format',
        ),
      );
    }

    // -- copyWith in action --
    // This creates a new Contact with only the non-null fields changed.
    // The ?? operator means "use the new value if provided, else keep existing"
    final updated = existing.copyWith(
      name: name?.trim() ?? existing.name,
      email: email?.trim() ?? existing.email,
      phone: phone?.trim() ?? existing.phone,
      notes: notes?.trim() ?? existing.notes,
      category: category ?? existing.category,
      isFavorite: isFavorite ?? existing.isFavorite,
    );

    _contacts[id] = updated;
    return Right(updated);
  }

  /// Toggles the favorite status of a contact.
  ///
  /// Demonstrates a simple [copyWith] + Either pattern.
  Either<ContactFailure, Contact> toggleFavorite(String id) {
    final existing = _contacts[id];
    if (existing == null) {
      return Left(ContactFailure.notFound(id: id));
    }

    // copyWith with a single field — all others remain the same
    final updated = existing.copyWith(isFavorite: !existing.isFavorite);
    _contacts[id] = updated;
    return Right(updated);
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  /// Deletes a contact by ID.
  ///
  /// Returns [Either]:
  /// - Left([ContactFailure.notFound]) if the contact doesn't exist
  /// - Right([Unit]) on success — Unit is dartz's void equivalent
  ///
  /// Why [Unit] instead of void?
  /// - void can't be used as a type parameter (Either<Failure, void> ❌)
  /// - Unit is a real type with a single value: unit
  /// - It means "operation succeeded, no meaningful return value"
  Either<ContactFailure, Unit> deleteContact(String id) {
    if (!_contacts.containsKey(id)) {
      return Left(ContactFailure.notFound(id: id));
    }
    _contacts.remove(id);
    // `unit` is the singleton value of type Unit (like void but usable)
    return const Right(unit);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Simple email validation regex.
  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  /// Total number of contacts (for display).
  int get count => _contacts.length;

  // ---------------------------------------------------------------------------
  // Chaining Either with flatMap
  // ---------------------------------------------------------------------------
  //
  // flatMap (also called "bind" or ">>=") chains operations that return Either.
  // If any step returns Left, the chain short-circuits immediately.
  //
  // Example: "Add a contact, then immediately favorite it"
  // ```dart
  // final result = repository
  //     .addContact(name: 'Alice')          // Either<Failure, Contact>
  //     .flatMap((contact) =>               // if Right, continue...
  //         repository.toggleFavorite(contact.id)); // Either<Failure, Contact>
  //
  // // If addContact fails → result is Left(failure), toggleFavorite never runs
  // // If addContact succeeds but toggleFavorite fails → result is Left(failure)
  // // If both succeed → result is Right(updatedContact)
  // ```
  //
  // Compare with try/catch equivalent:
  // ```dart
  // try {
  //   final contact = repository.addContact(name: 'Alice');
  //   final updated = repository.toggleFavorite(contact.id);
  //   return updated;
  // } catch (e) {
  //   // What type is e? Could be anything. No compiler help.
  //   return null;
  // }
  // ```
}
