// =============================================================================
// News Category Model
// =============================================================================
// Concepts demonstrated:
// - Dart enum with fields and methods (enhanced enums)
// - Enum constructors — each variant carries display data
// - IconData association — mapping categories to Material icons
// - fromName factory — safe lookup by string name
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Enhanced Enum
// -----------------------------------------------------------------------------
// Dart 2.17+ allows enums to have fields, constructors, and methods.
// This is perfect for categories that need display metadata.

/// Represents a news article category.
///
/// Each category carries a display [label] and an [icon] for the UI.
/// This avoids scattering category metadata across multiple files.
enum NewsCategory {
  /// Technology and software news.
  tech('Technology', Icons.computer),

  /// Sports and athletics news.
  sports('Sports', Icons.sports_soccer),

  /// Science and research news.
  science('Science', Icons.science),

  /// Health and wellness news.
  health('Health', Icons.health_and_safety),

  /// Business and finance news.
  business('Business', Icons.business),

  /// Entertainment and culture news.
  entertainment('Entertainment', Icons.movie);

  // ---------------------------------------------------------------------------
  // Enum fields and constructor
  // ---------------------------------------------------------------------------

  /// Human-readable display name for this category.
  final String label;

  /// Material icon associated with this category.
  final IconData icon;

  /// Creates a category with its display [label] and [icon].
  ///
  /// This constructor is called once per enum variant at compile time.
  const NewsCategory(this.label, this.icon);

  // ---------------------------------------------------------------------------
  // Lookup factory
  // ---------------------------------------------------------------------------

  /// Finds a [NewsCategory] by its [name] string.
  ///
  /// Returns null if no matching category is found.
  /// This is useful when parsing category names from URLs or JSON.
  ///
  /// Example:
  /// ```dart
  /// final cat = NewsCategory.fromName('tech'); // NewsCategory.tech
  /// final bad = NewsCategory.fromName('xyz');  // null
  /// ```
  static NewsCategory? fromName(String name) {
    // values is the auto-generated list of all enum variants
    for (final category in values) {
      if (category.name == name) return category;
    }
    return null;

    // Alternative: using firstWhereOrNull from collection:
    // return values.firstWhereOrNull((c) => c.name == name);
  }
}
