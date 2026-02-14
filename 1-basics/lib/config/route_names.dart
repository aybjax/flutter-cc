// =============================================================================
// Route Names
// =============================================================================
// Concepts demonstrated:
// - Named routes in Flutter (strings passed to Navigator.pushNamed)
// - Centralizing route strings avoids typos and makes refactoring easy
// - abstract final class prevents instantiation
// =============================================================================

/// Named-route constants used with [Navigator.pushNamed].
///
/// Keeping route strings in one place means a typo here is caught once,
/// rather than hunting through multiple files.
abstract final class RouteNames {
  /// The splash screen shown on app launch.
  static const String splash = '/';

  /// The login screen.
  static const String login = '/login';

  /// The registration screen.
  static const String register = '/register';

  /// The main home screen (tabs, drawer).
  static const String home = '/home';

  /// Todo detail — expects a todo id argument.
  static const String todoDetail = '/todo/detail';

  /// Todo form (create / edit) — optional todo argument for editing.
  static const String todoForm = '/todo/form';
}
