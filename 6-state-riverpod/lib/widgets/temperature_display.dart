// =============================================================================
// Temperature Display Widget — unit-aware temperature text
// =============================================================================
//
// A ConsumerWidget that reads the temperature unit provider and displays the
// temperature in the user's preferred unit. This is a great example of
// fine-grained rebuilds: only this widget rebuilds when the unit changes,
// not the entire screen.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';

// ---------------------------------------------------------------------------
// TemperatureDisplay
// ---------------------------------------------------------------------------

/// Displays a temperature value converted to the user's chosen unit.
///
/// Extends [ConsumerWidget] so it has access to `ref` in its `build` method.
/// This is the Riverpod equivalent of wrapping a widget with `Consumer`.
///
/// Alternative: you could use a plain [StatelessWidget] and wrap the text
/// in a [Consumer] widget instead:
/// ```dart
/// Consumer(
///   builder: (context, ref, child) {
///     final unit = ref.watch(temperatureUnitProvider);
///     return Text(...);
///   },
/// )
/// ```
class TemperatureDisplay extends ConsumerWidget {
  /// Creates a [TemperatureDisplay].
  ///
  /// [celsius] is the raw temperature in Celsius.
  /// [style] is an optional text style override.
  const TemperatureDisplay({
    super.key,
    required this.celsius,
    this.style,
    this.showUnit = true,
  });

  /// The temperature in Celsius (will be converted based on user preference).
  final double celsius;

  /// Optional text style.
  final TextStyle? style;

  /// Whether to show the unit label (e.g. "C" or "F") after the number.
  final bool showUnit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch triggers a rebuild whenever the unit changes
    final unit = ref.watch(temperatureUnitProvider);

    // Convert to the user's preferred unit
    final converted = convertTemp(celsius, unit);
    final label = unitLabel(unit);

    // Format to one decimal place
    final text = showUnit
        ? '${converted.toStringAsFixed(1)}°$label'
        : converted.toStringAsFixed(1);

    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.headlineMedium,
    );
  }
}

// Alternative: using ref.listen instead of ref.watch to trigger a side effect
// (e.g. analytics) when the unit changes:
//
// @override
// Widget build(BuildContext context, WidgetRef ref) {
//   ref.listen<TemperatureUnit>(temperatureUnitProvider, (prev, next) {
//     debugPrint('Unit changed from $prev to $next');
//   });
//   final unit = ref.watch(temperatureUnitProvider);
//   ...
// }
