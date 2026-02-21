// =============================================================================
// Register Screen — BlocConsumer for Registration Flow
// =============================================================================
// Concepts demonstrated:
// - Reusing the same AuthCubit for both login and register flows
// - BlocConsumer for rendering + side effects
// - Form validation patterns
// - Navigator.push/pop for screen transitions
//
// This screen is nearly identical to LoginScreen but calls
// AuthCubit.register() instead of login(). In a real app, you might
// add password confirmation, terms acceptance, etc.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../l10n/generated/app_localizations.dart';

// =============================================================================
// Register Screen
// =============================================================================

/// The registration screen with email/password form.
///
/// Uses the same [AuthCubit] as [LoginScreen] — both screens share
/// the same Cubit instance via BlocProvider in the widget tree.
/// This means login/register states are unified.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
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

    return BlocConsumer<AuthCubit, AuthState>(
      // -- Listener: show errors, handle success --
      listener: (context, state) {
        state.maybeWhen(
          error: (failure) {
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
          authenticated: (user, token) {
            // Pop back to root — main.dart will show the todo list
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          orElse: () {},
        );
      },

      // -- Builder: render the form --
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.register)),
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
                    Icons.person_add_outlined,
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
                      if (value.length < 3) {
                        return 'Password must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // -- Register button / loading indicator --
                  SizedBox(
                    height: 48,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : FilledButton(
                            onPressed: _onRegister,
                            child: Text(l10n.register),
                          ),
                  ),
                  const SizedBox(height: 16),

                  // -- Login link --
                  TextButton(
                    onPressed: isLoading ? null : () => Navigator.pop(context),
                    child: Text(l10n.hasAccount),
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

  void _onRegister() {
    if (_formKey.currentState?.validate() != true) return;

    context.read<AuthCubit>().register(
          _emailController.text,
          _passwordController.text,
        );
  }
}
