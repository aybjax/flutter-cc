// =============================================================================
// Contact Form Screen — Create / Edit
// =============================================================================
// Concepts demonstrated:
// - Form validation with l10n error messages
// - Creating vs updating with Either results
// - Enum dropdowns with localized labels
// - freezed copyWith for building update payloads
// - dartz Either fold() for handling save results
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/models.dart';
import '../repositories/contact_repository.dart';

/// A form screen for creating or editing a [Contact].
///
/// If [existingContact] is null, creates a new contact.
/// If [existingContact] is provided, edits that contact.
///
/// Returns `true` via [Navigator.pop] if a save was made, so the
/// list screen knows to refresh.
class ContactFormScreen extends StatefulWidget {
  final ContactRepository repository;
  final Contact? existingContact;

  const ContactFormScreen({
    super.key,
    required this.repository,
    this.existingContact,
  });

  /// Whether we're editing an existing contact vs creating a new one.
  bool get isEditing => existingContact != null;

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  // -- Form key for validation --
  final _formKey = GlobalKey<FormState>();

  // -- Controllers (pre-populated for editing) --
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _notesController;

  /// Selected category (defaults to existing or "other").
  late ContactCategory _category;

  @override
  void initState() {
    super.initState();
    final c = widget.existingContact;
    _nameController = TextEditingController(text: c?.name ?? '');
    _emailController = TextEditingController(text: c?.email ?? '');
    _phoneController = TextEditingController(text: c?.phone ?? '');
    _notesController = TextEditingController(text: c?.notes ?? '');
    _category = c?.category ?? ContactCategory.other;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        // Dynamic title: "Add Contact" or "Edit Contact" based on mode
        title: Text(widget.isEditing ? l10n.editContact : l10n.addContact),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // -- Name field (required) --
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.name,
                  prefixIcon: const Icon(Icons.person),
                ),
                textCapitalization: TextCapitalization.words,
                // Validator returns null for valid, error string for invalid
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    // l10n.errorRequired → "This field is required"
                    return l10n.errorRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // -- Email field (optional, validated format) --
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(value)) {
                      return l10n.errorInvalidEmail;
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // -- Phone field --
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: l10n.phone,
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // -- Category dropdown --
              DropdownButtonFormField<ContactCategory>(
                initialValue: _category,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                ),
                items: ContactCategory.values.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(
                      '${cat.icon} ${_categoryLabel(cat, l10n)}',
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _category = value);
                  }
                },
              ),
              const SizedBox(height: 16),

              // -- Notes field (multi-line) --
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: l10n.notes,
                  prefixIcon: const Icon(Icons.notes),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // -- Save button --
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Save Logic — Either fold for error handling
  // ---------------------------------------------------------------------------

  void _save() {
    // Validate the form first
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;

    if (widget.isEditing) {
      // -- Update existing contact --
      // updateContact returns Either<ContactFailure, Contact>
      final result = widget.repository.updateContact(
        id: widget.existingContact!.id,
        name: _nameController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        category: _category,
      );

      // -- fold: handle Left (failure) and Right (success) --
      result.fold(
        (failure) => _showFailure(failure),
        (contact) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.contactSaved)),
          );
          Navigator.pop(context, true); // true = data changed
        },
      );
    } else {
      // -- Create new contact --
      final result = widget.repository.addContact(
        name: _nameController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        category: _category,
      );

      result.fold(
        (failure) => _showFailure(failure),
        (contact) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.contactSaved)),
          );
          Navigator.pop(context, true);
        },
      );
    }
  }

  /// Shows a snackbar with a failure message using freezed's [when].
  void _showFailure(ContactFailure failure) {
    // when() provides exhaustive pattern matching on the union variants.
    // The compiler ensures we handle every variant.
    final message = failure.when(
      notFound: (id) => 'Contact not found (id: $id)',
      validationError: (field, msg) => '$field: $msg',
      storageError: (msg) => 'Storage error: $msg',
      unexpected: (error) => 'Unexpected error: $error',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String _categoryLabel(ContactCategory cat, AppLocalizations l10n) {
    return switch (cat) {
      ContactCategory.family => l10n.categoryFamily,
      ContactCategory.friend => l10n.categoryFriend,
      ContactCategory.work   => l10n.categoryWork,
      ContactCategory.other  => l10n.categoryOther,
    };
  }
}
