// =============================================================================
// Favorites Screen — list of favourite cities
// =============================================================================
//
// Demonstrates:
//  - StateNotifierProvider consumption (read the list, call notifier methods)
//  - Dismissible for swipe-to-remove with ref.read
//  - ref.watch vs ref.read — watch for reactive display, read for actions
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/l10n/app_localizations.dart';
import 'package:state_riverpod_tutorial/providers/weather_notifiers.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';
import 'package:state_riverpod_tutorial/screens/weather_detail_screen.dart';
import 'package:state_riverpod_tutorial/widgets/weather_card.dart';

// ---------------------------------------------------------------------------
// FavoritesScreen
// ---------------------------------------------------------------------------

/// Displays the user's favourite cities with weather summaries.
///
/// Swipe to remove a city from favourites. Tap to view detail.
class FavoritesScreen extends ConsumerWidget {
  /// Creates a [FavoritesScreen].
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    // ref.watch — rebuilds whenever the favourites list changes
    final favorites = ref.watch(favoriteCitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear all',
              onPressed: () {
                // Show confirmation dialog before clearing
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear all favorites?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Remove each city — we use ref.read because this
                          // is a one-shot action, not a reactive subscription.
                          for (final city in [...favorites]) {
                            ref
                                .read(favoriteCitiesProvider.notifier)
                                .removeCity(city.id);
                          }
                          Navigator.pop(ctx);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noFavorites,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final city = favorites[index];

                return Dismissible(
                  key: ValueKey(city.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    // ref.read — one-shot mutation, not a subscription
                    ref
                        .read(favoriteCitiesProvider.notifier)
                        .removeCity(city.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${city.name} removed'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            ref
                                .read(favoriteCitiesProvider.notifier)
                                .addCity(city);
                          },
                        ),
                      ),
                    );
                  },
                  child: WeatherCard(
                    cityId: city.id,
                    onTap: () {
                      ref.read(selectedCityIdProvider.notifier).state = city.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              WeatherDetailScreen(cityId: city.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
