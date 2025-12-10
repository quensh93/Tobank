import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:uuid/uuid.dart';

import '../../model/other/app_version_data.dart';
import '../../model/other/menu_response_data.dart';
import '../../model/wallet/request/customer_info_wallet_detail_request_data.dart';
import '../../model/wallet/response/customer_info_wallet_detail_response_data.dart';
import '../../model/wallet/response/wallet_detail_data.dart';
import '../../service/app_version_services.dart';
import '../../service/core/api_core.dart';
import '../../service/wallet_services.dart';
import '../../ui/common/loading_page.dart';
import '../../ui/dashboard_screen/dashboard_screen.dart';
import '../../ui/launcher/view/check_login_status_page.dart';
import '../../ui/launcher/view/update_page.dart';
import '../../ui/rule/rules_screen.dart';
import '../../ui/signup/sign_up_screen.dart';
import '../../ui/update_app/update_app_screen.dart';
import '../../util/app_util.dart';
import '../../util/application_info_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/secure_web_plugin.dart';
import '../../util/shared_preferences_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../../util/web_only_utils/token_util.dart';
import '../../util/web_only_utils/url_listener_service.dart';
import '../main/main_controller.dart';
import 'package:universal_html/html.dart' as html;


class LauncherController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;
  AppVersionData? appVersionData;
  final alphanumeric = RegExp(r'^[a-zA-Z0-9 !"#$%&()*+,-./:;<=>?@[\]^_`{|}~]+$');

  String errorTitle = '';
  bool hasError = false;

  bool isStoreMenuData = false;
  String? localLatestMenuUpdate;
  LauncherState currentLauncherState = LauncherState.loading;

  @override
  Future<void> onInit() async {
    if(mainController.getToPayment) {
      Get.back();
    }else{
      AppUtil.setStatusBarColor(Get.isDarkMode);

      // Check app ekyc provider
      if (mainController.authInfoData?.nationalCode != null && mainController.authInfoData?.mobile != null) {
        await mainController.getAppEkycProvider();
      }

      await _checkStoreMenuData();
      _checkTrust();
    }

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> _checkTrust() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final bool isTrust = await AppUtil.isTrust();
    if (isTrust) {
      _getAppVersionRequest();
    } else {
      Timer(const Duration(seconds: 5), () {
        exit(0);
      });
      SnackBarUtil.showInfoSnackBar(
        locale.app_not_supported_on_this_device,
      );
      if(kIsWeb){
        html.window.parent?.postMessage("close_clicked", "*");
      }
    }
  }

  Widget getMainWidget() {
    if (currentLauncherState == LauncherState.loading) {
      return LoadingPage(
        errorTitle,
        hasError: hasError,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        isLoading: isLoading,
        retryFunction: () {
          _getAppVersionRequest();
          if (mainController.overlayContext != null) {
            OverlaySupportEntry.of(mainController.overlayContext!)?.dismiss();
          }
        },
      );
    } else if (currentLauncherState == LauncherState.update) {
      return const UpdatePage();
    } else if (currentLauncherState == LauncherState.login) {
      return const CheckLoginStatusPage();
    } else {
      return Container();
    }
  }

  /// Sends a request to get the app version information.
  void _getAppVersionRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    /// todo: add pwa server side
    final String platform = (kIsWeb)
        ? 'pwa'
        : Platform.isAndroid
        ? 'redesign-android'
        : 'redesign-ios';
    isLoading = true;
    hasError = false;
    update();
    AppVersionServices.getAppVersion(platform).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final AppVersionData response, int _)):
          appVersionData = response;
          mainController.latestMenuUpdate = response.data!.lastestMenuUpdate;
          mainController.autf = response.data!.autf;
          mainController.advertisementText = response.data!.advertismentText;
          mainController.creditInquiryPrice = response.data!.creditInquiryPrice;
          mainController.backgroundTimeForRecheckPass = response.data!.backgroundTimeForPass ?? 60;
          mainController.activatePromissoryPublishPayment = response.data!.activatePromissoryPublishPayment ?? false;
          mainController.activateLoanFeePayment = response.data!.activateLoanFeePayment ?? false;
          mainController.activateWalletChargePayment = response.data!.activateWalletChargePayment ?? false;
          mainController.activateCreditInquiryPayment = response.data!.activateCreditInquiryPayment ?? false;
          mainController.activateIncreaseDepositBalance = response.data!.activateIncreaseDepositBalance ?? false;
          update();
          _checkVersion();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          switch (apiException.type) {
            case ApiExceptionType.vpnConnected:
              DialogUtil.showForbiddenMessage(
                buildContext: Get.context,
                actionFunction: () => _getAppVersionRequest(),
              );
            default:
              SnackBarUtil.showSnackBar(
                title: locale.show_error(apiException.displayCode),
                message: apiException.displayMessage,
              );
          }
      }
    });
  }

  void _checkVersion() {
    if (AppUtil.getVersionCode(appVersionData!.data!.app!.version!) >
        AppUtil.getVersionCode(ApplicationInfoUtil().appVersion)) {
      if ((appVersionData!.data!.app!.forcingUpdate != null && appVersionData!.data!.app!.forcingUpdate!) ||
          (appVersionData!.data!.app!.showUpdate != null && appVersionData!.data!.app!.showUpdate!)) {
        currentLauncherState = LauncherState.update;
        update();
      } else {
        checkToken();
      }
    } else {
      checkToken();
    }
  }

  /// Check token stored status in shared preferences
  /// if token exist, got to page 3
  /// else start [SignUpScreen]
  Future<void> checkToken() async {
    if (mainController.authInfoData != null) {
      // Check if the app was opened via a URL (with or without token)
      final bool isOpenedViaUrl = UrlService.instance.currentUri.path.isNotEmpty;

      if (isOpenedViaUrl) {
        print('🔑 App opened via URL, checking URL token');

        // Check if we have a URL token
        final urlTokenData = await TokenUtil.getStoredTokenWithKey(UrlService.urlTokenKey);

        if (urlTokenData != null) {
          final urlToken = urlTokenData['token'] as String?;
          final urlExpiry = urlTokenData['expiry'] as int?;

          if (urlToken != null && urlExpiry != null) {
            // Check if URL token is still valid
            final isUrlTokenValid = await TokenUtil.isTokenValid(urlToken, urlExpiry);

            if (isUrlTokenValid) {
              print('🔑 Valid URL token found, checking if it matches standard token');

              // Get standard token for comparison
              final standardTokenData = await TokenUtil.getStoredToken();
              if (standardTokenData != null) {
                final standardToken = standardTokenData['token'] as String?;

                // Compare tokens
                if (standardToken != null && standardToken == urlToken) {
                  print('🔑 URL token matches standard token, skipping password check');

                  // Clear both tokens since we've validated the user
                  await TokenUtil.clearTokenWithKey(UrlService.urlTokenKey);
                  await TokenUtil.clearStoredToken();

                  print('🔑 All tokens cleared after successful validation');

                  // Token is valid and matches, skip password check
                  currentLauncherState = LauncherState.login;
                  update();
                  _checkForMenuData();
                  return;
                } else {
                  print('🔑 URL token does not match standard token, requiring password');
                }
              } else {
                print('🔑 No standard token found for comparison, requiring password');
              }
            } else {
              // Clear invalid URL token
              print('🔑 URL token is invalid, clearing it and requiring password');
              await TokenUtil.clearTokenWithKey(UrlService.urlTokenKey);
            }
          }
        } else {
          print('🔑 No URL token found, requiring password for URL access');
        }

        // If we get here, it means URL access without valid matching tokens
        // Always require password in this case
        final String? password = await StorageUtil.getPassword();
        if (password == null || password == '') {
          AppUtil.logoutFromApp();
        } else {
          _deviceCapabilities();
          currentLauncherState = LauncherState.login;
          update();
        }
        return;
      }

      // Normal app launch (not via URL) - can use standard token
      print('🔑 Normal app launch, checking standard token');
      final tokenData = await TokenUtil.getStoredToken();
      if (tokenData != null) {
        final token = tokenData['token'] as String?;
        final expiry = tokenData['expiry'] as int?;

        if (token != null && expiry != null) {
          final isValid = await TokenUtil.isTokenValid(token, expiry);
          if (isValid) {
            // Valid token exists, skip password check for normal app launch
            print('🔑 Valid standard token exists, skipping password check');

            // Clear the standard token after successful validation
            await TokenUtil.clearStoredToken();
            print('🔑 Standard token cleared after successful validation');

            currentLauncherState = LauncherState.login;
            update();
            _checkForMenuData();
            return;
          }
        }
      }

      // No valid token, continue with normal password flow
      final String? password = await StorageUtil.getPassword();
      if (password == null || password == '') {
        AppUtil.logoutFromApp();
      } else {
        _deviceCapabilities();
        currentLauncherState = LauncherState.login;
        update();
      }
    } else {
      currentLauncherState = LauncherState.loading;
      update();
      showSignUpScreen();
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

  Future<void> launchURL() async {
    AppUtil.launchInBrowser(url: appVersionData!.data!.landingpage!.link!);
  }

  void showSignUpScreen() {
    Get.offAll(() => const SignUpScreen());
  }

  void showRuleScreen() {
    Get.to(() => const RulesScreen(
          isFirst: true,
        ));
  }

  /// check login status page
  ///
  ///
  ///
  final LocalAuthentication _auth = LocalAuthentication();
  bool isSecurityEnable = false;
  bool canAuthenticate = false;
  bool hasFingerPrint = false;
  bool hasFaceDetect = false;
  int tryCount = 0;
  bool isCorrectPassword = true;
  TextEditingController passwordController = TextEditingController();

  /// Show confirm message for logout from app
  Future<void> logout() async {

    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.logout_required_for_password_reset,
        description:
            locale.logout_warning_description,
        positiveMessage: locale.logout,
        negativeMessage: locale.close,
        positiveFunction: () async {
          Get.back();
          await mainController.analyticsService.logLogout();
          await AppUtil.deleteUserData(Get.context);
          currentLauncherState = LauncherState.loading;
          update();
          _getAppVersionRequest();
        },
        negativeFunction: () {
          Get.back();
        });
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
  /// handles incorrect attempts, and potentially calls [_checkForMenuData].
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
        _checkForMenuData();
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
          authMessages:  <AuthMessages>[
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
      _checkForMenuData();
    }
  }

  void _checkForMenuData() {
    bool shouldMenuUpdate = true;
    print("🔴");
    print("🔴 shouldMenuUpdate : $shouldMenuUpdate");
    print("🔴 isStoreMenuData : $isStoreMenuData");

    if (isStoreMenuData) {
      print("🔴 localLatestMenuUpdate : $localLatestMenuUpdate");
      if (localLatestMenuUpdate == null) {
        shouldMenuUpdate = true;
      } else {
        if (appVersionData != null) {
          if (localLatestMenuUpdate == appVersionData!.data!.lastestMenuUpdate) {
            shouldMenuUpdate = false;
          } else {
            shouldMenuUpdate = true;
          }
        } else {
          shouldMenuUpdate = false;
        }
      }
    } else {
      shouldMenuUpdate = true;
    }
    print("🔴🔴");
    if (shouldMenuUpdate) {
      print("🔴🔴🔴");
      _getMenuDataRequest();
    } else {
      _getCustomerInfoWalletDetailRequest();
    }
  }

  // Sends a request to get the menu data.
  void _getMenuDataRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    AppVersionServices.getMenu().then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final MenuResponseModel response, int _)):
          _storeMenuData(response);
          _getCustomerInfoWalletDetailRequest();
        case Failure(exception: final ApiException apiException):
          // Token expired
          if (apiException.type == ApiExceptionType.unhandledStatusCode && apiException.statusCode == 401) {
            AppUtil.logoutFromApp();
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  Future<void> _storeMenuData(MenuResponseModel menuResponseModel) async {
    await StorageUtil.setMainMenuSecureStorage(jsonEncode(menuResponseModel.data!.toJson()));
    await StorageUtil.setLatestMenuUpdateSecureStorage(menuResponseModel.lastestMenuUpdate);
    await mainController.getMenuData();
  }

  ///here in ios we don't have back and its will not cause error in this
  Future<void> _startDashBoardScreen() async {
    Get.offAll(() => const DashboardScreen());
  }

  bool isForceUpdate() {
    if (appVersionData != null && appVersionData!.data != null) {
      return appVersionData!.data!.app!.forcingUpdate!;
    } else {
      return false;
    }
  }

  String getUpdateButtonText() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
     String text = locale.download_new_version;
    final String version = appVersionData?.data?.app?.version ?? '';
    if (version.isEmpty) {
      return text;
    } else {
      return '$text ($version)';
    }
  }

  Future _checkStoreMenuData() async {
    final String? menuData = await StorageUtil.getMainMenuSecureStorage();
    localLatestMenuUpdate = await StorageUtil.getLatestMenuUpdateSecureStorage();
    if (menuData != null) {
      isStoreMenuData = true;
    } else {
      isStoreMenuData = false;
    }
  }

  // Sends a request to get customer info and wallet details.
  void _getCustomerInfoWalletDetailRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerInfoWalletDetailRequestData customerInfoWalletDetailRequestData = CustomerInfoWalletDetailRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: false,
      forceInquireAddressInfo: false,
      getCustomerStartableProcesses: false,
      getCustomerDeposits: false,
      getCustomerActiveCertificate: mainController.appEKycProvider == EKycProvider.yekta,
      category: 'notify',
      type: Platform.isAndroid ? 'redesign-android' : 'redesign-ios',
    );
    isLoading = true;
    update();
    WalletServices.getCustomerInfoWalletDetailRequest(
      customerInfoWalletDetailRequestData: customerInfoWalletDetailRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerInfoWalletDetailResponseData response, 200)):
          _storeCustomerInfoWalletDetail(response);
        case Success(value: (final AppVersionData response, 420)):
          Get.to(() => UpdateAppScreen(appVersionData: response));
        case Success<(Object, int), ApiException>():
          break; // Will not happen
        case Failure(exception: final ApiException apiException):
          // Token expired
          if (apiException.type == ApiExceptionType.unhandledStatusCode && apiException.statusCode == 401) {
            AppUtil.logoutFromApp();
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  Future<void> _checkCertificate({required String certificate}) async {

    /// todo: add later to pwa
    if (!(await AppUtil.isCertificatesEqual(certificate: certificate))) {
      if (kIsWeb) {
        await SecureWebPlugin.removePairKey();
      } else {
        await SecurePlugin.removeKey(
            phoneNumber: mainController.keyAliasModelList.first.keyAlias);
      }
      mainController.authInfoData!.ekycDeviceId = null;
      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);

      await mainController.getAppEkycProvider();
    }
  }

  Future<void> _storeCustomerInfoWalletDetail(
      CustomerInfoWalletDetailResponseData customerInfoWalletDetailResponseData) async {
    if (mainController.authInfoData != null) {
      if (customerInfoWalletDetailResponseData.data != null) {
        mainController.destinationEKycProvider = customerInfoWalletDetailResponseData.data!.ekycProvider ?? 0;
        if (customerInfoWalletDetailResponseData.data!.customerNumber != null) {
          mainController.authInfoData!.customerNumber = customerInfoWalletDetailResponseData.data!.customerNumber;
          mainController.authInfoData!.shahabCodeAcquired =
              customerInfoWalletDetailResponseData.data!.shahabCodeAcquired.toString();
          if (customerInfoWalletDetailResponseData.data!.firstName != null &&
              customerInfoWalletDetailResponseData.data!.lastName != null) {
            mainController.authInfoData!.firstName = customerInfoWalletDetailResponseData.data!.firstName;
            mainController.authInfoData!.lastName = customerInfoWalletDetailResponseData.data!.lastName;
          }
          mainController.authInfoData!.shabahangCustomerStatus =
              customerInfoWalletDetailResponseData.data!.customerStatus;
          mainController.authInfoData!.digitalBankingCustomer =
              customerInfoWalletDetailResponseData.data!.digitalBankingCustomer;
          mainController.authInfoData!.loyaltyCode = customerInfoWalletDetailResponseData.data!.loyaltyCode;
        }

        mainController.walletDetailData ??= WalletDetailData();
        final walletInfo = customerInfoWalletDetailResponseData.data!.walletInfo!;
        mainController.walletDetailData!.data = walletInfo;
        mainController.azkiMenu = customerInfoWalletDetailResponseData.data!.azkiMenu;

        final deviceUuid = walletInfo.deviceUuid;
        if (mainController.authInfoData!.deviceUUID == null) {
          if (deviceUuid != null) {
            mainController.authInfoData!.deviceUUID = deviceUuid;
          }
        } else {
          if (deviceUuid != null && deviceUuid != mainController.authInfoData!.deviceUUID) {
            await StorageUtil.deleteShaparakHubSecureStorage();
          }
        }

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
        mainController.authInfoData!.birthdayDate = DateConverterUtil.getDateJalali(gregorianDate: birthDate);

        if (walletInfo.zoomId != null) {
          if (walletInfo.zoomId!.zoomIdLicenseAndroid != null) {
            mainController.authInfoData!.zoomIdLicenseAndroid = walletInfo.zoomId!.zoomIdLicenseAndroid;
          }
          if (walletInfo.zoomId!.zoomIdLicenseIos != null) {
            mainController.authInfoData!.zoomIdLicenseIos = walletInfo.zoomId!.zoomIdLicenseIos;
          }
        }

        mainController.authInfoData!.goftinoId = walletInfo.user!.goftinoId;
      }

      if (customerInfoWalletDetailResponseData
          .data!.activeCertificateResponse !=
          null) {
        //
        print("🔴 token : ${customerInfoWalletDetailResponseData
            .data!.activeCertificateResponse!.token!}");
        await _checkCertificate(
            certificate: customerInfoWalletDetailResponseData.data!.activeCertificateResponse!.token!);
      }

      _convertVirtualBranchStatus();

      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);

      mainController.update();
      _startDashBoardScreen();
    }
  }

  Future<void> _convertVirtualBranchStatus() async {
    // Virtual branch status not converted
    if (mainController.authInfoData!.virtualBranchStatus == null) {
      switch (mainController.authInfoData!.virtualBranchIsRegistered) {
        case true:
          mainController.authInfoData!.virtualBranchStatus = VirtualBranchStatus.registered;
          break;
        case false:
          mainController.authInfoData!.virtualBranchStatus = VirtualBranchStatus.enrolled;
          break;
        case null:
          mainController.authInfoData!.virtualBranchStatus =
              mainController.appEKycProvider != null ? VirtualBranchStatus.enrolled : VirtualBranchStatus.notEnrolled;
          break;
      }
    }

    if (mainController.authInfoData!.virtualBranchStatus == VirtualBranchStatus.updatePublicKey) {
      mainController.authInfoData!.virtualBranchStatus = VirtualBranchStatus.registered;
    }
  }
}
