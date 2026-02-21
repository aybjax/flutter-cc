// =============================================================================
// City Search Screen — search for cities by name
// =============================================================================
//
// Demonstrates:
//  - StateProvider for the search query
//  - FutureProvider that auto-reruns when the query changes
//  - ref.read for one-shot writes (updating the query)
//  - Debouncing searches to avoid excessive API calls
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/l10n/app_localizations.dart';
import 'package:state_riverpod_tutorial/data/mock_weather.dart';
import 'package:state_riverpod_tutorial/providers/weather_notifiers.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';
import 'package:state_riverpod_tutorial/screens/weather_detail_screen.dart';

// ---------------------------------------------------------------------------
// CitySearchScreen
// ---------------------------------------------------------------------------

/// Allows the user to search for cities and view their weather.
///
/// Uses [ConsumerStatefulWidget] because we need a [TextEditingController]
/// with dispose lifecycle.
class CitySearchScreen extends ConsumerStatefulWidget {
  /// Creates a [CitySearchScreen].
  const CitySearchScreen({super.key});

  @override
  ConsumerState<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends ConsumerState<CitySearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Watch the search results (reactive: updates when query changes)
    final asyncResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.search),
      ),
      body: Column(
        children: [
          // -----------------------------------------------------------------
          // Search text field
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: l10n.searchCity,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                // Clear button
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    // ref.read for a one-shot write — doesn't cause this
                    // widget to rebuild (ref.watch would).
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                ),
              ),
              onChanged: (value) {
                // Update the search query provider; the searchResultsProvider
                // watches it and re-runs automatically.
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),

          // -----------------------------------------------------------------
          // Results list
          // -----------------------------------------------------------------
          Expanded(
            child: asyncResults.when(
              // Data state — show matching cities
              data: (cities) {
                if (cities.isEmpty && _controller.text.length >= 2) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(l10n.cityNotFound),
                      ],
                    ),
                  );
                }

                if (cities.isEmpty) {
                  // Show all available cities when no search query
                  return _buildAllCitiesList(context);
                }

                return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    final isFav = ref
                        .watch(favoriteCitiesProvider)
                        .any((c) => c.id == city.id);

                    return ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(city.name),
                      subtitle: Text(city.country),
                      trailing: IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                        onPressed: () {
                          ref
                              .read(favoriteCitiesProvider.notifier)
                              .toggleCity(city);
                        },
                      ),
                      onTap: () => _selectCity(city.id),
                    );
                  },
                );
              },

              // Loading state
              loading: () => const Center(child: CircularProgressIndicator()),

              // Error state
              error: (error, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(error.toString()),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(searchResultsProvider),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Build the "all cities" list shown when search is empty
  // -------------------------------------------------------------------------

  Widget _buildAllCitiesList(BuildContext context) {
    final allCities = mockCities.values.toList();

    return ListView.builder(
      itemCount: allCities.length,
      itemBuilder: (context, index) {
        final city = allCities[index];
        final isFav = ref
            .watch(favoriteCitiesProvider)
            .any((c) => c.id == city.id);

        return ListTile(
          leading: const Icon(Icons.location_city),
          title: Text(city.name),
          subtitle: Text(city.country),
          trailing: IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              ref.read(favoriteCitiesProvider.notifier).toggleCity(city);
            },
          ),
          onTap: () => _selectCity(city.id),
        );
      },
    );
  }

  // -------------------------------------------------------------------------
  // Navigation
  // -------------------------------------------------------------------------

  void _selectCity(String cityId) {
    // Record as recently viewed
    final city = mockCities[cityId];
    if (city != null) {
      ref.read(recentCitiesProvider.notifier).addCity(city);
    }

    ref.read(selectedCityIdProvider.notifier).state = cityId;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherDetailScreen(cityId: cityId),
      ),
    );
  }
}
