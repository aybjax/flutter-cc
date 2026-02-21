// =============================================================================
// screens/card_form_screen.dart — Form for creating/editing cards
// =============================================================================
//
// A full-screen form for creating a new Kanban card. Includes:
//   - Title text field (required)
//   - Description text field (optional)
//   - Column selection dropdown
//   - Validation with error messages
//
// The form uses a callback pattern — the parent screen provides an [onSave]
// callback that is called with the form data when the user taps Save.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:grpc_tutorial/l10n/app_localizations.dart';
import 'package:grpc_tutorial/models/models.dart';

// ---------------------------------------------------------------------------
// CardFormScreen
// ---------------------------------------------------------------------------

/// Full-screen form for creating a new Kanban card.
///
/// Requires a list of [columns] to populate the column dropdown, and an
/// [onSave] callback that receives the column ID, title, and description.
///
/// ## Usage:
/// ```dart
/// Navigator.push(context, MaterialPageRoute(
///   builder: (_) => CardFormScreen(
///     boardId: 'board_1',
///     columns: board.columns,
///     onSave: (columnId, title, description) {
///       cubit.createCard(columnId: columnId, title: title, description: description);
///     },
///   ),
/// ));
/// ```
class CardFormScreen extends StatefulWidget {
  /// The ID of the board this card belongs to.
  final String boardId;

  /// Available columns for the dropdown selector.
  final List<BoardColumn> columns;

  /// Callback invoked when the user saves the form.
  final void Function(String columnId, String title, String description) onSave;

  /// Optional existing card data for editing (null for create mode).
  final TaskCard? existingCard;

  const CardFormScreen({
    super.key,
    required this.boardId,
    required this.columns,
    required this.onSave,
    this.existingCard,
  });

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late String _selectedColumnId;

  @override
  void initState() {
    super.initState();

    // Pre-fill with existing card data if editing
    _titleController = TextEditingController(
      text: widget.existingCard?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingCard?.description ?? '',
    );

    // Default to the first column, or the card's current column if editing
    _selectedColumnId = widget.existingCard?.columnId ??
        (widget.columns.isNotEmpty ? widget.columns.first.id : '');
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
    final isEditing = widget.existingCard != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editCard : l10n.createCard),
        actions: [
          // Save button in the app bar
          TextButton(
            onPressed: _handleSave,
            child: Text(l10n.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // -----------------------------------------------------------------
            // Title field
            // -----------------------------------------------------------------
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.cardTitle,
                hintText: 'Enter task title...',
                border: const OutlineInputBorder(),
                // Alternative: use a filled style
                // filled: true,
              ),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.titleRequired;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // -----------------------------------------------------------------
            // Description field
            // -----------------------------------------------------------------
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.cardDescription,
                hintText: 'Describe the task...',
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),

            const SizedBox(height: 16),

            // -----------------------------------------------------------------
            // Column selection dropdown
            // -----------------------------------------------------------------
            DropdownButtonFormField<String>(
              // Using `initialValue` instead of deprecated `value`
              initialValue: _selectedColumnId,
              decoration: InputDecoration(
                labelText: l10n.selectColumn,
                border: const OutlineInputBorder(),
              ),
              items: widget.columns.map((column) {
                return DropdownMenuItem<String>(
                  value: column.id,
                  child: Text(column.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedColumnId = value;
                  });
                }
              },
            ),

            const SizedBox(height: 32),

            // -----------------------------------------------------------------
            // Save button (alternative to app bar button)
            // -----------------------------------------------------------------
            FilledButton.icon(
              onPressed: _handleSave,
              icon: const Icon(Icons.save),
              label: Text(l10n.save),
            ),

            // Alternative: cancel button
            // const SizedBox(height: 8),
            // OutlinedButton(
            //   onPressed: () => Navigator.of(context).pop(),
            //   child: Text(l10n.cancel),
            // ),
          ],
        ),
      ),
    );
  }

  /// Validates the form and calls the [onSave] callback.
  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(
        _selectedColumnId,
        _titleController.text.trim(),
        _descriptionController.text.trim(),
      );
      Navigator.of(context).pop();
    }
  }
}
