import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:secure_plugin/secure_response_data.dart' show SecureResponseData;

import '../model/common/encryption_key_pair.dart';
import 'storage_util.dart';

/// todo: add later to pwa
class SecureWebPlugin {
  SecureWebPlugin._();

  static Future<String> generatePairKey() async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    if (result == null) {
      final keyPair = await RSA.generate(1024);
      final rsaPublicKey =
          CryptoUtils.rsaPublicKeyFromPemPkcs1(keyPair.publicKey);
      final rsaPrivateKey =
          CryptoUtils.rsaPrivateKeyFromPemPkcs1(keyPair.privateKey);
      final String publicKeyString =
          CryptoUtils.encodeRSAPublicKeyToPem(rsaPublicKey);
      final String privateKeyString =
          CryptoUtils.encodeRSAPrivateKeyToPem(rsaPrivateKey);
      final EncryptionKeyPair encryptionKeyPair = EncryptionKeyPair(
          publicKey: publicKeyString, privateKey: privateKeyString);
      await StorageUtil.setEncryptionWebKeyPair(
          jsonEncode(encryptionKeyPair.toJson()));
      return publicKeyString;
    } else {
      final EncryptionKeyPair encryptionKeyPair =
          EncryptionKeyPair.fromJson(jsonDecode(result));
      return encryptionKeyPair.publicKey;
    }
  }

  static Future<bool> isEnroll() async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    return result != null;
  }

  static Future<String?> signData(String textPlain) async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    if (result != null) {
      final EncryptionKeyPair encryptionKeyPair =
          EncryptionKeyPair.fromJson(jsonDecode(result));
      final RSAPrivateKey rsaPrivateKey =
          CryptoUtils.rsaPrivateKeyFromPem(encryptionKeyPair.privateKey);
      final List<int> list = textPlain.codeUnits;
      final Uint8List bytes = Uint8List.fromList(list);
      return base64Encode(CryptoUtils.rsaSign(rsaPrivateKey, bytes,
          algorithmName: 'SHA-256/RSA'));
    } else {
      return null;
    }
  }

  static Future<String?> signDataWithKeyWeb({
    required String textPlain,
    required String key,
  }) async {
    //final EncryptionKeyPair encryptionKeyPair =
    //EncryptionKeyPair.fromJson(jsonDecode(result));
    //final RSAPrivateKey rsaPrivateKey =
    final List<int> list = key.codeUnits;
    final Uint8List bytes = Uint8List.fromList(list);
    return base64Encode(CryptoUtils.rsaSign(
        generateRSAPrivateKeyFromPhone(key), bytes,
        algorithmName: 'SHA-256/RSA'));
  }

  static RSAPrivateKey generateRSAPrivateKeyFromPhone(String phoneNumber, {int bitLength = 1024}) {
    // Hash the phone number to use as a seed (sha256 ensures 32 bytes)
    final hash = sha256.convert(utf8.encode(phoneNumber)).bytes;
    final seed = Uint8List.fromList(hash);

    // Deterministic secure random seeded with the hash
    final secureRandom = FortunaRandom()
      ..seed(KeyParameter(seed));

    // Standard RSA parameters (e = 65537 is widely used)
    final keyGenParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64);

    // Set up the key generator
    final keyGen = RSAKeyGenerator()
      ..init(ParametersWithRandom(keyGenParams, secureRandom));

    // Generate the key pair
    final keyPair = keyGen.generateKeyPair();
    final privateKey = keyPair.privateKey as RSAPrivateKey;
    // Done! This is a valid RSAPrivateKey, deterministic from phone number.
    return privateKey;
  }

// Helper to hex encode bytes
  static String hexEncode(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  static Future<bool> verifyData(String textPlain, String encryptedData) async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    if (result != null) {
      final EncryptionKeyPair encryptionKeyPair =
          EncryptionKeyPair.fromJson(jsonDecode(result));
      final RSAPublicKey rsaPublicKey =
          CryptoUtils.rsaPublicKeyFromPem(encryptionKeyPair.publicKey);
      final List<int> list = textPlain.codeUnits;
      final Uint8List bytes = Uint8List.fromList(list);
      final List<int> encryptedDataList = base64Decode(encryptedData);
      final Uint8List encryptedBytes = Uint8List.fromList(encryptedDataList);
      final bool verifyResult = CryptoUtils.rsaVerify(
        rsaPublicKey,
        bytes,
        encryptedBytes,
        algorithm: 'SHA-256/RSA',
      );
      return verifyResult;
    } else {
      return false;
    }
  }

  static Future<String?> getPublicKey() async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    if (result != null) {
      final EncryptionKeyPair encryptionKeyPair =
          EncryptionKeyPair.fromJson(jsonDecode(result));
      return encryptionKeyPair.publicKey;
    } else {
      return null;
    }
  }

  static Future<void> removePairKey() async {
    await StorageUtil.removeEncryptionWebKeyPair();
  }

  static Future<String?> signByteData(Uint8List bytes) async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    if (result != null) {
      final EncryptionKeyPair encryptionKeyPair =
          EncryptionKeyPair.fromJson(jsonDecode(result));
      final RSAPrivateKey rsaPrivateKey =
          CryptoUtils.rsaPrivateKeyFromPem(encryptionKeyPair.privateKey);
      return base64Encode(CryptoUtils.rsaSign(rsaPrivateKey, bytes,
          algorithmName: 'SHA-256/RSA'));
    } else {
      return null;
    }
  }

  static Future<bool> verifyByteData(
      Uint8List bytes, String encryptedData) async {
    final String? result = await StorageUtil.getEncryptionWebKeyPair();
    if (result != null) {
      final EncryptionKeyPair encryptionKeyPair =
          EncryptionKeyPair.fromJson(jsonDecode(result));
      final RSAPublicKey rsaPublicKey =
          CryptoUtils.rsaPublicKeyFromPem(encryptionKeyPair.publicKey);
      final List<int> encryptedDataList = base64Decode(encryptedData);
      final Uint8List encryptedBytes = Uint8List.fromList(encryptedDataList);
      final bool verifyResult = CryptoUtils.rsaVerify(
        rsaPublicKey,
        bytes,
        encryptedBytes,
        algorithm: 'SHA-256/RSA',
      );
      return verifyResult;
    } else {
      return false;
    }
  }

  /// Remove the RSA keypair associated with a phone number.
  static Future<SecureResponseData> removeKey({required String phoneNumber}) async {
    // On web: simply remove saved encryption key pair from storage
    await StorageUtil.removeEncryptionWebKeyPair();

    // Return an appropriate SecureResponseData (customize as needed)
    return SecureResponseData(
      statusCode: 200,
      message: 'Keypair removed from web storage.',
    );
  }

  static Future<bool> removeAllKey() async {
    try{
      await StorageUtil.removeCustomerKeyPair();
      await StorageUtil.removeEkycPreRegistrationModel();
      await StorageUtil.removeEncryptionWebKeyPair();
      return true;
    }catch(e){
      throw e;
    }
  }
}
