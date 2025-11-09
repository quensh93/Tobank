# flutter_secure_storage - Secure Data Storage for Flutter

[![flutter_secure_storage version](https://img.shields.io/pub/v/flutter_secure_storage)](https://pub.dev/packages/flutter_secure_storage)

**flutter_secure_storage** is a Flutter plugin that provides secure storage for sensitive data using platform-specific secure storage mechanisms.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Platform Support](#platform-support)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
  - [Android](#android-configuration)
  - [iOS/macOS](#ioss-macos-configuration)
  - [Web](#web-configuration)
  - [Linux](#linux-configuration)
  - [Windows](#windows-configuration)
- [Usage Examples](#usage-examples)
- [API Reference](#api-reference)
- [Best Practices](#best-practices)
- [Integration with fpdart](#integration-with-fpdart)
- [Troubleshooting](#troubleshooting)

## Introduction

This package provides a secure way to store sensitive data (like tokens, passwords, API keys) in your Flutter application using:

- **iOS**: Keychain
- **Android**: AES encryption with RSA-secured KeyStore (or EncryptedSharedPreferences)
- **macOS**: Keychain
- **Linux**: libsecret
- **Web**: WebCrypto API
- **Windows**: Windows Credential Manager

### Key Features

- ✅ Cross-platform secure storage
- ✅ Encrypted data storage
- ✅ Keychain/KeyStore integration
- ✅ Support for sensitive data like tokens and credentials
- ✅ Configurable accessibility options

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_secure_storage: ^9.2.4
```

Install dependencies:

```bash
flutter pub get
```

## Platform Support

| Platform | Status | Storage Method |
|----------|--------|----------------|
| Android | ✅ | KeyStore / EncryptedSharedPreferences |
| iOS | ✅ | Keychain |
| macOS | ✅ | Keychain |
| Web | ⚠️ | WebCrypto (experimental) |
| Linux | ✅ | libsecret |
| Windows | ⚠️ | Credential Manager (limited support) |

## Getting Started

### Basic Usage

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage instance
final storage = FlutterSecureStorage();

// Write a value
await storage.write(key: 'token', value: 'my-secret-token');

// Read a value
String? value = await storage.read(key: 'token');

// Delete a value
await storage.delete(key: 'token');

// Delete all values
await storage.deleteAll();

// Read all values
Map<String, String> allValues = await storage.readAll();
```

## Configuration

### Android Configuration

#### 1. Minimum SDK Version

In `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        minSdkVersion 18  // Required
    }
}
```

#### 2. Backend Configuration (Optional)

Prevent Google Drive backup issues by configuring in `AndroidManifest.xml`:

```xml
<application
    android:allowBackup="false">
    <!-- ... -->
</application>
```

Or exclude only the secure storage:

```xml
<application>
    <meta-data
        android:name="android:allowBackup"
        android:value="true" />
    
    <android:fullBackupContent>
        <include domain="sharedpref" path="." />
        <exclude domain="sharedpref" path="FlutterSecureStorage/" />
    </android:fullBackupContent>
</application>
```

#### 3. EncryptedSharedPreferences (Optional)

To use `EncryptedSharedPreferences` instead of KeyStore:

```dart
AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
```

**Important**: Pass options to the constructor, not to individual functions!

### iOS/macOS Configuration

#### macOS Keychain

For macOS, add to both `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<key>keychain-access-groups</key>
<array/>
```

#### iOS Keychain Accessibility

Control when keychain items can be accessed:

```dart
final options = IOSOptions(
  accessibility: KeychainAccessibility.first_unlock,
);

await storage.write(
  key: 'token',
  value: 'my-token',
  iOptions: options,
);
```

Available options:
- `first_unlock` - Accessible after first unlock
- `first_unlock_this_device` - Accessible after first unlock on this device
- `unlocked` - Always accessible (default)

### Web Configuration

⚠️ **Warning**: Web implementation is experimental and has limitations.

**Requirements**:
- HTTP Strict Transport Security (HSTS) enabled
- Proper security headers configured

The storage is:
- **Browser-specific**: Data only works in the same browser
- **Domain-specific**: Tied to the current domain
- **Non-portable**: Cannot transfer between browsers or machines

See:
- [HSTS Guide](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security)
- [Security Headers Guide](https://www.netsparker.com/blog/web-security/http-security-headers/)

### Linux Configuration

Install required dependencies:

**Build dependencies:**
```bash
sudo apt-get install libsecret-1-dev libjsoncpp-dev
```

**Runtime dependencies:**
```bash
sudo apt-get install libsecret-1-0 libjsoncpp1
```

**For Snapcraft:**

```yaml
parts:
  your-app:
    build-packages:
      - libsecret-1-dev
      - libjsoncpp-dev
    stage-packages:
      - libsecret-1-0
      - libjsoncpp1
```

### Windows Configuration

⚠️ **Limitations**:
- `readAll()` not supported
- `deleteAll()` not supported
- Subject to change

## Usage Examples

### Storing Authentication Tokens

```dart
class AuthService {
  final _storage = FlutterSecureStorage();
  
  // Store token
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  // Retrieve token
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  // Delete token on logout
  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }
  
  // Clear all stored data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
```

### Storing User Credentials

```dart
class CredentialManager {
  final _storage = FlutterSecureStorage();
  
  Future<void> saveCredentials({
    required String username,
    required String password,
  }) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }
  
  Future<Map<String, String?>> getCredentials() async {
    final username = await _storage.read(key: 'username');
    final password = await _storage.read(key: 'password');
    
    return {
      'username': username,
      'password': password,
    };
  }
}
```

### Conditional Storage Access (iOS)

```dart
class SecurePreferences {
  final _storage = FlutterSecureStorage();
  
  // Store data accessible after first unlock
  Future<void> storeDataAfterUnlock(String key, String value) async {
    final options = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    );
    
    await _storage.write(
      key: key,
      value: value,
      iOptions: options,
    );
  }
  
  // Store data with biometric protection
  Future<void> storeWithBiometric(String key, String value) async {
    final options = IOSOptions(
      accessibility: KeychainAccessibility.whenPasscodeSetThisDeviceOnly,
    );
    
    await _storage.write(
      key: key,
      value: value,
      iOptions: options,
    );
  }
}
```

### Platform-Specific Options

```dart
class PlatformAwareStorage {
  // Android with EncryptedSharedPreferences
  FlutterSecureStorage getAndroidStorage() {
    final androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    
    return FlutterSecureStorage(aOptions: androidOptions);
  }
  
  // iOS with specific accessibility
  Future<void> writeForiOS(String key, String value) async {
    final iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      accountName: 'my_app', // Optional account grouping
    );
    
    await FlutterSecureStorage().write(
      key: key,
      value: value,
      iOptions: iosOptions,
    );
  }
}
```

## API Reference

### FlutterSecureStorage Constructor

```dart
FlutterSecureStorage({
  AndroidOptions? aOptions,
  IOSOptions? iOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

### Methods

#### `write()`

Write a key-value pair to secure storage.

```dart
Future<void> write({
  required String key,
  required String value,
  IOSOptions? iOptions,
  AndroidOptions? aOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

#### `read()`

Read a value by key.

```dart
Future<String?> read({
  required String key,
  IOSOptions? iOptions,
  AndroidOptions? aOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

#### `delete()`

Delete a value by key.

```dart
Future<void> delete({
  required String key,
  IOSOptions? iOptions,
  AndroidOptions? aOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

#### `deleteAll()`

Delete all stored values.

```dart
Future<void> deleteAll({
  IOSOptions? iOptions,
  AndroidOptions? aOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

#### `readAll()`

Read all stored values.

```dart
Future<Map<String, String>> readAll({
  IOSOptions? iOptions,
  AndroidOptions? aOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

#### `containsKey()`

Check if a key exists.

```dart
Future<bool> containsKey({
  required String key,
  IOSOptions? iOptions,
  AndroidOptions? aOptions,
  LinuxOptions? lOptions,
  WebOptions? webOptions,
  WindowsOptions? wOptions,
  MacOsOptions? mOptions,
})
```

## Best Practices

### 1. Use for Sensitive Data Only

```dart
// ✅ Good: Store sensitive data
await storage.write(key: 'auth_token', value: token);
await storage.write(key: 'user_password', value: password);

// ❌ Bad: Don't store non-sensitive data
await storage.write(key: 'user_name', value: name); // Use SharedPreferences
await storage.write(key: 'app_settings', value: settings);
```

### 2. Code Optimization Using Enum Keys

**Why Use Enum Keys?**

Using enum-based key management provides:
- ✅ **Type Safety**: Compile-time checking prevents typos
- ✅ **Code Readability**: Clear, descriptive key names
- ✅ **Centralized Management**: All keys in one place
- ✅ **Easy Refactoring**: IDE can rename all occurrences
- ✅ **IntelliSense Support**: Auto-completion for key names

```dart
// Define your storage keys as an enum
enum SecureStorageKeys {
  uid,
  token,
  isLogin,
  username,
  fullName,
  firstName,
  lastName,
  fcmToken,
  refreshToken,
  apiKey,
}

// Usage with type safety
await storage.write(key: SecureStorageKeys.token.name, value: token);
String? token = await storage.read(key: SecureStorageKeys.token.name);
```

### 3. Singleton Pattern for Storage Service

**Benefits of Singleton Pattern:**
- ✅ **Resource Efficiency**: Single instance prevents multiple FlutterSecureStorage objects
- ✅ **Consistent Configuration**: Same options across the app
- ✅ **Memory Optimization**: Reduced memory footprint
- ✅ **Clean API**: Single point of access

```dart
class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    iOptions: const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Optimized CRUD methods
  static Future<void> write(SecureStorageKeys key, dynamic value) async {
    await _storage.write(key: key.name, value: value.toString());
  }

  static Future<String?> read(SecureStorageKeys key) async {
    return await _storage.read(key: key.name);
  }

  static Future<void> delete(SecureStorageKeys key) async {
    await _storage.delete(key: key.name);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }

  static Future<bool> containsKey(SecureStorageKeys key) async {
    return await _storage.containsKey(key: key.name);
  }
}
```

### 4. Additional Security Enhancements

#### Encrypt Before Storing (Double Encryption)

For extremely sensitive data, consider encrypting values before storing:

```dart
import 'package:encrypt/encrypt.dart';

class EnhancedSecureStorage {
  static final _encrypt = Encrypt(Encrypter(AES(Key.fromSecureRandom(32))));
  
  static Future<void> writeEncrypted(SecureStorageKeys key, String value) async {
    final encrypted = _encrypt.encrypt(value, iv: IV.fromSecureRandom(16));
    await SecureStorageService.write(key, encrypted.base64);
  }
  
  static Future<String?> readDecrypted(SecureStorageKeys key) async {
    final encrypted = await SecureStorageService.read(key);
    if (encrypted == null) return null;
    
    try {
      final encryptedBytes = Encrypted.fromBase64(encrypted);
      return _encrypt.decrypt(encryptedBytes);
    } catch (e) {
      print('Decryption failed: $e');
      return null;
    }
  }
}
```

#### Platform-Specific Security Options

```dart
class PlatformAwareSecureStorage {
  static FlutterSecureStorage getStorage() {
    if (Platform.isAndroid) {
      return FlutterSecureStorage(
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
          // Additional Android security options
          resetOnError: true,
        ),
      );
    }
    
    if (Platform.isIOS) {
      return FlutterSecureStorage(
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
          // Require biometric authentication
          synchronizable: false,
        ),
      );
    }
    
    return FlutterSecureStorage();
  }
}
```

### 5. Optimized CRUD Methods with Error Handling

```dart
class OptimizedSecureStorage {
  static final _storage = FlutterSecureStorage();
  
  // Write with validation and error handling
  static Future<bool> write(SecureStorageKeys key, dynamic value) async {
    try {
      if (value == null) {
        await _storage.delete(key: key.name);
        return true;
      }
      
      await _storage.write(key: key.name, value: value.toString());
      return true;
    } catch (e) {
      print('Error writing to secure storage: $e');
      return false;
    }
  }
  
  // Read with caching for frequent access
  static final Map<String, String> _cache = {};
  
  static Future<String?> read(SecureStorageKeys key, {bool useCache = true}) async {
    try {
      if (useCache && _cache.containsKey(key.name)) {
        return _cache[key.name];
      }
      
      final value = await _storage.read(key: key.name);
      if (useCache && value != null) {
        _cache[key.name] = value;
      }
      
      return value;
    } catch (e) {
      print('Error reading from secure storage: $e');
      return null;
    }
  }
  
  // Batch operations for efficiency
  static Future<Map<String, String?>> readMultiple(List<SecureStorageKeys> keys) async {
    final Map<String, String?> results = {};
    
    await Future.wait(keys.map((key) async {
      results[key.name] = await read(key);
    }));
    
    return results;
  }
  
  // Clear cache when needed
  static void clearCache() {
    _cache.clear();
  }
}
```

### 2. Error Handling

```dart
class SecureStorageManager {
  final _storage = FlutterSecureStorage();
  
  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: 'auth_token');
    } catch (e) {
      print('Error reading secure storage: $e');
      // Handle error (e.g., clear corrupted data, log to analytics)
      return null;
    }
  }
  
  Future<void> saveAuthToken(String token) async {
    try {
      await _storage.write(key: 'auth_token', value: token);
    } catch (e) {
      print('Error writing to secure storage: $e');
      // Handle error (show user-friendly message)
      rethrow;
    }
  }
}
```

### 3. Clear Data on Logout

```dart
Future<void> logout() async {
  try {
    // Clear secure storage
    await storage.deleteAll();
    
    // Clear other app data
    await prefs.clear();
    
    // Navigate to login
    Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    print('Error during logout: $e');
  }
}
```

### 4. Platform-Specific Considerations

```dart
class PlatformSafeStorage {
  bool get isWeb => kIsWeb;
  bool get isAndroid => Platform.isAndroid;
  bool get isIOS => Platform.isIOS;
  
  FlutterSecureStorage getStorage() {
    if (isWeb) {
      // Web has limitations
      return FlutterSecureStorage();
    }
    
    if (isAndroid) {
      // Android with EncryptedSharedPreferences
      return FlutterSecureStorage(
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );
    }
    
    // iOS/macOS
    return FlutterSecureStorage();
  }
}
```

## Integration with fpdart

Use `TaskEither` for functional error handling:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();
  
  // Read with error handling
  TaskEither<String, String> readToken() {
    return TaskEither.tryCatch(
      () async => (await _storage.read(key: 'token')) ?? '',
      (error, stackTrace) => 'Failed to read token: $error',
    );
  }
  
  // Write with error handling
  TaskEither<String, void> writeToken(String token) {
    return TaskEither.tryCatch(
      () async => await _storage.write(key: 'token', value: token),
      (error, stackTrace) => 'Failed to write token: $error',
    );
  }
}

// Usage
final result = await storageService.readToken().run();
result.fold(
  (error) => print('Error: $error'),
  (token) => print('Token: $token'),
);
```

## Troubleshooting

### Android: InvalidKeyException

**Problem**: `java.security.InvalidKeyException: Failed to unwrap key`

**Solution**: Disable backup or exclude secure storage from backup.

See [Android Configuration](#android-configuration) section.

### macOS: Keychain Access Groups

**Problem**: Items not accessible

**Solution**: Add keychain access groups entitlement.

See [iOS/macOS Configuration](#ioss-macos-configuration) section.

### Web: Data Not Persisting

**Problem**: Data lost on page refresh

**Possible Causes**:
- Local storage disabled in browser
- Private/incognito mode
- Browser security settings

**Solution**: Check browser settings and inform users about requirements.

### Linux: Build Errors

**Problem**: Missing libsecret

**Solution**: Install dependencies:

```bash
sudo apt-get install libsecret-1-dev libjsoncpp-dev
```

### Windows: readAll/deleteAll Not Working

**Problem**: `readAll()` or `deleteAll()` throws error

**Solution**: These methods are not supported on Windows yet. Use individual `read()` and `delete()` calls.

## Resources

- [Pub.dev Package](https://pub.dev/packages/flutter_secure_storage)
- [GitHub Repository](https://github.com/mogol/flutter_secure_storage)
- [Example App](https://github.com/mogol/flutter_secure_storage/tree/master/example)
- [Issues](https://github.com/mogol/flutter_secure_storage/issues)

## License

BSD-3-Clause
