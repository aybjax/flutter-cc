// =============================================================================
// Category Screen
// =============================================================================
//
// Manages expense categories stored in Isar. Demonstrates:
// - Isar CRUD operations via CategoryDao
// - Reactive UI updates with watchLazy()
// - Color and icon selection
// - Isar collection queries
// =============================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../models/category.dart';
import '../storage/isar/category_dao.dart';

// ---------------------------------------------------------------------------
// Category Screen
// ---------------------------------------------------------------------------

/// Screen for managing expense categories stored in Isar.
///
/// Features:
/// - List all categories with color indicators
/// - Add/edit categories with name, color, and icon
/// - Delete categories
/// - Reactive updates via Isar watchLazy()
class CategoryScreen extends StatefulWidget {
  /// Called when categories change (for parent refresh)
  final VoidCallback? onChanged;

  const CategoryScreen({super.key, this.onChanged});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryDao _categoryDao = CategoryDao();
  List<Category> _categories = [];
  bool _isLoading = true;
  StreamSubscription<void>? _watchSubscription;

  // Available colors for category selection
  static const List<Color> _availableColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
  ];

  // Available icons for category selection
  static const List<IconData> _availableIcons = [
    Icons.restaurant,
    Icons.directions_car,
    Icons.shopping_cart,
    Icons.receipt,
    Icons.movie,
    Icons.local_hospital,
    Icons.school,
    Icons.home,
    Icons.flight,
    Icons.fitness_center,
    Icons.pets,
    Icons.coffee,
    Icons.phone_android,
    Icons.wifi,
    Icons.child_care,
    Icons.more_horiz,
  ];

  @override
  void initState() {
    super.initState();
    _loadCategories();

    // Subscribe to Isar watchLazy() for reactive updates
    // This fires whenever any category is added, updated, or deleted
    _watchSubscription = _categoryDao.watchCategories().listen((_) {
      _loadCategories();
    });
  }

  @override
  void dispose() {
    _watchSubscription?.cancel();
    super.dispose();
  }

  /// Loads all categories from Isar.
  Future<void> _loadCategories() async {
    final categories = await _categoryDao.getAllCategories();
    if (!mounted) return;

    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_categories.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.category_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(l10n.noCategories),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _showCategoryDialog(),
              icon: const Icon(Icons.add),
              label: Text(l10n.addCategory),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(category.colorValue),
              child: Icon(
                IconData(category.iconCode, fontFamily: 'MaterialIcons'),
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(category.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => _showCategoryDialog(category: category),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _deleteCategory(category),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Shows a dialog for creating or editing a category.
  Future<void> _showCategoryDialog({Category? category}) async {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = category != null;

    final nameController = TextEditingController(
      text: category?.name ?? '',
    );
    var selectedColor = category != null
        ? Color(category.colorValue)
        : _availableColors[0];
    var selectedIcon = category != null
        ? IconData(category.iconCode, fontFamily: 'MaterialIcons')
        : _availableIcons[0];

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? l10n.editCategory : l10n.addCategory),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category name
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: l10n.categoryName,
                        border: const OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),

                    const SizedBox(height: 16),

                    // Color selection
                    Text(
                      l10n.categoryColor,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableColors.map((color) {
                        final isSelected = color.toARGB32() == selectedColor.toARGB32();
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() => selectedColor = color);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      width: 3,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Icon selection
                    Text(
                      l10n.categoryIcon,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableIcons.map((icon) {
                        final isSelected =
                            icon.codePoint == selectedIcon.codePoint;
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() => selectedIcon = icon);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? selectedColor.withValues(alpha: 0.2)
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                              border: isSelected
                                  ? Border.all(color: selectedColor, width: 2)
                                  : Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant,
                                    ),
                            ),
                            child: Icon(icon, size: 20),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(l10n.save),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true && nameController.text.trim().isNotEmpty) {
      final cat = category ?? Category();
      cat
        ..name = nameController.text.trim()
        ..colorValue = selectedColor.toARGB32()
        ..iconCode = selectedIcon.codePoint
        ..sortKey = nameController.text.trim();

      if (isEditing) {
        cat.id = category.id;
      }

      await _categoryDao.saveCategory(cat);
      widget.onChanged?.call();
    }

    nameController.dispose();
  }

  /// Deletes a category after confirmation.
  Future<void> _deleteCategory(Category category) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(l10n.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _categoryDao.deleteCategory(category.id);
      widget.onChanged?.call();
    }
  }
}
