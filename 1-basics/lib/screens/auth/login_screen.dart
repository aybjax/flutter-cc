// =============================================================================
// Login Screen
// =============================================================================
// Concepts demonstrated:
// - Form widget — groups TextFormFields and enables validation
// - TextFormField / TextField — all important fields documented
// - FocusNode — managing keyboard focus between fields
// - GlobalKey<FormState> — accessing form state for validation
// - Form validation pattern: validator → validate() → save()
// - ElevatedButton, TextButton, OutlinedButton with full style overrides
// - Navigator.pushReplacementNamed — replacing current route
// - SingleChildScrollView — prevents overflow when keyboard opens
// - const constructors — compile-time constant widgets for performance
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/route_names.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/loading_overlay.dart';

/// The login screen with email and password fields.
///
/// Demonstrates the full [Form] + [TextFormField] pattern with validation,
/// focus management, and provider integration.
class LoginScreen extends StatefulWidget {
  /// Creates the login screen.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ---------------------------------------------------------------------------
  // Form key
  // ---------------------------------------------------------------------------

  /// A GlobalKey uniquely identifies the Form widget and lets us call
  /// _formKey.currentState!.validate() to trigger all validators.
  final _formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Controllers
  // ---------------------------------------------------------------------------

  /// TextEditingController gives you access to the text field's value
  /// and lets you set it programmatically.
  ///
  /// Must be disposed in dispose() to free resources.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Focus nodes
  // ---------------------------------------------------------------------------

  /// FocusNode tracks and controls keyboard focus for a text field.
  ///
  /// Used to:
  /// - Move focus to the next field when the user presses Enter
  /// - Programmatically focus a field (e.g., after an error)
  /// - Listen for focus changes
  ///
  /// Must be disposed in dispose().
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // ---------------------------------------------------------------------------
  // Local state
  // ---------------------------------------------------------------------------

  /// Whether to hide the password text.
  bool _obscurePassword = true;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void dispose() {
    // Always dispose controllers and focus nodes.
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// Validates the form and attempts login.
  Future<void> _submit() async {
    // validate() runs each TextFormField's validator function.
    // Returns true if ALL validators pass.
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, RouteNames.home);
    } else {
      CustomSnackBar.showError(
        context,
        message: authProvider.errorMessage ?? 'Login failed',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // SingleChildScrollView prevents overflow when the keyboard opens.
        // Without it, the form fields would be pushed off-screen and Flutter
        // would show a yellow/black overflow stripe.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          // Center + ConstrainedBox limits the form width on wide screens
          // (e.g., macOS, tablets, web). Without this, fields stretch
          // edge-to-edge which looks bad on large displays.
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return LoadingOverlay(
                isLoading: authProvider.isLoading,
                child: Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // ↑ Validates as the user types (can be annoying).
                  //   Default is AutovalidateMode.disabled — only on submit.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),

                      // -- App logo with Hero for transition from splash --
                      Hero(
                        tag: 'app_logo',
                        child: Icon(
                          Icons.check_circle_outline,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // -- Title --
                      Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // =====================================================
                      // Email TextFormField
                      // =====================================================
                      // TextFormField is a TextField wrapped in a FormField,
                      // which adds validation support via the `validator`
                      // callback.
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,

                        // -- Input behavior --
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                        // autofocus: false,       // Auto-focus on screen open
                        // autofillHints: [AutofillHints.email], // Autofill
                        // enableSuggestions: true, // Keyboard suggestions
                        // readOnly: false,         // Prevents editing
                        // enabled: true,           // Greys out when false
                        // maxLength: 100,          // Shows character counter
                        // maxLines: 1,             // Single line (default)
                        // minLines: 1,             // Minimum visible lines
                        // expands: false,          // Fill available height
                        // obscureText: false,      // Hide text (for passwords)
                        // textCapitalization: TextCapitalization.none,

                        // -- Appearance --
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'you@example.com',
                          prefixIcon: Icon(Icons.email_outlined),
                          // suffixIcon: ...,       // Icon after text
                          // helperText: '...',     // Text below the field
                          // counterText: '',       // Override character counter
                          // errorText: '...',      // Manually show error
                          // filled: true,          // From theme
                          // fillColor: ...,        // From theme
                          // border: ...,           // From theme
                          // enabledBorder: ...,    // From theme
                          // focusedBorder: ...,    // From theme
                          // errorBorder: ...,      // From theme
                        ),
                        // cursorColor: ...,        // Cursor color
                        // cursorWidth: 2.0,        // Cursor thickness
                        // cursorHeight: ...,       // Cursor height
                        // cursorRadius: ...,       // Cursor corner radius
                        // showCursor: true,        // Whether to show cursor
                        // style: ...,              // Text style inside field

                        // -- Callbacks --
                        // onChanged: (value) {},   // Called on every keystroke
                        // onTap: () {},            // Called when field is tapped
                        // onTapOutside: (event) {},// Called when tapping outside
                        onFieldSubmitted: (_) {
                          // When the user presses the keyboard's "Next" button,
                          // move focus to the password field.
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },

                        // -- Validation --
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null; // null means valid
                        },
                      ),
                      const SizedBox(height: 16),

                      // =====================================================
                      // Password TextFormField
                      // =====================================================
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          // suffixIcon toggles password visibility.
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        onFieldSubmitted: (_) => _submit(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 3) {
                            return 'Password must be at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // =====================================================
                      // Login Button (ElevatedButton)
                      // =====================================================
                      // ElevatedButton — the primary action button with
                      // elevation (shadow).
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: authProvider.isLoading ? null : _submit,
                          // Passing null to onPressed disables the button.
                          // This prevents double-submits while loading.

                          // Style overrides for this specific button.
                          // These merge with the theme's elevatedButtonTheme.
                          // style: ElevatedButton.styleFrom(
                          //   foregroundColor: ...,    // Text/icon color
                          //   backgroundColor: ...,    // Button background
                          //   disabledForegroundColor: ..., // When disabled
                          //   disabledBackgroundColor: ..., // When disabled
                          //   shadowColor: ...,        // Shadow color
                          //   elevation: ...,          // Shadow depth
                          //   padding: ...,            // Internal padding
                          //   minimumSize: ...,        // Minimum dimensions
                          //   maximumSize: ...,        // Maximum dimensions
                          //   fixedSize: ...,          // Exact dimensions
                          //   side: ...,               // Border
                          //   shape: ...,              // Border shape
                          //   textStyle: ...,          // Text style
                          //   tapTargetSize: ...,      // Touch area
                          //   animationDuration: ...,  // Press animation
                          //   enableFeedback: ...,     // Haptic feedback
                          //   alignment: ...,          // Child alignment
                          //   splashFactory: ...,      // Ripple style
                          // ),

                          child: const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // =====================================================
                      // Register Link (TextButton)
                      // =====================================================
                      // TextButton — a flat button without elevation.
                      // Used for less prominent actions.
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.register,
                          );
                        },
                        child: const Text("Don't have an account? Register"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
            ),
          ),
        ),
      ),
    );
  }
}
