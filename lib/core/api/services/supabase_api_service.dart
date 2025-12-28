import 'dart:async';

import 'package:supabase/supabase.dart';

import '../api_config.dart';
import '../exceptions/api_exceptions.dart';
import '../stac_api_service.dart';

/// Supabase-backed implementation of [StacApiService].
///
/// This service reads STAC JSON documents from Supabase tables:
/// - `stac_screens` for screen documents (expects `json` column).
/// - `stac_config` for configuration documents (expects `json` column).
/// - `screen_versions` for version history (optional).
class SupabaseApiService implements StacApiService {
  SupabaseApiService({
    ApiConfig? config,
    SupabaseClient? client,
    SupabaseGateway? gateway,
  }) : config = config ?? _defaultSupabaseConfig() {
    if (gateway != null) {
      _gateway = gateway;
    } else if (client != null) {
      _gateway = SupabaseClientGateway(client);
    } else {
      _gateway = SupabaseClientGateway(_createClient(this.config));
    }

    if (this.config.mode != ApiMode.supabase) {
      throw ArgumentError(
        'SupabaseApiService requires ApiMode.supabase configuration',
      );
    }
  }

  /// API configuration.
  final ApiConfig config;

  late final SupabaseGateway _gateway;

  final Map<String, _CacheEntry> _cache = {};
  int _expiredCacheCount = 0;

  @override
  Future<Map<String, dynamic>> fetchScreen(String screenName) async {
    final cacheKey = 'screen_$screenName';
    final cached = _getCachedData(cacheKey);
    if (cached != null) return cached;

    final record = await _safeGatewayCallNullable(
      () => _gateway.fetchScreen(screenName),
      onNotFound: () => ScreenNotFoundException(screenName),
    );

    final json = _extractJson(
      record,
      'screen',
      screenName,
      jsonColumnName: 'json',
    );
    _cacheData(cacheKey, json);
    return json;
  }

  @override
  Future<Map<String, dynamic>> fetchRoute(String route) async {
    final screenName = _routeToScreen(route);
    return fetchScreen(screenName);
  }

  /// Fetch configuration JSON (navigation, theme, etc.).
  @override
  Future<Map<String, dynamic>> fetchConfig(String configName) async {
    final cacheKey = 'config_$configName';
    final cached = _getCachedData(cacheKey);
    if (cached != null) return cached;

    final record = await _safeGatewayCallNullable(
      () => _gateway.fetchConfig(configName),
      onNotFound: () =>
          ApiException('Configuration $configName not found', statusCode: 404),
    );

    // The stac_config table uses the 'config' column for the JSON payload
    final json = _extractJson(
      record,
      'config',
      configName,
      jsonColumnName: 'config',
    );
    _cacheData(cacheKey, json);
    return json;
  }

  /// List all available screens.
  Future<List<String>> listScreens() async {
    final rows = await _safeGatewayCall(_gateway.listScreens);
    return rows.map((row) => row['name'] as String).toList();
  }

  /// Get lightweight metadata for a screen (without JSON payload).
  Future<Map<String, dynamic>> getScreenMetadata(String screenName) async {
    final record = await _safeGatewayCallNullable(
      () => _gateway.fetchScreen(screenName),
      onNotFound: () => ScreenNotFoundException(screenName),
    );

    final result = Map<String, dynamic>.from(record);
    result.remove('json');
    return result;
  }

  /// Get version history for a screen.
  Future<List<Map<String, dynamic>>> getVersionHistory(
    String screenName,
  ) async {
    return _safeGatewayCall(() => _gateway.getVersionHistory(screenName));
  }

  /// Cache statistics helper for debug tooling.
  Map<String, dynamic> getCacheStats() {
    final now = DateTime.now();
    final validEntries = _cache.entries.where(
      (entry) => now.difference(entry.value.timestamp) <= config.cacheExpiry,
    );

    return {
      'total_cached': _cache.length,
      'valid_cached': validEntries.length,
      'expired_cached': _expiredCacheCount,
      'cache_keys': _cache.keys.toList(),
    };
  }

  @override
  Future<void> refresh() async {
    await clearCache();
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
    _expiredCacheCount = 0;
  }

  @override
  bool isCached(String key) => _isCacheValid(key);

  @override
  Map<String, dynamic>? getCached(String key) => _getCachedData(key);

  Map<String, dynamic>? _getCachedData(String key) {
    if (!_isCacheValid(key)) return null;
    return _cache[key]?.data;
  }

  bool _isCacheValid(String key) {
    if (!config.enableCaching) return false;
    final entry = _cache[key];
    if (entry == null) return false;
    final isExpired =
        DateTime.now().difference(entry.timestamp) > config.cacheExpiry;
    if (isExpired) {
      _cache.remove(key);
      _expiredCacheCount++;
      return false;
    }
    return true;
  }

  void _cacheData(String key, Map<String, dynamic> data) {
    if (!config.enableCaching) return;
    _cache[key] = _CacheEntry(data, DateTime.now());
  }

  Future<T> _safeGatewayCall<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return result;
    } on ScreenNotFoundException {
      rethrow;
    } on ApiException {
      rethrow;
    } on PostgrestException catch (e, stackTrace) {
      throw ApiException(e.message, originalError: e, stackTrace: stackTrace);
    } catch (e, stackTrace) {
      throw ApiException(
        'Supabase request failed',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<T> _safeGatewayCallNullable<T>(
    Future<T?> Function() operation, {
    required Exception Function() onNotFound,
  }) async {
    final result = await _safeGatewayCall(operation);
    if (result == null) {
      throw onNotFound();
    }
    return result;
  }

  Map<String, dynamic> _extractJson(
    Map<String, dynamic> record,
    String kind,
    String identifier, {
    String jsonColumnName = 'json',
  }) {
    final raw = record[jsonColumnName];
    if (raw == null) {
      throw ApiException(
        '$kind $identifier is missing $jsonColumnName payload',
      );
    }
    if (raw is! Map) {
      throw JsonParsingException('Invalid JSON payload for $kind $identifier');
    }
    return Map<String, dynamic>.from(raw);
  }

  String _routeToScreen(String route) {
    if (route.isEmpty || route == '/') {
      return 'home_screen';
    }

    final sanitized = route.replaceAll(RegExp(r'^/+'), '');
    final normalized = sanitized.replaceAll('/', '_');
    if (normalized.endsWith('_screen')) {
      return normalized;
    }
    return '${normalized}_screen';
  }

  static ApiConfig _defaultSupabaseConfig() {
    const url = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    const anonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: '',
    );
    return ApiConfig.supabase(url, anonKey);
  }

  static SupabaseClient _createClient(ApiConfig config) {
    final url = config.supabaseUrl;
    final anonKey = config.supabaseAnonKey;
    if (url == null || anonKey == null || url.isEmpty || anonKey.isEmpty) {
      throw ArgumentError(
        'Supabase API configuration requires supabaseUrl and supabaseAnonKey',
      );
    }
    return SupabaseClient(url, anonKey);
  }
}

/// Abstraction over Supabase operations for easier testing.
abstract class SupabaseGateway {
  Future<Map<String, dynamic>?> fetchScreen(String screenName);

  Future<Map<String, dynamic>?> fetchConfig(String configName);

  Future<List<Map<String, dynamic>>> listScreens();

  Future<List<Map<String, dynamic>>> getVersionHistory(String screenName);
}

class SupabaseClientGateway implements SupabaseGateway {
  SupabaseClientGateway(this.client);

  final SupabaseClient client;

  @override
  Future<Map<String, dynamic>?> fetchScreen(String screenName) {
    return client
        .from('stac_screens')
        .select()
        .eq('name', screenName)
        .maybeSingle();
  }

  @override
  Future<Map<String, dynamic>?> fetchConfig(String configName) {
    return client
        .from('stac_config')
        .select()
        .eq('name', configName)
        .maybeSingle();
  }

  @override
  Future<List<Map<String, dynamic>>> listScreens() {
    return client.from('stac_screens').select('name').order('name');
  }

  @override
  Future<List<Map<String, dynamic>>> getVersionHistory(String screenName) {
    return client
        .from('screen_versions')
        .select()
        .eq('screen', screenName)
        .order('version', ascending: false);
  }
}

class _CacheEntry {
  _CacheEntry(this.data, this.timestamp);

  final Map<String, dynamic> data;
  final DateTime timestamp;
}
