// =============================================================================
// Auth Repository Interface (Domain Layer)
// =============================================================================
// Abstract contract that the domain layer defines and the data layer
// implements. This is the Dependency Inversion Principle in action:
// high-level modules (domain) don't depend on low-level modules (data).
// =============================================================================

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user_entity.dart';

// ---------------------------------------------------------------------------
// AuthRepository
// ---------------------------------------------------------------------------

/// Defines authentication operations the app supports.
///
/// Returns [Either<Failure, UserEntity>] so callers can handle
/// success and failure without try/catch:
/// ```dart
/// final result = await authRepo.login(email, password);
/// result.fold(
///   (failure) => showError(failure.message),
///   (user) => navigateHome(user),
/// );
/// ```
///
/// The data layer provides the concrete implementation
/// ([AuthRepositoryImpl]) which is registered in the DI container.
abstract class AuthRepository {
  /// Authenticates a user with [email] and [password].
  ///
  /// Returns [UserEntity] on success, [Failure] on error.
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Creates a new user account with [email] and [password].
  ///
  /// Returns [UserEntity] on success, [Failure] on error.
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
  });

  // Alternative: add token refresh
  // Future<Either<Failure, UserEntity>> refreshToken();
}
