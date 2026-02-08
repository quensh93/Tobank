/// Stub for WebBiometricService on non-web platforms
class WebBiometricService {
  static bool isAvailable() => false;
  static Future<bool> isEnabled() async => false;
  static Future<void> setEnabled(bool enabled) async {}
  static Future<bool> isRegistered() async => false;
  static Future<bool> register({
    required String userId,
    bool passkeyOnly = false,
  }) async => false;
  static Future<bool> authenticate({String? reason, String? userId}) async =>
      false;
  static Future<void> removeCredential() async {}
}
