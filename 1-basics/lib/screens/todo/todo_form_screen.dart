// =============================================================================
// Todo Form Screen (Create / Edit)
// =============================================================================
// Concepts demonstrated:
// - Dual-purpose form — same screen for creating and editing
// - Pre-populating fields when editing (TextEditingController.text = ...)
// - Form validation with GlobalKey<FormState>
// - Navigator.pop with result — returning success/failure to caller
// - File picker integration placeholder (actual integration in Commit 14)
// - Conditional UI based on whether we're creating or editing
// - The icon_url limitation: backend expects a URL, not uploaded file bytes
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/todo_detail.dart';
import '../../providers/auth_provider.dart';
import '../../services/file_service.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/loading_overlay.dart';

/// A form screen for creating or editing a todo.
///
/// If [existingTodo] is provided (via Navigator arguments), the form
/// pre-populates with the todo's data and performs an update on submit.
/// Otherwise, it creates a new todo.
///
/// Note about icon_url: The backend expects a publicly accessible URL for
/// the todo's icon image. It downloads the image from that URL, processes
/// it, and stores it. This means you can't directly upload file bytes —
/// you need to provide a URL to an image hosted somewhere. The file picker
/// can select local files, but for this backend you'd need to upload them
/// to a hosting service first. For this tutorial, the icon_url field
/// accepts a direct URL string.
class TodoFormScreen extends StatefulWidget {
  /// The existing todo to edit, or null for creating a new one.
  final TodoDetail? existingTodo;

  /// Creates the todo form screen.
  const TodoFormScreen({super.key, this.existingTodo});

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  // ---------------------------------------------------------------------------
  // Form state
  // ---------------------------------------------------------------------------

  /// Form key for validation.
  final _formKey = GlobalKey<FormState>();

  /// Controllers for each text field.
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _iconUrlController;

  /// Focus nodes for field navigation.
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _iconUrlFocusNode = FocusNode();

  /// Whether we're in edit mode (vs create mode).
  bool get _isEditing => widget.existingTodo != null;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    // Initialize controllers.
    // If editing, pre-populate with existing data.
    _titleController = TextEditingController(
      text: widget.existingTodo?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingTodo?.description ?? '',
    );
    _iconUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _iconUrlController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _iconUrlFocusNode.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// Opens the file picker to select an image.
  Future<void> _pickFile() async {
    try {
      final fileService = FileService();
      final path = await fileService.pickFile();
      if (!mounted) return;
      if (path != null) {
        CustomSnackBar.show(
          context,
          message: 'Selected: ${path.split('/').last}',
        );
      }
    } catch (e) {
      if (!mounted) return;
      CustomSnackBar.showError(
        context,
        message: 'File picker error: $e',
      );
    }
  }

  /// Validates and submits the form.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    if (authProvider.token == null) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final iconUrl =
        _iconUrlController.text.trim().isNotEmpty
            ? _iconUrlController.text.trim()
            : null;

    bool success;

    if (_isEditing) {
      // Update existing todo.
      success = await todoProvider.updateTodo(
        authProvider.token!,
        widget.existingTodo!.id,
        title: title,
        description: description,
        iconUrl: iconUrl,
      );
    } else {
      // Create new todo.
      success = await todoProvider.addTodo(
        authProvider.token!,
        title: title,
        description: description,
        iconUrl: iconUrl,
      );
    }

    if (!mounted) return;

    if (success) {
      CustomSnackBar.showSuccess(
        context,
        message: _isEditing ? 'Todo updated' : 'Todo created',
      );
      // Pop with true to signal success to the caller.
      Navigator.pop(context, true);
    } else {
      CustomSnackBar.showError(
        context,
        message: todoProvider.errorMessage ?? 'Operation failed',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Todo' : 'New Todo'),
      ),
      body: SafeArea(
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return LoadingOverlay(
              isLoading: todoProvider.isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // -- Title field --
                      TextFormField(
                        controller: _titleController,
                        focusNode: _titleFocusNode,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'What needs to be done?',
                          prefixIcon: Icon(Icons.title),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // -- Description field (multi-line) --
                      TextFormField(
                        controller: _descriptionController,
                        focusNode: _descriptionFocusNode,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 5, // Shows 5 lines at once
                        minLines: 3, // Starts with 3 lines
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Add some details...',
                          prefixIcon: Icon(Icons.description),
                          alignLabelWithHint: true, // Align label to top
                        ),
                      ),
                      const SizedBox(height: 16),

                      // -- Icon URL field --
                      // Note: The backend expects a URL to an image, not
                      // file bytes. If you want to use a local file, you'd
                      // need to upload it to a hosting service first and
                      // provide the URL here.
                      TextFormField(
                        controller: _iconUrlController,
                        focusNode: _iconUrlFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          labelText: 'Image URL (optional)',
                          hintText: 'https://example.com/image.png',
                          prefixIcon: Icon(Icons.image),
                          helperText:
                              'Provide a URL to an image for the todo icon',
                        ),
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      const SizedBox(height: 32),

                      // -- File picker button --
                      // Note: The backend expects a URL, not file bytes.
                      // This picker selects a local file and shows the path,
                      // but can't directly upload to this backend.
                      OutlinedButton.icon(
                        onPressed: _pickFile,
                        icon: const Icon(Icons.attach_file),
                        label: const Text('Pick Image File'),
                      ),
                      const SizedBox(height: 24),

                      // -- Submit button --
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: todoProvider.isLoading ? null : _submit,
                          child: Text(_isEditing ? 'Save Changes' : 'Create Todo'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
