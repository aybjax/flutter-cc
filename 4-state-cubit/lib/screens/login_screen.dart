// =============================================================================
// Login Screen — BlocConsumer for Auth Flow
// =============================================================================
// Concepts demonstrated:
// - BlocConsumer = BlocBuilder + BlocListener in one widget
// - BlocBuilder: renders the form differently based on auth state
// - BlocListener: reacts to state changes (show error, navigate)
// - context.read<AuthCubit>() for calling methods
// - Form validation with TextFormField
//
// Flow:
// 1. User fills in email/password
// 2. User taps "Login"
// 3. AuthCubit emits Loading → form shows spinner
// 4a. AuthCubit emits Authenticated → navigate to todo list
// 4b. AuthCubit emits Error → show error snackbar
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../l10n/generated/app_localizations.dart';
import 'register_screen.dart';

// =============================================================================
// Login Screen
// =============================================================================

/// The login screen with email/password form.
///
/// Uses [BlocConsumer] to both render based on state AND react to changes.
/// This is the recommended approach when you need both rendering and
/// side effects (like navigation) in the same widget.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Form key for validation.
  final _formKey = GlobalKey<FormState>();

  /// Controllers for the text fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // =========================================================================
    // BlocConsumer = BlocBuilder + BlocListener
    // =========================================================================
    // BlocConsumer combines two things:
    // 1. listener: runs side effects (show snackbar, navigate)
    //    - Called ONCE per state change (not on every build)
    //    - Perfect for one-time actions
    // 2. builder: returns a widget based on the current state
    //    - Called on EVERY state change
    //    - Used for rendering the UI
    //
    // Alternative: use BlocBuilder and BlocListener separately:
    // ```dart
    // BlocListener<AuthCubit, AuthState>(
    //   listener: (context, state) { ... },
    //   child: BlocBuilder<AuthCubit, AuthState>(
    //     builder: (context, state) { ... },
    //   ),
    // )
    // ```
    return BlocConsumer<AuthCubit, AuthState>(
      // -- Listener: side effects --
      listener: (context, state) {
        state.maybeWhen(
          error: (failure) {
            // Show error in a snackbar
            final message = failure.when(
              network: (msg) => l10n.errorNetwork,
              server: (msg, _) => msg,
              unauthorized: () => l10n.errorUnauthorized,
              notFound: (id) => 'Not found',
              validation: (field, msg) => msg,
              unexpected: (error) => l10n.errorServer,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
        // Note: navigation to todo list is handled in main.dart
        // based on the auth state, not here
      },

      // -- Builder: render the UI --
      builder: (context, state) {
        // Check if we're in loading state to disable the form
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.login)),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -- App icon --
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 32),

                  // -- Email field --
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: l10n.email,
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.errorRequired;
                      }
                      if (!value.contains('@')) {
                        return l10n.errorInvalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // -- Password field --
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: true,
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.errorRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // -- Login button / loading indicator --
                  SizedBox(
                    height: 48,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : FilledButton(
                            onPressed: _onLogin,
                            child: Text(l10n.login),
                          ),
                  ),
                  const SizedBox(height: 16),

                  // -- Register link --
                  TextButton(
                    onPressed: isLoading ? null : _navigateToRegister,
                    child: Text(l10n.noAccount),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// Validates the form and calls the AuthCubit's login method.
  void _onLogin() {
    if (_formKey.currentState?.validate() != true) return;

    // context.read<AuthCubit>() gets the Cubit from the widget tree.
    // Unlike context.watch(), read() doesn't subscribe to changes —
    // it just gets a reference to call methods.
    context.read<AuthCubit>().login(
          _emailController.text,
          _passwordController.text,
        );
  }

  /// Navigates to the registration screen.
  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }
}

// =============================================================================
// context.read vs context.watch
// =============================================================================
//
// context.read<AuthCubit>()
// - Gets the Cubit WITHOUT subscribing to state changes
// - Use in event handlers (onPressed, onTap, etc.)
// - NEVER use inside build() — won't rebuild when state changes
//
// context.watch<AuthCubit>()
// - Gets the Cubit AND subscribes to state changes
// - Use inside build() for reactive rendering
// - Equivalent to BlocBuilder but less explicit
// - CAN'T use in event handlers (throws)
//
// BlocBuilder<AuthCubit, AuthState>
// - The explicit, recommended way to subscribe to state changes
// - Provides buildWhen for filtering rebuilds
// - Makes the dependency on AuthCubit visible in the code
// =============================================================================
