import 'package:flutter/foundation.dart';
import 'secure_storage_keys.dart';
import 'secure_storage_service.dart';
import '../helpers/logger.dart';

/// Comprehensive usage examples for secure storage
/// 
/// This class demonstrates best practices and various use cases
/// for the secure storage system
class SecureStorageExamples {
  // Private constructor
  SecureStorageExamples._();
  
  // Singleton instance
  static final SecureStorageExamples _instance = SecureStorageExamples._();
  
  // Factory constructor
  factory SecureStorageExamples() => _instance;
  
  /// Example 1: Basic Authentication Flow
  /// 
  /// Demonstrates storing and retrieving authentication tokens
  static Future<void> authenticationFlowExample() async {
    try {
      // Store authentication token
      final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
      final success = await SecureStorageService.write(SecureStorageKeys.token, token);
      
      if (success) {
        if (kDebugMode) {
          print('✅ Authentication token stored successfully');
        }
        
        // Retrieve token
        final retrievedToken = await SecureStorageService.read(SecureStorageKeys.token);
        if (retrievedToken != null) {
          if (kDebugMode) {
            print('✅ Token retrieved: ${retrievedToken.substring(0, 20)}...');
          }
        }
        
        // Mark user as logged in
        await SecureStorageService.write(SecureStorageKeys.isLogin, 'true');
        
        // Store user profile information
        await SecureStorageService.writeMultiple({
          SecureStorageKeys.username: 'john_doe',
          SecureStorageKeys.fullName: 'John Doe',
          SecureStorageKeys.email: 'john.doe@example.com',
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Authentication flow error: $e');
      }
    }
  }
  
  /// Example 2: User Profile Management
  /// 
  /// Demonstrates managing user profile data
  static Future<void> userProfileExample() async {
    try {
      // Store complete user profile
      final userProfile = {
        SecureStorageKeys.username: 'jane_smith',
        SecureStorageKeys.firstName: 'Jane',
        SecureStorageKeys.lastName: 'Smith',
        SecureStorageKeys.email: 'jane.smith@example.com',
        SecureStorageKeys.phoneNumber: '+1234567890',
        SecureStorageKeys.fullName: 'Jane Smith',
      };
      
      final success = await SecureStorageService.writeMultiple(userProfile);
      
      if (success) {
        if (kDebugMode) {
          print('✅ User profile stored successfully');
        }
        
        // Retrieve specific profile fields
        final profileKeys = [
          SecureStorageKeys.username,
          SecureStorageKeys.fullName,
          SecureStorageKeys.email,
        ];
        
        final profileData = await SecureStorageService.readMultiple(profileKeys);
        
        if (kDebugMode) {
          AppLogger.d('📋 User Profile:');
          profileData.forEach((key, value) {
            AppLogger.d('  $key: $value');
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ User profile error: $e');
      }
    }
  }
  
  /// Example 3: Device Token Management
  /// 
  /// Demonstrates managing device-specific tokens
  static Future<void> deviceTokenExample() async {
    try {
      // Store FCM token
      final fcmToken = 'fcm_token_123456789';
      await SecureStorageService.write(SecureStorageKeys.fcmToken, fcmToken);
      
      // Store device ID
      final deviceId = 'device_${DateTime.now().millisecondsSinceEpoch}';
      await SecureStorageService.write(SecureStorageKeys.deviceId, deviceId);
      
      // Check if tokens exist
      final hasFcmToken = await SecureStorageService.containsKey(SecureStorageKeys.fcmToken);
      final hasDeviceId = await SecureStorageService.containsKey(SecureStorageKeys.deviceId);
      
      if (kDebugMode) {
        print('📱 Device tokens status:');
        print('  FCM Token: ${hasFcmToken ? "✅ Stored" : "❌ Missing"}');
        print('  Device ID: ${hasDeviceId ? "✅ Stored" : "❌ Missing"}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Device token error: $e');
      }
    }
  }
  
  /// Example 4: Enhanced Security with Double Encryption
  /// 
  /// Demonstrates using enhanced encryption for sensitive data
  static Future<void> enhancedSecurityExample() async {
    try {
      // Store highly sensitive data with double encryption
      final sensitiveData = 'super_secret_api_key_12345';
      
      final success = await SecureStorageService.writeEncrypted(
        SecureStorageKeys.apiKey,
        sensitiveData,
      );
      
      if (success) {
        if (kDebugMode) {
          print('✅ Sensitive data encrypted and stored');
        }
        
        // Retrieve and decrypt the data
        final decryptedData = await SecureStorageService.readDecrypted(
          SecureStorageKeys.apiKey,
        );
        
        if (decryptedData != null) {
          if (kDebugMode) {
            print('✅ Data decrypted successfully: ${decryptedData.substring(0, 10)}...');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Enhanced security error: $e');
      }
    }
  }
  
  /// Example 5: Data with Expiration
  /// 
  /// Demonstrates storing data that expires automatically
  static Future<void> expiringDataExample() async {
    try {
      // Store session data that expires in 30 minutes
      final sessionData = 'session_token_${DateTime.now().millisecondsSinceEpoch}';
      
      final success = await SecureStorageService.writeWithExpiration(
        SecureStorageKeys.sessionId,
        sessionData,
        30, // 30 minutes
      );
      
      if (success) {
        if (kDebugMode) {
          print('✅ Session data stored with 30-minute expiration');
        }
        
        // Read the data (will return null if expired)
        final sessionValue = await SecureStorageService.readWithExpirationCheck(
          SecureStorageKeys.sessionId,
        );
        
        if (sessionValue != null) {
          if (kDebugMode) {
            print('✅ Session data retrieved: $sessionValue');
          }
        } else {
          if (kDebugMode) {
            print('⏰ Session data has expired');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Expiring data error: $e');
      }
    }
  }
  
  /// Example 6: Data Integrity Verification
  /// 
  /// Demonstrates storing data with integrity checks
  static Future<void> integrityVerificationExample() async {
    try {
      // Store data with integrity checksum
      final importantData = 'critical_user_preferences_data';
      
      final success = await SecureStorageService.writeWithIntegrity(
        SecureStorageKeys.customKey1,
        importantData,
      );
      
      if (success) {
        if (kDebugMode) {
          print('✅ Data stored with integrity verification');
        }
        
        // Read and verify integrity
        final verifiedData = await SecureStorageService.readWithIntegrityCheck(
          SecureStorageKeys.customKey1,
        );
        
        if (verifiedData != null) {
          if (kDebugMode) {
            print('✅ Data integrity verified: $verifiedData');
          }
        } else {
          if (kDebugMode) {
            print('❌ Data integrity check failed - data may be corrupted');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Integrity verification error: $e');
      }
    }
  }
  
  /// Example 7: App Settings Management
  /// 
  /// Demonstrates managing app settings securely
  static Future<void> appSettingsExample() async {
    try {
      // Store app settings
      final settings = {
        SecureStorageKeys.biometricEnabled: 'true',
        SecureStorageKeys.autoLoginEnabled: 'false',
      };
      
      final success = await SecureStorageService.writeMultiple(settings);
      
      if (success) {
        if (kDebugMode) {
          print('✅ App settings stored');
        }
        
        // Read settings
        final biometricEnabled = await SecureStorageService.read(
          SecureStorageKeys.biometricEnabled,
        );
        final autoLoginEnabled = await SecureStorageService.read(
          SecureStorageKeys.autoLoginEnabled,
        );
        
        if (kDebugMode) {
          print('⚙️ App Settings:');
          print('  Biometric: ${biometricEnabled == 'true' ? "Enabled" : "Disabled"}');
          print('  Auto Login: ${autoLoginEnabled == 'true' ? "Enabled" : "Disabled"}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ App settings error: $e');
      }
    }
  }
  
  /// Example 8: Logout and Data Cleanup
  /// 
  /// Demonstrates proper cleanup on logout
  static Future<void> logoutCleanupExample() async {
    try {
      if (kDebugMode) {
        print('🚪 Starting logout cleanup...');
      }
      
      // Clear only sensitive data (keeps user preferences)
      final success = await SecureStorageService.clearSensitiveData();
      
      if (success) {
        if (kDebugMode) {
          print('✅ Sensitive data cleared');
        }
        
        // Verify sensitive data is cleared
        final token = await SecureStorageService.read(SecureStorageKeys.token);
        final isLogin = await SecureStorageService.read(SecureStorageKeys.isLogin);
        
        if (kDebugMode) {
          print('🔍 Cleanup verification:');
          print('  Token: ${token == null ? "✅ Cleared" : "❌ Still exists"}');
          print('  Login Status: ${isLogin == null ? "✅ Cleared" : "❌ Still exists"}');
        }
      }
      
      // Alternative: Clear all data
      // await SecureStorageService.clear();
      
    } catch (e) {
      if (kDebugMode) {
        print('❌ Logout cleanup error: $e');
      }
    }
  }
  
  /// Example 9: Storage Statistics and Monitoring
  /// 
  /// Demonstrates monitoring storage usage and health
  static Future<void> storageMonitoringExample() async {
    try {
      // Get storage statistics
      final stats = SecureStorageService.getStats();
      
      if (kDebugMode) {
        print('📊 Storage Statistics:');
        print('  Cache Enabled: ${stats['cacheEnabled']}');
        print('  Cache Size: ${stats['cacheSize']}');
        print('  Platform: ${stats['platform']}');
        print('  Cached Keys: ${stats['cachedKeys']}');
      }
      
      // Validate storage integrity
      final isValid = await SecureStorageService.validateStorage();
      
      if (kDebugMode) {
        print('🔍 Storage Validation: ${isValid ? "✅ Healthy" : "❌ Issues detected"}');
      }
      
      // Clean up expired data
      await SecureStorageService.cleanupExpiredData();
      
      if (kDebugMode) {
        print('🧹 Expired data cleanup completed');
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('❌ Storage monitoring error: $e');
      }
    }
  }
  
  /// Example 10: Error Handling and Recovery
  /// 
  /// Demonstrates proper error handling patterns
  static Future<void> errorHandlingExample() async {
    try {
      // Attempt to read non-existent data
      final nonExistentData = await SecureStorageService.read(
        SecureStorageKeys.customKey2,
      );
      
      if (nonExistentData == null) {
        if (kDebugMode) {
          print('ℹ️ Non-existent data handled gracefully');
        }
      }
      
      // Attempt to write with invalid data
      final writeSuccess = await SecureStorageService.write(
        SecureStorageKeys.customKey3,
        null, // This should be handled gracefully
      );
      
      if (writeSuccess) {
        if (kDebugMode) {
          print('✅ Null value handled correctly');
        }
      }
      
      // Test cache functionality
      SecureStorageService.setCacheEnabled(false);
      await SecureStorageService.read(
        SecureStorageKeys.username,
        useCache: false,
      );
      
      SecureStorageService.setCacheEnabled(true);
      await SecureStorageService.read(
        SecureStorageKeys.username,
        useCache: true,
      );
      
      if (kDebugMode) {
        print('🔄 Cache functionality tested');
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error handling test failed: $e');
      }
    }
  }
  
  /// Run all examples
  /// 
  /// This method demonstrates all the secure storage capabilities
  static Future<void> runAllExamples() async {
    if (kDebugMode) {
      print('🚀 Starting Secure Storage Examples...\n');
    }
    
    await authenticationFlowExample();
    await userProfileExample();
    await deviceTokenExample();
    await enhancedSecurityExample();
    await expiringDataExample();
    await integrityVerificationExample();
    await appSettingsExample();
    await storageMonitoringExample();
    await errorHandlingExample();
    
    if (kDebugMode) {
      print('\n✅ All examples completed successfully!');
    }
  }
}
