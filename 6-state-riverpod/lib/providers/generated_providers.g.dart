// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherGreetingHash() => r'7c50a3d6f419826e2606ad1ac977f3ee1c79caa8';

/// Returns a greeting string that includes the currently selected city.
///
/// Demonstrates a simple generated provider that reads other providers.
///
/// Copied from [weatherGreeting].
@ProviderFor(weatherGreeting)
final weatherGreetingProvider = AutoDisposeProvider<String>.internal(
  weatherGreeting,
  name: r'weatherGreetingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherGreetingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherGreetingRef = AutoDisposeProviderRef<String>;
String _$generatedWeatherHash() => r'c802009249db5b7d8cb19e42bb8bd76619d3ded6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Fetches weather for [cityId] — generated equivalent of
/// [currentWeatherProvider] from weather_providers.dart.
///
/// The `cityId` parameter automatically makes this a `.family` provider.
///
/// Copied from [generatedWeather].
@ProviderFor(generatedWeather)
const generatedWeatherProvider = GeneratedWeatherFamily();

/// Fetches weather for [cityId] — generated equivalent of
/// [currentWeatherProvider] from weather_providers.dart.
///
/// The `cityId` parameter automatically makes this a `.family` provider.
///
/// Copied from [generatedWeather].
class GeneratedWeatherFamily extends Family<AsyncValue<Weather>> {
  /// Fetches weather for [cityId] — generated equivalent of
  /// [currentWeatherProvider] from weather_providers.dart.
  ///
  /// The `cityId` parameter automatically makes this a `.family` provider.
  ///
  /// Copied from [generatedWeather].
  const GeneratedWeatherFamily();

  /// Fetches weather for [cityId] — generated equivalent of
  /// [currentWeatherProvider] from weather_providers.dart.
  ///
  /// The `cityId` parameter automatically makes this a `.family` provider.
  ///
  /// Copied from [generatedWeather].
  GeneratedWeatherProvider call(String cityId) {
    return GeneratedWeatherProvider(cityId);
  }

  @override
  GeneratedWeatherProvider getProviderOverride(
    covariant GeneratedWeatherProvider provider,
  ) {
    return call(provider.cityId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generatedWeatherProvider';
}

/// Fetches weather for [cityId] — generated equivalent of
/// [currentWeatherProvider] from weather_providers.dart.
///
/// The `cityId` parameter automatically makes this a `.family` provider.
///
/// Copied from [generatedWeather].
class GeneratedWeatherProvider extends AutoDisposeFutureProvider<Weather> {
  /// Fetches weather for [cityId] — generated equivalent of
  /// [currentWeatherProvider] from weather_providers.dart.
  ///
  /// The `cityId` parameter automatically makes this a `.family` provider.
  ///
  /// Copied from [generatedWeather].
  GeneratedWeatherProvider(String cityId)
    : this._internal(
        (ref) => generatedWeather(ref as GeneratedWeatherRef, cityId),
        from: generatedWeatherProvider,
        name: r'generatedWeatherProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$generatedWeatherHash,
        dependencies: GeneratedWeatherFamily._dependencies,
        allTransitiveDependencies:
            GeneratedWeatherFamily._allTransitiveDependencies,
        cityId: cityId,
      );

  GeneratedWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityId,
  }) : super.internal();

  final String cityId;

  @override
  Override overrideWith(
    FutureOr<Weather> Function(GeneratedWeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GeneratedWeatherProvider._internal(
        (ref) => create(ref as GeneratedWeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityId: cityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Weather> createElement() {
    return _GeneratedWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeneratedWeatherProvider && other.cityId == cityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeneratedWeatherRef on AutoDisposeFutureProviderRef<Weather> {
  /// The parameter `cityId` of this provider.
  String get cityId;
}

class _GeneratedWeatherProviderElement
    extends AutoDisposeFutureProviderElement<Weather>
    with GeneratedWeatherRef {
  _GeneratedWeatherProviderElement(super.provider);

  @override
  String get cityId => (origin as GeneratedWeatherProvider).cityId;
}

String _$generatedLiveWeatherHash() =>
    r'd5c36c5630d2d0697f05ece98b641fc4fd28f442';

/// Live weather stream for [cityId] — generated version.
///
/// Copied from [generatedLiveWeather].
@ProviderFor(generatedLiveWeather)
const generatedLiveWeatherProvider = GeneratedLiveWeatherFamily();

/// Live weather stream for [cityId] — generated version.
///
/// Copied from [generatedLiveWeather].
class GeneratedLiveWeatherFamily extends Family<AsyncValue<Weather>> {
  /// Live weather stream for [cityId] — generated version.
  ///
  /// Copied from [generatedLiveWeather].
  const GeneratedLiveWeatherFamily();

  /// Live weather stream for [cityId] — generated version.
  ///
  /// Copied from [generatedLiveWeather].
  GeneratedLiveWeatherProvider call(String cityId) {
    return GeneratedLiveWeatherProvider(cityId);
  }

  @override
  GeneratedLiveWeatherProvider getProviderOverride(
    covariant GeneratedLiveWeatherProvider provider,
  ) {
    return call(provider.cityId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generatedLiveWeatherProvider';
}

/// Live weather stream for [cityId] — generated version.
///
/// Copied from [generatedLiveWeather].
class GeneratedLiveWeatherProvider extends AutoDisposeStreamProvider<Weather> {
  /// Live weather stream for [cityId] — generated version.
  ///
  /// Copied from [generatedLiveWeather].
  GeneratedLiveWeatherProvider(String cityId)
    : this._internal(
        (ref) => generatedLiveWeather(ref as GeneratedLiveWeatherRef, cityId),
        from: generatedLiveWeatherProvider,
        name: r'generatedLiveWeatherProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$generatedLiveWeatherHash,
        dependencies: GeneratedLiveWeatherFamily._dependencies,
        allTransitiveDependencies:
            GeneratedLiveWeatherFamily._allTransitiveDependencies,
        cityId: cityId,
      );

  GeneratedLiveWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityId,
  }) : super.internal();

  final String cityId;

  @override
  Override overrideWith(
    Stream<Weather> Function(GeneratedLiveWeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GeneratedLiveWeatherProvider._internal(
        (ref) => create(ref as GeneratedLiveWeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityId: cityId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Weather> createElement() {
    return _GeneratedLiveWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeneratedLiveWeatherProvider && other.cityId == cityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeneratedLiveWeatherRef on AutoDisposeStreamProviderRef<Weather> {
  /// The parameter `cityId` of this provider.
  String get cityId;
}

class _GeneratedLiveWeatherProviderElement
    extends AutoDisposeStreamProviderElement<Weather>
    with GeneratedLiveWeatherRef {
  _GeneratedLiveWeatherProviderElement(super.provider);

  @override
  String get cityId => (origin as GeneratedLiveWeatherProvider).cityId;
}

String _$demoCounterHash() => r'59f5d8a063082563acf04a572f4d6308c53c3fdb';

/// Manages a simple counter for demonstration purposes.
///
/// Shows that @riverpod class-based providers are equivalent to
/// `NotifierProvider.autoDispose`.
///
/// Copied from [DemoCounter].
@ProviderFor(DemoCounter)
final demoCounterProvider =
    AutoDisposeNotifierProvider<DemoCounter, int>.internal(
      DemoCounter.new,
      name: r'demoCounterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$demoCounterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DemoCounter = AutoDisposeNotifier<int>;
String _$generatedForecastHash() => r'410bd6731591aaa5b851e85ba535c4922f583e03';

abstract class _$GeneratedForecast
    extends BuildlessAutoDisposeAsyncNotifier<List<DailyForecast>> {
  late final String cityId;

  FutureOr<List<DailyForecast>> build(String cityId);
}

/// Manages a forecast that is loaded asynchronously.
///
/// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
///
/// Copied from [GeneratedForecast].
@ProviderFor(GeneratedForecast)
const generatedForecastProvider = GeneratedForecastFamily();

/// Manages a forecast that is loaded asynchronously.
///
/// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
///
/// Copied from [GeneratedForecast].
class GeneratedForecastFamily extends Family<AsyncValue<List<DailyForecast>>> {
  /// Manages a forecast that is loaded asynchronously.
  ///
  /// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
  ///
  /// Copied from [GeneratedForecast].
  const GeneratedForecastFamily();

  /// Manages a forecast that is loaded asynchronously.
  ///
  /// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
  ///
  /// Copied from [GeneratedForecast].
  GeneratedForecastProvider call(String cityId) {
    return GeneratedForecastProvider(cityId);
  }

  @override
  GeneratedForecastProvider getProviderOverride(
    covariant GeneratedForecastProvider provider,
  ) {
    return call(provider.cityId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generatedForecastProvider';
}

/// Manages a forecast that is loaded asynchronously.
///
/// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
///
/// Copied from [GeneratedForecast].
class GeneratedForecastProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          GeneratedForecast,
          List<DailyForecast>
        > {
  /// Manages a forecast that is loaded asynchronously.
  ///
  /// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
  ///
  /// Copied from [GeneratedForecast].
  GeneratedForecastProvider(String cityId)
    : this._internal(
        () => GeneratedForecast()..cityId = cityId,
        from: generatedForecastProvider,
        name: r'generatedForecastProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$generatedForecastHash,
        dependencies: GeneratedForecastFamily._dependencies,
        allTransitiveDependencies:
            GeneratedForecastFamily._allTransitiveDependencies,
        cityId: cityId,
      );

  GeneratedForecastProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityId,
  }) : super.internal();

  final String cityId;

  @override
  FutureOr<List<DailyForecast>> runNotifierBuild(
    covariant GeneratedForecast notifier,
  ) {
    return notifier.build(cityId);
  }

  @override
  Override overrideWith(GeneratedForecast Function() create) {
    return ProviderOverride(
      origin: this,
      override: GeneratedForecastProvider._internal(
        () => create()..cityId = cityId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityId: cityId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    GeneratedForecast,
    List<DailyForecast>
  >
  createElement() {
    return _GeneratedForecastProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeneratedForecastProvider && other.cityId == cityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeneratedForecastRef
    on AutoDisposeAsyncNotifierProviderRef<List<DailyForecast>> {
  /// The parameter `cityId` of this provider.
  String get cityId;
}

class _GeneratedForecastProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          GeneratedForecast,
          List<DailyForecast>
        >
    with GeneratedForecastRef {
  _GeneratedForecastProviderElement(super.provider);

  @override
  String get cityId => (origin as GeneratedForecastProvider).cityId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
