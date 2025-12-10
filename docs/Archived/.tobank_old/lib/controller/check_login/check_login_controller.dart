import 'package:universal_io/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class CheckLoginController extends GetxController {
  MainController mainController = Get.find();

  final alphanumeric = RegExp(r'^[a-zA-Z0-9 !"#$%&()*+,-./:;<=>?@[\]^_`{|}~]+$');

  final LocalAuthentication _auth = LocalAuthentication();

  TextEditingController passwordController = TextEditingController();

  bool isSecurityEnable = false;
  bool canAuthenticate = false;
  bool hasFingerPrint = false;
  bool hasFaceDetect = false;
  int tryCount = 0;
  bool isCorrectPassword = true;

  bool isLoading = false;

  @override
  Future<void> onInit() async {
    checkToken();
    super.onInit();
  }

  /// Check token stored status in shared preferences
  /// if token exist, got to page 3
  /// else start [SignUpScreen]
  Future<void> checkToken() async {
    if (mainController.authInfoData != null) {
      final String? password = await StorageUtil.getPassword();
      if (password == null || password == '') {
        AppUtil.logoutFromApp();
      } else {
        _deviceCapabilities();
      }
    }
  }

  /// Checks device capabilities for biometric authentication, updates the UI, and checks settings status.
  Future<void> _deviceCapabilities() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    if (canAuthenticate) {
      final List<BiometricType> biometricTypeList = await _auth.getAvailableBiometrics();
      if (biometricTypeList.contains(BiometricType.strong) && Platform.isAndroid) {
        hasFingerPrint = true;
      } else if (biometricTypeList.contains(BiometricType.face) && Platform.isIOS) {
        hasFaceDetect = true;
      } else if (biometricTypeList.contains(BiometricType.fingerprint) && Platform.isIOS) {
        hasFingerPrint = true;
      }
    }
    update();
    _checkSettingsStatus();
  }

  Future<void> validatePassword() async {
    AppUtil.hideKeyboard(Get.context!);
    if (alphanumeric.hasMatch(passwordController.text) && passwordController.text.length >= 5) {
      isCorrectPassword = true;
      _checkPassword();
    } else {
      isCorrectPassword = false;
    }
    update();
  }

  /// Checks the entered password against the stored password,
  /// handles incorrect attempts, and potentially navigates back or checks certificate expiry.
  Future<void> _checkPassword() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (!await _timeIsPass()) {
      SnackBarUtil.showInfoSnackBar(
        locale.three_wrong_password_attempts,
      );
    } else {
      final String? password = await StorageUtil.getPassword();
      if (password == AppUtil.encryptDataWithAES(data: passwordController.text)) {
        // TODO: check
        Get.back();
        AppUtil.checkCertificateExpire(certificateCheckType: CertificateCheckType.login);
      } else {
        tryCount++;
        if (tryCount >= 3) {
          _storeRequestTime();
        }
        SnackBarUtil.showInfoSnackBar(
          locale.incorrect_password_,
        );
      }
    }
  }

  /// Store timestamp of when user can enter pass code again
  /// time that stored = current time + 5*60 seconds
  Future<void> _storeRequestTime() async {
    SharedPreferencesUtil()
        .setInt(Constants.timeToRequest, DateTime.now().millisecondsSinceEpoch + Constants.passTimeOut);
  }

  /// Check for stored timestamp in shared preferences & compare with
  /// time of now
  Future<bool> _timeIsPass() async {
    final int? time = SharedPreferencesUtil().getInt(Constants.timeToRequest);
    if (time == null) {
      return true;
    }
    if (time < DateTime.now().millisecondsSinceEpoch) {
      _removeTimeStored();
      return true;
    } else {
      return false;
    }
  }

  /// Remove stored time that store in shared preferences
  Future<void> _removeTimeStored() async {
    tryCount = 0;
    SharedPreferencesUtil().remove(Constants.timeToRequest);
  }

  /// Check shared preferences for find is fingerprint & pass code is enable
  /// or not
  /// if fingerprint & pass code is not enable run [_checkForMenuData] function
  Future<void> _checkSettingsStatus() async {
    isSecurityEnable = SharedPreferencesUtil().getBool(Constants.fingerPrint) ?? false;
    update();
    if (isSecurityEnable && (hasFaceDetect || hasFingerPrint)) {
      authenticate();
    }
  }

  /// Show fingerprint sensor check activity
  /// if fingerprint is correct, run [_checkForMenuData] function
  Future<void> authenticate() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
          localizedReason:
              (hasFaceDetect && Platform.isIOS) ? locale.face_recognize_sensor : locale.touch_finger_print_sensor,
          authMessages: [
            AndroidAuthMessages(
              biometricSuccess: locale.request_status_success,
              biometricHint: locale.login_with_finger_print,
              biometricNotRecognized: locale.not_recognized,
              cancelButton: locale.cancel_laghv,
              signInTitle: locale.tobank,
              biometricRequiredTitle: locale.login_with_finger_print,
              goToSettingsButton: locale.system_settings,
              goToSettingsDescription: locale.set_finger_print_in_this_section,
            ),
             IOSAuthMessages(
              goToSettingsDescription: locale.set_finger_print_in_this_section,
              goToSettingsButton: locale.system_settings,
              cancelButton: locale.cancel_laghv,
            ),
          ]);
    } on PlatformException catch (e) {
      AppUtil.printResponse(e.toString());
    }
    if (authenticated) {
      // TODO: show success  snackBar?
      Get.back();
      AppUtil.checkCertificateExpire(certificateCheckType: CertificateCheckType.login);
    }
  }
}
