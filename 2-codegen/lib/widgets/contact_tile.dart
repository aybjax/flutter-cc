// =============================================================================
// Contact Tile Widget
// =============================================================================
// Concepts demonstrated:
// - Displaying freezed model data in a ListTile
// - Accessing generated fields (category enum, nullable fields)
// - Callback pattern for parent communication (onTap, onFavoriteToggle)
// =============================================================================

import 'package:flutter/material.dart';
import '../models/models.dart';

/// A single contact row in the contact list.
///
/// This is a "dumb" widget — it receives data and callbacks from its parent.
/// It doesn't know about the repository or state management.
class ContactTile extends StatelessWidget {
  /// The contact to display.
  ///
  /// This is a freezed model, so it's immutable and has value equality.
  /// Two ContactTiles with the same contact will render identically.
  final Contact contact;

  /// Called when the tile is tapped (navigates to edit form).
  final VoidCallback onTap;

  /// Called when the favorite icon is tapped.
  final VoidCallback onFavoriteToggle;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // -- Leading: category icon in a colored circle --
      leading: CircleAvatar(
        backgroundColor: _categoryColor(contact.category),
        child: Text(
          // contact.category is the enum value — .icon comes from our extension
          contact.category.icon,
          style: const TextStyle(fontSize: 20),
        ),
      ),

      // -- Title: contact name --
      title: Text(
        contact.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      // -- Subtitle: email or phone (nullable fields) --
      // The ?. operator safely accesses nullable fields.
      // The ?? operator provides a fallback.
      subtitle: Text(
        contact.email ?? contact.phone ?? '',
        style: TextStyle(color: Colors.grey[600]),
      ),

      // -- Trailing: favorite toggle --
      trailing: IconButton(
        icon: Icon(
          contact.isFavorite ? Icons.star : Icons.star_border,
          color: contact.isFavorite ? Colors.amber : Colors.grey,
        ),
        onPressed: onFavoriteToggle,
      ),

      onTap: onTap,
    );
  }

  // -- Helper: color for each category --
  Color _categoryColor(ContactCategory category) {
    return switch (category) {
      ContactCategory.family => Colors.blue[100]!,
      ContactCategory.friend => Colors.green[100]!,
      ContactCategory.work   => Colors.orange[100]!,
      ContactCategory.other  => Colors.grey[200]!,
    };
  }
}
