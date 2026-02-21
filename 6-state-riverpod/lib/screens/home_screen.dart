// =============================================================================
// Home Screen — main dashboard showing recent / favourite cities weather
// =============================================================================
//
// Demonstrates:
//  - ConsumerWidget with ref.watch for reactive UI
//  - Reading multiple providers in one widget
//  - Navigation to other screens
//  - ref.listen for side effects (snackbar notifications)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/l10n/app_localizations.dart';
import 'package:state_riverpod_tutorial/data/mock_weather.dart';
import 'package:state_riverpod_tutorial/providers/weather_notifiers.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';
import 'package:state_riverpod_tutorial/screens/city_search_screen.dart';
import 'package:state_riverpod_tutorial/screens/favorites_screen.dart';
import 'package:state_riverpod_tutorial/screens/settings_screen.dart';
import 'package:state_riverpod_tutorial/screens/weather_detail_screen.dart';
import 'package:state_riverpod_tutorial/widgets/weather_card.dart';

// ---------------------------------------------------------------------------
// HomeScreen
// ---------------------------------------------------------------------------

/// The main screen of the Weather Dashboard.
///
/// Shows weather cards for favourite and recently viewed cities. Uses
/// [ConsumerStatefulWidget] to demonstrate `ref.listen` in `initState`
/// (actually in `build`, since Riverpod listeners must be set up there).
///
/// Alternative: you could use a plain [ConsumerWidget] if you don't need
/// initState / dispose lifecycle. ConsumerStatefulWidget is needed only when
/// you combine Riverpod with StatefulWidget lifecycle methods.
class HomeScreen extends ConsumerStatefulWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // -----------------------------------------------------------------------
    // ref.listen — fire-and-forget side effects
    // -----------------------------------------------------------------------
    // Unlike ref.watch (which triggers rebuilds), ref.listen runs a callback
    // without causing a rebuild. Perfect for showing snackbars, dialogs, or
    // triggering navigation in response to state changes.
    ref.listen<int>(favoritesCountProvider, (previous, next) {
      if (previous != null && next > previous) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.favorites}: $next'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });

    // -----------------------------------------------------------------------
    // ref.watch — reactive reads that trigger rebuilds
    // -----------------------------------------------------------------------
    final favorites = ref.watch(favoriteCitiesProvider);
    final recentCities = ref.watch(recentCitiesProvider);

    // Combine favourites + popular cities for the dashboard
    final dashboardCityIds = <String>{
      ...favorites.map((c) => c.id),
      // Show a few default cities if the user hasn't favourited any
      if (favorites.isEmpty) ...['new-york', 'london', 'tokyo'],
      ...recentCities.map((c) => c.id),
    }.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: l10n.search,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CitySearchScreen()),
            ),
          ),

          // Favourites button with badge
          Badge(
            label: Text('${favorites.length}'),
            isLabelVisible: favorites.isNotEmpty,
            child: IconButton(
              icon: const Icon(Icons.favorite),
              tooltip: l10n.favorites,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              ),
            ),
          ),

          // Settings
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        // Pull to refresh — invalidate all weather providers
        onRefresh: () async {
          for (final id in dashboardCityIds) {
            ref.invalidate(currentWeatherProvider(id));
          }
          // Small delay so the indicator is visible
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          children: [
            const SizedBox(height: 8),

            // Section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                favorites.isEmpty
                    ? 'Popular Cities'
                    : l10n.favorites,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            // Weather cards
            for (final cityId in dashboardCityIds)
              WeatherCard(
                cityId: cityId,
                onTap: () => _navigateToDetail(context, cityId),
              ),

            const SizedBox(height: 80), // bottom padding for FAB
          ],
        ),
      ),

      // FAB to search for a new city
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CitySearchScreen()),
        ),
        icon: const Icon(Icons.add),
        label: Text(l10n.search),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Navigation helpers
  // -------------------------------------------------------------------------

  /// Navigates to the weather detail screen and records the city as recent.
  void _navigateToDetail(BuildContext context, String cityId) {
    // Record as recently viewed
    final city = mockCities[cityId];
    if (city != null) {
      ref.read(recentCitiesProvider.notifier).addCity(city);
    }

    // Update selected city
    ref.read(selectedCityIdProvider.notifier).state = cityId;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherDetailScreen(cityId: cityId),
      ),
    );
  }
}
