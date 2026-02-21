// =============================================================================
// Todo Form Screen — Create/Edit with BlocConsumer
// =============================================================================
// Concepts demonstrated:
// - BlocConsumer for form submission with loading state
// - BlocListener for navigating back after successful save
// - Create vs Edit mode in the same screen
// - How the Cubit's Saved state triggers navigation
//
// This screen handles both creating new todos and editing existing ones.
// The mode is determined by whether existingTodo is provided.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/todo/todo_detail_cubit.dart';
import '../cubits/todo/todo_detail_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/models.dart';
import '../repositories/todo_repository.dart';

// =============================================================================
// Todo Form Screen
// =============================================================================

/// A form screen for creating or editing a todo.
///
/// If [existingTodo] is null, the form creates a new todo.
/// If [existingTodo] is provided, the form edits that todo.
///
/// Uses [TodoDetailCubit] for the save operation:
/// - Create: calls cubit.createTodo(title, description)
/// - Edit: calls cubit.updateTodo(id, title, description)
///
/// [BlocListener] watches for the Saved state to navigate back.
class TodoFormScreen extends StatelessWidget {
  /// The todo repository for creating the cubit.
  final TodoRepository todoRepository;

  /// The existing todo to edit, or null for create mode.
  final TodoDetail? existingTodo;

  const TodoFormScreen({
    super.key,
    required this.todoRepository,
    this.existingTodo,
  });

  /// Whether we're editing an existing todo (vs creating a new one).
  bool get isEditing => existingTodo != null;

  @override
  Widget build(BuildContext context) {
    // Create a new TodoDetailCubit for this form
    // In create mode, the cubit stays in Initial state
    // In edit mode, we don't need to loadTodo — we already have the data
    return BlocProvider(
      create: (_) => TodoDetailCubit(todoRepository: todoRepository),
      child: _TodoFormView(
        existingTodo: existingTodo,
        isEditing: isEditing,
      ),
    );
  }
}

/// The inner form view with access to TodoDetailCubit.
class _TodoFormView extends StatefulWidget {
  final TodoDetail? existingTodo;
  final bool isEditing;

  const _TodoFormView({
    required this.existingTodo,
    required this.isEditing,
  });

  @override
  State<_TodoFormView> createState() => _TodoFormViewState();
}

class _TodoFormViewState extends State<_TodoFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Pre-fill controllers with existing data for edit mode
    _titleController = TextEditingController(
      text: widget.existingTodo?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingTodo?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // =========================================================================
    // BlocConsumer for form:
    // - Builder: renders form, shows loading during save
    // - Listener: navigates back on Saved, shows error on Error
    // =========================================================================
    return BlocConsumer<TodoDetailCubit, TodoDetailState>(
      // -- Listener: side effects --
      listener: (context, state) {
        state.maybeWhen(
          saved: (todo) {
            // Show success snackbar and navigate back
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.todoSaved)),
            );
            Navigator.pop(context);
          },
          error: (failure) {
            // Show error snackbar
            final message = failure.when(
              network: (msg) => l10n.errorNetwork,
              server: (msg, _) => msg,
              unauthorized: () => l10n.errorUnauthorized,
              notFound: (id) => 'Todo #$id not found',
              validation: (field, msg) => msg,
              unexpected: (error) => l10n.errorServer,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },

      // -- Builder: render the form --
      builder: (context, state) {
        final isLoading = state is TodoDetailLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.isEditing ? l10n.editTodo : l10n.addTodo),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -- Title field --
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: l10n.title,
                      prefixIcon: const Icon(Icons.title),
                      border: const OutlineInputBorder(),
                    ),
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.errorRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // -- Description field --
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: l10n.description,
                      prefixIcon: const Icon(Icons.description),
                      border: const OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),

                  // -- Save button / loading indicator --
                  SizedBox(
                    height: 48,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : FilledButton.icon(
                            onPressed: _onSave,
                            icon: const Icon(Icons.save),
                            label: Text(l10n.save),
                          ),
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

  /// Validates the form and calls the appropriate cubit method.
  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;

    final cubit = context.read<TodoDetailCubit>();

    if (widget.isEditing) {
      // Edit mode: update the existing todo
      cubit.updateTodo(
        id: widget.existingTodo!.id,
        title: _titleController.text,
        description: _descriptionController.text,
      );
    } else {
      // Create mode: create a new todo
      cubit.createTodo(
        title: _titleController.text,
        description: _descriptionController.text,
      );
    }
  }
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Create vs Edit in one screen:
// - Same form UI, different cubit method called on save
// - existingTodo determines the mode
// - Controllers are pre-filled in edit mode
//
// Why BlocConsumer instead of just BlocBuilder?
// - We need the listener for navigation (pop) and snackbar
// - BlocBuilder alone can't do side effects
// - BlocConsumer = BlocBuilder + BlocListener in one widget
//
// Alternative: separate CreateTodoScreen and EditTodoScreen
// That works too, but leads to code duplication. The shared form
// pattern is more maintainable for simple CRUD apps.
//
// Form validation:
// - Client-side validation runs first (empty title)
// - If validation passes, the cubit makes the API call
// - Server-side validation errors come back as TodoFailure.validation
// - Both are shown to the user via snackbar
// =============================================================================
