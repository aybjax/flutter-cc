// =============================================================================
// User Model — Freezed + JSON Serializable
// =============================================================================
// Concepts demonstrated:
// - @freezed annotation — generates immutable data class
// - @JsonSerializable integration — fromJson/toJson via generated code
// - part directive — connects this file to generated *.freezed.dart and *.g.dart
// - How the backend returns user data from /login and /register
//
// The Go backend returns:
//   { "user": { "id": 1, "email": "alice@example.com" }, "token": "jwt..." }
//
// We model just the user part here. The token is stored separately.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

// -- Part directives --
// These tell Dart that generated code lives in sibling files.
// `part 'user.freezed.dart'` — contains copyWith, ==, hashCode, toString
// `part 'user.g.dart'`       — contains _$UserFromJson, _$UserToJson
part 'user.freezed.dart';
part 'user.g.dart';

// =============================================================================
// User Data Class
// =============================================================================

/// A user returned by the Go backend after login or registration.
///
/// The backend JSON looks like:
/// ```json
/// { "id": 1, "email": "alice@example.com" }
/// ```
///
/// Freezed generates:
/// - `copyWith()` for creating modified copies
/// - `==` and `hashCode` for value equality
/// - `toString()` for readable debug output
/// - `fromJson/toJson` for JSON serialization
@freezed
abstract class User with _$User {
  /// Creates a [User] with id and email from the backend.
  const factory User({
    /// Unique user ID assigned by the backend.
    required int id,

    /// The user's email address.
    required String email,
  }) = _User;

  // ---------------------------------------------------------------------------
  // JSON serialization
  // ---------------------------------------------------------------------------
  // This factory connects to the generated _$UserFromJson function.

  /// Deserializes a [User] from a JSON map.
  ///
  /// Example:
  /// ```dart
  /// final json = {'id': 1, 'email': 'alice@example.com'};
  /// final user = User.fromJson(json);
  /// ```
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Why a separate User model?
// - Clean separation: authentication data vs todo data
// - The backend returns user info in login/register responses
// - In a real app, you'd persist this for showing the current user's info
//
// Alternative: you could embed user data in an AuthState union type.
// We keep it as a standalone model for reuse and clarity.
// =============================================================================
