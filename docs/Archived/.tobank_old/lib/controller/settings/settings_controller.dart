import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../model/common/settings_data.dart';
import '../../model/profile/request/delete_account_request_data.dart';
import '../../service/core/api_core.dart';
import '../../service/delete_account_services.dart';
import '../../ui/change_password/change_password_screen.dart';
import '../../ui/settings/widget/confirm_delete_bottom_sheet.dart';
import '../../ui/settings/widget/theme_selector_bottom_sheet.dart';
import '../../ui/settings/widget/verify_code_delete_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class SettingsController extends GetxController {
  static const String eventName = 'Settings_Event';
  final LocalAuthentication _auth = LocalAuthentication();
  MainController mainController = Get.find();
  bool canAuthenticate = false;
  bool hasFingerPrint = false;
  bool hasFaceDetect = false;
  bool isSecurityEnable = false;

  bool isLoading = false;
  TextEditingController otpController = TextEditingController();
  bool isOtpValid = true;
  bool isDeleteLoading = false;
  bool isConfirm = false;

  String? selectedTheme = '';

  @override
  void onInit() {
    super.onInit();
    selectedTheme = StorageUtil.getThemeCode();
    _getSms();
    _deviceCapabilities();
    _checkSecurityEnableState();
  }

  @override
  void onClose() {
    AppUtil.printResponse('disposeGetSMS');
    try {
      SmsAutoFill().unregisterListener();
    } on Exception catch (e) {
      AppUtil.printResponse(e.toString());
    }
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Listens for incoming SMS messages containing an OTP and populates the OTP field.
  Future<void> _getSms() async {
    AppUtil.printResponse('getSms');
    await SmsAutoFill().listenForCode();
    SmsAutoFill().code.listen((event) {
      AppUtil.printResponse(event);
      event.trim();
      final List<String> sms = [];
      for (int i = 0; i < event.length; i++) {
        final String t = event.substring(i, i + 1);
        sms.add(t);
      }
      String code = '';
      for (int i = 0; i < sms.length; i++) {
        if (i == sms.length - 1) {
          code = code + sms[i];
        } else {
          code = code + sms[i];
        }
      }
      code.trim();
      otpController.text = code;
      return;
    });
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
  }

  /// Show activity to get fingerprint from user
  /// If pass code is disable, should be enable it first
  /// and show message to confirm it
  Future<void> authenticate() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
          localizedReason:
              (Platform.isIOS && hasFaceDetect) ? locale.face_recognize_sensor : locale.touch_finger_print_sensor,
          authMessages:  <AuthMessages>[
            AndroidAuthMessages(
              biometricSuccess: locale.request_status_success,
              biometricHint: locale.login_with_finger_print,
              biometricNotRecognized: locale.not_recognized,
              cancelButton: locale.cancel_laghv,
              signInTitle: '${locale.tobank} ',
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
    storeFingerPrintStatus(authenticated);
  }

  void cancelAuthentication() {
    _auth.stopAuthentication();
  }

  /// Store fingerprint status (enable or disable) in shared preferences
  Future<void> storeFingerPrintStatus(bool isActive) async {
    SharedPreferencesUtil().setBool(Constants.fingerPrint, isActive);
    isSecurityEnable = isActive;
    update();
    if (isActive) {
      mainController.analyticsService
          .logEvent(name: eventName, parameters: {'value': 'Finger_Print', 'status': 'Is_Active'});
    }
  }

  /// Check status of fingerprint in shared preferences
  Future<void> _checkSecurityEnableState() async {
    isSecurityEnable = SharedPreferencesUtil().getBool(Constants.fingerPrint) ?? false;
    update();
  }

  void toggleActive(bool value) {
    if (value) {
      authenticate();
    } else {
      cancelAuthentication();
      storeFingerPrintStatus(false);
    }
  }

  String getCurrentTheme() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedTheme == null || selectedTheme == 'system') {
      return locale.system_default_mode;
    } else if (selectedTheme == 'dark') {
      return locale.night_mode;
    } else {
      return locale.day_mode;
    }
  }

  void handleItemClick(SettingsItemData settingItemData) {
    if (settingItemData.event == 1) {
      Get.to(() => const ChangePasswordScreen());
    } else if (settingItemData.event == 2) {
      _showConfirmDeleteBottomSheet();
    } else if (settingItemData.event == 3) {
      _logout();
    }
  }

  /// Show confirm message for logout from app
  Future<void> _logout() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.confirm_logout,
        description:
            locale.logout_description,
        positiveMessage: locale.yes,
        negativeMessage: locale.no,
        positiveFunction: () async {
          Get.back(closeOverlays: true);
          await AppUtil.logoutFromApp();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void validate() {
    bool isValid = true;
    if (otpController.text.trim().length == Constants.otpLength) {
      isOtpValid = true;
    } else {
      isValid = false;
      isOtpValid = false;
    }
    update();
    if (isValid) {
      _deleteAccountRequest();
    }
  }

  /// Requests an OTP for account deletion and handles the response.
  void getDeleteOtpRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    _getSms();
    otpController.text = '';
    isLoading = true;
    update();
    DeleteAccountServices.deleteOtpRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _showOtpBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _showOtpBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const VerifyCodeBottomSheet(),
            ));
  }

  /// Sends a request to delete the user's account and handles the response.
  void _deleteAccountRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DeleteAccountRequestData deleteAccountRequestData = DeleteAccountRequestData();
    deleteAccountRequestData.code = int.parse(otpController.text);

    isDeleteLoading = true;
    update();
    DeleteAccountServices.deleteRequest(
      deleteAccountRequestData: deleteAccountRequestData,
    ).then((result) {
      isDeleteLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _closeBottomSheets();
          SnackBarUtil.showSuccessSnackBar(locale.account_deleted_successfully);
          Timer(const Duration(seconds: 2), () {
            AppUtil.logoutFromApp();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _closeBottomSheets() {
    Get.back();
    Get.back();
  }

  void setIsConfirm(bool? value) {
    isConfirm = value!;
    update();
  }

  void _showConfirmDeleteBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const ConfirmDeleteBottomSheet(),
            ));
  }

  void showThemeSelectorBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const ThemeSelectorBottomSheet(),
            ));
  }

  void setSelectedTheme(String? value) {
    selectedTheme = value;
    update();
    AppUtil.toggleThemeSwitcher(selectedTheme!);
    Get.back();
  }
}
