import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
// Conditional import to support both web and native
import 'web_biometric_service.dart'
    if (dart.library.io) 'non_web_biometric_service.dart';

/// Unified Biometric Service
/// Abstracts the difference between Native (local_auth) and Web (WebBiometricService)
class BiometricService {
  static final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if biometrics are available
  static Future<bool> isAvailable() async {
    if (kIsWeb) {
      return WebBiometricService.isAvailable();
    } else {
      try {
        final bool canAuthenticateWithBiometrics =
            await _localAuth.canCheckBiometrics;
        final bool canAuthenticate =
            canAuthenticateWithBiometrics ||
            await _localAuth.isDeviceSupported();
        return canAuthenticate;
      } catch (e) {
        debugPrint('Error checking biometric availability: $e');
        return false;
      }
    }
  }

  /// Authenticate the user
  /// [reason] - Message to show (e.g., "Please authenticate to sign")
  /// [userId] - Optional, used for Web registration if needed
  static Future<bool> authenticate({
    String reason = 'لطفا احراز هویت کنید',
    String? userId,
  }) async {
    if (kIsWeb) {
      // Web implementation
      return await WebBiometricService.authenticate(
        reason: reason,
        userId: userId,
      );
    } else {
      // Native implementation via local_auth
      try {
        return await _localAuth.authenticate(
          localizedReason: reason,
          // options: const AuthenticationOptions(stickyAuth: true, biometricOnly: false),
        );
      } catch (e) {
        debugPrint('Error authenticating: $e');
        return false;
      }
    }
  }
}
