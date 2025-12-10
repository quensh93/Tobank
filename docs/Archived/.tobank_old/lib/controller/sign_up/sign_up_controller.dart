import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/key_alias_model.dart';
import '../../model/other/app_version_data.dart';
import '../../model/other/menu_response_data.dart';
import '../../model/profile/auth_info_data.dart';
import '../../model/profile/request/get_verification_code_request_data.dart';
import '../../model/profile/request/sign_up_data.dart';
import '../../model/profile/response/token_data.dart';
import '../../model/profile/response/verify_code_data.dart';
import '../../model/wallet/request/customer_info_wallet_detail_request_data.dart';
import '../../model/wallet/response/customer_info_wallet_detail_response_data.dart';
import '../../model/wallet/response/wallet_detail_data.dart';
import '../../service/app_version_services.dart';
import '../../service/core/api_core.dart';
import '../../service/profile_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/common/date_selector_bottom_sheet.dart';
import '../../ui/dashboard_screen/dashboard_screen.dart';
import '../../ui/launcher/launcher_screen.dart';
import '../../ui/rule/rules_screen.dart';
import '../../ui/update_app/update_app_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class SignUpController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;
  bool isRequestOtpLoading = false;
  bool isCodeValid = true;
  int counter = 120;
  TokenData _tokenData = TokenData();
  static const String eventName = 'Settings_Event';

  TextEditingController nationalCodeController = TextEditingController();

  bool isNationalCodeValid = true;

  TextEditingController dateController = TextEditingController();
  String initDateString = '';
  String dateJalaliString = '';
  String? dateGregorian;
  final LocalAuthentication _auth = LocalAuthentication();
  bool canAuthenticate = false;
  bool hasFingerPrint = false;
  bool hasFaceDetect = false;
  bool isSecurityEnable = false;

  bool isDateValid = true;
  bool enableManualOtp = false;

  bool isMobileValid = true;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  DateTime time = DateTime(2021);
  Timer? timer;
  bool isCorrectNewPassword = true;
  bool isCorrectReNewPassword = true;
  String errorMessageNewPassword = '';
  String errorMessageReNewPassword = '';
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode reNewPasswordFocusNode = FocusNode();
  final alphanumeric = RegExp(r'^[a-zA-Z\d !"#$%&()*+,-./:;<=>?@[\]^_`{|}~]+$');
  bool get hasLetters =>
      RegExp(r'[a-z]').hasMatch(newPasswordController.text) &&
      RegExp(r'[A-Z]').hasMatch(newPasswordController.text);
  bool get hasDigits => RegExp(r'\d').hasMatch(newPasswordController.text);
  bool get hasMinLength => newPasswordController.text.length >= 8;

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController renewPasswordController = TextEditingController();

  @override
  void onInit() {
    if (mainController.autf != null) {
      enableManualOtp = Platform.isIOS ? true : !mainController.autf!;
    } else {
      enableManualOtp = Platform.isIOS ? true : false;
    }

    newPasswordController.addListener(() {
      update();
    });


    _initSmsAutoFill();
    _deviceCapabilities();
    initDateString = AppUtil.twentyYearsBeforeNow();
    super.onInit();
  }

  /// Checks device capabilities for biometric authentication, updates the UI, and checks settings status.
  Future<void> _deviceCapabilities() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    if (canAuthenticate) {
      final List<BiometricType> biometricTypeList =
          await _auth.getAvailableBiometrics();
      if (biometricTypeList.contains(BiometricType.strong) &&
          Platform.isAndroid) {
        hasFingerPrint = true;
      } else if (biometricTypeList.contains(BiometricType.face) &&
          Platform.isIOS) {
        hasFaceDetect = true;
      } else if (biometricTypeList.contains(BiometricType.fingerprint) &&
          Platform.isIOS) {
        hasFingerPrint = true;
      }
    }
    update();
  }

  /// Show activity to get fingerprint from user
  /// If pass code is disable, should be enable it first
  /// and show message to confirm it
  Future<void> authenticate() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
          localizedReason: (Platform.isIOS && hasFaceDetect)
              ? locale.face_recognize_sensor
              : locale.touch_finger_print_sensor,
          authMessages: <AuthMessages>[
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

  /// Cancels the ongoing authentication process.
  void cancelAuthentication() {
    _auth.stopAuthentication();
  }

  /// Store fingerprint status (enable or disable) in shared preferences
  Future<void> storeFingerPrintStatus(bool isActive) async {
    SharedPreferencesUtil().setBool(Constants.fingerPrint, isActive);
    isSecurityEnable = isActive;
    update();
    if (isActive) {
      mainController.analyticsService.logEvent(
          name: eventName,
          parameters: {'value': 'Finger_Print', 'status': 'Is_Active'});
    }
  }

  /// Get data of [VerifyCodeData] from server request
  Future<bool> getVerifyCodeRequest({bool needUpdate = true}) async {
    final locale = AppLocalizations.of(Get.context!)!;

    _initSmsAutoFill();

    codeController.text = '';
    isRequestOtpLoading = true;
    isCodeValid = true;

    final getVerificationCodeRequestData = GetVerificationCodeRequestData(
      phoneNumber: phoneNumberController.text,
    );

    try {
      final result = await ProfileServices.getVerificationCodeRequest(
        getVerificationCodeRequestData: getVerificationCodeRequestData,
      );

      isRequestOtpLoading = false;

      switch (result) {
        case Success(value: (_, 200)):
          codeController.text = '';
          counter = 120;
          _startTimer();
          if (needUpdate) {
            AppUtil.changePageController(
              pageController: pageController,
              page: 1,
              isClosed: isClosed,
            );
          }
          return true;

        case Success(value: (final AppVersionData response, 420)):
          Get.to(() => UpdateAppScreen(appVersionData: response));
          return true;

        case Success<(Object, int), ApiException>():
          // This case is a bit unclear. What should happen here?
          //  It's a Success with an ApiException, which is unexpected.
          //  I'm going to log a warning and return false for now.
          print(
              "WARNING: Unexpected Success case with ApiException.  Check logic.");
          return false;

        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      // Catch any other errors that might occur during the API call
      print("Error in getVerifyCodeRequest: $e");
      SnackBarUtil.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred.',
      );
      isRequestOtpLoading = false;
      return false;
    }
  }

  /// Verify sms code with the server
  /// Get data of [TokenData] from server
  /// if response is success run [_storeAuthInfo] with [TokenData]
  Future<bool> _verifyCodeRequest({bool needUpdate = true}) async {
    final locale = AppLocalizations.of(Get.context!)!;

    final signUpData = SignUpData();
    signUpData.mobile = phoneNumberController.text;
    signUpData.birthDate = dateController.text.replaceAll('/', '-');
    signUpData.nationalCode = nationalCodeController.text;
    signUpData.password = codeController.text;
    signUpData.type = '';

    isLoading = true;
    update();

    try {
      final result = await ProfileServices.verifyCodeRequest(
        signUpData: signUpData,
      );

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TokenData response, _)):
          _tokenData = response;
          update();
          if (needUpdate) {
            AppUtil.changePageController(
              pageController: pageController,
              page: 2,
              isClosed: isClosed,
            );
          }
          return true; // Return true on success

        case Failure(exception: final ApiException apiException):
          isCodeValid = false;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      // Catch any other errors during the API call
      print("Error in _verifyCodeRequest: $e");
      SnackBarUtil.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred.',
      );
      isLoading = false;
      update();
      return false; // Return false on error
    }
  }

  /// Get data from [TokenData] and store it in [AuthInfoData]
  /// in shared preferences
  ///
  /// after that, start [DashboardScreen]
  Future<bool> _storeAuthInfo({bool needUpdate = true}) async {
    try {
      mainController.authInfoData = AuthInfoData();
      mainController.authInfoData!.uuid = const Uuid().v4();
      mainController.authInfoData!.token = _tokenData.data!.user!.token;
      mainController.authInfoData!.mobile = _tokenData.data!.user!.mobile;
      mainController.authInfoData!.maxAmount = _tokenData.data!.user!.maxAmount;
      mainController.authInfoData!.firstName = _tokenData.data!.user!.firstName;
      mainController.authInfoData!.lastName = _tokenData.data!.user!.lastName;
      mainController.authInfoData!.imageUrl = _tokenData.data!.user!.file;
      mainController.authInfoData!.avatar = _tokenData.data!.user!.avatar;
      mainController.authInfoData!.birthdayDate =
          DateConverterUtil.getDateJalali(
              gregorianDate: _tokenData.data!.user!.birthDate);
      mainController.authInfoData!.nationalCode =
          _tokenData.data!.user!.nationalCode;
      mainController.authInfoData!.goftinoId = _tokenData.data!.user!.goftinoId;

      mainController.authInfoData!.customerNumber =
          _tokenData.data!.customer?.customerNumber;
      mainController.authInfoData!.shahabCodeAcquired =
          _tokenData.data!.customer?.shahabCodeAcquired.toString();
      mainController.authInfoData!.shabahangCustomerStatus =
          _tokenData.data!.customer?.customerStatus;
      print("mjp");
      print(_tokenData.data!.customer?.customerStatus);
      print(mainController.authInfoData!.shabahangCustomerStatus);
      mainController.authInfoData!.digitalBankingCustomer =
          _tokenData.data!.customer?.digitalBankingCustomer;

      Sentry.configureScope(
        (scope) => scope.setUser(SentryUser(
            id: mainController.authInfoData!.uuid,
            username: _tokenData.data!.user!.mobile)),
      );
      if (needUpdate) {
        mainController.update();
      }
      await StorageUtil.setAuthInfoDataSecureStorage(
          mainController.authInfoData!);
      await mainController.analyticsService
          .setUserProperties(userId: mainController.authInfoData!.mobile);
      final bool menuDataResult =
          await _getMenuDataRequest(needUpdate: needUpdate);
      return menuDataResult; // Return the result of _getMenuDataRequest
    } catch (e) {
      print("Error in _storeAuthInfo: $e");
      // Optionally, show a SnackBar or other error message here
      return false; // Return false if an error occurs
    }
  }

  /// Count from 60 to 0. after that show request again button on the screen
  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (counter < 1) {
        timer.cancel();
      } else {
        counter = counter - 1;
      }
      update();
    });
  }

  Future<bool> setPassword(String password, {bool needUpdate = true}) async {
    try {
      await StorageUtil.setPassword(AppUtil.encryptDataWithAES(data: password));
      final bool authInfoResult = await _storeAuthInfo(needUpdate: needUpdate);
      return authInfoResult; // Return the result of _storeAuthInfo
    } catch (e) {
      print("Error in setPassword: $e");
      // Optionally, show a SnackBar or other error message here.  Consider more specific error handling.
      return false; // Return false if an error occurs during password storage or authInfo processing.
    }
  }

  /// Validate values of form before request
  void validateLoginPage() {
    ///skip this in web for test
    //phoneNumberController.text = '09162363723';
    //phoneNumberController.text = '09124764369';
    //nationalCodeController.text = '1272125191';
    //nationalCodeController.text = '0440636711';
    //dateController.text = '1374/11/07';
    //dateController.text = '1375/11/13';
    bool isValid = true;
    AppUtil.hideKeyboard(Get.context!);
    if (phoneNumberController.text.trim().length ==
            Constants.mobileNumberLength &&
        phoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
      isMobileValid = true;
    } else {
      isMobileValid = false;
      isValid = false;
    }
    if (nationalCodeController.text.trim().length ==
            Constants.nationalCodeLength &&
        AppUtil.validateNationalCode(nationalCodeController.text) &&
        nationalCodeController.text != '0000000000') {
      isNationalCodeValid = true;
    } else {
      isNationalCodeValid = false;
      isValid = false;
    }
    if (dateController.text.isNotEmpty) {
      isDateValid = true;
    } else {
      isDateValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      getVerifyCodeRequest();
    }
  }

  /// Initializes SMS autofill functionality for automatically retrievingOTP codes.
  ///
  /// This function sets up a listener for incoming SMS messages containing One-Time Passwords (OTPs)
  /// using the `sms_autofill` package. It attempts to unregister any existing listeners and then
  /// registers a new listener to capture incoming OTP codes.
  Future<void> _initSmsAutoFill() async {
    try {
      await SmsAutoFill().unregisterListener();
    } on Exception catch (error) {
      AppUtil.printResponse(error.toString());
    }
    AppUtil.printResponse('getSms');
    try {
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
        AppUtil.printResponse(code.trim());
        codeController.text = code.trim();
      });
    } on Exception catch (error) {
      enableManualOtp = true;
      AppUtil.printResponse(error.toString());
    }
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

  /// Formats the current timer value into a string representation.
  String getTimerString() {
    final timer =
        intl.DateFormat('mm:ss').format(time.add(Duration(seconds: counter)));
    return timer;
  }

  Future<bool> submitVerifyCode({bool needUpdate = true}) async {
    AppUtil.hideKeyboard(Get.context!);
    if (codeController.text.trim().length == 5) {
      return await _verifyCodeRequest(needUpdate: needUpdate);
    }
    return false;
  }

  void validatePassword() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (newPasswordController.text.trim().length >= 8) {
      if (alphanumeric.hasMatch(newPasswordController.text.trim())) {
        isCorrectNewPassword = true;
      } else {
        errorMessageNewPassword = locale.password_farsi_error;
        isValid = false;
        isCorrectNewPassword = false;
      }
    } else {
      errorMessageNewPassword = locale.password_length_error;
      isValid = false;
      isCorrectNewPassword = false;
    }
    if (renewPasswordController.text.trim().length >= 8) {
      if (alphanumeric.hasMatch(renewPasswordController.text.trim())) {
        isCorrectReNewPassword = true;
      } else {
        errorMessageReNewPassword = locale.password_farsi_error;
        isValid = false;
        isCorrectReNewPassword = false;
      }
    } else {
      errorMessageReNewPassword = locale.password_not_match_with_entered_one;
      isValid = false;
      isCorrectReNewPassword = false;
    }

    final bool isSecureEnough = hasLetters && hasDigits && hasMinLength;
    if (!isSecureEnough) {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(locale.password_condition_error);
    }



    update();
    if (isValid) {
      if (newPasswordController.text.trim() != renewPasswordController.text.trim()) {
        errorMessageReNewPassword = locale.password_not_match_with_entered_one;
        isValid = false;
        isCorrectReNewPassword = false;
        // SnackBarUtil.showInfoSnackBar(
        //   locale.password_not_match_,
        // );
      } else {
        setPassword(newPasswordController.text.trim());
      }
    }
  }

  void returnToLauncherScreen() {
    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(builder: (context) => const LauncherScreen()),
      ModalRoute.withName('/Home'),
    );
  }

  /// Hide keyboard & show date picker dialog modal
  void showSelectDateDialog() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor:
            Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initDateString,
            title: locale.select_birth_date,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              dateController.text = dateJalaliString;
              initDateString = dateJalaliString;
              dateGregorian = DateConverterUtil.getDateGregorian(
                  jalaliDate: dateJalaliString.replaceAll('-', '/'));
              update();
              Get.back();
            },
          );
        });
  }

  void toggleActive(bool value) {
    if (value) {
      authenticate();
    } else {
      cancelAuthentication();
      storeFingerPrintStatus(false);
    }
  }

  /// Retrieves menu data from the server and handles theresponse.
  Future<bool> _getMenuDataRequest({bool needUpdate = true}) async {
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    if (needUpdate) {
      update();
    }

    try {
      final result = await AppVersionServices.getMenu();

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MenuResponseModel response, int _)):
          _storeMenuData(response);
          final bool isDone =
              await _getCustomerInfoWalletDetailRequest(needUpdate: needUpdate);
          return isDone; // Return the result of _getCustomerInfoWalletDetailRequest
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      // Catch any other errors during the API call
      print("Error in _getMenuDataRequest: $e");
      SnackBarUtil.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred.',
      );
      isLoading = false;
      update();
      return false; // Return false on error
    }
  }

  Future<void> _storeMenuData(MenuResponseModel menuResponseModel) async {
    await StorageUtil.setMainMenuSecureStorage(
        jsonEncode(menuResponseModel.data!.toJson()));
    await StorageUtil.setLatestMenuUpdateSecureStorage(
        menuResponseModel.lastestMenuUpdate);
    await mainController.getMenuData();
  }

  /// Handles the back press action based on the current page and loading state.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 1 || pageController.page == 2) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();

        if (pageController.page == 2) {
          //final NavigatorState navigator = Navigator.of(Get.context!);
          //navigator.pop();
          Get.back();
        } else {
          if (Platform.isAndroid) {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }
          AppUtil.previousPageController(pageController, isClosed);
        }
        if (Platform.isAndroid) {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        }
        //AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  bool showFingerprint() {
    return canAuthenticate && (hasFaceDetect || hasFingerPrint);
  }

  /// Retrieves customer wallet details from the server and handles the response.
  Future<bool> _getCustomerInfoWalletDetailRequest(
      {bool needUpdate = true}) async {
    final locale = AppLocalizations.of(Get.context!)!;

    final CustomerInfoWalletDetailRequestData
        customerInfoWalletDetailRequestData =
        CustomerInfoWalletDetailRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: true,
      forceInquireAddressInfo: false,
      getCustomerStartableProcesses: false,
      getCustomerDeposits: true,
      getCustomerActiveCertificate: false,
      category: 'notify',
      type: Platform.isAndroid ? 'redesign-android' : 'redesign-ios',
    );
    isLoading = true;
    if (needUpdate) {
      update();
    }

    try {
      final result = await WalletServices.getCustomerInfoWalletDetailRequest(
        customerInfoWalletDetailRequestData:
            customerInfoWalletDetailRequestData,
      );

      isLoading = false;
      if (needUpdate) {
        update();
      }

      switch (result) {
        case Success(
            value: (final CustomerInfoWalletDetailResponseData response, int _)
          ):
          await _storeCustomerInfoWalletDetail(response,
              needUpdate: needUpdate);
          return true; // Return the result of _storeCustomerInfoWalletDetail
        case Success<(Object, int), ApiException>():
          break; // Will not happen
          return true; // Or false, depending on what you want to indicate here
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      // Catch any other errors during the API call
      print("Error in _getCustomerInfoWalletDetailRequest: $e");
      SnackBarUtil.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred.',
      );
      isLoading = false;
      update();
      return false; // Return false on error
    }
    return false;
  }

  /// Stores customer wallet details and updates userprofile information.
  Future<void> _storeCustomerInfoWalletDetail(
      CustomerInfoWalletDetailResponseData customerInfoWalletDetailResponseData,
      {bool needUpdate = true}) async {
    if (mainController.authInfoData != null) {
      if (customerInfoWalletDetailResponseData.data != null) {
        mainController.destinationEKycProvider =
            customerInfoWalletDetailResponseData.data!.ekycProvider ?? 0;
        if (customerInfoWalletDetailResponseData.data!.customerNumber != null) {
          mainController.authInfoData!.customerNumber =
              customerInfoWalletDetailResponseData.data!.customerNumber;
          mainController.authInfoData!.shahabCodeAcquired =
              customerInfoWalletDetailResponseData.data!.shahabCodeAcquired
                  .toString();

          if (customerInfoWalletDetailResponseData.data!.firstName != null &&
              customerInfoWalletDetailResponseData.data!.lastName != null) {
            mainController.authInfoData!.firstName =
                customerInfoWalletDetailResponseData.data!.firstName;
            mainController.authInfoData!.lastName =
                customerInfoWalletDetailResponseData.data!.lastName;
          }

          mainController.authInfoData!.shabahangCustomerStatus =
              customerInfoWalletDetailResponseData.data!.customerStatus;
          mainController.authInfoData!.digitalBankingCustomer =
              customerInfoWalletDetailResponseData.data!.digitalBankingCustomer;
          mainController.authInfoData!.loyaltyCode =
              customerInfoWalletDetailResponseData.data!.loyaltyCode;
          mainController.hasDeposit =
              customerInfoWalletDetailResponseData.data!.hasDeposit;
        }
        mainController.walletDetailData ??= WalletDetailData();
        final walletInfo =
            customerInfoWalletDetailResponseData.data!.walletInfo!;
        mainController.walletDetailData!.data = walletInfo;
        mainController.azkiMenu =
            customerInfoWalletDetailResponseData.data!.azkiMenu;

        final firstName = walletInfo.user!.firstName;
        final lastName = walletInfo.user!.lastName;
        if (firstName != null && lastName != null) {
          mainController.authInfoData!.firstName = firstName;
          mainController.authInfoData!.lastName = lastName;
        }

        final nationalCode = walletInfo.user!.nationalCode;
        if (nationalCode != null) {
          mainController.authInfoData!.nationalCode = nationalCode;
        }

        final birthDate = walletInfo.user!.birthDate;
        mainController.authInfoData!.birthdayDate =
            DateConverterUtil.getDateJalali(gregorianDate: birthDate);

        if (walletInfo.zoomId != null) {
          if (walletInfo.zoomId!.zoomIdLicenseAndroid != null) {
            mainController.authInfoData!.zoomIdLicenseAndroid =
                walletInfo.zoomId!.zoomIdLicenseAndroid;
          }
          if (walletInfo.zoomId!.zoomIdLicenseIos != null) {
            mainController.authInfoData!.zoomIdLicenseIos =
                walletInfo.zoomId!.zoomIdLicenseIos;
          }
        }

        mainController.authInfoData!.goftinoId = walletInfo.user!.goftinoId;
      }
      mainController.keyAliasModelList = [];
      mainController.keyAliasModelList.add(KeyAliasModel(
          keyAlias: mainController.authInfoData!.mobile!,
          timestamp: DateTime.now().millisecondsSinceEpoch));
      await StorageUtil.setKeyAliasModel(mainController.keyAliasModelList);
      await StorageUtil.setAuthInfoDataSecureStorage(
          mainController.authInfoData!);
      await mainController.getAppEkycProvider();
      if (needUpdate) {
        Get.offAll(() => const DashboardScreen());
      }
    }
  }

  void showRuleScreen() {
    Get.to(() => const RulesScreen(isFirst: true));
  }
}
