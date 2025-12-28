import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/mock_api_service.dart';
import '../stac_api_service.dart';
import '../api_config.dart';
import 'api_config_provider.dart';

part 'mock_api_service_provider.g.dart';

/// Mock API service provider
///
/// Provides a singleton instance of MockApiService.
/// The service is automatically recreated when the API configuration changes.
@riverpod
MockApiService mockApiService(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return MockApiService(config: config);
}

/// Generic STAC API service provider
///
/// Returns the appropriate API service based on the current configuration.
/// Currently only supports MockApiService, but will be extended to support
/// Supabase and custom API services.
@riverpod
StacApiService stacApiService(Ref ref) {
  final config = ref.watch(apiConfigProvider);

  switch (config.mode) {
    case ApiMode.mock:
      return ref.watch(mockApiServiceProvider);

    case ApiMode.supabase:
      // Supabase API service not yet implemented
      throw UnimplementedError('Supabase API service not implemented');

    case ApiMode.custom:
      // Custom API service not yet implemented
      throw UnimplementedError('Custom API service not implemented');
  }
}

/// Hot reload notifier for mock data
///
/// Provides a mechanism to trigger hot reload of mock data.
/// When triggered, it clears the cache and invalidates the API service provider,
/// causing all dependent widgets to rebuild with fresh data.
@riverpod
class MockDataReloadNotifier extends _$MockDataReloadNotifier {
  @override
  int build() {
    // Counter to track reload events
    return 0;
  }

  /// Trigger a hot reload of mock data
  ///
  /// This will:
  /// 1. Clear the cache in the MockApiService
  /// 2. Increment the reload counter
  /// 3. Invalidate the API service provider
  /// 4. Trigger UI refresh for all dependent widgets
  Future<void> reloadMockData() async {
    final apiService = ref.read(mockApiServiceProvider);

    // Clear cache and reload
    await apiService.reloadMockData();

    // Increment counter to notify listeners
    state = state + 1;

    // Invalidate the API service provider to force rebuild
    ref.invalidate(stacApiServiceProvider);
  }

  /// Get the number of times mock data has been reloaded
  int get reloadCount => state;
}

/// Provider to check if mock data has been reloaded
///
/// Useful for showing reload indicators or notifications.
@riverpod
bool hasMockDataReloaded(Ref ref) {
  final reloadCount = ref.watch(mockDataReloadProvider);
  return reloadCount > 0;
}

/// Provider for mock data reload count
///
/// Returns the number of times mock data has been reloaded.
@riverpod
int mockDataReloadCount(Ref ref) {
  return ref.watch(mockDataReloadProvider);
}
