// =============================================================================
// Login Use Case
// =============================================================================
// Encapsulates the "log in a user" business rule. Use cases are the
// application's entry points - the presentation layer calls use cases,
// never repositories directly.
// =============================================================================

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

// ---------------------------------------------------------------------------
// LoginUseCase
// ---------------------------------------------------------------------------

/// Executes user authentication.
///
/// Use cases follow the Single Responsibility Principle: each use case
/// does exactly one thing. This makes them easy to test and reuse.
///
/// Registered as a **factory** in get_it because use cases are stateless:
/// ```dart
/// getIt.registerFactory(() => LoginUseCase(getIt()));
/// ```
class LoginUseCase {
  final AuthRepository _repository;

  /// Creates a [LoginUseCase] with the injected [AuthRepository].
  const LoginUseCase(this._repository);

  /// Executes the login operation.
  ///
  /// Returns [Right(UserEntity)] on success, [Left(Failure)] on error.
  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    // In a more complex app, you might add validation here:
    // if (!EmailValidator.isValid(email)) {
    //   return Future.value(Left(Failure.validation(message: 'Invalid email')));
    // }

    return _repository.login(email: email, password: password);
  }

  // Alternative: use a Params class for type safety
  // Future<Either<Failure, UserEntity>> call(LoginParams params) {
  //   return _repository.login(
  //     email: params.email,
  //     password: params.password,
  //   );
  // }
}
