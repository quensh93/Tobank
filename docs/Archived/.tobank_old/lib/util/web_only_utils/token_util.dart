import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../constants.dart';

class TokenUtil {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const int tokenExpiryMinutes = 10; // Token expires after 10 minutes

  TokenUtil._();

  // Generate a short-lived token with an expiry timestamp
  static Future<Map<String, dynamic>> generateShortLivedToken() async {
    try {
      // Generate a random secure token
      const length = 32;
      const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random.secure();
      final token = String.fromCharCodes(
        Iterable.generate(
          length,
              (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );

      // Include an expiry timestamp (current time + 10 minutes)
      final expiry = DateTime.now().add(Duration(minutes: tokenExpiryMinutes)).millisecondsSinceEpoch;

      // Return token data
      final tokenData = {
        'token': token,
        'expiry': expiry,
      };

      // Optionally store the token in secure storage for later validation (if needed)
      await _storage.write(
        key: Constants.temporaryAuthToken,
        value: jsonEncode(tokenData),
      );

      return tokenData;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Store token in secure storage
  static Future<bool> storeToken(String token) async {
    return storeTokenWithKey(token, Constants.temporaryAuthToken);
  }

  // Store token in secure storage with a specific key
  static Future<bool> storeTokenWithKey(String token, String key) async {
    try {
      print('🔑 Storing token in secure storage with key: $key');

      // Include an expiry timestamp (current time + 10 minutes)
      final expiry = DateTime.now().add(Duration(minutes: tokenExpiryMinutes)).millisecondsSinceEpoch;

      // Create token data with the provided token and a new expiry time
      final tokenData = {
        'token': token,
        'expiry': expiry,
      };

      // Store in secure storage
      await _storage.write(
        key: key,
        value: jsonEncode(tokenData),
      );

      print('🔑 Token stored successfully with expiry: ${DateTime.fromMillisecondsSinceEpoch(expiry)}');
      return true;
    } catch (e, stackTrace) {
      print('🔑 Failed to store token: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  // Validate a token's expiry
  static Future<bool> isTokenValid(String token, int expiry) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now > expiry) {
        Sentry.captureMessage('Token has expired', params: [
          {'token': token, 'expiry': expiry, 'now': now}
        ]);
        return false;
      }
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  // Retrieve a stored token (if stored in secure storage)
  static Future<Map<String, dynamic>?> getStoredToken() async {
    return getStoredTokenWithKey(Constants.temporaryAuthToken);
  }

  // Retrieve a stored token with a specific key
  static Future<Map<String, dynamic>?> getStoredTokenWithKey(String key) async {
    try {
      final storedToken = await _storage.read(key: key);
      if (storedToken == null) return null;
      return jsonDecode(storedToken) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }

  // Clear the stored token after use
  static Future<void> clearStoredToken() async {
    await _storage.delete(key: Constants.temporaryAuthToken);
  }

  // Clear a token with a specific key
  static Future<void> clearTokenWithKey(String key) async {
    await _storage.delete(key: key);
  }

  // Test function to manually test TokenUtil functionality
  static Future<void> testTokenUtil() async {
    try {
      print('🔑 Starting TokenUtil test...');

      // 1. Generate a new token
      print('\n🔑 1. Generating new token...');
      final tokenData = await generateShortLivedToken();
      print('🔑 Generated token: ${tokenData['token']}');
      print('🔑 Expiry time: ${DateTime.fromMillisecondsSinceEpoch(tokenData['expiry'])}');

      // 2. Validate the token
      print('\n🔑 2. Validating token...');
      final isValid = await isTokenValid(tokenData['token'], tokenData['expiry']);
      print('🔑 Token is valid: $isValid');

      // 3. Store a specific token
      print('\n🔑 3. Testing storeToken method...');
      final testToken = 'test-token-${DateTime.now().millisecondsSinceEpoch}';
      final storeResult = await storeToken(testToken);
      print('🔑 Token stored successfully: $storeResult');

      // 4. Retrieve stored token
      print('\n🔑 4. Retrieving stored token...');
      final storedToken = await getStoredToken();
      print('🔑 Retrieved token: ${storedToken?['token']}');
      print('🔑 Stored token matches test token: ${storedToken?['token'] == testToken}');

      // 5. Test expired token
      print('\n🔑 5. Testing expired token...');
      final pastExpiry = DateTime.now().subtract(Duration(minutes: 1)).millisecondsSinceEpoch;
      final isExpiredValid = await isTokenValid(testToken, pastExpiry);
      print('🔑 Expired token is valid: $isExpiredValid');

      // 6. Testing custom key storage
      print('\n🔑 6. Testing custom key storage...');
      final customKeyToken = 'custom-key-token-${DateTime.now().millisecondsSinceEpoch}';
      final customKey = 'test_custom_key';
      await storeTokenWithKey(customKeyToken, customKey);
      final customKeyStoredToken = await getStoredTokenWithKey(customKey);
      print('🔑 Custom key token retrieved: ${customKeyStoredToken?['token']}');
      print('🔑 Custom key token matches: ${customKeyStoredToken?['token'] == customKeyToken}');
      await clearTokenWithKey(customKey);

      // 7. Clear the token
      print('\n🔑 7. Clearing token...');
      await clearStoredToken();
      final clearedToken = await getStoredToken();
      print('🔑 Token cleared successfully: ${clearedToken == null}');

      print('\n🔑 TokenUtil test completed successfully!');
    } catch (e) {
      print('🔑 Error during TokenUtil test: $e');
      rethrow;
    }
  }
}