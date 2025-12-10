// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// API configuration provider
///
/// Manages the current API configuration for the application.
/// Supports runtime configuration switching between mock, Supabase, and custom APIs.
///
/// Example usage:
/// ```dart
/// // Read the current configuration
/// final config = ref.watch(apiConfigProvider);
///
/// // Switch to mock mode
/// ref.read(apiConfigProvider.notifier).setConfig(ApiConfig.mock());
///
/// // Switch to Supabase mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.supabase('https://project.supabase.co', 'public-anon-key'),
/// );
///
/// // Switch to custom API mode
///
/// // Switch to custom API mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.custom('https://api.example.com'),
/// );
/// ```

@ProviderFor(ApiConfigNotifier)
const apiConfigProvider = ApiConfigNotifierProvider._();

/// API configuration provider
///
/// Manages the current API configuration for the application.
/// Supports runtime configuration switching between mock, Supabase, and custom APIs.
///
/// Example usage:
/// ```dart
/// // Read the current configuration
/// final config = ref.watch(apiConfigProvider);
///
/// // Switch to mock mode
/// ref.read(apiConfigProvider.notifier).setConfig(ApiConfig.mock());
///
/// // Switch to Supabase mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.supabase('https://project.supabase.co', 'public-anon-key'),
/// );
///
/// // Switch to custom API mode
///
/// // Switch to custom API mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.custom('https://api.example.com'),
/// );
/// ```
final class ApiConfigNotifierProvider
    extends $NotifierProvider<ApiConfigNotifier, ApiConfig> {
  /// API configuration provider
  ///
  /// Manages the current API configuration for the application.
  /// Supports runtime configuration switching between mock, Supabase, and custom APIs.
  ///
  /// Example usage:
  /// ```dart
  /// // Read the current configuration
  /// final config = ref.watch(apiConfigProvider);
  ///
  /// // Switch to mock mode
  /// ref.read(apiConfigProvider.notifier).setConfig(ApiConfig.mock());
  ///
  /// // Switch to Supabase mode
  /// ref.read(apiConfigProvider.notifier).setConfig(
  ///   ApiConfig.supabase('https://project.supabase.co', 'public-anon-key'),
  /// );
  ///
  /// // Switch to custom API mode
  ///
  /// // Switch to custom API mode
  /// ref.read(apiConfigProvider.notifier).setConfig(
  ///   ApiConfig.custom('https://api.example.com'),
  /// );
  /// ```
  const ApiConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiConfigNotifierHash();

  @$internal
  @override
  ApiConfigNotifier create() => ApiConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiConfig>(value),
    );
  }
}

String _$apiConfigNotifierHash() => r'3f7d1d89ad5a2e286210204f999e4dcea62ca1f4';

/// API configuration provider
///
/// Manages the current API configuration for the application.
/// Supports runtime configuration switching between mock, Supabase, and custom APIs.
///
/// Example usage:
/// ```dart
/// // Read the current configuration
/// final config = ref.watch(apiConfigProvider);
///
/// // Switch to mock mode
/// ref.read(apiConfigProvider.notifier).setConfig(ApiConfig.mock());
///
/// // Switch to Supabase mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.supabase('https://project.supabase.co', 'public-anon-key'),
/// );
///
/// // Switch to custom API mode
///
/// // Switch to custom API mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.custom('https://api.example.com'),
/// );
/// ```

abstract class _$ApiConfigNotifier extends $Notifier<ApiConfig> {
  ApiConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ApiConfig, ApiConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ApiConfig, ApiConfig>,
              ApiConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for checking if mock API is enabled

@ProviderFor(isMockApiEnabled)
const isMockApiEnabledProvider = IsMockApiEnabledProvider._();

/// Provider for checking if mock API is enabled

final class IsMockApiEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for checking if mock API is enabled
  const IsMockApiEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isMockApiEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isMockApiEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isMockApiEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isMockApiEnabledHash() => r'd1dbda1a554d21c67a242b9c2d504198d7ddd09b';

/// Provider for checking if Supabase API is enabled

@ProviderFor(isSupabaseApiEnabled)
const isSupabaseApiEnabledProvider = IsSupabaseApiEnabledProvider._();

/// Provider for checking if Supabase API is enabled

final class IsSupabaseApiEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for checking if Supabase API is enabled
  const IsSupabaseApiEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSupabaseApiEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSupabaseApiEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSupabaseApiEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSupabaseApiEnabledHash() =>
    r'6469a4a72b57ea8cbe3734aef5c5b29c50e76a31';

/// Provider for checking if custom API is enabled

@ProviderFor(isCustomApiEnabled)
const isCustomApiEnabledProvider = IsCustomApiEnabledProvider._();

/// Provider for checking if custom API is enabled

final class IsCustomApiEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for checking if custom API is enabled
  const IsCustomApiEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isCustomApiEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isCustomApiEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isCustomApiEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isCustomApiEnabledHash() =>
    r'f2e7c37676a335bb3d2c68631a8f6dfa37fb3f6e';

/// Provider for getting the current API mode

@ProviderFor(currentApiMode)
const currentApiModeProvider = CurrentApiModeProvider._();

/// Provider for getting the current API mode

final class CurrentApiModeProvider
    extends $FunctionalProvider<ApiMode, ApiMode, ApiMode>
    with $Provider<ApiMode> {
  /// Provider for getting the current API mode
  const CurrentApiModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentApiModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentApiModeHash();

  @$internal
  @override
  $ProviderElement<ApiMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiMode create(Ref ref) {
    return currentApiMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiMode>(value),
    );
  }
}

String _$currentApiModeHash() => r'8ad4808ea9c39fbf582bc2199945a27e332a493b';

/// Provider for checking if caching is enabled

@ProviderFor(isCachingEnabled)
const isCachingEnabledProvider = IsCachingEnabledProvider._();

/// Provider for checking if caching is enabled

final class IsCachingEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for checking if caching is enabled
  const IsCachingEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isCachingEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isCachingEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isCachingEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isCachingEnabledHash() => r'bb5d97ca84d6fee1aaac7e2a70033f0be4e36b02';
