// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:basic_utils/basic_utils.dart';
// import 'package:crypto/crypto.dart';
// import 'package:fast_rsa/fast_rsa.dart';
// import 'package:pointycastle/key_generators/api.dart';
// import 'package:pointycastle/key_generators/rsa_key_generator.dart';
// import 'package:pointycastle/random/fortuna_random.dart';
// import 'package:secure_plugin/secure_response_data.dart'
//     show SecureResponseData;

// import '../model/common/encryption_key_pair.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'storage_util.dart';

// // Import WebBiometricService conditionally
// import 'web_only_utils/web_biometric_service_stub.dart'
//     if (dart.library.html) 'web_only_utils/web_biometric_service.dart' as web_biometric;

// /// todo: add later to pwa
// class SecureWebPlugin {
//   SecureWebPlugin._();

//   static Future<String> generatePairKey() async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result == null) {
//       final keyPair = await RSA.generate(1024);
//       final rsaPublicKey =
//           CryptoUtils.rsaPublicKeyFromPemPkcs1(keyPair.publicKey);
//       final rsaPrivateKey =
//           CryptoUtils.rsaPrivateKeyFromPemPkcs1(keyPair.privateKey);
//       final String publicKeyString =
//           CryptoUtils.encodeRSAPublicKeyToPem(rsaPublicKey);
//       final String privateKeyString =
//           CryptoUtils.encodeRSAPrivateKeyToPem(rsaPrivateKey);
//       final EncryptionKeyPair encryptionKeyPair = EncryptionKeyPair(
//           publicKey: publicKeyString, privateKey: privateKeyString);
//       await StorageUtil.setEncryptionWebKeyPair(
//           jsonEncode(encryptionKeyPair.toJson()));
//       return publicKeyString;
//     } else {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       return encryptionKeyPair.publicKey;
//     }
//   }

//   static Future<bool> isEnroll() async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     return result != null;
//   }

//   /// Sign text data with biometric authentication (similar to mobile signText)
//   /// This method requires biometric authentication before signing
//   /// [reason] is the message shown to user during authentication
//   static Future<String?> signData(
//     String textPlain, {
//     String? reason,
//   }) async {
//     // 1. Check if key pair exists
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result == null) {
//       print('🔴 SecureWebPlugin: No key pair found in web storage');
//       return null;
//     }

//     // 2. Require biometric authentication before signing (like mobile - no credential check)
//     // If credential doesn't exist, auto-register with userId (like mobile behavior)
//     try {
//       if (kIsWeb) {
//         // Get userId from storage for auto-registration if needed
//         final authInfoData = await StorageUtil.getAuthInfoDataSecureStorage();
//         final userId = authInfoData?.mobile ?? 'user';
        
//         final isAuthenticated = await web_biometric.WebBiometricService.authenticate(
//           reason: reason ??
//               'لطفا جهت تایید از اثر انگشت یا رمز ورود خود استفاده نمایید',
//           userId: userId, // For auto-registration if credential doesn't exist
//         );

//         if (!isAuthenticated) {
//           print('🔴 SecureWebPlugin: Biometric authentication failed or cancelled');
//           return null;
//         }

//         print('✅ SecureWebPlugin: Biometric authentication successful');
//       }
//     } catch (e) {
//       print('🔴 SecureWebPlugin: Error during biometric authentication: $e');
//       return null;
//     }

//     // 3. After successful authentication, sign the data
//     try {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       final RSAPrivateKey rsaPrivateKey =
//           CryptoUtils.rsaPrivateKeyFromPem(encryptionKeyPair.privateKey);
//       final List<int> list = textPlain.codeUnits;
//       final Uint8List bytes = Uint8List.fromList(list);

//       final signature = base64Encode(CryptoUtils.rsaSign(
//         rsaPrivateKey,
//         bytes,
//         algorithmName: 'SHA-256/RSA',
//       ));

//       print('✅ SecureWebPlugin: Text data signed successfully');
//       return signature;
//     } catch (e) {
//       print('🔴 SecureWebPlugin: Error signing text data: $e');
//       return null;
//     }
//   }

//   static Future<String?> signDataWithKeyWeb({
//     required String textPlain,
//     required String key,
//   }) async {
//     //final EncryptionKeyPair encryptionKeyPair =
//     //EncryptionKeyPair.fromJson(jsonDecode(result));
//     //final RSAPrivateKey rsaPrivateKey =
//     final List<int> list = key.codeUnits;
//     final Uint8List bytes = Uint8List.fromList(list);
//     return base64Encode(CryptoUtils.rsaSign(
//         generateRSAPrivateKeyFromPhone(key), bytes,
//         algorithmName: 'SHA-256/RSA'));
//   }

//   static RSAPrivateKey generateRSAPrivateKeyFromPhone(String phoneNumber,
//       {int bitLength = 1024}) {
//     // Hash the phone number to use as a seed (sha256 ensures 32 bytes)
//     final hash = sha256.convert(utf8.encode(phoneNumber)).bytes;
//     final seed = Uint8List.fromList(hash);

//     // Deterministic secure random seeded with the hash
//     final secureRandom = FortunaRandom()..seed(KeyParameter(seed));

//     // Standard RSA parameters (e = 65537 is widely used)
//     final keyGenParams =
//         RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64);

//     // Set up the key generator
//     final keyGen = RSAKeyGenerator()
//       ..init(ParametersWithRandom(keyGenParams, secureRandom));

//     // Generate the key pair
//     final keyPair = keyGen.generateKeyPair();
//     final privateKey = keyPair.privateKey as RSAPrivateKey;
//     // Done! This is a valid RSAPrivateKey, deterministic from phone number.
//     return privateKey;
//   }

// // Helper to hex encode bytes
//   static String hexEncode(List<int> bytes) =>
//       bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

//   static Future<bool> verifyData(String textPlain, String encryptedData) async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result != null) {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       final RSAPublicKey rsaPublicKey =
//           CryptoUtils.rsaPublicKeyFromPem(encryptionKeyPair.publicKey);
//       final List<int> list = textPlain.codeUnits;
//       final Uint8List bytes = Uint8List.fromList(list);
//       final List<int> encryptedDataList = base64Decode(encryptedData);
//       final Uint8List encryptedBytes = Uint8List.fromList(encryptedDataList);
//       final bool verifyResult = CryptoUtils.rsaVerify(
//         rsaPublicKey,
//         bytes,
//         encryptedBytes,
//         algorithm: 'SHA-256/RSA',
//       );
//       return verifyResult;
//     } else {
//       return false;
//     }
//   }

//   static Future<String?> getPublicKey() async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result != null) {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       return encryptionKeyPair.publicKey;
//     } else {
//       return null;
//     }
//   }

//   static Future<void> removePairKey() async {
//     await StorageUtil.removeEncryptionWebKeyPair();
//   }

//   /// Sign byte data with biometric authentication (similar to mobile)
//   /// This method requires biometric authentication before signing
//   /// [reason] is the message shown to user during authentication
//   static Future<String?> signByteData(
//     Uint8List bytes, {
//     String? reason,
//   }) async {
//     // 1. Check if key pair exists
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result == null) {
//       print('🔴 SecureWebPlugin: No key pair found in web storage');
//       return null;
//     }

//     // 2. Require biometric authentication before signing (like mobile)
//     try {
//       if (kIsWeb) {
//         // Get userId for auto-registration if needed (like mobile - no credential check needed)
//         // In mobile: biometric is requested directly without credential check
//         // In Web: if credential doesn't exist, auto-register then authenticate
//         final userId = 'user'; // Can be improved to get from mainController if available
        
//         final isAuthenticated = await web_biometric.WebBiometricService.authenticate(
//           reason: reason ??
//               'لطفا جهت تایید امضای دیجیتال از اثر انگشت یا رمز ورود خود استفاده نمایید',
//           userId: userId, // For auto-registration if credential doesn't exist
//         );

//         if (!isAuthenticated) {
//           print('🔴 SecureWebPlugin: Biometric authentication failed or cancelled');
//           return null;
//         }

//         print('✅ SecureWebPlugin: Biometric authentication successful');
//       }
//     } catch (e) {
//       print('🔴 SecureWebPlugin: Error during biometric authentication: $e');
//       return null;
//     }

//     // 3. After successful authentication, sign the data
//     try {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       final RSAPrivateKey rsaPrivateKey =
//           CryptoUtils.rsaPrivateKeyFromPem(encryptionKeyPair.privateKey);

//       final signature = base64Encode(CryptoUtils.rsaSign(
//         rsaPrivateKey,
//         bytes,
//         algorithmName: 'SHA-256/RSA',
//       ));

//       print('✅ SecureWebPlugin: Data signed successfully');
//       return signature;
//     } catch (e) {
//       print('🔴 SecureWebPlugin: Error signing data: $e');
//       return null;
//     }
//   }

//   static Future<bool> verifyByteData(
//       Uint8List bytes, String encryptedData) async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result != null) {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       final RSAPublicKey rsaPublicKey =
//           CryptoUtils.rsaPublicKeyFromPem(encryptionKeyPair.publicKey);
//       final List<int> encryptedDataList = base64Decode(encryptedData);
//       final Uint8List encryptedBytes = Uint8List.fromList(encryptedDataList);
//       final bool verifyResult = CryptoUtils.rsaVerify(
//         rsaPublicKey,
//         bytes,
//         encryptedBytes,
//         algorithm: 'SHA-256/RSA',
//       );
//       return verifyResult;
//     } else {
//       return false;
//     }
//   }

//   /// Remove the RSA keypair associated with a phone number.
//   static Future<SecureResponseData> removeKey(
//       {required String phoneNumber}) async {
//     // On web: simply remove saved encryption key pair from storage
//     await StorageUtil.removeEncryptionWebKeyPair();

//     // Return an appropriate SecureResponseData (customize as needed)
//     return SecureResponseData(
//       statusCode: 200,
//       message: 'Keypair removed from web storage.',
//     );
//   }

//   static Future<bool> removeAllKey() async {
//     try {
//       await StorageUtil.removeCustomerKeyPair();
//       await StorageUtil.removeEkycPreRegistrationModel();
//       await StorageUtil.removeEncryptionWebKeyPair();
//       return true;
//     } catch (e) {
//       throw e;
//     }
//   }

//   /// Get the private key from web storage (similar to SecurePlugin.getPrivateKey for iOS)
//   /// Returns the private key in PKCS1 format (without PEM headers)
//   static Future<SecureResponseData> getPrivateKey() async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result != null) {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));

//       // Extract PKCS1 private key from PEM format
//       // The private key is stored in PKCS8 format, we need to convert it
//       final RSAPrivateKey rsaPrivateKey =
//           CryptoUtils.rsaPrivateKeyFromPem(encryptionKeyPair.privateKey);

//       // Encode to PKCS1 format and then to base64 (matching iOS format)
//       final String privateKeyPkcs1 =
//           CryptoUtils.encodeRSAPrivateKeyToPemPkcs1(rsaPrivateKey);

//       // Remove PEM headers and get only the base64 content
//       final String base64PrivateKey = privateKeyPkcs1
//           .replaceAll('-----BEGIN RSA PRIVATE KEY-----', '')
//           .replaceAll('-----END RSA PRIVATE KEY-----', '')
//           .replaceAll('\n', '')
//           .replaceAll('\r', '')
//           .trim();

//       return SecureResponseData(
//         statusCode: 200,
//         isSuccess: true,
//         data: base64PrivateKey,
//         message: 'Private key retrieved successfully',
//       );
//     } else {
//       return SecureResponseData(
//         statusCode: 404,
//         isSuccess: false,
//         message: 'No key pair found in web storage',
//       );
//     }
//   }

//   /// Get the RSA private key object directly (for use in PDF signing)
//   static Future<RSAPrivateKey?> getRSAPrivateKey() async {
//     final String? result = await StorageUtil.getEncryptionWebKeyPair();
//     if (result != null) {
//       final EncryptionKeyPair encryptionKeyPair =
//           EncryptionKeyPair.fromJson(jsonDecode(result));
//       return CryptoUtils.rsaPrivateKeyFromPem(encryptionKeyPair.privateKey);
//     }
//     return null;
//   }
// }
