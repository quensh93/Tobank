import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../storage/storage_util.dart';
import '../../utils/app_util.dart';
import '../../../widgets/dialogs/web_pin_dialog.dart';

/// WebAuthn Biometric Service for PWA
/// Uses Web Authentication API (WebAuthn) for biometric authentication
/// For Apple devices, uses password authentication instead of WebAuthn to avoid passkey requirement
class WebBiometricService {
  WebBiometricService._();

  static const String _credentialIdKey = 'webauthn_credential_id';
  static const String _enabledKey = 'webauthn_biometric_enabled';

  static bool _isUserCancelledError(Object error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('notallowederror') ||
        errorString.contains('aborterror') ||
        errorString.contains('user_cancelled') ||
        errorString.contains('cancelled') ||
        errorString.contains('canceled') ||
        errorString.contains('abort') ||
        errorString.contains('not allowed') ||
        errorString.contains('operation was aborted') ||
        errorString.contains('user denied');
  }

  /// Check if the device is an Apple device (iOS/iPadOS)
  /// Public method to check if running on Apple device
  static bool isAppleDevice() {
    try {
      final userAgent = html.window.navigator.userAgent.toLowerCase();
      return userAgent.contains('iphone') ||
          userAgent.contains('ipad') ||
          userAgent.contains('ipod') ||
          (userAgent.contains('macintosh') &&
              userAgent.contains('safari') &&
              !userAgent.contains('chrome'));
    } catch (e) {
      print('Error detecting Apple device: $e');
      return false;
    }
  }

  /// Private method (keeping for backward compatibility)
  static bool _isAppleDevice() => isAppleDevice();

  /// Check if WebAuthn is available in the browser
  static bool isAvailable() {
    try {
      // For Apple devices, we use password authentication instead of WebAuthn
      if (_isAppleDevice()) {
        return true; // Password authentication is always available
      }
      final credentials = html.window.navigator.credentials;
      return credentials != null;
    } catch (e) {
      print('WebAuthn not available: $e');
      return false;
    }
  }

  /// Check if biometric is enabled for this user
  static Future<bool> isEnabled() async {
    try {
      final enabled = html.window.localStorage[_enabledKey];
      return enabled == 'true';
    } catch (e) {
      return false;
    }
  }

  /// Set biometric enabled status
  static Future<void> setEnabled(bool enabled) async {
    try {
      html.window.localStorage[_enabledKey] = enabled.toString();
    } catch (e) {
      print('Error setting biometric enabled: $e');
    }
  }

  /// Check if a credential is already registered
  /// Checks if WebAuthn credential OR password is set (for password fallback)
  static Future<bool> isRegistered() async {
    try {
      // Check if WebAuthn credential is registered
      final credentialId = html.window.localStorage[_credentialIdKey];
      if (credentialId != null && credentialId.isNotEmpty) {
        return true; // WebAuthn credential is registered
      }
      // Fallback: check if password is set (for password authentication fallback)
      final String? storedPassword = await StorageUtil.getPassword();
      return storedPassword != null && storedPassword.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Check whether a real WebAuthn credential is stored.
  /// Unlike [isRegistered], this does not include password fallback state.
  static Future<bool> isPasskeyRegistered() async {
    try {
      final credentialId = html.window.localStorage[_credentialIdKey];
      return credentialId != null && credentialId.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Register a new WebAuthn credential (first time setup)
  /// For Apple devices, tries passkey first (if iCloud available), falls back to password
  /// If passkeyOnly is true, password fallback is disabled (useful for settings toggle)
  static Future<bool> register({
    required String userId,
    bool passkeyOnly = false,
  }) async {
    if (!isAvailable()) {
      print('Authentication is not available');
      return false;
    }

    // For Apple devices, try passkey first (requires iCloud + two-step verification)
    // If passkey fails, fall back to password authentication (unless passkeyOnly is true)
    if (_isAppleDevice()) {
      print(
        '🍎 WebBiometricService - Apple device detected, trying passkey first...',
      );

      // Try to register passkey (WebAuthn with platform authenticator)
      try {
        final challenge = _generateRandomBytes(32);
        final userIdBytes = Uint8List.fromList(utf8.encode(userId));

        // Create credential options for passkey (platform authenticator)
        final publicKeyCredentialCreationOptions = {
          'publicKey': {
            'challenge': challenge,
            'rp': {'name': 'Tobank', 'id': html.window.location.hostname},
            'user': {'id': userIdBytes, 'name': userId, 'displayName': userId},
            'pubKeyCredParams': [
              {'type': 'public-key', 'alg': -7}, // ES256
              {'type': 'public-key', 'alg': -257}, // RS256
            ],
            'authenticatorSelection': {
              'authenticatorAttachment':
                  'platform', // Try passkey (requires iCloud)
              'userVerification': 'required',
              'residentKey': 'preferred',
            },
            'timeout': 60000,
            'attestation': 'none',
          },
        };

        // Try to create passkey credential
        final credential = await _createCredential(
          publicKeyCredentialCreationOptions,
        );

        if (credential != null) {
          // Passkey registration successful (user has iCloud + two-step verification)
          html.window.localStorage[_credentialIdKey] = credential;
          await setEnabled(true);
          print(
            '✅ WebBiometricService - Passkey registered successfully (iCloud available)',
          );
          return true;
        }
      } catch (e) {
        final errorString = e.toString().toLowerCase();
        // Check for cancel/abort errors - Safari/iOS may use different error messages
        // Common WebAuthn cancel errors:
        // - NotAllowedError: The operation either timed out or was not allowed
        // - AbortError: The operation was aborted
        // - USER_CANCELLED: Custom error from some implementations
        final isUserCancelled =
            errorString.contains('notallowederror') ||
            errorString.contains('aborterror') ||
            errorString.contains('user_cancelled') ||
            errorString.contains('cancelled') ||
            errorString.contains('canceled') ||
            errorString.contains('abort') ||
            errorString.contains('not allowed') ||
            errorString.contains('operation was aborted') ||
            errorString.contains('user denied');

        if (isUserCancelled) {
          print(
            '🚫 WebBiometricService - Passkey registration cancelled by user: $e',
          );
          return false; // User cancelled - don't fallback to password
        }
        print(
          '⚠️ WebBiometricService - Passkey registration failed (likely no iCloud): $e',
        );
        // For other errors (like no iCloud), fall through to password authentication
      }

      // Password fallback - only if passkeyOnly is false
      if (!passkeyOnly) {
        // Fallback to password authentication (if passkey failed)
        print(
          '🔐 WebBiometricService - Falling back to password authentication',
        );
        final String? storedPassword = await StorageUtil.getPassword();
        if (storedPassword != null && storedPassword.isNotEmpty) {
          await setEnabled(true);
          print(
            '✅ WebBiometricService - Password authentication enabled (password already set)',
          );
          return true;
        } else {
          print(
            '🔴 WebBiometricService - Password not set. User needs to set a password first.',
          );
          return false;
        }
      } else {
        print(
          '🔐 WebBiometricService - passkeyOnly mode, no password fallback',
        );
        return false;
      }
    }

    try {
      // Create a challenge (in production, this should come from server)
      final challenge = _generateRandomBytes(32);

      // User information
      final userIdBytes = Uint8List.fromList(utf8.encode(userId));

      // Create credential options
      final publicKeyCredentialCreationOptions = _createCredentialOptions(
        challenge: challenge,
        userId: userIdBytes,
        userName: userId,
      );

      // Call navigator.credentials.create via JS interop
      final credential = await _createCredential(
        publicKeyCredentialCreationOptions,
      );

      if (credential != null) {
        // Store credential ID for future authentication
        html.window.localStorage[_credentialIdKey] = credential;
        await setEnabled(true);
        print('WebAuthn credential registered successfully');
        return true;
      }

      // WebAuthn registration returned null - try password fallback
      if (!passkeyOnly) {
        print(
          '🔐 WebBiometricService - WebAuthn returned null, trying password fallback',
        );
        final String? storedPassword = await StorageUtil.getPassword();
        if (storedPassword != null && storedPassword.isNotEmpty) {
          await setEnabled(true);
          print(
            '✅ WebBiometricService - Password authentication enabled (password already set)',
          );
          return true;
        }
      }
      return false;
    } catch (e) {
      final errorString = e.toString().toLowerCase();
      // Check for cancel/abort errors
      final isUserCancelled =
          errorString.contains('notallowederror') ||
          errorString.contains('aborterror') ||
          errorString.contains('user_cancelled') ||
          errorString.contains('cancelled') ||
          errorString.contains('canceled') ||
          errorString.contains('abort') ||
          errorString.contains('not allowed') ||
          errorString.contains('operation was aborted') ||
          errorString.contains('user denied');

      if (isUserCancelled) {
        print(
          '🚫 WebBiometricService - WebAuthn registration cancelled by user: $e',
        );
        return false; // User cancelled - don't fallback to password
      }

      print('Error registering WebAuthn credential: $e');

      // For other errors, try password fallback
      if (!passkeyOnly) {
        print(
          '🔐 WebBiometricService - WebAuthn failed, trying password fallback',
        );
        final String? storedPassword = await StorageUtil.getPassword();
        if (storedPassword != null && storedPassword.isNotEmpty) {
          await setEnabled(true);
          print(
            '✅ WebBiometricService - Password authentication enabled (password already set)',
          );
          return true;
        }
      }
      return false;
    }
  }

  /// Authenticate using password for Apple devices, or WebAuthn for other devices
  /// [reason] is an optional message shown to user
  /// [userId] is optional - if provided and credential doesn't exist, will auto-register
  /// This matches mobile behavior where biometric is requested directly, no credential check needed
  static Future<bool> authenticate({String? reason, String? userId}) async {
    if (!isAvailable()) {
      print('Authentication is not available');
      return false;
    }

    // For Apple devices, try passkey first (if available), fall back to password
    if (_isAppleDevice()) {
      print(
        '🍎 WebBiometricService - Apple device detected, trying passkey first...',
      );

      final credentialId = html.window.localStorage[_credentialIdKey];

      // If credential exists, try to use passkey
      if (credentialId != null && credentialId.isNotEmpty) {
        try {
          final challenge = _generateRandomBytes(32);
          final result = await _getCredential(
            challenge: challenge,
            credentialId: credentialId,
          );

          if (result) {
            print('✅ WebBiometricService - Passkey authentication successful');
            return true;
          }
          // If result is false, it might be cancelled or failed
          // Don't fallback to password if user cancelled
          print(
            '⚠️ WebBiometricService - Passkey authentication returned false',
          );
          return false; // Don't fallback - user might have cancelled
        } catch (e) {
          final errorString = e.toString();
          // Check if user cancelled
          if (errorString.contains('USER_CANCELLED')) {
            print(
              '🚫 WebBiometricService - Passkey authentication cancelled by user',
            );
            return false; // User cancelled - don't fallback to password
          }
          print('⚠️ WebBiometricService - Passkey authentication failed: $e');
          // For other errors, fall through to password authentication
        }
      }

      // If no credential exists and userId is provided, try to register passkey first
      if ((credentialId == null || credentialId.isEmpty) && userId != null) {
        print(
          '🔐 WebBiometricService - No credential found, trying to register passkey...',
        );
        final registered = await register(userId: userId);
        if (!registered) {
          // Registration failed or was cancelled - check if password is available
          // If register returned false due to cancel, we should return false
          // But if it returned false due to password fallback, it would have returned true
          // So if registered is false, it means user cancelled or registration failed
          // In this case, we should fallback to password if available
          print(
            '⚠️ WebBiometricService - Passkey registration failed or cancelled, checking password...',
          );
          // Will fall through to password authentication below
        } else {
          // Registration successful - check if passkey was registered (credential exists now)
          final newCredentialId = html.window.localStorage[_credentialIdKey];
          if (newCredentialId != null && newCredentialId.isNotEmpty) {
            // Passkey was registered, try to authenticate with it
            try {
              final challenge = _generateRandomBytes(32);
              final result = await _getCredential(
                challenge: challenge,
                credentialId: newCredentialId,
              );
              if (result) {
                print(
                  '✅ WebBiometricService - Passkey authentication successful after registration',
                );
                return true;
              }
              // If result is false, don't fallback - user might have cancelled
              print(
                '⚠️ WebBiometricService - Passkey authentication returned false after registration',
              );
              return false;
            } catch (e) {
              final errorString = e.toString();
              // Check if user cancelled
              if (errorString.contains('USER_CANCELLED')) {
                print(
                  '🚫 WebBiometricService - Passkey authentication cancelled by user after registration',
                );
                return false; // User cancelled - don't fallback to password
              }
              print(
                '⚠️ WebBiometricService - Passkey authentication failed after registration: $e',
              );
              // For other errors, fall through to password authentication
            }
          } else {
            // Registration returned true but no credential - means password was enabled
            // Fall through to password authentication
            print(
              '🔐 WebBiometricService - Registration enabled password authentication',
            );
          }
        }
      }

      // Fallback to password authentication
      print('🔐 WebBiometricService - Falling back to password authentication');
      return await _authenticateWithPassword(reason: reason);
    }

    // For non-Apple devices, use WebAuthn with password fallback
    final credentialId = html.window.localStorage[_credentialIdKey];

    // If credential doesn't exist and userId is provided, auto-register (like mobile)
    // In mobile: biometric is requested directly, no credential check needed
    // In Web: if credential doesn't exist, we can auto-register with userId
    if ((credentialId == null || credentialId.isEmpty) && userId != null) {
      print(
        '🔐 WebBiometricService - No credential found, auto-registering with userId: $userId',
      );
      final registered = await register(userId: userId);
      if (!registered) {
        print('🔴 WebBiometricService - Failed to auto-register credential');
        // Fallback to password authentication
        print(
          '🔐 WebBiometricService - Falling back to password authentication',
        );
        return await _authenticateWithPassword(reason: reason);
      }
      print('✅ WebBiometricService - Credential auto-registered successfully');
    } else if (credentialId == null || credentialId.isEmpty) {
      // No credential and no userId provided - try password fallback
      print(
        'No credential registered and no userId provided for auto-registration',
      );
      // Fallback to password authentication
      print('🔐 WebBiometricService - Falling back to password authentication');
      return await _authenticateWithPassword(reason: reason);
    }

    try {
      // Create a challenge (in production, this should come from server)
      final challenge = _generateRandomBytes(32);

      // Get the credentialId again (in case we just registered)
      final currentCredentialId = html.window.localStorage[_credentialIdKey];
      if (currentCredentialId == null || currentCredentialId.isEmpty) {
        print('No credential available after registration attempt');
        // Fallback to password authentication
        print(
          '🔐 WebBiometricService - Falling back to password authentication',
        );
        return await _authenticateWithPassword(reason: reason);
      }

      // Call navigator.credentials.get via JS interop
      // Note: WebAuthn doesn't support custom reason messages,
      // but the browser will show its default biometric prompt
      final result = await _getCredential(
        challenge: challenge,
        credentialId: currentCredentialId,
      );

      if (result) {
        return true;
      }

      // WebAuthn returned false - fallback to password
      print(
        '🔐 WebBiometricService - WebAuthn returned false, falling back to password authentication',
      );
      return await _authenticateWithPassword(reason: reason);
    } catch (e) {
      final errorString = e.toString().toLowerCase();
      // Check for cancel/abort errors
      final isUserCancelled =
          errorString.contains('notallowederror') ||
          errorString.contains('aborterror') ||
          errorString.contains('user_cancelled') ||
          errorString.contains('cancelled') ||
          errorString.contains('canceled') ||
          errorString.contains('abort') ||
          errorString.contains('not allowed') ||
          errorString.contains('operation was aborted') ||
          errorString.contains('user denied');

      if (isUserCancelled) {
        print('🚫 WebBiometricService - WebAuthn cancelled by user: $e');
        return false; // User cancelled - don't fallback to password
      }

      print('Error authenticating with WebAuthn: $e');
      // Fallback to password authentication for other errors
      print('🔐 WebBiometricService - Falling back to password authentication');
      return await _authenticateWithPassword(reason: reason);
    }
  }

  /// Authenticate using password for Apple devices
  /// This avoids the passkey requirement on Apple devices
  static Future<bool> _authenticateWithPassword({String? reason}) async {
    try {
      // Check if password is set
      final String? storedPassword = await StorageUtil.getPassword();
      if (storedPassword == null || storedPassword.isEmpty) {
        print(
          '🔴 WebBiometricService - No password found. User needs to set a password first.',
        );
        return false;
      }

      // Use Get.context or find the current context
      final context = Get.context;
      if (context == null) {
        print(
          '🔴 WebBiometricService - No context available for password dialog',
        );
        return false;
      }

      // Show password dialog and wait for result
      void Function(String)? setErrorCallback;
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return WebPinDialog(
            onDialogCreated: (setError) {
              setErrorCallback = setError;
            },
            onConfirm: (password) async {
              // Encrypt the entered password and compare with stored password
              final encryptedPassword = AppUtil.encryptDataWithAES(
                data: password,
              );
              if (encryptedPassword == storedPassword) {
                Navigator.of(dialogContext).pop(true);
              } else {
                // Show error and keep dialog open
                if (setErrorCallback != null) {
                  setErrorCallback!('رمز عبور اشتباه است');
                }
              }
            },
          );
        },
      );

      // If result is null or false, user cancelled or authentication failed
      final authenticated = result == true;

      if (authenticated) {
        print('✅ WebBiometricService - Password authentication successful');
      } else {
        print(
          '🔴 WebBiometricService - Password authentication cancelled or failed',
        );
      }

      return authenticated;
    } catch (e) {
      print(
        '🔴 WebBiometricService - Error during password authentication: $e',
      );
      return false;
    }
  }

  /// Remove registered credential
  static Future<void> removeCredential() async {
    try {
      html.window.localStorage.remove(_credentialIdKey);
      await setEnabled(false);
    } catch (e) {
      print('Error removing credential: $e');
    }
  }

  /// Generate random bytes for challenge
  static Uint8List _generateRandomBytes(int length) {
    final random = Uint8List(length);
    final crypto = html.window.crypto;
    if (crypto != null) {
      crypto.getRandomValues(random);
    }
    return random;
  }

  /// Create credential options for registration
  static Map<String, dynamic> _createCredentialOptions({
    required Uint8List challenge,
    required Uint8List userId,
    required String userName,
  }) {
    return {
      'publicKey': {
        'challenge': challenge,
        'rp': {'name': 'Tobank', 'id': html.window.location.hostname},
        'user': {'id': userId, 'name': userName, 'displayName': userName},
        'pubKeyCredParams': [
          {'type': 'public-key', 'alg': -7}, // ES256
          {'type': 'public-key', 'alg': -257}, // RS256
        ],
        'authenticatorSelection': {
          // Remove 'platform' requirement to allow cross-platform authenticators
          // This allows password fallback on devices that don't support platform authenticators
          'userVerification':
              'preferred', // Changed from 'required' to 'preferred' to allow password fallback
          'residentKey': 'preferred',
        },
        'timeout': 60000,
        'attestation': 'none',
      },
    };
  }

  /// Create credential using JS interop
  static Future<String?> _createCredential(Map<String, dynamic> options) async {
    try {
      final result = await _jsCreateCredential(options);
      return result;
    } catch (e) {
      print('JS createCredential error: $e');
      return null;
    }
  }

  /// Get credential for authentication using JS interop
  static Future<bool> _getCredential({
    required Uint8List challenge,
    required String credentialId,
  }) async {
    try {
      final result = await _jsGetCredential(challenge, credentialId);
      return result;
    } catch (e) {
      if (_isUserCancelledError(e)) {
        rethrow;
      }
      print('JS getCredential error: $e');
      return false;
    }
  }

  /// JS interop for creating credential
  static Future<String?> _jsCreateCredential(Map<String, dynamic> options) {
    final completer = Completer<String?>();

    // Use the JS function directly through interop

    // Use eval to run the JS code
    final result = html.window.navigator.credentials;
    if (result != null) {
      _executeWebAuthnCreate(options)
          .then((value) {
            completer.complete(value);
          })
          .catchError((e) {
            completer.complete(null);
          });
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  /// JS interop for getting credential (authentication)
  static Future<bool> _jsGetCredential(
    Uint8List challenge,
    String credentialId,
  ) {
    final completer = Completer<bool>();

    _executeWebAuthnGet(challenge, credentialId)
        .then((value) {
          completer.complete(value);
        })
        .catchError((e) {
          if (_isUserCancelledError(e)) {
            completer.completeError(e);
            return;
          }
          completer.complete(false);
        });

    return completer.future;
  }

  /// Execute WebAuthn create using dart:js_interop
  static Future<String?> _executeWebAuthnCreate(
    Map<String, dynamic> options,
  ) async {
    try {
      final publicKeyOptions = options['publicKey'] as Map<String, dynamic>;

      // Create the credential using JS Promise
      final jsPromise = _createCredentialJS(
        (publicKeyOptions['challenge'] as Uint8List).toJS,
        (publicKeyOptions['user']['id'] as Uint8List).toJS,
        (publicKeyOptions['user']['name'] as String).toJS,
        (publicKeyOptions['rp']['name'] as String).toJS,
        (publicKeyOptions['rp']['id'] as String).toJS,
      );

      final result = await jsPromise.toDart;
      return result?.toDart;
    } catch (e) {
      print('Execute WebAuthn create error: $e');
      return null;
    }
  }

  /// Execute WebAuthn get (authenticate) using dart:js_interop
  static Future<bool> _executeWebAuthnGet(
    Uint8List challenge,
    String credentialId,
  ) async {
    try {
      final jsPromise = _getCredentialJS(challenge.toJS, credentialId.toJS);

      final result = await jsPromise.toDart;
      return result?.toDart ?? false;
    } catch (e) {
      if (_isUserCancelledError(e)) {
        rethrow;
      }
      print('Execute WebAuthn get error: $e');
      return false;
    }
  }
}

// JS interop declarations
@JS('window.webAuthnCreate')
external JSPromise<JSString?> _createCredentialJS(
  JSUint8Array challenge,
  JSUint8Array userId,
  JSString userName,
  JSString rpName,
  JSString rpId,
);

@JS('window.webAuthnGet')
external JSPromise<JSBoolean?> _getCredentialJS(
  JSUint8Array challenge,
  JSString credentialId,
);
