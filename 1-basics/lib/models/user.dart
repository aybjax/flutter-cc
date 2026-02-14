// =============================================================================
// User Model
// =============================================================================
// Concepts demonstrated:
// - Dart class with final fields (immutable after construction)
// - Factory constructor for JSON deserialization (fromJson pattern)
// - Named constructor vs factory constructor
// - Type casting with `as` and null-aware operators
// - Getters (implicit via final fields)
// =============================================================================

/// Represents an authenticated user returned by the backend.
///
/// The backend sends:
/// ```json
/// { "id": 1, "email": "user@example.com" }
/// ```
///
/// Fields are [final] — once created, a [User] cannot be modified.
/// This is a common pattern for data classes in Dart.
class User {
  /// Unique identifier assigned by the backend.
  final int id;

  /// The user's email address (used as username).
  final String email;

  /// Primary constructor.
  ///
  /// The `required` keyword forces callers to provide both arguments
  /// by name, improving readability:
  /// ```dart
  /// User(id: 1, email: 'a@b.com')
  /// ```
  const User({
    required this.id,
    required this.email,
  });

  /// Factory constructor that creates a [User] from a JSON map.
  ///
  /// A *factory* constructor can return an existing instance or decide
  /// which subclass to create. Here we simply delegate to the primary
  /// constructor after extracting the JSON keys.
  ///
  /// The `as int` / `as String` casts will throw at runtime if the
  /// backend sends unexpected types — which is fine during development
  /// because it surfaces bugs immediately.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
    );
  }

  /// Converts this user back to a JSON-compatible map.
  ///
  /// Useful for debugging or sending data back to the server.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }

  /// Human-readable representation for debugging.
  @override
  String toString() => 'User(id: $id, email: $email)';
}
