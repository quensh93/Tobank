/// Abstract interface for STAC API services
///
/// This interface defines the contract for fetching and managing
/// STAC JSON configurations from various sources (mock, Supabase, custom API).
abstract class StacApiService {
  /// Fetch JSON configuration by screen name
  ///
  /// Returns a map containing the STAC JSON configuration for the specified screen.
  /// Throws [ScreenNotFoundException] if the screen doesn't exist.
  /// Throws [NetworkException] if there's a network error.
  Future<Map<String, dynamic>> fetchScreen(String screenName);

  /// Fetch JSON configuration by route
  ///
  /// Returns a map containing the STAC JSON configuration for the specified route.
  /// Throws [ScreenNotFoundException] if the route doesn't exist.
  /// Throws [NetworkException] if there's a network error.
  Future<Map<String, dynamic>> fetchRoute(String route);

  /// Fetch configuration JSON by name
  ///
  /// Returns a map containing the configuration JSON.
  /// Throws [ApiException] if the configuration doesn't exist or network error.
  Future<Map<String, dynamic>> fetchConfig(String configName);

  /// Refresh cached data
  ///
  /// Clears the cache and refetches data from the source.
  /// This is useful for implementing pull-to-refresh functionality.
  Future<void> refresh();

  /// Clear all cached data
  ///
  /// Removes all cached JSON configurations from memory and disk.
  Future<void> clearCache();

  /// Check if data is cached
  ///
  /// Returns true if the specified key has cached data that hasn't expired.
  bool isCached(String key);

  /// Get cached data
  ///
  /// Returns the cached JSON configuration for the specified key,
  /// or null if no valid cache exists.
  Map<String, dynamic>? getCached(String key);
}
