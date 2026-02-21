// =============================================================================
// Dependency Injection Container (get_it)
// =============================================================================
// Centralizes all dependency registration in one place. This is the
// composition root - the only place that knows about concrete implementations.
//
// get_it registration types demonstrated:
// - registerSingleton:      Eager, created immediately
// - registerLazySingleton:  Lazy, created on first access
// - registerFactory:        New instance every time
// - registerSingletonAsync: Async initialization (e.g., SharedPreferences)
// =============================================================================

import 'package:get_it/get_it.dart';

import '../../data/datasources/todo_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/create_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/cubits/auth/auth_cubit.dart';
import '../../presentation/cubits/todo/todo_cubit.dart';
import '../network/dio_client.dart';

// ---------------------------------------------------------------------------
// Global service locator instance
// ---------------------------------------------------------------------------

/// The global [GetIt] instance used throughout the app.
///
/// Access registered dependencies anywhere:
/// ```dart
/// final dioClient = getIt<DioClient>();
/// final authCubit = getIt<AuthCubit>();
/// ```
final getIt = GetIt.instance;

// ---------------------------------------------------------------------------
// Setup function
// ---------------------------------------------------------------------------

/// Registers all dependencies. Call this once before runApp().
///
/// Registration order matters when dependencies reference each other.
/// We register from the lowest layer (network) up to the highest
/// (presentation).
///
/// This function is async to support [registerSingletonAsync] if needed.
Future<void> setupDependencies() async {
  // ===========================================================================
  // Core / Network Layer
  // ===========================================================================

  // registerLazySingleton: created on first use, then cached forever.
  // Perfect for singletons that may not be needed immediately.
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(),
  );

  // Alternative: registerSingleton for eager initialization
  // getIt.registerSingleton<DioClient>(DioClient());

  // Alternative: registerSingletonAsync for async setup
  // getIt.registerSingletonAsync<SharedPreferences>(
  //   () => SharedPreferences.getInstance(),
  // );
  // await getIt.allReady(); // Wait for async singletons

  // ===========================================================================
  // Data Layer - Data Sources
  // ===========================================================================

  // Lazy singleton because there's only one remote API
  getIt.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSource(getIt<DioClient>()),
  );

  // ===========================================================================
  // Data Layer - Repository Implementations
  // ===========================================================================

  // Register concrete implementations against their abstract interfaces.
  // This is the Dependency Inversion Principle: the rest of the app
  // depends on AuthRepository (abstract), not AuthRepositoryImpl (concrete).

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<TodoRemoteDataSource>()),
  );

  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt<TodoRemoteDataSource>()),
  );

  // ===========================================================================
  // Domain Layer - Use Cases
  // ===========================================================================

  // registerFactory: creates a new instance every time.
  // Use cases are stateless, so a factory is appropriate.
  // (LazySingleton would also work since they're immutable.)

  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<GetTodosUseCase>(
    () => GetTodosUseCase(getIt<TodoRepository>()),
  );

  getIt.registerFactory<CreateTodoUseCase>(
    () => CreateTodoUseCase(getIt<TodoRepository>()),
  );

  getIt.registerFactory<DeleteTodoUseCase>(
    () => DeleteTodoUseCase(getIt<TodoRepository>()),
  );

  // ===========================================================================
  // Presentation Layer - Cubits
  // ===========================================================================

  // registerFactory: each screen gets its own cubit instance.
  // This prevents state leaking between screens.

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      dioClient: getIt<DioClient>(),
    ),
  );

  getIt.registerFactory<TodoCubit>(
    () => TodoCubit(
      getTodosUseCase: getIt<GetTodosUseCase>(),
      createTodoUseCase: getIt<CreateTodoUseCase>(),
      deleteTodoUseCase: getIt<DeleteTodoUseCase>(),
      todoRepository: getIt<TodoRepository>(),
    ),
  );

  // Alternative: use registerSingleton for cubits that must persist
  // getIt.registerSingleton<AuthCubit>(AuthCubit(...));
}
