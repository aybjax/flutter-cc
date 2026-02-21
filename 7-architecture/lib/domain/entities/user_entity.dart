// =============================================================================
// User Entity
// =============================================================================
// Pure domain entity - no framework dependencies, no JSON annotations.
// This is what the rest of the app works with. The data layer maps
// API responses (UserModel) into this entity.
// =============================================================================

/// Represents an authenticated user in the domain layer.
///
/// Entities are framework-agnostic: no json_annotation, no freezed.
/// They define what the business logic cares about, nothing more.
///
/// The [token] is included here for convenience since the auth flow
/// needs it immediately after login/register.
class UserEntity {
  /// Unique identifier from the backend.
  final int id;

  /// User's email address (used for login).
  final String email;

  /// JWT token for authenticating subsequent requests.
  final String token;

  /// Creates a [UserEntity].
  const UserEntity({
    required this.id,
    required this.email,
    required this.token,
  });

  // Alternative: you could use Equatable for value equality
  // @override
  // List<Object?> get props => [id, email, token];
}
