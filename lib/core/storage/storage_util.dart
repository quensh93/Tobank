import 'secure_storage_service.dart';
import 'secure_storage_keys.dart';
import '../../model/common/auth_info_data.dart';
import 'dart:convert';

/// StorageUtil wrapper to maintain compatibility with legacy code
/// Uses SecureStorageService under the hood
class StorageUtil {
  static Future<String?> getPassword() async {
    return await SecureStorageService.read(SecureStorageKeys.password);
  }

  static Future<void> setPassword(String password) async {
    await SecureStorageService.write(SecureStorageKeys.password, password);
  }

  static Future<String?> getBase64UserSignatureImage() async {
    return await SecureStorageService.read(SecureStorageKeys.signatureImage);
  }

  static Future<void> setBase64UserSignatureImage(String base64Image) async {
    await SecureStorageService.write(
      SecureStorageKeys.signatureImage,
      base64Image,
    );
  }

  static Future<String?> getEncryptionWebKeyPair() async {
    return await SecureStorageService.read(
      SecureStorageKeys.encryptionWebKeyPair,
    );
  }

  static Future<void> setEncryptionWebKeyPair(String value) async {
    await SecureStorageService.write(
      SecureStorageKeys.encryptionWebKeyPair,
      value,
    );
  }

  static Future<void> removeEncryptionWebKeyPair() async {
    await SecureStorageService.delete(SecureStorageKeys.encryptionWebKeyPair);
  }

  static Future<AuthInfoData?> getAuthInfoDataSecureStorage() async {
    final String? result = await SecureStorageService.read(
      SecureStorageKeys.authInfoData,
    );
    if (result != null) {
      return AuthInfoData.fromJson(jsonDecode(result));
    }
    return null;
  }

  static Future<void> setAuthInfoDataSecureStorage(
    AuthInfoData authInfoData,
  ) async {
    await SecureStorageService.write(
      SecureStorageKeys.authInfoData,
      jsonEncode(authInfoData.toJson()),
    );
  }

  static Future<void> removeCustomerKeyPair() async {
    await SecureStorageService.delete(SecureStorageKeys.customerKeyPair);
  }

  static Future<void> removeEkycPreRegistrationModel() async {
    await SecureStorageService.delete(
      SecureStorageKeys.ekycPreRegistrationModel,
    );
  }

  static Future<String?> getUserCertificate() async {
    return await SecureStorageService.read(SecureStorageKeys.userCertificate);
  }

  static Future<void> setUserCertificate(String certificate) async {
    await SecureStorageService.write(
      SecureStorageKeys.userCertificate,
      certificate,
    );
  }
}
