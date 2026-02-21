// =============================================================================
// Auth Repository Implementation (Data Layer)
// =============================================================================
// Concrete implementation of the domain's AuthRepository interface.
// This is where we bridge the data source (raw HTTP) and domain layer
// (Either<Failure, Entity>). All exceptions are caught and converted
// to typed Failures.
// =============================================================================

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/todo_remote_datasource.dart';

// ---------------------------------------------------------------------------
// AuthRepositoryImpl
// ---------------------------------------------------------------------------

/// Implements [AuthRepository] by delegating to [TodoRemoteDataSource].
///
/// This class is the "adapter" between the raw data source and the
/// clean domain interface. It handles:
/// 1. Calling the data source
/// 2. Converting models to entities
/// 3. Catching exceptions and returning Failures
///
/// Registered as a **lazy singleton** in get_it, bound to the abstract type:
/// ```dart
/// getIt.registerLazySingleton<AuthRepository>(
///   () => AuthRepositoryImpl(getIt()),
/// );
/// ```
class AuthRepositoryImpl implements AuthRepository {
  final TodoRemoteDataSource _dataSource;

  /// Creates an [AuthRepositoryImpl] with the injected data source.
  const AuthRepositoryImpl(this._dataSource);

  // ---------------------------------------------------------------------------
  // Login
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _dataSource.login(
        email: email,
        password: password,
      );
      // Convert data model -> domain entity at the boundary
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Register
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _dataSource.register(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Maps a [DioException] to the appropriate [Failure] type.
  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Failure.network(
          message: e.message ?? 'Network error occurred',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        if (statusCode == 401) {
          return Failure.unauthorized(
            message: e.message ?? 'Unauthorized',
          );
        }
        return Failure.server(
          message: e.message ?? 'Server error occurred',
        );
      default:
        return Failure.unknown(
          message: e.message ?? 'Unknown error occurred',
        );
    }
  }

  // Alternative: extract _mapDioException to a shared mixin
  // mixin DioExceptionMapper {
  //   Failure mapDioException(DioException e) { ... }
  // }
}
