import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/stac_api_service.dart';
import 'package:tobank_sdui/core/api/services/mock_api_service.dart';
import 'package:tobank_sdui/core/api/services/supabase_api_service.dart';
import 'api_config_provider.dart';

part 'stac_api_service_provider.g.dart';

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
@Riverpod(keepAlive: true)
StacApiService stacApiService(Ref ref) {
  final config = ref.watch(apiConfigProvider);

  switch (config.mode) {
    case ApiMode.mock:
      return MockApiService(config: config);

    case ApiMode.supabase:
      return SupabaseApiService(config: config);

    case ApiMode.custom:
      // CustomApiService to be implemented
      throw UnimplementedError('Custom API service not yet implemented');
  }
}

/// Provider for refreshing API data
///
/// This provider can be used to trigger a refresh of all cached data.
/// It clears the cache and forces a refetch from the source.
@riverpod
class ApiRefreshNotifier extends _$ApiRefreshNotifier {
  @override
  Future<void> build() async {
    // Initial state - no refresh needed
  }

  /// Refresh all cached data
  ///
  /// Clears the cache and forces a refetch from the API source.
  /// Returns a Future that completes when the refresh is done.
  Future<void> refresh() async {
    state = const AsyncLoading();

    try {
      final apiService = ref.read(stacApiServiceProvider);
      await apiService.refresh();
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      rethrow;
    }
  }

  /// Clear all cached data
  ///
  /// Removes all cached data without triggering a refetch.
  Future<void> clearCache() async {
    state = const AsyncLoading();

    try {
      final apiService = ref.read(stacApiServiceProvider);
      await apiService.clearCache();
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider for fetching a specific screen
///
/// This provider automatically caches the result and refetches when needed.
/// It also handles errors and loading states.
@riverpod
Future<Map<String, dynamic>> fetchScreen(Ref ref, String screenName) async {
  final apiService = ref.watch(stacApiServiceProvider);
  return apiService.fetchScreen(screenName);
}

/// Provider for fetching a screen by route
///
/// This provider automatically caches the result and refetches when needed.
@riverpod
Future<Map<String, dynamic>> fetchRoute(Ref ref, String route) async {
  final apiService = ref.watch(stacApiServiceProvider);
  return apiService.fetchRoute(route);
}

/// Provider for checking if a screen is cached
@riverpod
bool isScreenCached(Ref ref, String screenName) {
  final apiService = ref.read(stacApiServiceProvider);
  return apiService.isCached(screenName);
}

/// Provider for getting cached screen data
@riverpod
Map<String, dynamic>? getCachedScreen(Ref ref, String screenName) {
  final apiService = ref.read(stacApiServiceProvider);
  return apiService.getCached(screenName);
}
