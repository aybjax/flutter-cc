// =============================================================================
// API Constants
// =============================================================================
// Centralizes all API endpoint paths and configuration values.
// Using constants prevents typos and makes refactoring easier.
// =============================================================================

/// Holds all API-related constants used across the data layer.
///
/// Keeping endpoints in one place means a URL change only requires
/// editing this file rather than hunting through multiple datasources.
class ApiConstants {
  // ---------------------------------------------------------------------------
  // Prevent instantiation - this is a pure constants class
  // ---------------------------------------------------------------------------
  ApiConstants._();

  // ---------------------------------------------------------------------------
  // Auth endpoints
  // ---------------------------------------------------------------------------

  /// POST /register - Create a new user account.
  static const String register = '/register';

  /// POST /login - Authenticate an existing user.
  static const String login = '/login';

  // ---------------------------------------------------------------------------
  // Todo endpoints
  // ---------------------------------------------------------------------------

  /// GET /todos - Fetch paginated list of todos.
  /// Also used for POST /todos - Create a new todo.
  static const String todos = '/todos';

  /// Builds the path for a single todo by ID.
  ///
  /// Example: todoById(42) => '/todos/42'
  static String todoById(int id) => '/todos/$id';

  // ---------------------------------------------------------------------------
  // Pagination defaults
  // ---------------------------------------------------------------------------

  /// Default page size when fetching todo lists.
  static const int defaultPageSize = 10;

  // ---------------------------------------------------------------------------
  // Timeouts (in milliseconds)
  // ---------------------------------------------------------------------------

  /// How long to wait for a connection to be established.
  static const int connectTimeout = 10000;

  /// How long to wait for the server to send data.
  static const int receiveTimeout = 15000;

  // Alternative: you could load these from .env too
  // static int get connectTimeout =>
  //     int.parse(dotenv.env['CONNECT_TIMEOUT'] ?? '10000');
}
