// =============================================================================
// Settings Screen — temperature unit and language preferences
// =============================================================================
//
// Demonstrates:
//  - StateProvider mutation (temperature unit toggle)
//  - Reading and writing simple providers
//  - Using ref.read in callbacks (not ref.watch)
//  - SegmentedButton for modern Material 3 selection UI
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/l10n/app_localizations.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';

// ---------------------------------------------------------------------------
// Locale provider — controls the app's language
// ---------------------------------------------------------------------------

/// The user's chosen locale. `null` means "use system default".
///
/// This StateProvider lives here (close to the settings UI) but could also
/// live in weather_providers.dart.
final localeProvider = StateProvider<Locale?>((ref) => null);

// ---------------------------------------------------------------------------
// SettingsScreen
// ---------------------------------------------------------------------------

/// Lets the user change temperature unit and language.
class SettingsScreen extends ConsumerWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentUnit = ref.watch(temperatureUnitProvider);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // =================================================================
          // Temperature unit section
          // =================================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              l10n.temperatureUnit,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          // Using SegmentedButton — the modern Material 3 selection widget.
          // This avoids the deprecated RadioListTile groupValue/onChanged API.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<TemperatureUnit>(
              segments: [
                ButtonSegment(
                  value: TemperatureUnit.celsius,
                  label: Text(l10n.celsius),
                  icon: const Icon(Icons.thermostat),
                ),
                ButtonSegment(
                  value: TemperatureUnit.fahrenheit,
                  label: Text(l10n.fahrenheit),
                  icon: const Icon(Icons.thermostat),
                ),
              ],
              selected: {currentUnit},
              onSelectionChanged: (values) {
                // ref.read for one-shot write — we don't want this callback
                // itself to be reactive
                ref.read(temperatureUnitProvider.notifier).state = values.first;
              },
            ),
          ),

          // Alternative: you could use RadioListTile with RadioGroup ancestor
          // (Flutter 3.32+):
          //
          // RadioGroup<TemperatureUnit>(
          //   value: currentUnit,
          //   onChanged: (value) {
          //     ref.read(temperatureUnitProvider.notifier).state = value;
          //   },
          //   child: Column(
          //     children: [
          //       RadioListTile<TemperatureUnit>(
          //         title: Text(l10n.celsius),
          //         value: TemperatureUnit.celsius,
          //       ),
          //       RadioListTile<TemperatureUnit>(
          //         title: Text(l10n.fahrenheit),
          //         value: TemperatureUnit.fahrenheit,
          //       ),
          //     ],
          //   ),
          // )

          const SizedBox(height: 16),
          const Divider(),

          // =================================================================
          // Language section
          // =================================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              l10n.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          // Language selection using ListTiles with a selected indicator.
          // Avoids the deprecated RadioListTile groupValue/onChanged API.
          _LanguageTile(
            title: 'System Default',
            isSelected: currentLocale == null,
            onTap: () {
              ref.read(localeProvider.notifier).state = null;
            },
          ),
          _LanguageTile(
            title: l10n.english,
            isSelected: currentLocale?.languageCode == 'en',
            onTap: () {
              ref.read(localeProvider.notifier).state = const Locale('en');
            },
          ),
          _LanguageTile(
            title: l10n.spanish,
            isSelected: currentLocale?.languageCode == 'es',
            onTap: () {
              ref.read(localeProvider.notifier).state = const Locale('es');
            },
          ),

          const Divider(),

          // =================================================================
          // Info section — shows current provider values for debugging
          // =================================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Provider Values (Debug)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text('temperatureUnitProvider'),
            subtitle: Text(currentUnit.name),
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('localeProvider'),
            subtitle: Text(currentLocale?.languageCode ?? 'system'),
          ),

          // Show the selected city provider value
          Consumer(
            builder: (context, ref, child) {
              final selectedCity = ref.watch(selectedCityIdProvider);
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('selectedCityIdProvider'),
                subtitle: Text(selectedCity ?? 'none'),
              );
            },
          ),

          // Show search query
          Consumer(
            builder: (context, ref, child) {
              final query = ref.watch(searchQueryProvider);
              return ListTile(
                leading: const Icon(Icons.search),
                title: const Text('searchQueryProvider'),
                subtitle: Text(query.isEmpty ? '(empty)' : query),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Language tile (private helper)
// ---------------------------------------------------------------------------

/// A [ListTile] that shows a checkmark when selected.
class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.circle_outlined),
      selected: isSelected,
      onTap: onTap,
    );
  }
}
