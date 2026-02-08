import 'secure_storage_service.dart';
import 'secure_storage_keys.dart';

/// StorageUtil wrapper to maintain compatibility with legacy code
/// Uses SecureStorageService under the hood
class StorageUtil {
  static Future<String?> getPassword() async {
    return await SecureStorageService.read(SecureStorageKeys.password);
  }

  static Future<void> setPassword(String password) async {
    await SecureStorageService.write(SecureStorageKeys.password, password);
  }
}
