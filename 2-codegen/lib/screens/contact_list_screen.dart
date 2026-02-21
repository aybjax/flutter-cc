// =============================================================================
// Contact List Screen — Main UI
// =============================================================================
// Concepts demonstrated:
// - Using l10n (AppLocalizations) for all user-facing strings
// - Displaying dartz Either results in the UI
// - Working with freezed models (accessing fields, using copyWith)
// - Search filtering with debounce-like behavior
// - Dismissible for swipe-to-delete
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/models.dart';
import '../repositories/contact_repository.dart';
import 'contact_form_screen.dart';
import '../widgets/contact_tile.dart';

/// The main screen showing a list of all contacts.
///
/// Demonstrates:
/// - [AppLocalizations] for localized strings
/// - [ContactRepository] returning [Either] results
/// - [Contact] freezed model with value equality
class ContactListScreen extends StatefulWidget {
  /// The shared repository instance (passed in to demonstrate DI basics).
  final ContactRepository repository;

  const ContactListScreen({super.key, required this.repository});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  /// Current search query for filtering contacts.
  String _searchQuery = '';

  /// Currently selected category filter (null = show all).
  ContactCategory? _selectedCategory;

  /// Whether to show only favorites.
  bool _showFavoritesOnly = false;

  // -- Computed property: filtered contact list --
  List<Contact> get _filteredContacts => widget.repository.getAllContacts(
    category: _selectedCategory,
    favoritesOnly: _showFavoritesOnly ? true : null,
    searchQuery: _searchQuery,
  );

  @override
  Widget build(BuildContext context) {
    // -- l10n: Access localized strings --
    // AppLocalizations.of(context) returns the generated class with all
    // your translated strings. The ! operator asserts non-null because
    // we've set up localizationsDelegates in MaterialApp.
    final l10n = AppLocalizations.of(context)!;
    final contacts = _filteredContacts;

    return Scaffold(
      appBar: AppBar(
        // l10n.appTitle → "Contact Book" (en) / "Agenda de Contactos" (es)
        title: Text(l10n.appTitle),
        actions: [
          // -- Favorites toggle --
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : null,
            ),
            // l10n.favorites → "Favorites" / "Favoritos"
            tooltip: l10n.favorites,
            onPressed: () => setState(() {
              _showFavoritesOnly = !_showFavoritesOnly;
            }),
          ),
          // -- Settings (language switcher) --
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () => _showSettingsDialog(context, l10n),
          ),
        ],
      ),
      body: Column(
        children: [
          // -- Search bar --
          _buildSearchBar(l10n),
          // -- Category filter chips --
          _buildCategoryChips(l10n),
          // -- Contact count --
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              // l10n.contactsCount — demonstrates ICU plural rules:
              // =0 → "No contacts" / "Sin contactos"
              // =1 → "1 contact" / "1 contacto"
              // other → "{count} contacts" / "{count} contactos"
              child: Text(
                l10n.contactsCount(contacts.length),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          // -- Contact list --
          Expanded(
            child: contacts.isEmpty
                ? Center(
                    child: Text(
                      l10n.noContactsYet,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return _buildContactItem(context, contact, l10n);
                    },
                  ),
          ),
        ],
      ),
      // -- FAB to add new contact --
      floatingActionButton: FloatingActionButton(
        // l10n.addContact → "Add Contact" / "Agregar Contacto"
        tooltip: l10n.addContact,
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search Bar
  // ---------------------------------------------------------------------------

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          // l10n.search → "Search contacts..." / "Buscar contactos..."
          hintText: l10n.search,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // Clear button appears when there's text
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => _searchQuery = ''),
                )
              : null,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Category Filter Chips
  // ---------------------------------------------------------------------------

  Widget _buildCategoryChips(AppLocalizations l10n) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(l10n.all),
              selected: _selectedCategory == null,
              onSelected: (_) => setState(() => _selectedCategory = null),
            ),
          ),
          // One chip per category
          ...ContactCategory.values.map((cat) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text('${cat.icon} ${_categoryLabel(cat, l10n)}'),
                selected: _selectedCategory == cat,
                onSelected: (_) => setState(() {
                  _selectedCategory = _selectedCategory == cat ? null : cat;
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Contact List Item with Dismissible
  // ---------------------------------------------------------------------------

  Widget _buildContactItem(
    BuildContext context,
    Contact contact,
    AppLocalizations l10n,
  ) {
    // Dismissible wraps the tile to enable swipe-to-delete
    return Dismissible(
      key: ValueKey(contact.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      // -- Confirm before deleting --
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.deleteContact),
            // l10n.confirmDelete with interpolation:
            // "Are you sure you want to delete {name}?" / "¿Estás seguro...?"
            content: Text(l10n.confirmDelete(contact.name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.deleteContact),
              ),
            ],
          ),
        );
      },
      // -- Perform the delete --
      onDismissed: (_) {
        // deleteContact returns Either<ContactFailure, Unit>
        final result = widget.repository.deleteContact(contact.id);

        // fold: handle both Left (failure) and Right (success)
        result.fold(
          (failure) {
            // Using freezed's when() to get a user-friendly message
            final message = failure.when(
              notFound: (id) => 'Contact not found',
              validationError: (field, msg) => msg,
              storageError: (msg) => msg,
              unexpected: (error) => 'Unexpected error: $error',
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          (_) {
            // Success — show confirmation and refresh
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.contactDeleted)),
            );
            setState(() {}); // Refresh the list
          },
        );
      },
      child: ContactTile(
        contact: contact,
        onTap: () => _navigateToForm(context, contact: contact),
        onFavoriteToggle: () {
          // toggleFavorite returns Either<ContactFailure, Contact>
          widget.repository.toggleFavorite(contact.id);
          setState(() {}); // Refresh to show updated star icon
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  Future<void> _navigateToForm(
    BuildContext context, {
    Contact? contact,
  }) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ContactFormScreen(
          repository: widget.repository,
          existingContact: contact,
        ),
      ),
    );

    // If the form returned true, refresh the list
    if (result == true) {
      setState(() {});
    }
  }

  // ---------------------------------------------------------------------------
  // Settings Dialog (Language Switcher)
  // ---------------------------------------------------------------------------

  void _showSettingsDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settings),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.language),
              subtitle: const Text('Change app language'),
            ),
            // Language options
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              onTap: () {
                _changeLocale(context, const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Text('🇪🇸'),
              title: const Text('Español'),
              onTap: () {
                _changeLocale(context, const Locale('es'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changeLocale(BuildContext context, Locale locale) {
    // This calls the callback in main.dart to change the locale.
    // In a real app, you'd use a state management solution.
    final state = context.findAncestorStateOfType<_AppLocaleState>();
    state?.setLocale(locale);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns the localized label for a [ContactCategory].
  String _categoryLabel(ContactCategory cat, AppLocalizations l10n) {
    return switch (cat) {
      ContactCategory.family => l10n.categoryFamily,
      ContactCategory.friend => l10n.categoryFriend,
      ContactCategory.work   => l10n.categoryWork,
      ContactCategory.other  => l10n.categoryOther,
    };
  }
}

// =============================================================================
// App Locale State (referenced from main.dart)
// =============================================================================
// This mixin/state is used by the language switcher. It's defined here
// but the actual StatefulWidget is in main.dart. We expose just the type
// so findAncestorStateOfType can locate it.

/// Mixin that main.dart's state implements to allow locale changes.
mixin AppLocaleStateMixin<T extends StatefulWidget> on State<T> {
  void setLocale(Locale locale);
}

/// Type alias for findAncestorStateOfType (see _changeLocale above).
typedef _AppLocaleState = AppLocaleStateMixin;
