// =============================================================================
// Location Service
// =============================================================================
// Concepts demonstrated:
// - Geolocator package — accessing device GPS
// - Permission handling — checking and requesting location permissions
// - Async/await with error handling
// - Platform-specific behavior (permissions differ on iOS vs Android)
// - LocationPermission enum (denied, deniedForever, whileInUse, always)
// - Service availability check (location services enabled?)
// =============================================================================

import 'package:geolocator/geolocator.dart';

/// Wraps the [Geolocator] package for simplified location access.
///
/// Usage flow:
/// 1. Check if location services are enabled
/// 2. Check current permission status
/// 3. Request permission if needed
/// 4. Get the current position
///
/// Platform configuration required:
/// - iOS: Add keys to Info.plist (NSLocationWhenInUseUsageDescription)
/// - Android: Add permissions to AndroidManifest.xml
class LocationService {
  /// Gets the current GPS position after checking permissions.
  ///
  /// Returns a [Position] with latitude and longitude, or throws
  /// an exception if permissions are denied or services are off.
  ///
  /// The [Position] object contains:
  /// - latitude (double)
  /// - longitude (double)
  /// - accuracy (double, in meters)
  /// - altitude (double, in meters)
  /// - speed (double, in m/s)
  /// - heading (double, in degrees)
  /// - timestamp (DateTime)
  Future<Position> getCurrentPosition() async {
    // Step 1: Check if location services (GPS) are enabled on the device.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(
        'Location services are disabled. '
        'Please enable GPS in your device settings.',
      );
    }

    // Step 2: Check the current permission status.
    var permission = await Geolocator.checkPermission();

    // Step 3: Request permission if not yet granted.
    if (permission == LocationPermission.denied) {
      // Ask the user for permission.
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission was denied by the user.');
      }
    }

    // If the user permanently denied permissions, we can't ask again.
    // They need to go to Settings to enable it manually.
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied. '
        'Please enable location access in Settings.',
      );
    }

    // Step 4: Permission granted — get the current position.
    // LocationAccuracy levels:
    // - lowest: ~3000m accuracy (very fast, very low battery)
    // - low: ~1000m accuracy
    // - medium: ~500m accuracy
    // - high: ~100m accuracy (recommended for most apps)
    // - best: ~10m accuracy (slower, more battery)
    // - bestForNavigation: most accurate (highest battery drain)
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        // timeLimit: Duration(seconds: 10), // Timeout for getting position
      ),
    );
  }

  /// Checks whether the app has location permission.
  ///
  /// Returns a human-readable string describing the permission status.
  Future<String> checkPermissionStatus() async {
    final permission = await Geolocator.checkPermission();
    return switch (permission) {
      LocationPermission.denied => 'Denied',
      LocationPermission.deniedForever => 'Permanently Denied',
      LocationPermission.whileInUse => 'While In Use',
      LocationPermission.always => 'Always',
      LocationPermission.unableToDetermine => 'Unable to Determine',
    };
  }

  /// Opens the device's location settings page.
  ///
  /// Useful when permissions are permanently denied — the user
  /// must enable location access from the Settings app.
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Opens the app's permission settings page.
  ///
  /// Useful for directing the user to re-enable denied permissions.
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }
}
