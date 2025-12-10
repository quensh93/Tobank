import 'package:shared_preferences/shared_preferences.dart';

import '../model/pichak/store_shaparak_payment_model.dart';
import '../model/profile/auth_info_data.dart';
import 'app_util.dart';
import 'constants.dart';

class SharedPreferencesUtil {
  static final SharedPreferencesUtil _instance = SharedPreferencesUtil._internal();
  late SharedPreferences _preferences;

  factory SharedPreferencesUtil() {
    return _instance;
  }

  SharedPreferencesUtil._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  Future<bool> clear() {
    return _preferences.clear();
  }

  Future<AuthInfoData?> getAuthInfoSecureBackup() async {
    final String? authInfoDataStringEncrypted = getString(Constants.authInfoSecure);
    if (authInfoDataStringEncrypted != null) {
      final String authInfoDataString = AppUtil.decryptWithAES(authInfoDataStringEncrypted);
      return authInfoFromJson(authInfoDataString);
    } else {
      return null;
    }
  }

  Future<StoreShaparakPaymentModel?> getStoreShaparakPayment() async {
    final String? storeShaparakPaymentString = getString(Constants.storeShaparakPayment);
    if (storeShaparakPaymentString != null) {
      return storeShaparakPaymentModelFromJson(storeShaparakPaymentString);
    } else {
      return null;
    }
  }
}
