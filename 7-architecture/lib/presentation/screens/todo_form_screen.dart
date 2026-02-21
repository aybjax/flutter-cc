// =============================================================================
// Todo Form Screen
// =============================================================================
// Handles both creating and editing todos. When todoId is null, it creates
// a new todo. When todoId is provided, it updates the existing one.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';

import '../cubits/todo/todo_cubit.dart';
import '../cubits/todo/todo_state.dart';

// ---------------------------------------------------------------------------
// TodoFormScreen
// ---------------------------------------------------------------------------

/// Create or edit a todo.
///
/// In create mode ([todoId] is null), it calls [TodoCubit.createTodo].
/// In edit mode ([todoId] is provided), it calls [TodoCubit.updateTodo].
///
/// Pre-populates fields with [initialTitle] and [initialDescription]
/// when editing an existing todo.
class TodoFormScreen extends StatefulWidget {
  /// If non-null, we're editing an existing todo.
  final int? todoId;

  /// Pre-populated title (for edit mode).
  final String? initialTitle;

  /// Pre-populated description (for edit mode).
  final String? initialDescription;

  /// Creates a [TodoFormScreen].
  const TodoFormScreen({
    super.key,
    this.todoId,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  // ---------------------------------------------------------------------------
  // Form state
  // ---------------------------------------------------------------------------

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  /// Whether we're in edit mode.
  bool get _isEditing => widget.todoId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editTodo : l10n.addTodo),
      ),
      body: BlocListener<TodoCubit, TodoState>(
        listener: (context, state) {
          // Show error if something went wrong
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---------------------------------------------------------------------------
                // Title field
                // ---------------------------------------------------------------------------
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: l10n.title,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.title),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ---------------------------------------------------------------------------
                // Description field
                // ---------------------------------------------------------------------------
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: l10n.description,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.description),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 24),

                // ---------------------------------------------------------------------------
                // Submit button
                // ---------------------------------------------------------------------------
                BlocBuilder<TodoCubit, TodoState>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

                    return FilledButton.icon(
                      onPressed: isLoading ? null : _submit,
                      icon: isLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.save),
                      label: Text(l10n.save),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// Validates the form and creates or updates the todo.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final cubit = context.read<TodoCubit>();

    bool success;

    if (_isEditing) {
      success = await cubit.updateTodo(
        id: widget.todoId!,
        title: title,
        description: description,
      );
    } else {
      success = await cubit.createTodo(
        title: title,
        description: description,
      );
    }

    // Navigate back on success
    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  // Alternative: use a separate controller class
  // class TodoFormController {
  //   final TodoCubit _cubit;
  //   Future<bool> submit(String title, String description) async { ... }
  // }
}
