import 'dart:convert';
import 'package:crypto/crypto.dart';

class AppUtil {
  /// Simple AES simulation (hashing) for now as we don't have crypto/encrypt packages setup
  /// In a real app, use 'encrypt' package.
  static String encryptDataWithAES({required String data}) {
    // For now, just hashing it to simulate "encryption" for comparison
    var bytes = utf8.encode(data);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
