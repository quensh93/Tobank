import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for sensitive configuration data
///
/// Uses flutter_secure_storage to securely store API keys, tokens,
/// and Supabase configuration on the device.
class SecureConfigStorage {
  /// Singleton instance
  static final SecureConfigStorage instance = SecureConfigStorage._();

  /// Private constructor
  SecureConfigStorage._();

  /// Flutter secure storage instance
  late final FlutterSecureStorage _storage;

  /// Whether the storage has been initialized
  bool _initialized = false;

  /// Storage keys
  static const String _apiKeyKey = 'stac_api_key';
  static const String _authTokenKey = 'stac_auth_token';
  static const String _refreshTokenKey = 'stac_refresh_token';
  static const String _supabaseConfigKey = 'stac_Supabase_config';
  static const String _customApiUrlKey = 'stac_custom_api_url';
  static const String _userCredentialsKey = 'stac_user_credentials';
  static const String _encryptionKeyKey = 'stac_encryption_key';

  /// Initialize secure storage
  ///
  /// Should be called once during app initialization.
  Future<void> initialize() async {
    if (_initialized) return;

    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );

    _initialized = true;
  }

  /// Ensure storage is initialized
  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'SecureConfigStorage not initialized. Call initialize() first.',
      );
    }
  }

  // ==================== API Key Management ====================

  /// Save API key securely
  ///
  /// Stores the API key in encrypted storage.
  Future<void> saveApiKey(String apiKey) async {
    _ensureInitialized();

    if (apiKey.isEmpty) {
      throw ArgumentError('API key cannot be empty');
    }

    await _storage.write(key: _apiKeyKey, value: apiKey);
  }

  /// Get API key
  ///
  /// Retrieves the stored API key, or null if not set.
  Future<String?> getApiKey() async {
    _ensureInitialized();
    return await _storage.read(key: _apiKeyKey);
  }

  /// Delete API key
  ///
  /// Removes the API key from secure storage.
  Future<void> deleteApiKey() async {
    _ensureInitialized();
    await _storage.delete(key: _apiKeyKey);
  }

  /// Check if API key exists
  Future<bool> hasApiKey() async {
    _ensureInitialized();
    final apiKey = await getApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }

  // ==================== Authentication Tokens ====================

  /// Save authentication token
  ///
  /// Stores the auth token securely.
  Future<void> saveAuthToken(String token) async {
    _ensureInitialized();

    if (token.isEmpty) {
      throw ArgumentError('Auth token cannot be empty');
    }

    await _storage.write(key: _authTokenKey, value: token);
  }

  /// Get authentication token
  ///
  /// Retrieves the stored auth token, or null if not set.
  Future<String?> getAuthToken() async {
    _ensureInitialized();
    return await _storage.read(key: _authTokenKey);
  }

  /// Delete authentication token
  Future<void> deleteAuthToken() async {
    _ensureInitialized();
    await _storage.delete(key: _authTokenKey);
  }

  /// Save refresh token
  ///
  /// Stores the refresh token securely.
  Future<void> saveRefreshToken(String token) async {
    _ensureInitialized();

    if (token.isEmpty) {
      throw ArgumentError('Refresh token cannot be empty');
    }

    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Get refresh token
  ///
  /// Retrieves the stored refresh token, or null if not set.
  Future<String?> getRefreshToken() async {
    _ensureInitialized();
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Delete refresh token
  Future<void> deleteRefreshToken() async {
    _ensureInitialized();
    await _storage.delete(key: _refreshTokenKey);
  }

  /// Clear all authentication tokens
  ///
  /// Removes both auth and refresh tokens.
  Future<void> clearAuthTokens() async {
    _ensureInitialized();
    await Future.wait([deleteAuthToken(), deleteRefreshToken()]);
  }

  // ==================== Supabase Configuration ====================

  /// Save Supabase configuration
  ///
  /// Stores Supabase config (project ID, API key, etc.) securely.
  Future<void> saveSupabaseConfig(Map<String, String> config) async {
    _ensureInitialized();

    if (config.isEmpty) {
      throw ArgumentError('Supabase config cannot be empty');
    }

    final jsonString = jsonEncode(config);
    await _storage.write(key: _supabaseConfigKey, value: jsonString);
  }

  /// Get Supabase configuration
  ///
  /// Retrieves the stored Supabase config, or null if not set.
  Future<Map<String, String>?> getSupabaseConfig() async {
    _ensureInitialized();

    final jsonString = await _storage.read(key: _supabaseConfigKey);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      // Invalid JSON, return null
      return null;
    }
  }

  /// Delete Supabase configuration
  Future<void> deleteSupabaseConfig() async {
    _ensureInitialized();
    await _storage.delete(key: _supabaseConfigKey);
  }

  /// Check if Supabase config exists
  Future<bool> hasSupabaseConfig() async {
    _ensureInitialized();
    final config = await getSupabaseConfig();
    return config != null && config.isNotEmpty;
  }

  // ==================== Custom API Configuration ====================

  /// Save custom API URL
  ///
  /// Stores the custom API base URL securely.
  Future<void> saveCustomApiUrl(String url) async {
    _ensureInitialized();

    if (url.isEmpty) {
      throw ArgumentError('API URL cannot be empty');
    }

    // Validate URL format
    if (!url.startsWith('https://')) {
      throw ArgumentError('API URL must use HTTPS protocol');
    }

    await _storage.write(key: _customApiUrlKey, value: url);
  }

  /// Get custom API URL
  ///
  /// Retrieves the stored custom API URL, or null if not set.
  Future<String?> getCustomApiUrl() async {
    _ensureInitialized();
    return await _storage.read(key: _customApiUrlKey);
  }

  /// Delete custom API URL
  Future<void> deleteCustomApiUrl() async {
    _ensureInitialized();
    await _storage.delete(key: _customApiUrlKey);
  }

  // ==================== User Credentials ====================

  /// Save user credentials
  ///
  /// Stores username and password securely.
  /// Note: This should only be used if absolutely necessary.
  /// Prefer token-based authentication.
  Future<void> saveUserCredentials({
    required String username,
    required String password,
  }) async {
    _ensureInitialized();

    if (username.isEmpty || password.isEmpty) {
      throw ArgumentError('Username and password cannot be empty');
    }

    final credentials = {
      'username': username,
      'password': password,
      'saved_at': DateTime.now().toIso8601String(),
    };

    final jsonString = jsonEncode(credentials);
    await _storage.write(key: _userCredentialsKey, value: jsonString);
  }

  /// Get user credentials
  ///
  /// Retrieves stored credentials, or null if not set.
  Future<Map<String, String>?> getUserCredentials() async {
    _ensureInitialized();

    final jsonString = await _storage.read(key: _userCredentialsKey);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      return {
        'username': decoded['username'] as String,
        'password': decoded['password'] as String,
        'saved_at': decoded['saved_at'] as String,
      };
    } catch (e) {
      // Invalid JSON, return null
      return null;
    }
  }

  /// Delete user credentials
  Future<void> deleteUserCredentials() async {
    _ensureInitialized();
    await _storage.delete(key: _userCredentialsKey);
  }

  // ==================== Encryption Key Management ====================

  /// Save encryption key
  ///
  /// Stores an encryption key for additional data encryption.
  Future<void> saveEncryptionKey(String key) async {
    _ensureInitialized();

    if (key.isEmpty) {
      throw ArgumentError('Encryption key cannot be empty');
    }

    await _storage.write(key: _encryptionKeyKey, value: key);
  }

  /// Get encryption key
  ///
  /// Retrieves the stored encryption key, or null if not set.
  Future<String?> getEncryptionKey() async {
    _ensureInitialized();
    return await _storage.read(key: _encryptionKeyKey);
  }

  /// Delete encryption key
  Future<void> deleteEncryptionKey() async {
    _ensureInitialized();
    await _storage.delete(key: _encryptionKeyKey);
  }

  // ==================== Generic Storage ====================

  /// Save generic secure value
  ///
  /// Stores any string value securely with a custom key.
  Future<void> saveSecureValue(String key, String value) async {
    _ensureInitialized();

    if (key.isEmpty) {
      throw ArgumentError('Key cannot be empty');
    }

    await _storage.write(key: 'stac_custom_$key', value: value);
  }

  /// Get generic secure value
  ///
  /// Retrieves a stored value by key, or null if not set.
  Future<String?> getSecureValue(String key) async {
    _ensureInitialized();

    if (key.isEmpty) {
      throw ArgumentError('Key cannot be empty');
    }

    return await _storage.read(key: 'stac_custom_$key');
  }

  /// Delete generic secure value
  Future<void> deleteSecureValue(String key) async {
    _ensureInitialized();

    if (key.isEmpty) {
      throw ArgumentError('Key cannot be empty');
    }

    await _storage.delete(key: 'stac_custom_$key');
  }

  // ==================== Utility Methods ====================

  /// Clear all stored data
  ///
  /// Removes all data from secure storage.
  /// Use with caution - this cannot be undone.
  Future<void> clearAll() async {
    _ensureInitialized();
    await _storage.deleteAll();
  }

  /// Get all stored keys
  ///
  /// Returns a list of all keys currently stored.
  /// Useful for debugging and migration.
  Future<List<String>> getAllKeys() async {
    _ensureInitialized();

    final all = await _storage.readAll();
    return all.keys.toList();
  }

  /// Check if storage contains a key
  Future<bool> containsKey(String key) async {
    _ensureInitialized();
    return await _storage.containsKey(key: key);
  }

  /// Export configuration (for backup/migration)
  ///
  /// Returns a map of non-sensitive configuration data.
  /// Does NOT include passwords or tokens.
  Future<Map<String, dynamic>> exportConfig() async {
    _ensureInitialized();

    final config = <String, dynamic>{};

    // Export non-sensitive data only
    final customApiUrl = await getCustomApiUrl();
    if (customApiUrl != null) {
      config['custom_api_url'] = customApiUrl;
    }

    final hasApiKey = await this.hasApiKey();
    config['has_api_key'] = hasApiKey;

    final hasSupabaseConfig = await this.hasSupabaseConfig();
    config['has_Supabase_config'] = hasSupabaseConfig;

    return config;
  }

  /// Get storage statistics
  ///
  /// Returns information about stored items for debugging.
  Future<Map<String, dynamic>> getStorageStats() async {
    _ensureInitialized();

    final all = await _storage.readAll();

    return {
      'total_items': all.length,
      'has_api_key': await hasApiKey(),
      'has_auth_token': await getAuthToken() != null,
      'has_refresh_token': await getRefreshToken() != null,
      'has_Supabase_config': await hasSupabaseConfig(),
      'has_custom_api_url': await getCustomApiUrl() != null,
      'has_user_credentials': await getUserCredentials() != null,
      'has_encryption_key': await getEncryptionKey() != null,
    };
  }
}
