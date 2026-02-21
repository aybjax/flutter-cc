// =============================================================================
// Widget Test — Basic Smoke Test
// =============================================================================
// This is a placeholder test. For comprehensive Cubit testing,
// see the bloc_test examples in the comments below.
// =============================================================================

import 'package:flutter_test/flutter_test.dart';

import 'package:state_cubit_tutorial/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const StateCubitTutorialApp());

    // Verify that the login screen is shown initially.
    // The app starts in AuthState.initial(), which shows LoginScreen.
    expect(find.text('Login'), findsWidgets);
  });
}

// =============================================================================
// Cubit Testing with bloc_test
// =============================================================================
//
// The bloc_test package provides blocTest<Cubit, State>() for testing:
//
// ```dart
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockAuthRepository extends Mock implements AuthRepository {}
//
// void main() {
//   late MockAuthRepository mockAuthRepo;
//
//   setUp(() {
//     mockAuthRepo = MockAuthRepository();
//   });
//
//   group('AuthCubit', () {
//     blocTest<AuthCubit, AuthState>(
//       'emits [loading, authenticated] when login succeeds',
//       setUp: () {
//         when(() => mockAuthRepo.login(any(), any()))
//             .thenAnswer((_) async => Right((
//               const User(id: 1, email: 'test@test.com'),
//               'token123',
//             )));
//       },
//       build: () => AuthCubit(authRepository: mockAuthRepo),
//       act: (cubit) => cubit.login('test@test.com', 'password'),
//       expect: () => [
//         const AuthState.loading(),
//         isA<AuthAuthenticated>(),
//       ],
//     );
//
//     blocTest<AuthCubit, AuthState>(
//       'emits [loading, error] when login fails',
//       setUp: () {
//         when(() => mockAuthRepo.login(any(), any()))
//             .thenAnswer((_) async => const Left(
//               TodoFailure.server(message: 'Invalid credentials', statusCode: 401),
//             ));
//       },
//       build: () => AuthCubit(authRepository: mockAuthRepo),
//       act: (cubit) => cubit.login('test@test.com', 'wrong'),
//       expect: () => [
//         const AuthState.loading(),
//         isA<AuthError>(),
//       ],
//     );
//
//     blocTest<AuthCubit, AuthState>(
//       'emits [initial] when logout is called',
//       setUp: () {
//         when(() => mockAuthRepo.logout()).thenReturn(null);
//       },
//       build: () => AuthCubit(authRepository: mockAuthRepo),
//       seed: () => const AuthState.authenticated(
//         user: User(id: 1, email: 'test@test.com'),
//         token: 'token123',
//       ),
//       act: (cubit) => cubit.logout(),
//       expect: () => [const AuthState.initial()],
//     );
//   });
// }
// ```
// =============================================================================
