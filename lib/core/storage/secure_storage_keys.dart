/// Enum-based key management for secure storage
/// 
/// This enum provides type-safe, centralized key management for secure storage.
/// Benefits:
/// - Type safety: Compile-time checking prevents typos
/// - Code readability: Clear, descriptive key names
/// - Centralized management: All keys in one place
/// - Easy refactoring: IDE can rename all occurrences
/// - IntelliSense support: Auto-completion for key names
enum SecureStorageKeys {
  // Authentication keys
  uid,
  token,
  refreshToken,
  isLogin,
  
  // User profile keys
  username,
  fullName,
  firstName,
  lastName,
  email,
  phoneNumber,
  
  // Device keys
  fcmToken,
  deviceId,
  
  // API keys
  apiKey,
  apiSecret,
  
  // App settings (sensitive)
  biometricEnabled,
  autoLoginEnabled,
  
  // Session keys
  sessionId,
  lastLoginTime,
  
  // Security keys
  pinCode,
  biometricData,
  
  // Custom keys (add more as needed)
  customKey1,
  customKey2,
  customKey3,
}

/// Extension to provide additional functionality for SecureStorageKeys
extension SecureStorageKeysExtension on SecureStorageKeys {
  /// Get the string representation of the key
  String get key => name;
  
  /// Get a human-readable description of the key
  String get description {
    switch (this) {
      case SecureStorageKeys.uid:
        return 'User ID';
      case SecureStorageKeys.token:
        return 'Authentication Token';
      case SecureStorageKeys.refreshToken:
        return 'Refresh Token';
      case SecureStorageKeys.isLogin:
        return 'Login Status';
      case SecureStorageKeys.username:
        return 'Username';
      case SecureStorageKeys.fullName:
        return 'Full Name';
      case SecureStorageKeys.firstName:
        return 'First Name';
      case SecureStorageKeys.lastName:
        return 'Last Name';
      case SecureStorageKeys.email:
        return 'Email Address';
      case SecureStorageKeys.phoneNumber:
        return 'Phone Number';
      case SecureStorageKeys.fcmToken:
        return 'Push Notification Token';
      case SecureStorageKeys.deviceId:
        return 'Device ID';
      case SecureStorageKeys.apiKey:
        return 'API Key';
      case SecureStorageKeys.apiSecret:
        return 'API Secret';
      case SecureStorageKeys.biometricEnabled:
        return 'Biometric Authentication Enabled';
      case SecureStorageKeys.autoLoginEnabled:
        return 'Auto Login Enabled';
      case SecureStorageKeys.sessionId:
        return 'Session ID';
      case SecureStorageKeys.lastLoginTime:
        return 'Last Login Time';
      case SecureStorageKeys.pinCode:
        return 'PIN Code';
      case SecureStorageKeys.biometricData:
        return 'Biometric Data';
      case SecureStorageKeys.customKey1:
        return 'Custom Key 1';
      case SecureStorageKeys.customKey2:
        return 'Custom Key 2';
      case SecureStorageKeys.customKey3:
        return 'Custom Key 3';
    }
  }
  
  /// Check if this key is considered highly sensitive
  bool get isHighlySensitive {
    switch (this) {
      case SecureStorageKeys.token:
      case SecureStorageKeys.refreshToken:
      case SecureStorageKeys.apiKey:
      case SecureStorageKeys.apiSecret:
      case SecureStorageKeys.pinCode:
      case SecureStorageKeys.biometricData:
        return true;
      default:
        return false;
    }
  }
  
  /// Check if this key should be cleared on logout
  bool get shouldClearOnLogout {
    switch (this) {
      case SecureStorageKeys.token:
      case SecureStorageKeys.refreshToken:
      case SecureStorageKeys.isLogin:
      case SecureStorageKeys.sessionId:
      case SecureStorageKeys.lastLoginTime:
        return true;
      default:
        return false;
    }
  }
}
