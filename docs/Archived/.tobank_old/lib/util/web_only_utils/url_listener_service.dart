import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_html/html.dart' as html;

import 'token_util.dart';

/// A service to manage URL changes in a Flutter Web app.
class UrlService {
  // Key for storing URL tokens separately
  static const String urlTokenKey = 'tempTokenFromUrl';

  // Singleton instance for easy access.
  static final UrlService instance = UrlService._internal();

  // StreamController to emit URL changes.
  final _urlStreamController = StreamController<Uri>.broadcast();

  // Current parsed URI.
  Uri _currentUri;

  // Private constructor for singleton pattern.
  UrlService._internal() : _currentUri = _parseUri(html.window.location.href) {
    debugPrint('🔵 UrlService initialized with initial URI: $_currentUri');
    Sentry.captureMessage(
      'UrlService initialized',
      params: [
        {'initialUri': _currentUri.toString()},
      ],
      level: SentryLevel.info,
    );

    // Initialize the current URI.
    _updateCurrentUri();
    // Listen for popstate events (triggered by back/forward or pushState).
    html.window.onPopState.listen((event) {
      debugPrint('🔵 Popstate event triggered');
      Sentry.captureMessage(
        'Popstate event triggered',
        params: [
          {'currentUri': _currentUri.toString()},
        ],
        level: SentryLevel.info,
      );
      _updateCurrentUri();
      _urlStreamController.add(_currentUri);
    });
  }

  /// Static method to parse URI with error handling.
  static Uri _parseUri(String uriString) {
    try {
      // Ensure no hash (#) remains (though PathUrlStrategy should handle this).
      final cleanedUriString = uriString.split('#').first;

      // Handle HTML-encoded ampersands in the URL (fix for &amp; issues)
      String decodedUriString = cleanedUriString.replaceAll('&amp;', '&');

      return Uri.parse(decodedUriString);
    } catch (e) {
      debugPrint('🔵 Error parsing URI: $e');
      Sentry.captureMessage(
        'Error parsing URI',
        params: [
          {'uriString': uriString},
          {'error': e.toString()},
        ],
        level: SentryLevel.error,
      );
      return Uri();
    }
  }

  /// Check if current URL is a callback URL
  bool get isCallbackUrl {
    return _currentUri.path.contains('/callback');
  }

  /// Static method to check URL for token and save it with a special key.
  static Future<void> checkAndSaveToken() async {
    final currentUri = _parseUri(html.window.location.href);
    debugPrint('🔵 Checking URL for token: $currentUri');
    debugPrint('🔵 Query parameters: ${currentUri.queryParameters}');

    // Extract token from URL
    String? token;

    // First, try to get token directly from query parameters
    token = currentUri.queryParameters['token'];

    // If not found and we're on a callback URL, look more carefully
    if ((token == null || token.isEmpty) && currentUri.path.contains('/callback')) {
      debugPrint('🔵 Callback URL detected, checking all parameters thoroughly');

      // Log all query parameters for debugging
      currentUri.queryParameters.forEach((key, value) {
        debugPrint('🔵 Query param: $key = $value');
      });

      // Double-check HTML-encoded parameters
      final rawUrl = html.window.location.href;
      debugPrint('🔵 Raw URL: $rawUrl');

      // Try looking for token pattern in the raw URL
      final tokenRegex = RegExp(r'token=([^&]+)');
      final match = tokenRegex.firstMatch(rawUrl);
      if (match != null && match.groupCount >= 1) {
        token = match.group(1);
        debugPrint('🔵 Token extracted via regex: $token');
      }
    }

    if (token != null && token.isNotEmpty) {
      print('🔊 Token found in URL: ${token.length > 10 ? token.substring(0, 10) + '...' : token}');
      await _saveUrlToken(token);

      // Remove the token from URL to prevent reuse
      if (currentUri.queryParameters.containsKey('token')) {
        final newParams = Map<String, String>.from(currentUri.queryParameters);
        newParams.remove('token');
        html.window.history.replaceState(null, '',
            Uri(
              path: currentUri.path,
              queryParameters: newParams.isEmpty ? null : newParams,
            ).toString());
      }
    } else {
      print('🔊 No token found in URL, clearing URL token storage');
      await _clearUrlToken();
    }
  }

  /// Save token from URL with a special key
  static Future<void> _saveUrlToken(String token) async {
    try {
      print('🔑 Saving URL token to storage: ${token.length > 10 ? token.substring(0, 10) + '...' : token}');

      // Save the token to secure storage with the URL token key
      final success = await TokenUtil.storeTokenWithKey(token, urlTokenKey);

      if (success) {
        print('🔑 ✅ URL token successfully saved to secure storage');
      } else {
        print('🔑 ❌ Failed to save URL token to secure storage');
      }

      Sentry.captureMessage(
        'URL token storage attempt',
        params: [
          {'success': success},
          {'tokenLength': token.length},
        ],
        level: success ? SentryLevel.info : SentryLevel.error,
      );
    } catch (e, stackTrace) {
      print('🔑 ❌ Error saving URL token to storage: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  /// Clear the URL token from storage
  static Future<void> _clearUrlToken() async {
    try {
      await TokenUtil.clearTokenWithKey(urlTokenKey);
      print('🔑 ✅ URL token cleared from storage');
    } catch (e, stackTrace) {
      print('🔑 ❌ Error clearing URL token: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  /// Get the URL token if it exists
  static Future<String?> getUrlToken() async {
    try {
      final tokenData = await TokenUtil.getStoredTokenWithKey(urlTokenKey);
      if (tokenData != null) {
        final token = tokenData['token'] as String?;
        final expiry = tokenData['expiry'] as int?;

        if (token != null && expiry != null) {
          // Check if token is still valid
          final isValid = await TokenUtil.isTokenValid(token, expiry);
          if (isValid) {
            return token;
          } else {
            print('🔑 URL token has expired, clearing');
            await _clearUrlToken();
            return null;
          }
        }
      }
      return null;
    } catch (e, stackTrace) {
      print('🔑 ❌ Error getting URL token: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Stream of URI changes.
  Stream<Uri> get onUrlChanged => _urlStreamController.stream;

  /// Get the current URL as a parsed [Uri].
  Uri get currentUri => _currentUri;

  /// Get the current query parameters.
  Map<String, String> get queryParameters => _currentUri.queryParameters;

  /// Get the current path.
  String get path => _currentUri.path;

  /// Update the current URI and notify listeners.
  void _updateCurrentUri() {
    _currentUri = _parseUri(html.window.location.href);
    debugPrint('🔵 Updated current URI to: $_currentUri');
    Sentry.captureMessage(
      'Updated current URI',
      params: [
        {'currentUri': _currentUri.toString()},
        {'queryParameters': _currentUri.queryParameters.toString()},
      ],
      level: SentryLevel.info,
    );
  }

  /// Parse a transaction ID from the URL if it exists
  String? getTransactionId() {
    if (_currentUri.queryParameters.containsKey('transaction')) {
      return _currentUri.queryParameters['transaction'];
    }
    return null;
  }

  /// Get the device parameter from URL if it exists
  String? getDeviceParameter() {
    if (_currentUri.queryParameters.containsKey('device')) {
      return _currentUri.queryParameters['device'];
    }
    return null;
  }

  /// Programmatically push a new URL state (without reloading).
  void pushState({String? path, Map<String, String>? queryParameters}) {
    final newUri = Uri(
      path: path ?? _currentUri.path,
      queryParameters: queryParameters ?? _currentUri.queryParameters,
    );
    debugPrint('🔵 Pushing new state with URI: $newUri');
    html.window.history.pushState(null, '', newUri.toString());
    Sentry.captureMessage(
      'Pushed new URL state',
      params: [
        {'newUri': newUri.toString()},
      ],
      level: SentryLevel.info,
    );
    _updateCurrentUri();
    _urlStreamController.add(_currentUri);
  }

  /// Programmatically replace the current URL state (without adding to history).
  void replaceState({String? path, Map<String, String>? queryParameters}) {
    final newUri = Uri(
      path: path ?? _currentUri.path,
      queryParameters: queryParameters ?? _currentUri.queryParameters,
    );
    debugPrint('🔵 Replacing state with URI: $newUri');
    html.window.history.replaceState(null, '', newUri.toString());
    Sentry.captureMessage(
      'Replaced current URL state',
      params: [
        {'newUri': newUri.toString()},
      ],
      level: SentryLevel.info,
    );
    _updateCurrentUri();
    _urlStreamController.add(_currentUri);
  }

  /// Dispose of the service to prevent memory leaks.
  void dispose() {
    debugPrint('🔵 Disposing UrlService');
    Sentry.captureMessage(
      'Disposing UrlService',
      params: [],
      level: SentryLevel.info,
    );
    _urlStreamController.close();
  }
}