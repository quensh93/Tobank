import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication manager for handling token-based authentication
///
/// Manages access tokens, refresh tokens, and automatic token refresh.
/// Uses flutter_secure_storage for secure token storage.
class AuthManager {
  /// Secure storage instance
  final FlutterSecureStorage _storage;

  /// Access token key in secure storage
  static const String _accessTokenKey = 'stac_access_token';

  /// Refresh token key in secure storage
  static const String _refreshTokenKey = 'stac_refresh_token';

  /// Token expiry timestamp key in secure storage
  static const String _tokenExpiryKey = 'stac_token_expiry';

  /// Cached access token (in memory for performance)
  String? _cachedAccessToken;

  /// Cached refresh token (in memory for performance)
  String? _cachedRefreshToken;

  /// Token expiry timestamp
  DateTime? _tokenExpiry;

  /// Token refresh callback
  /// Should return a new access token and optionally a new refresh token
  Future<TokenPair> Function(String refreshToken)? onTokenRefresh;

  /// Token expiry callback
  /// Called when tokens expire and cannot be refreshed
  void Function()? onTokenExpired;

  AuthManager({
    FlutterSecureStorage? storage,
    this.onTokenRefresh,
    this.onTokenExpired,
  }) : _storage = storage ?? const FlutterSecureStorage();

  /// Initialize the auth manager by loading tokens from secure storage
  Future<void> initialize() async {
    _cachedAccessToken = await _storage.read(key: _accessTokenKey);
    _cachedRefreshToken = await _storage.read(key: _refreshTokenKey);

    final expiryString = await _storage.read(key: _tokenExpiryKey);
    if (expiryString != null) {
      _tokenExpiry = DateTime.parse(expiryString);
    }
  }

  /// Get the current access token
  ///
  /// Automatically refreshes the token if it's expired and a refresh token is available.
  /// Returns null if no token is available or refresh fails.
  Future<String?> getAccessToken() async {
    // Check if token is expired
    if (_isTokenExpired()) {
      // Try to refresh the token
      final refreshed = await _refreshTokenIfNeeded();
      if (!refreshed) {
        return null;
      }
    }

    return _cachedAccessToken;
  }

  /// Get the current refresh token
  Future<String?> getRefreshToken() async {
    return _cachedRefreshToken;
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Save authentication tokens
  ///
  /// Stores tokens securely and updates the in-memory cache.
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;
    _tokenExpiry = expiresAt;

    // Save to secure storage
    await _storage.write(key: _accessTokenKey, value: accessToken);

    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }

    if (expiresAt != null) {
      await _storage.write(key: _tokenExpiryKey, value: expiresAt.toIso8601String());
    }
  }

  /// Clear all authentication tokens
  ///
  /// Removes tokens from both memory and secure storage.
  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    _tokenExpiry = null;

    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _tokenExpiryKey);
  }

  /// Refresh the access token using the refresh token
  ///
  /// Returns true if refresh was successful, false otherwise.
  Future<bool> refreshToken() async {
    if (_cachedRefreshToken == null || _cachedRefreshToken!.isEmpty) {
      return false;
    }

    if (onTokenRefresh == null) {
      return false;
    }

    try {
      final tokenPair = await onTokenRefresh!(_cachedRefreshToken!);

      await saveTokens(
        accessToken: tokenPair.accessToken,
        refreshToken: tokenPair.refreshToken ?? _cachedRefreshToken,
        expiresAt: tokenPair.expiresAt,
      );

      return true;
    } catch (e) {
      // Token refresh failed
      await clearTokens();
      onTokenExpired?.call();
      return false;
    }
  }

  /// Check if the current token is expired
  bool _isTokenExpired() {
    if (_tokenExpiry == null) {
      return false; // No expiry set, assume token is valid
    }

    // Add a 1-minute buffer to refresh before actual expiry
    final bufferTime = _tokenExpiry!.subtract(const Duration(minutes: 1));
    return DateTime.now().isAfter(bufferTime);
  }

  /// Refresh token if needed
  Future<bool> _refreshTokenIfNeeded() async {
    if (!_isTokenExpired()) {
      return true; // Token is still valid
    }

    return await refreshToken();
  }

  /// Get time until token expiry
  Duration? getTimeUntilExpiry() {
    if (_tokenExpiry == null) {
      return null;
    }

    final now = DateTime.now();
    if (now.isAfter(_tokenExpiry!)) {
      return Duration.zero;
    }

    return _tokenExpiry!.difference(now);
  }

  /// Check if token will expire soon (within the specified duration)
  bool willExpireSoon(Duration threshold) {
    final timeUntilExpiry = getTimeUntilExpiry();
    if (timeUntilExpiry == null) {
      return false;
    }

    return timeUntilExpiry <= threshold;
  }
}

/// Token pair model
///
/// Contains access token and optional refresh token with expiry information.
class TokenPair {
  /// Access token for API authentication
  final String accessToken;

  /// Refresh token for obtaining new access tokens
  final String? refreshToken;

  /// Token expiry timestamp
  final DateTime? expiresAt;

  const TokenPair({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  /// Create from JSON
  factory TokenPair.fromJson(Map<String, dynamic> json) {
    return TokenPair(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : json['expires_in'] != null
              ? DateTime.now().add(Duration(seconds: json['expires_in'] as int))
              : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (expiresAt != null) 'expires_at': expiresAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TokenPair(accessToken: ${accessToken.substring(0, 10)}..., '
        'hasRefreshToken: ${refreshToken != null}, expiresAt: $expiresAt)';
  }
}
