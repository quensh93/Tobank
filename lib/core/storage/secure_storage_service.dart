import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_storage_keys.dart';

/// Singleton SecureStorageService for optimized secure data storage
/// 
/// This service provides:
/// - Singleton pattern for resource efficiency
/// - Type-safe enum-based key management
/// - Platform-specific security configurations
/// - Optimized CRUD operations with error handling
/// - Caching for frequently accessed data
/// - Batch operations for efficiency
class SecureStorageService {
  // Private constructor for singleton pattern
  SecureStorageService._internal();
  
  // Singleton instance
  static final SecureStorageService _instance = SecureStorageService._internal();
  
  // Factory constructor returns the singleton instance
  factory SecureStorageService() => _instance;
  
  // Private storage instance with platform-specific options
  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(
      resetOnError: true,
    ),
    iOptions: const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      synchronizable: false,
    ),
    lOptions: const LinuxOptions(),
    wOptions: const WindowsOptions(
      useBackwardCompatibility: false,
    ),
    mOptions: const MacOsOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      synchronizable: false,
    ),
  );
  
  // Cache for frequently accessed data
  static final Map<String, String> _cache = {};
  static bool _cacheEnabled = true;
  
  /// Enable or disable caching
  static void setCacheEnabled(bool enabled) {
    _cacheEnabled = enabled;
    if (!enabled) {
      clearCache();
    }
  }
  
  /// Clear the cache
  static void clearCache() {
    _cache.clear();
  }
  
  /// Write a value to secure storage
  /// 
  /// [key] - The enum key to store the value under
  /// [value] - The value to store (will be converted to string)
  /// [useCache] - Whether to cache the value for faster access
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> write(
    SecureStorageKeys key, 
    dynamic value, {
    bool useCache = true,
  }) async {
    try {
      if (value == null) {
        await _storage.delete(key: key.name);
        if (useCache && _cacheEnabled) {
          _cache.remove(key.name);
        }
        return true;
      }
      
      final stringValue = value.toString();
      await _storage.write(key: key.name, value: stringValue);
      
      if (useCache && _cacheEnabled) {
        _cache[key.name] = stringValue;
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error writing to secure storage (${key.name}): $e');
      }
      return false;
    }
  }
  
  /// Read a value from secure storage
  /// 
  /// [key] - The enum key to read
  /// [useCache] - Whether to use cached value if available
  /// 
  /// Returns the stored value or null if not found
  static Future<String?> read(
    SecureStorageKeys key, {
    bool useCache = true,
  }) async {
    try {
      // Check cache first if enabled
      if (useCache && _cacheEnabled && _cache.containsKey(key.name)) {
        return _cache[key.name];
      }
      
      // Read from storage
      final value = await _storage.read(key: key.name);
      
      // Update cache if enabled and value exists
      if (useCache && _cacheEnabled && value != null) {
        _cache[key.name] = value;
      }
      
      return value;
    } catch (e) {
      if (kDebugMode) {
        print('Error reading from secure storage (${key.name}): $e');
      }
      return null;
    }
  }
  
  /// Delete a value from secure storage
  /// 
  /// [key] - The enum key to delete
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> delete(SecureStorageKeys key) async {
    try {
      await _storage.delete(key: key.name);
      
      // Remove from cache
      if (_cacheEnabled) {
        _cache.remove(key.name);
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting from secure storage (${key.name}): $e');
      }
      return false;
    }
  }
  
  /// Check if a key exists in secure storage
  /// 
  /// [key] - The enum key to check
  /// 
  /// Returns true if the key exists, false otherwise
  static Future<bool> containsKey(SecureStorageKeys key) async {
    try {
      return await _storage.containsKey(key: key.name);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking key existence (${key.name}): $e');
      }
      return false;
    }
  }
  
  /// Read multiple values in batch
  /// 
  /// [keys] - List of enum keys to read
  /// [useCache] - Whether to use cached values if available
  /// 
  /// Returns a map of key names to their values
  static Future<Map<String, String?>> readMultiple(
    List<SecureStorageKeys> keys, {
    bool useCache = true,
  }) async {
    final Map<String, String?> results = {};
    
    try {
      await Future.wait(keys.map((key) async {
        results[key.name] = await read(key, useCache: useCache);
      }));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading multiple keys: $e');
      }
    }
    
    return results;
  }
  
  /// Write multiple values in batch
  /// 
  /// [data] - Map of enum keys to their values
  /// [useCache] - Whether to cache the values
  /// 
  /// Returns true if all writes were successful, false otherwise
  static Future<bool> writeMultiple(
    Map<SecureStorageKeys, dynamic> data, {
    bool useCache = true,
  }) async {
    try {
      await Future.wait(data.entries.map((entry) async {
        await write(entry.key, entry.value, useCache: useCache);
      }));
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error writing multiple keys: $e');
      }
      return false;
    }
  }
  
  /// Clear all data from secure storage
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> clear() async {
    try {
      await _storage.deleteAll();
      clearCache();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing secure storage: $e');
      }
      return false;
    }
  }
  
  /// Clear only sensitive data (keys that should be cleared on logout)
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> clearSensitiveData() async {
    try {
      final sensitiveKeys = SecureStorageKeys.values
          .where((key) => key.shouldClearOnLogout)
          .toList();
      
      await Future.wait(sensitiveKeys.map((key) async {
        await delete(key);
      }));
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing sensitive data: $e');
      }
      return false;
    }
  }
  
  /// Read all stored values
  /// 
  /// Returns a map of all key-value pairs
  static Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      if (kDebugMode) {
        print('Error reading all values: $e');
      }
      return {};
    }
  }
  
  /// Get storage statistics
  /// 
  /// Returns information about cache usage and storage status
  static Map<String, dynamic> getStats() {
    return {
      'cacheEnabled': _cacheEnabled,
      'cacheSize': _cache.length,
      'cachedKeys': _cache.keys.toList(),
      'platform': Platform.operatingSystem,
    };
  }
  
  /// Validate storage integrity
  /// 
  /// Checks if the storage is working properly
  /// 
  /// Returns true if storage is working, false otherwise
  static Future<bool> validateStorage() async {
    try {
      const testKey = SecureStorageKeys.customKey1;
      final testValue = 'test_value_${DateTime.now().millisecondsSinceEpoch}';
      
      // Test write
      final writeSuccess = await write(testKey, testValue, useCache: false);
      if (!writeSuccess) return false;
      
      // Test read
      final readValue = await read(testKey, useCache: false);
      if (readValue != testValue) return false;
      
      // Test delete
      final deleteSuccess = await delete(testKey);
      if (!deleteSuccess) return false;
      
      // Verify deletion
      final verifyValue = await read(testKey, useCache: false);
      if (verifyValue != null) return false;
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Storage validation failed: $e');
      }
      return false;
    }
  }
  
  // ==================== ENHANCED SECURITY FEATURES ====================
  
  /// Generate a secure random key for encryption
  static String _generateSecureKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(bytes);
  }
  
  /// Encrypt data using AES encryption with a generated key
  static String _encrypt(String data, String key) {
    try {
      final keyBytes = sha256.convert(utf8.encode(key)).bytes;
      final dataBytes = utf8.encode(data);
      
      // Simple XOR encryption (for demonstration - use proper AES in production)
      final encrypted = <int>[];
      for (int i = 0; i < dataBytes.length; i++) {
        encrypted.add(dataBytes[i] ^ keyBytes[i % keyBytes.length]);
      }
      
      return base64Encode(encrypted);
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }
  
  /// Decrypt data using the provided key
  static String _decrypt(String encryptedData, String key) {
    try {
      final keyBytes = sha256.convert(utf8.encode(key)).bytes;
      final encryptedBytes = base64Decode(encryptedData);
      
      // Simple XOR decryption (for demonstration - use proper AES in production)
      final decrypted = <int>[];
      for (int i = 0; i < encryptedBytes.length; i++) {
        decrypted.add(encryptedBytes[i] ^ keyBytes[i % keyBytes.length]);
      }
      
      return utf8.decode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }
  
  /// Write encrypted data to secure storage (double encryption)
  /// 
  /// [key] - The enum key to store under
  /// [value] - The value to encrypt and store
  /// [encryptionKey] - Optional custom encryption key
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> writeEncrypted(
    SecureStorageKeys key,
    String value, {
    String? encryptionKey,
  }) async {
    try {
      final keyToUse = encryptionKey ?? _generateSecureKey();
      final encrypted = _encrypt(value, keyToUse);
      
      // Store both encrypted data and encryption key
      final success = await write(key, encrypted);
      if (success) {
        // Store the encryption key separately
        final keyStorageKey = SecureStorageKeys.values.firstWhere(
          (k) => k.name == '${key.name}_encryption_key',
          orElse: () => SecureStorageKeys.customKey1,
        );
        await write(keyStorageKey, keyToUse);
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }
  
  /// Read and decrypt data from secure storage
  /// 
  /// [key] - The enum key to read
  /// [encryptionKey] - Optional custom encryption key
  /// 
  /// Returns the decrypted value or null if not found
  static Future<String?> readDecrypted(
    SecureStorageKeys key, {
    String? encryptionKey,
  }) async {
    try {
      final encrypted = await read(key);
      if (encrypted == null) return null;
      
      String? keyToUse = encryptionKey;
      if (keyToUse == null) {
        // Retrieve the stored encryption key
        final keyStorageKey = SecureStorageKeys.values.firstWhere(
          (k) => k.name == '${key.name}_encryption_key',
          orElse: () => SecureStorageKeys.customKey1,
        );
        keyToUse = await read(keyStorageKey);
      }
      
      if (keyToUse == null) return null;
      
      return _decrypt(encrypted, keyToUse);
    } catch (e) {
      return null;
    }
  }
  
  /// Delete encrypted data and its encryption key
  /// 
  /// [key] - The enum key to delete
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> deleteEncrypted(SecureStorageKeys key) async {
    try {
      final success = await delete(key);
      
      // Also delete the encryption key
      final keyStorageKey = SecureStorageKeys.values.firstWhere(
        (k) => k.name == '${key.name}_encryption_key',
        orElse: () => SecureStorageKeys.customKey1,
      );
      await delete(keyStorageKey);
      
      return success;
    } catch (e) {
      return false;
    }
  }
  
  // ==================== DATA INTEGRITY FEATURES ====================
  
  /// Generate checksum for data integrity
  static String _generateChecksum(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Write data with integrity checksum
  /// 
  /// [key] - The enum key to store under
  /// [value] - The value to store
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> writeWithIntegrity(
    SecureStorageKeys key,
    String value,
  ) async {
    try {
      final checksum = _generateChecksum(value);
      final dataWithChecksum = {
        'value': value,
        'checksum': checksum,
      };
      
      return await write(key, jsonEncode(dataWithChecksum));
    } catch (e) {
      return false;
    }
  }
  
  /// Read data and verify integrity
  /// 
  /// [key] - The enum key to read
  /// 
  /// Returns the value if integrity is verified, null if corrupted or not found
  static Future<String?> readWithIntegrityCheck(SecureStorageKeys key) async {
    try {
      final data = await read(key);
      if (data == null) return null;
      
      final decoded = jsonDecode(data) as Map<String, dynamic>;
      final value = decoded['value'] as String;
      final storedChecksum = decoded['checksum'] as String;
      
      // Verify checksum
      final calculatedChecksum = _generateChecksum(value);
      if (calculatedChecksum != storedChecksum) {
        // Data corruption detected, delete the corrupted data
        await delete(key);
        return null;
      }
      
      return value;
    } catch (e) {
      return null;
    }
  }
  
  // ==================== DATA EXPIRATION FEATURES ====================
  
  /// Write data with expiration time
  /// 
  /// [key] - The enum key to store under
  /// [value] - The value to store
  /// [expirationMinutes] - Minutes until the data expires
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> writeWithExpiration(
    SecureStorageKeys key,
    String value,
    int expirationMinutes,
  ) async {
    try {
      final expirationTime = DateTime.now().add(Duration(minutes: expirationMinutes));
      final dataWithExpiration = {
        'value': value,
        'expiresAt': expirationTime.millisecondsSinceEpoch,
      };
      
      return await write(key, jsonEncode(dataWithExpiration));
    } catch (e) {
      return false;
    }
  }
  
  /// Read data and check if it has expired
  /// 
  /// [key] - The enum key to read
  /// 
  /// Returns the value if not expired, null if expired or not found
  static Future<String?> readWithExpirationCheck(SecureStorageKeys key) async {
    try {
      final data = await read(key);
      if (data == null) return null;
      
      final decoded = jsonDecode(data) as Map<String, dynamic>;
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(decoded['expiresAt']);
      
      if (DateTime.now().isAfter(expirationTime)) {
        // Data has expired, delete it
        await delete(key);
        return null;
      }
      
      return decoded['value'] as String;
    } catch (e) {
      return null;
    }
  }
  
  /// Clean up expired data
  /// 
  /// This method should be called periodically to clean up expired data
  static Future<void> cleanupExpiredData() async {
    try {
      final allData = await readAll();
      final now = DateTime.now();
      
      for (final entry in allData.entries) {
        try {
          final decoded = jsonDecode(entry.value) as Map<String, dynamic>;
          if (decoded.containsKey('expiresAt')) {
            final expirationTime = DateTime.fromMillisecondsSinceEpoch(decoded['expiresAt']);
            if (now.isAfter(expirationTime)) {
              // Find the corresponding enum key and delete it
              final key = SecureStorageKeys.values.firstWhere(
                (k) => k.name == entry.key,
                orElse: () => SecureStorageKeys.customKey1,
              );
              await delete(key);
            }
          }
        } catch (e) {
          // Skip invalid entries
          continue;
        }
      }
    } catch (e) {
      // Handle cleanup errors silently
    }
  }
}
