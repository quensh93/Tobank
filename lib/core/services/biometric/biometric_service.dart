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

  /// Check whether biometric/passkey is already registered for current user.
  /// On web this checks local credential/password state.
  /// On native this maps to biometric availability.
  static Future<bool> isRegistered() async {
    if (kIsWeb) {
      return WebBiometricService.isRegistered();
    }
    return isAvailable();
  }

  /// Explicit registration step for web biometric (passkey/password fallback).
  /// Native local_auth has no registration step, so this returns false.
  static Future<bool> register({
    required String userId,
    bool passkeyOnly = false,
  }) async {
    if (!kIsWeb) {
      return false;
    }
    return WebBiometricService.register(
      userId: userId,
      passkeyOnly: passkeyOnly,
    );
  }

  /// Authenticate the user
  /// [reason] - Message to show (e.g., "Please authenticate to sign")
  /// [userId] - Optional context only (no implicit registration)
  static Future<bool> authenticate({
    String reason = 'لطفا احراز هویت کنید',
    String? userId,
  }) async {
    if (kIsWeb) {
      if (userId != null && userId.isNotEmpty) {
        debugPrint(
          'BiometricService.authenticate ignores userId on web; use register() for credential creation.',
        );
      }
      return await WebBiometricService.authenticate(
        reason: reason,
        userId: null,
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
