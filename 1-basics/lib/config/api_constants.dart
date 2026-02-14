// =============================================================================
// API Constants
// =============================================================================
// Concepts demonstrated:
// - Dart abstract final class (cannot be instantiated or extended)
// - Static constants for compile-time values
// - String interpolation for building URLs
// - Organizing configuration in a single place
// =============================================================================

/// Centralized API configuration.
///
/// Uses [abstract final class] so it cannot be instantiated or subclassed.
/// All members are static — accessed as [ApiConstants.baseUrl], etc.
abstract final class ApiConstants {
  // ---------------------------------------------------------------------------
  // Base URL
  // ---------------------------------------------------------------------------

  /// The root URL of the Go backend server.
  ///
  /// In a real app you would read this from an environment variable or
  /// a flavor-specific config file. For this tutorial it points to the
  /// local development server.
  static const String baseUrl = 'http://localhost:8080';

  // ---------------------------------------------------------------------------
  // Auth endpoints
  // ---------------------------------------------------------------------------

  /// POST — register a new user.
  /// Body: `{ "email": "...", "password": "..." }`
  /// Returns: `{ "user": {...}, "token": "..." }`
  static const String registerEndpoint = '$baseUrl/register';

  /// POST — log in with existing credentials.
  /// Body: `{ "email": "...", "password": "..." }`
  /// Returns: `{ "user": {...}, "token": "..." }`
  static const String loginEndpoint = '$baseUrl/login';

  // ---------------------------------------------------------------------------
  // Todo endpoints
  // ---------------------------------------------------------------------------

  /// GET  — list todos (paginated: ?page=1&page_size=10)
  /// POST — create a new todo
  static const String todosEndpoint = '$baseUrl/todos';

  /// Returns the endpoint for a single todo by [id].
  ///
  /// Used for GET (detail), PATCH (update), and DELETE.
  /// This is a static *method* (not a constant) because it depends on
  /// a runtime value.
  static String todoByIdEndpoint(int id) => '$baseUrl/todos/$id';

  // ---------------------------------------------------------------------------
  // Pagination defaults
  // ---------------------------------------------------------------------------

  /// The number of items fetched per page (matches backend default).
  static const int defaultPageSize = 10;
}
