// =============================================================================
// Login Screen — Auth Guard Demo
// =============================================================================
// Concepts demonstrated:
// - Simple login form for demonstrating navigation auth guards
// - Shared auth state via ValueNotifier (kept simple — no provider needed)
// - Form validation with TextFormField
// - @RoutePage() annotation for auto_route code generation
//
// This is intentionally minimal — the focus is on navigation, not auth.
// In a real app, you'd use a proper auth service with token management.
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// -- Global auth state --
// Using a simple ValueNotifier instead of a full state management solution.
// This is shared across all three navigation approaches.
// In production, use Provider, Riverpod, or Bloc for auth state.

/// Whether the user is currently authenticated.
///
/// All three navigation approaches (Navigator, GoRouter, auto_route)
/// check this value to decide whether to allow or redirect access.
final ValueNotifier<bool> isAuthenticated = ValueNotifier(false);

/// The "logged in" user's display name.
final ValueNotifier<String> currentUserName = ValueNotifier('');

// -----------------------------------------------------------------------------
// Login Screen Widget
// -----------------------------------------------------------------------------

/// A minimal login screen used to demonstrate auth guards in all
/// three navigation approaches.
///
/// Accepts [onLoginSuccess] callback so each navigation approach
/// can handle post-login routing differently.
@RoutePage()
class LoginScreen extends StatefulWidget {
  /// Optional callback invoked after successful login.
  ///
  /// - Default Navigator: pushes to the previous route
  /// - GoRouter: uses `go()` to redirect
  /// - auto_route: the guard handles redirection automatically
  final VoidCallback? onLoginSuccess;

  /// Creates a [LoginScreen].
  const LoginScreen({super.key, this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // -- Form state --
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'user@example.com');
  final _passwordController = TextEditingController(text: 'password');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Login handler
  // ---------------------------------------------------------------------------

  /// Validates the form and updates global auth state.
  ///
  /// In a real app, this would call an auth service and await a response.
  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    // Simulate successful login
    isAuthenticated.value = true;
    currentUserName.value = _emailController.text.split('@').first;

    // Let the caller decide where to navigate after login.
    // Each navigation approach handles this differently.
    if (widget.onLoginSuccess != null) {
      widget.onLoginSuccess!();
    } else {
      // Default: just pop back if no callback provided
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -- Header --
                  Icon(
                    Icons.newspaper,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'News Reader',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to access your profile',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),

                  // -- Email field --
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // Simple email check — not production-grade
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // -- Password field --
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outlined),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // -- Login button --
                  FilledButton(
                    onPressed: _handleLogin,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // -- Demo hint --
                  Text(
                    'Hint: Any email/password works for this demo.\n'
                    'This screen demonstrates auth guards in all '
                    'three navigation approaches.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
