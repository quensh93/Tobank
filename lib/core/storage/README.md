# Secure Storage Package

A comprehensive secure storage solution for Flutter applications with enhanced security features, type safety, and performance optimizations.

## 🚀 Features

- ✅ **Type-Safe Key Management**: Enum-based keys prevent typos and provide IntelliSense
- ✅ **Singleton Pattern**: Resource-efficient single instance management
- ✅ **Platform-Specific Security**: Optimized configurations for each platform
- ✅ **Enhanced Encryption**: Double encryption for extremely sensitive data
- ✅ **Data Integrity**: Checksum verification to detect corruption
- ✅ **Automatic Expiration**: Time-based data expiration with cleanup
- ✅ **Caching System**: In-memory caching for frequently accessed data
- ✅ **Batch Operations**: Efficient bulk read/write operations
- ✅ **Error Handling**: Comprehensive error handling and recovery
- ✅ **Storage Monitoring**: Health checks and usage statistics

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_secure_storage: ^9.2.4
  crypto: ^3.0.3
```

## 🎯 Quick Start

### Basic Usage

```dart
import 'package:your_app/core/storage/secure_storage.dart';

// Store data
await SecureStorageService.write(SecureStorageKeys.token, 'your_token');

// Read data
final token = await SecureStorageService.read(SecureStorageKeys.token);

// Delete data
await SecureStorageService.delete(SecureStorageKeys.token);

// Clear all data
await SecureStorageService.clear();
```

### Enhanced Security

```dart
// Store with double encryption
await SecureStorageService.writeEncrypted(
  SecureStorageKeys.apiKey, 
  'super_secret_key'
);

// Read and decrypt
final secret = await SecureStorageService.readDecrypted(
  SecureStorageKeys.apiKey
);
```

### Data with Expiration

```dart
// Store data that expires in 30 minutes
await SecureStorageService.writeWithExpiration(
  SecureStorageKeys.sessionId,
  'session_data',
  30, // minutes
);

// Read (returns null if expired)
final session = await SecureStorageService.readWithExpirationCheck(
  SecureStorageKeys.sessionId
);
```

## 🔧 Configuration

### Platform-Specific Options

The service automatically configures optimal settings for each platform:

- **Android**: EncryptedSharedPreferences with resetOnError
- **iOS**: Keychain with first_unlock_this_device accessibility
- **macOS**: Keychain with biometric protection
- **Linux**: libsecret with encryption
- **Windows**: Credential Manager (limited support)

### Custom Configuration

```dart
// Disable caching
SecureStorageService.setCacheEnabled(false);

// Clear cache manually
SecureStorageService.clearCache();

// Get storage statistics
final stats = SecureStorageService.getStats();
```

## 📚 Available Keys

The `SecureStorageKeys` enum provides type-safe access to all storage keys:

### Authentication Keys
- `uid` - User ID
- `token` - Authentication token
- `refreshToken` - Refresh token
- `isLogin` - Login status

### User Profile Keys
- `username` - Username
- `fullName` - Full name
- `firstName` - First name
- `lastName` - Last name
- `email` - Email address
- `phoneNumber` - Phone number

### Device Keys
- `fcmToken` - Firebase Cloud Messaging token
- `deviceId` - Device identifier

### Security Keys
- `apiKey` - API key
- `apiSecret` - API secret
- `pinCode` - PIN code
- `biometricData` - Biometric data

### App Settings
- `biometricEnabled` - Biometric authentication enabled
- `autoLoginEnabled` - Auto login enabled

### Session Keys
- `sessionId` - Session identifier
- `lastLoginTime` - Last login timestamp

### Custom Keys
- `customKey1`, `customKey2`, `customKey3` - For custom data

## 🔒 Security Features

### 1. Double Encryption

For extremely sensitive data, use enhanced encryption:

```dart
// Automatically generates encryption key
await EnhancedSecureStorage.writeEncrypted(
  SecureStorageKeys.apiKey,
  'super_secret_data'
);
```

### 2. Data Integrity Verification

Detect data corruption with checksums:

```dart
await IntegritySecureStorage.writeWithIntegrity(
  SecureStorageKeys.customKey1,
  'important_data'
);

final data = await IntegritySecureStorage.readWithIntegrityCheck(
  SecureStorageKeys.customKey1
);
```

### 3. Automatic Data Expiration

Store data with automatic expiration:

```dart
await ExpiringSecureStorage.writeWithExpiration(
  SecureStorageKeys.sessionId,
  'session_data',
  60 // expires in 60 minutes
);
```

### 4. Sensitive Data Cleanup

Clear only sensitive data on logout:

```dart
// Clears only keys marked as sensitive
await SecureStorageService.clearSensitiveData();
```

## 📊 Monitoring and Maintenance

### Storage Health Check

```dart
// Validate storage integrity
final isValid = await SecureStorageService.validateStorage();

// Get storage statistics
final stats = SecureStorageService.getStats();
print('Cache size: ${stats['cacheSize']}');
print('Platform: ${stats['platform']}');
```

### Cleanup Operations

```dart
// Clean up expired data
await SecureStorageService.cleanupExpiredData();

// Clear cache
SecureStorageService.clearCache();
```

## 🎯 Best Practices

### 1. Use Type-Safe Keys

```dart
// ✅ Good - Type safe
await SecureStorageService.write(SecureStorageKeys.token, token);

// ❌ Bad - String keys prone to typos
await storage.write(key: 'auth_token', value: token);
```

### 2. Enable Caching for Frequent Access

```dart
// Enable caching for frequently accessed data
await SecureStorageService.write(SecureStorageKeys.username, username);
final cachedUsername = await SecureStorageService.read(SecureStorageKeys.username);
```

### 3. Use Enhanced Encryption for Sensitive Data

```dart
// For highly sensitive data
await SecureStorageService.writeEncrypted(
  SecureStorageKeys.apiSecret,
  secretKey
);
```

### 4. Implement Proper Error Handling

```dart
try {
  final token = await SecureStorageService.read(SecureStorageKeys.token);
  if (token == null) {
    // Handle missing token
    return;
  }
  // Use token
} catch (e) {
  // Handle error
  print('Error reading token: $e');
}
```

### 5. Clear Sensitive Data on Logout

```dart
Future<void> logout() async {
  // Clear only sensitive data (keeps user preferences)
  await SecureStorageService.clearSensitiveData();
  
  // Or clear everything
  // await SecureStorageService.clear();
}
```

## 🧪 Testing

Run comprehensive examples:

```dart
import 'package:your_app/core/storage/secure_storage.dart';

// Run all examples
await SecureStorageExamples.runAllExamples();
```

## 🔍 Troubleshooting

### Common Issues

1. **Storage validation fails**
   - Check platform-specific requirements
   - Verify secure storage permissions

2. **Cache issues**
   - Clear cache: `SecureStorageService.clearCache()`
   - Disable cache: `SecureStorageService.setCacheEnabled(false)`

3. **Encryption errors**
   - Ensure crypto package is added
   - Check data format before encryption

### Debug Information

Enable debug mode to see detailed logs:

```dart
// Debug information is automatically shown in debug mode
if (kDebugMode) {
  print('Storage stats: ${SecureStorageService.getStats()}');
}
```

## 📖 Examples

See `SecureStorageExamples` class for comprehensive usage examples covering:

- Authentication flow
- User profile management
- Device token management
- Enhanced security features
- Data expiration
- Integrity verification
- App settings
- Logout cleanup
- Storage monitoring
- Error handling

## 🤝 Contributing

1. Follow the existing code style
2. Add comprehensive documentation
3. Include tests for new features
4. Update examples as needed

## 📄 License

This package is part of the core architecture and follows the project's license terms.
