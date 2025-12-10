/// Secure Storage Package
/// 
/// This package provides a comprehensive secure storage solution with:
/// - Type-safe enum-based key management
/// - Singleton pattern for resource efficiency
library;
/// - Enhanced security features (double encryption, biometric protection)
/// - Data integrity verification
/// - Automatic data expiration
/// - Comprehensive error handling and monitoring
/// 
/// ## Quick Start
/// 
/// ```dart
/// import 'package:your_app/core/storage/secure_storage.dart';
/// 
/// // Basic usage
/// await SecureStorageService.write(SecureStorageKeys.token, 'your_token');
/// final token = await SecureStorageService.read(SecureStorageKeys.token);
/// 
/// // Enhanced security with double encryption
/// await SecureStorageService.writeEncrypted(SecureStorageKeys.apiKey, 'secret');
/// final secret = await SecureStorageService.readDecrypted(SecureStorageKeys.apiKey);
/// 
/// // Data with expiration
/// await SecureStorageService.writeWithExpiration(SecureStorageKeys.sessionId, 'data', 30);
/// final sessionData = await SecureStorageService.readWithExpirationCheck(SecureStorageKeys.sessionId);
/// 
/// // Data integrity verification
/// await SecureStorageService.writeWithIntegrity(SecureStorageKeys.customKey1, 'important_data');
/// final verifiedData = await SecureStorageService.readWithIntegrityCheck(SecureStorageKeys.customKey1);
/// ```
/// 
/// ## Features
/// 
/// - ✅ Type-safe key management with enums
/// - ✅ Singleton pattern for optimal performance
/// - ✅ Platform-specific security configurations
/// - ✅ Caching for frequently accessed data
/// - ✅ Batch operations for efficiency
/// - ✅ Double encryption for sensitive data
/// - ✅ Data integrity verification
/// - ✅ Automatic data expiration
/// - ✅ Comprehensive error handling
/// - ✅ Storage monitoring and validation
/// 
/// ## Best Practices
/// 
/// 1. Use enum keys for type safety
/// 2. Enable caching for frequently accessed data
/// 3. Use enhanced encryption for sensitive data
/// 4. Implement proper error handling
/// 5. Clear sensitive data on logout
/// 6. Monitor storage health regularly
/// 
/// See [SecureStorageExamples] for comprehensive usage examples.

// Core components
export 'secure_storage_keys.dart';
export 'secure_storage_service.dart';
export 'secure_storage_examples.dart';
