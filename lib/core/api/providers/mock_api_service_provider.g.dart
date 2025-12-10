// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_api_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mock API service provider
///
/// Provides a singleton instance of MockApiService.
/// The service is automatically recreated when the API configuration changes.

@ProviderFor(mockApiService)
const mockApiServiceProvider = MockApiServiceProvider._();

/// Mock API service provider
///
/// Provides a singleton instance of MockApiService.
/// The service is automatically recreated when the API configuration changes.

final class MockApiServiceProvider
    extends $FunctionalProvider<MockApiService, MockApiService, MockApiService>
    with $Provider<MockApiService> {
  /// Mock API service provider
  ///
  /// Provides a singleton instance of MockApiService.
  /// The service is automatically recreated when the API configuration changes.
  const MockApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockApiServiceHash();

  @$internal
  @override
  $ProviderElement<MockApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockApiService create(Ref ref) {
    return mockApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockApiService>(value),
    );
  }
}

String _$mockApiServiceHash() => r'3a38f89b31f481a6d3bcb61b25d542bfe70a4aba';

/// Generic STAC API service provider
///
/// Returns the appropriate API service based on the current configuration.
/// Currently only supports MockApiService, but will be extended to support
/// Supabase and custom API services.

@ProviderFor(stacApiService)
const stacApiServiceProvider = StacApiServiceProvider._();

/// Generic STAC API service provider
///
/// Returns the appropriate API service based on the current configuration.
/// Currently only supports MockApiService, but will be extended to support
/// Supabase and custom API services.

final class StacApiServiceProvider
    extends $FunctionalProvider<StacApiService, StacApiService, StacApiService>
    with $Provider<StacApiService> {
  /// Generic STAC API service provider
  ///
  /// Returns the appropriate API service based on the current configuration.
  /// Currently only supports MockApiService, but will be extended to support
  /// Supabase and custom API services.
  const StacApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stacApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stacApiServiceHash();

  @$internal
  @override
  $ProviderElement<StacApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StacApiService create(Ref ref) {
    return stacApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StacApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StacApiService>(value),
    );
  }
}

String _$stacApiServiceHash() => r'6fad46ad175e6b22083bef9e99117300cd38b312';

/// Hot reload notifier for mock data
///
/// Provides a mechanism to trigger hot reload of mock data.
/// When triggered, it clears the cache and invalidates the API service provider,
/// causing all dependent widgets to rebuild with fresh data.

@ProviderFor(MockDataReloadNotifier)
const mockDataReloadProvider = MockDataReloadNotifierProvider._();

/// Hot reload notifier for mock data
///
/// Provides a mechanism to trigger hot reload of mock data.
/// When triggered, it clears the cache and invalidates the API service provider,
/// causing all dependent widgets to rebuild with fresh data.
final class MockDataReloadNotifierProvider
    extends $NotifierProvider<MockDataReloadNotifier, int> {
  /// Hot reload notifier for mock data
  ///
  /// Provides a mechanism to trigger hot reload of mock data.
  /// When triggered, it clears the cache and invalidates the API service provider,
  /// causing all dependent widgets to rebuild with fresh data.
  const MockDataReloadNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockDataReloadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockDataReloadNotifierHash();

  @$internal
  @override
  MockDataReloadNotifier create() => MockDataReloadNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mockDataReloadNotifierHash() =>
    r'9317d2934f581d5f3de91c0980b053492a135ac1';

/// Hot reload notifier for mock data
///
/// Provides a mechanism to trigger hot reload of mock data.
/// When triggered, it clears the cache and invalidates the API service provider,
/// causing all dependent widgets to rebuild with fresh data.

abstract class _$MockDataReloadNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider to check if mock data has been reloaded
///
/// Useful for showing reload indicators or notifications.

@ProviderFor(hasMockDataReloaded)
const hasMockDataReloadedProvider = HasMockDataReloadedProvider._();

/// Provider to check if mock data has been reloaded
///
/// Useful for showing reload indicators or notifications.

final class HasMockDataReloadedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if mock data has been reloaded
  ///
  /// Useful for showing reload indicators or notifications.
  const HasMockDataReloadedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasMockDataReloadedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasMockDataReloadedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasMockDataReloaded(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasMockDataReloadedHash() =>
    r'64c2ab9febe7afee1d51e4c55d31050f51187638';

/// Provider for mock data reload count
///
/// Returns the number of times mock data has been reloaded.

@ProviderFor(mockDataReloadCount)
const mockDataReloadCountProvider = MockDataReloadCountProvider._();

/// Provider for mock data reload count
///
/// Returns the number of times mock data has been reloaded.

final class MockDataReloadCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider for mock data reload count
  ///
  /// Returns the number of times mock data has been reloaded.
  const MockDataReloadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockDataReloadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockDataReloadCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return mockDataReloadCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mockDataReloadCountHash() =>
    r'96fc608e01fd9dad1f7f96a9aa63750e36388b43';
