// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stac_api_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// STAC API service provider
///
/// Provides the appropriate API service implementation based on the current configuration.
/// Automatically switches between mock, Supabase, and custom API services.
///
/// Example usage:
/// ```dart
/// // Fetch a screen
///
/// Example usage:
/// ```dart
/// // Fetch a screen
/// final apiService = ref.read(stacApiServiceProvider);
/// final screenData = await apiService.fetchScreen('home_screen');
///
/// // Refresh data
/// await ref.read(stacApiServiceProvider).refresh();
/// ```

@ProviderFor(stacApiService)
const stacApiServiceProvider = StacApiServiceProvider._();

/// STAC API service provider
///
/// Provides the appropriate API service implementation based on the current configuration.
/// Automatically switches between mock, Supabase, and custom API services.
///
/// Example usage:
/// ```dart
/// // Fetch a screen
///
/// Example usage:
/// ```dart
/// // Fetch a screen
/// final apiService = ref.read(stacApiServiceProvider);
/// final screenData = await apiService.fetchScreen('home_screen');
///
/// // Refresh data
/// await ref.read(stacApiServiceProvider).refresh();
/// ```

final class StacApiServiceProvider
    extends $FunctionalProvider<StacApiService, StacApiService, StacApiService>
    with $Provider<StacApiService> {
  /// STAC API service provider
  ///
  /// Provides the appropriate API service implementation based on the current configuration.
  /// Automatically switches between mock, Supabase, and custom API services.
  ///
  /// Example usage:
  /// ```dart
  /// // Fetch a screen
  ///
  /// Example usage:
  /// ```dart
  /// // Fetch a screen
  /// final apiService = ref.read(stacApiServiceProvider);
  /// final screenData = await apiService.fetchScreen('home_screen');
  ///
  /// // Refresh data
  /// await ref.read(stacApiServiceProvider).refresh();
  /// ```
  const StacApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stacApiServiceProvider',
        isAutoDispose: false,
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

String _$stacApiServiceHash() => r'c09cfc07c761a1f07879decf91203a8c99f32fe8';

/// Provider for refreshing API data
///
/// This provider can be used to trigger a refresh of all cached data.
/// It clears the cache and forces a refetch from the source.

@ProviderFor(ApiRefreshNotifier)
const apiRefreshProvider = ApiRefreshNotifierProvider._();

/// Provider for refreshing API data
///
/// This provider can be used to trigger a refresh of all cached data.
/// It clears the cache and forces a refetch from the source.
final class ApiRefreshNotifierProvider
    extends $AsyncNotifierProvider<ApiRefreshNotifier, void> {
  /// Provider for refreshing API data
  ///
  /// This provider can be used to trigger a refresh of all cached data.
  /// It clears the cache and forces a refetch from the source.
  const ApiRefreshNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiRefreshProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiRefreshNotifierHash();

  @$internal
  @override
  ApiRefreshNotifier create() => ApiRefreshNotifier();
}

String _$apiRefreshNotifierHash() =>
    r'3ce08508cfd6e1aaa361a0e1450695705f127452';

/// Provider for refreshing API data
///
/// This provider can be used to trigger a refresh of all cached data.
/// It clears the cache and forces a refetch from the source.

abstract class _$ApiRefreshNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

/// Provider for fetching a specific screen
///
/// This provider automatically caches the result and refetches when needed.
/// It also handles errors and loading states.

@ProviderFor(fetchScreen)
const fetchScreenProvider = FetchScreenFamily._();

/// Provider for fetching a specific screen
///
/// This provider automatically caches the result and refetches when needed.
/// It also handles errors and loading states.

final class FetchScreenProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Provider for fetching a specific screen
  ///
  /// This provider automatically caches the result and refetches when needed.
  /// It also handles errors and loading states.
  const FetchScreenProvider._({
    required FetchScreenFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchScreenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchScreenHash();

  @override
  String toString() {
    return r'fetchScreenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return fetchScreen(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchScreenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchScreenHash() => r'ea179acd3a92b85f6834212e439f627bc9062bd9';

/// Provider for fetching a specific screen
///
/// This provider automatically caches the result and refetches when needed.
/// It also handles errors and loading states.

final class FetchScreenFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>>, String> {
  const FetchScreenFamily._()
    : super(
        retry: null,
        name: r'fetchScreenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for fetching a specific screen
  ///
  /// This provider automatically caches the result and refetches when needed.
  /// It also handles errors and loading states.

  FetchScreenProvider call(String screenName) =>
      FetchScreenProvider._(argument: screenName, from: this);

  @override
  String toString() => r'fetchScreenProvider';
}

/// Provider for fetching a screen by route
///
/// This provider automatically caches the result and refetches when needed.

@ProviderFor(fetchRoute)
const fetchRouteProvider = FetchRouteFamily._();

/// Provider for fetching a screen by route
///
/// This provider automatically caches the result and refetches when needed.

final class FetchRouteProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Provider for fetching a screen by route
  ///
  /// This provider automatically caches the result and refetches when needed.
  const FetchRouteProvider._({
    required FetchRouteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchRouteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchRouteHash();

  @override
  String toString() {
    return r'fetchRouteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return fetchRoute(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchRouteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchRouteHash() => r'fc09b6a19a231f2cfa28335e63c1fbadee315c9f';

/// Provider for fetching a screen by route
///
/// This provider automatically caches the result and refetches when needed.

final class FetchRouteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>>, String> {
  const FetchRouteFamily._()
    : super(
        retry: null,
        name: r'fetchRouteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for fetching a screen by route
  ///
  /// This provider automatically caches the result and refetches when needed.

  FetchRouteProvider call(String route) =>
      FetchRouteProvider._(argument: route, from: this);

  @override
  String toString() => r'fetchRouteProvider';
}

/// Provider for checking if a screen is cached

@ProviderFor(isScreenCached)
const isScreenCachedProvider = IsScreenCachedFamily._();

/// Provider for checking if a screen is cached

final class IsScreenCachedProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for checking if a screen is cached
  const IsScreenCachedProvider._({
    required IsScreenCachedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isScreenCachedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isScreenCachedHash();

  @override
  String toString() {
    return r'isScreenCachedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return isScreenCached(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsScreenCachedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isScreenCachedHash() => r'bd0b9777f83f20a694b06178d01eaaf14e895a4f';

/// Provider for checking if a screen is cached

final class IsScreenCachedFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  const IsScreenCachedFamily._()
    : super(
        retry: null,
        name: r'isScreenCachedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for checking if a screen is cached

  IsScreenCachedProvider call(String screenName) =>
      IsScreenCachedProvider._(argument: screenName, from: this);

  @override
  String toString() => r'isScreenCachedProvider';
}

/// Provider for getting cached screen data

@ProviderFor(getCachedScreen)
const getCachedScreenProvider = GetCachedScreenFamily._();

/// Provider for getting cached screen data

final class GetCachedScreenProvider
    extends
        $FunctionalProvider<
          Map<String, dynamic>?,
          Map<String, dynamic>?,
          Map<String, dynamic>?
        >
    with $Provider<Map<String, dynamic>?> {
  /// Provider for getting cached screen data
  const GetCachedScreenProvider._({
    required GetCachedScreenFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getCachedScreenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getCachedScreenHash();

  @override
  String toString() {
    return r'getCachedScreenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Map<String, dynamic>?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, dynamic>? create(Ref ref) {
    final argument = this.argument as String;
    return getCachedScreen(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetCachedScreenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getCachedScreenHash() => r'9d53c6f49064df18ec5df933bd0808ddee77287d';

/// Provider for getting cached screen data

final class GetCachedScreenFamily extends $Family
    with $FunctionalFamilyOverride<Map<String, dynamic>?, String> {
  const GetCachedScreenFamily._()
    : super(
        retry: null,
        name: r'getCachedScreenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for getting cached screen data

  GetCachedScreenProvider call(String screenName) =>
      GetCachedScreenProvider._(argument: screenName, from: this);

  @override
  String toString() => r'getCachedScreenProvider';
}
