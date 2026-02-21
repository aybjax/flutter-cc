// =============================================================================
// Global BlocObserver - Logs all BLoC events, transitions, and errors
// =============================================================================
// Demonstrates:
// - BlocObserver for centralized logging and debugging
// - Monitoring all BLoCs from a single place
// - Useful for analytics, crash reporting, debugging
// =============================================================================

import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

// ---------------------------------------------------------------------------
// AppBlocObserver
// ---------------------------------------------------------------------------

/// Global observer that logs all BLoC activity across the app.
///
/// Registered in [main()] via [Bloc.observer = AppBlocObserver()].
/// In production, you could send events to analytics or crash reporting
/// services instead of just logging.
class AppBlocObserver extends BlocObserver {
  /// Called when a new BLoC or Cubit is created.
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    developer.log(
      'onCreate: ${bloc.runtimeType}',
      name: 'BlocObserver',
    );
  }

  /// Called whenever an event is added to a BLoC.
  ///
  /// This is NOT called for Cubits (they don't have events).
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log(
      'onEvent: ${bloc.runtimeType} -> $event',
      name: 'BlocObserver',
    );
  }

  /// Called whenever a state transition occurs in a BLoC.
  ///
  /// A [Transition] contains the current state, the event that triggered
  /// the transition, and the next state.
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    developer.log(
      'onTransition: ${bloc.runtimeType}\n'
      '  currentState: ${transition.currentState}\n'
      '  event: ${transition.event}\n'
      '  nextState: ${transition.nextState}',
      name: 'BlocObserver',
    );
  }

  /// Called whenever a state change occurs in a BLoC or Cubit.
  ///
  /// Unlike [onTransition], this is called for both BLoCs and Cubits.
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    developer.log(
      'onChange: ${bloc.runtimeType}\n'
      '  currentState: ${change.currentState}\n'
      '  nextState: ${change.nextState}',
      name: 'BlocObserver',
    );
  }

  /// Called whenever an error occurs in a BLoC or Cubit.
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    developer.log(
      'onError: ${bloc.runtimeType} -> $error',
      name: 'BlocObserver',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Called when a BLoC or Cubit is closed.
  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    developer.log(
      'onClose: ${bloc.runtimeType}',
      name: 'BlocObserver',
    );
  }
}

// Alternative: Filtered observer that only logs specific BLoCs:
// class FilteredBlocObserver extends BlocObserver {
//   final Set<Type> _trackedBlocs = {ProductListBloc, CartBloc};
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     if (_trackedBlocs.contains(bloc.runtimeType)) {
//       super.onEvent(bloc, event);
//       log(...);
//     }
//   }
// }
