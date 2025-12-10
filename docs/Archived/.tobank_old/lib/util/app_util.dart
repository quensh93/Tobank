import 'dart:async';
import 'dart:convert';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:universal_io/io.dart';
import 'dart:math' as math;
import 'dart:math';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:device_apps/device_apps.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

// import 'package:is_device_secure/is_device_secure.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:safe_device/safe_device.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:util_plugin/util_plugin.dart';
import 'package:uuid/uuid.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart';
import 'package:zoom_id/zoom_id.dart';

import '../controller/dashboard/dashboard_controller.dart';
import '../controller/facility/facility_controller.dart';
import '../controller/main/main_controller.dart';
import '../controller/tobank_services/tobank_services_controller.dart';
import '../model/base64/request_data.dart';
import '../model/base64/response_data.dart';
import '../model/bpms/bpms_ownership_data.dart';
import '../model/bpms/bpms_warranty_data.dart';
import '../model/bpms/document_state_data.dart';
import '../model/bpms/military_guarantee/military_guarantee_deposit_type_data.dart';
import '../model/bpms/parsa_loan/response/task/process_state_response_data.dart';
import '../model/bpms/response/get_task_data_response_data.dart';
import '../model/card/card_block_reason_data.dart';
import '../model/close_deposit_type_item_data.dart';
import '../model/common/encryption_key_pair.dart';
import '../model/common/menu_data.dart';
import '../model/common/menu_data_model.dart';
import '../model/common/sign_document_data.dart';
import '../model/contact_match/custom_contact.dart';
import '../model/contact_match/custom_match_contact.dart';
import '../model/pichak/bank_data.dart';
import '../model/pichak/guarantee_status_data.dart';
import '../model/pichak/transfer_action_data.dart';
import '../model/profile/auth_info_data.dart';
import '../model/promissory/external_signer.dart';
import '../model/promissory/promissory_finalized_item_data.dart';
import '../model/shaparak_hub/shaparak_public_key_model.dart';
import '../model/sign_model.dart';
import '../model/transfer/purpose_data.dart';
import '../model/transfer/transfer_method_data.dart';
import '../new_structure/core/app_config/app_config.dart';
import '../new_structure/core/injection/injection.dart';
import '../new_structure/core/services/secure/device_security.dart';
import '../service/profile_services.dart';
import '../ui/acceptor/acceptor_screen.dart';
import '../ui/card_balance/card_balance_screen.dart';
import '../ui/card_to_card/card_to_card_screen.dart';
import '../ui/charity/charity_screen.dart';
import '../ui/common/message_overlay_view.dart';
import '../ui/customer_club/customer_club_screen.dart';
import '../ui/facility/facility_screen.dart';
import '../ui/gift_card/list_gift_card/gift_card_main_screen.dart';
import '../ui/internal_web_view/internal_web_view_screen.dart';
import '../ui/internet/internet_screen.dart';
import '../ui/invoice/invoice_screen.dart';
import '../ui/launcher/launcher_screen.dart';
import '../ui/mega_gasht/mega_gasht_screen.dart';
import '../ui/parsa_loan/parsa_loan_access/parsa_loan_access_screen.dart';
import '../ui/pichak/pichak_screen.dart';
import '../ui/renew_certificate/renew_certificate_bottom_sheet.dart';
import '../ui/sim_charge/sim_charge_screen.dart';
import '../ui/support/support_screen.dart';
import '../ui/tobank_services/tobank_services_screen.dart';
import '../ui/parsa_loan/parsa_loan_amount/parsa_loan_amount_screen.dart';
import '../ui/parsa_loan/parsa_loan_branch_info/parsa_loan_branch_info_screen.dart';
import '../ui/parsa_loan/parsa_loan_contract/parsa_loan_contract_screen.dart';
import '../ui/parsa_loan/parsa_loan_customer_address/parsa_loan_customer_address_screen.dart';
import '../ui/parsa_loan/parsa_loan_customer_document/parsa_loan_customer_document_screen.dart';
import '../ui/parsa_loan/parsa_loan_employment_type/parsa_loan_employment_type_screen.dart';
import '../ui/parsa_loan/parsa_loan_get_customer_score/parsa_loan_get_customer_score_screen.dart';
import '../ui/parsa_loan/parsa_loan_inquiry/parsa_loan_inquiry_screen.dart';
import '../ui/parsa_loan/parsa_loan_promissory/parsa_loan_promissory_screen.dart';
import '../ui/parsa_loan/parsa_loan_select_deposit/parsa_loan_select_deposit_screen.dart';
import '../ui/parsa_loan/parsa_loan_select_plan/parsa_loan_select_plan_screen.dart';
import '../widget/svg/svg_icon.dart';
import 'application_info_util.dart';
import 'authentication_constants.dart' as authentication_constants;
import 'constants.dart';
import 'data_constants.dart';
import 'date_converter_util.dart';
import 'enums_constants.dart';
import 'file_util.dart';
import 'secure_web_plugin.dart';
import 'shared_preferences_util.dart';
import 'snack_bar_util.dart';
import 'storage_util.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_io/io.dart';

import 'web_only_utils/web_pdf_sign.dart';

class AppUtil {
  AppUtil._();

  static MainController mainController = Get.find();

  static Future<int> getFileSizeCompressQuality(
      {required int fileSize, required double maxFileSize}) async {
    if (fileSize > maxFileSize) {
      return (maxFileSize * 100 / fileSize).floor().toInt();
    } else {
      return 100;
    }
  }

  /*static String baseUrlStatic() {
    if (kIsWeb) {
      return Constants.baseUrlStatic;
    }
    if (isProduction()) {
      return Constants.baseUrlStatic;
    } else {
      return Constants.devBaseStaticUrl;
    }
  }*/

  /*/// todo: add later to pwa (flavor baseurl)
  // API Client
  static String baseUrl() {
    if (isProduction()) {
      return Constants.baseUrl;
    } else {
      return Constants.devBaseUrl;
    }
  }*/

  /*static String baseUrlSSLFingerprint() {
    if (isProduction()) {
      return Constants.baseUrlSSLFingerprint;
    } else {
      return Constants.devBaseUrlSSLFingerprint;
    }
  }*/

  static Map<String, String> getAppAndDeviceDetailHTTPHeaders() {
    final headers = {
      'App-Version': getHeaderVersionCode(ApplicationInfoUtil().appVersion),
      'App-Platform': GetPlatform.isWeb
          ? 'web'
          : GetPlatform.isAndroid
              ? 'android'
              : 'ios',
      'App-Store': mainController.appStore,
      'Device-UUID': mainController.deviceUuid ?? 'NONE',
      'User-Device-UUID': mainController.authInfoData?.uuid ?? 'NONE',
    };
    return headers;
  }

  static String getToken() {
    return mainController.authInfoData!.token!;
  }

  static String getDecodedStringApiCall(String dataEncodedString) {
    return AppUtil.base64Decoding(dataEncodedString);
  }

  static Future<bool> checkDeviceIsSecure() async {
    ///TODO-MERGE
    return (await AppUtil.isDeviceSecure()) ?? false;
  }

  // API Client

  static String? mime(String fileName) {
    final int lastDot = fileName.lastIndexOf('.', fileName.length - 1);
    if (lastDot != -1) {
      return fileName.substring(lastDot + 1);
    } else {
      return null;
    }
  }

  static String splitCardNumber(String cardNumber, String separator) {
    final buffer = StringBuffer();
    for (int i = 0; i < cardNumber.length; i++) {
      buffer.write(cardNumber[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != cardNumber.length) {
        buffer.write(separator); // Add double spaces.
      }
    }
    return buffer.toString();
  }

  static String formatMoney(var amount) {
    if (amount == null) {
      return '';
    }
    amount = amount.toString().replaceAll(',', '');
    return intl.NumberFormat('#,###', 'en_US').format(double.parse(amount));
  }

  static String formatMillions(var amount) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (amount == null) {
      return '';
    }
    final int remain = amount ~/ 1000000;
    return '$remain ${locale.million}';
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static String maskCardNumber(String cardNumber) {
    if (cardNumber.contains('*') || cardNumber.length != 16) {
      return cardNumber;
    } else {
      final String firstFour = cardNumber.substring(0, 4);
      final String lastFour = cardNumber.substring(12, 16);
      const String eightStart = '********';
      return firstFour + eightStart + lastFour;
    }
  }

  /// remove [AuthInfoData] from shared preferences & return to [LauncherScreen]
  static Future logoutFromApp({bool needToClearRoute = true}) async {
    final MainController mainController = Get.find();
    ProfileServices.logOutUser();
    StorageUtil.box.remove(Constants.shaparakHubStoredData);
    StorageUtil.box.remove(authentication_constants
        .AuthenticationConstants.authenticateCertificateModel);
    StorageUtil.box.remove(authentication_constants
        .AuthenticationConstants.base64UserSignatureImage);
    await SharedPreferencesUtil().remove(Constants.authInfo);
    await SharedPreferencesUtil().remove(Constants.passCode);
    await SharedPreferencesUtil().remove(Constants.fingerPrint);
    await SharedPreferencesUtil().remove(Constants.timeToRequest);
    await SharedPreferencesUtil().remove(Constants.acceptorAuthInfo);
    await SharedPreferencesUtil().remove(Constants.password);
    await SharedPreferencesUtil().remove(Constants.authInfoSecure);
    await SharedPreferencesUtil().remove(Constants.shaparakHubStoredData);
    await SharedPreferencesUtil()
        .remove(Constants.automaticDynamicPinStoredData);
    await SharedPreferencesUtil().remove(authentication_constants
        .AuthenticationConstants.authenticateCertificateModel);
    await SharedPreferencesUtil().remove(authentication_constants
        .AuthenticationConstants.base64UserSignatureImage);
    await SharedPreferencesUtil().clear();
    if (kIsWeb) {
      await SecureWebPlugin.removeAllKey();
    } else {
      await SecurePlugin.removeKey(
          phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    }

    await StorageUtil.deleteAuthenticateCertificateModel();
    await StorageUtil.reset();
    if (!kIsWeb && Platform.isIOS) {
      ZoomId.logOutIos(mainController.authInfoData!.mobile!);
    } else {
      if (getIt<AppConfigService>().config.environment ==
          AppEnvironment.production) {
        ZoomId.logOutAndroid(
          license: mainController.authInfoData!.zoomIdLicenseAndroid ??
              Constants.zoomIdLicense,
          phone: mainController.authInfoData!.mobile!,
          nationalId: mainController.authInfoData!.nationalCode!,
        );
      }
    }
    // Save device uuid after logout
    await StorageUtil.setDeviceUuid(mainController.deviceUuid!);
    mainController.authInfoData = null;

    // Remove web data
    if (!kIsWeb && Platform.isAndroid) {
      await WebStorageManager.instance().deleteAllData();
    } else if (!kIsWeb && Platform.isIOS) {
      final dataRecords = await WebStorageManager.instance()
          .fetchDataRecords(dataTypes: WebsiteDataType.ALL);
      await WebStorageManager.instance().removeDataFor(
          dataTypes: WebsiteDataType.ALL, dataRecords: dataRecords);
    }

    if(!kIsWeb){
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      firebaseMessaging.setAutoInitEnabled(false);
      firebaseMessaging.deleteToken();
    }

    if (needToClearRoute) {
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => const LauncherScreen()),
        ModalRoute.withName('/Home'),
      );
    }
  }

  /// remove [AuthInfoData] from shared preferences
  static Future deleteUserData(BuildContext? context , [bool needToClearRoute = true]) async {
    final MainController mainController = Get.find();
    ProfileServices.logOutUser();
    StorageUtil.box.remove(Constants.shaparakHubStoredData);
    StorageUtil.box.remove(authentication_constants
        .AuthenticationConstants.authenticateCertificateModel);
    StorageUtil.box.remove(authentication_constants
        .AuthenticationConstants.base64UserSignatureImage);
    await SharedPreferencesUtil().remove(Constants.authInfo);
    await SharedPreferencesUtil().remove(Constants.passCode);
    await SharedPreferencesUtil().remove(Constants.fingerPrint);
    await SharedPreferencesUtil().remove(Constants.timeToRequest);
    await SharedPreferencesUtil().remove(Constants.acceptorAuthInfo);
    await SharedPreferencesUtil().remove(Constants.password);
    await SharedPreferencesUtil().remove(Constants.authInfoSecure);
    await SharedPreferencesUtil().remove(Constants.shaparakHubStoredData);
    await SharedPreferencesUtil()
        .remove(Constants.automaticDynamicPinStoredData);
    await SharedPreferencesUtil().remove(authentication_constants
        .AuthenticationConstants.authenticateCertificateModel);
    await SharedPreferencesUtil().remove(authentication_constants
        .AuthenticationConstants.base64UserSignatureImage);
    await SharedPreferencesUtil().clear();
    await StorageUtil.reset();
    if (kIsWeb) {
      await SecureWebPlugin.removeAllKey();
    } else {
      await SecurePlugin.removeKey(
          phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    }
    await StorageUtil.deleteAuthenticateCertificateModel();
    // Save device uuid after logout
    await StorageUtil.setDeviceUuid(mainController.deviceUuid!);
    mainController.authInfoData = null;

    // Remove web data
    if (!kIsWeb && Platform.isAndroid) {
      await WebStorageManager.instance().deleteAllData();
    } else if (!kIsWeb && Platform.isIOS) {
      final dataRecords = await WebStorageManager.instance()
          .fetchDataRecords(dataTypes: WebsiteDataType.ALL);
      await WebStorageManager.instance().removeDataFor(
          dataTypes: WebsiteDataType.ALL, dataRecords: dataRecords);
    }

    if(!kIsWeb){
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      firebaseMessaging.setAutoInitEnabled(false);
      firebaseMessaging.deleteToken();
    }

    if (needToClearRoute) {
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => const LauncherScreen()),
        ModalRoute.withName('/Home'),
      );
    }
  }

  static bool validateNationalCode(String nationalCode) {
    final int control = int.parse(nationalCode[9]);
    int sum = 0;
    for (int i = 10; i > 1; i--) {
      sum += int.parse(nationalCode[10 - i]) * i;
    }
    final int remain = sum % 11;
    if (remain < 2) {
      if (control == remain) {
        return true;
      } else {
        return false;
      }
    } else {
      if (11 - remain == control) {
        return true;
      } else {
        return false;
      }
    }
  }

  static String? getPersianNumbers(String? textNumber) {
    if (textNumber == null) {
      return textNumber;
    }
    return textNumber
        .replaceAll('1', '۱')
        .replaceAll('2', '۲')
        .replaceAll('3', '۳')
        .replaceAll('4', '۴')
        .replaceAll('5', '۵')
        .replaceAll('6', '۶')
        .replaceAll('7', '۷')
        .replaceAll('8', '۸')
        .replaceAll('9', '۹')
        .replaceAll('0', '۰');
  }

  static String getEnglishNumbers(String textNumber) {
    return textNumber
        .replaceAll('۱', '1')
        .replaceAll('۲', '2')
        .replaceAll('۳', '3')
        .replaceAll('۴', '4')
        .replaceAll('۵', '5')
        .replaceAll('۶', '6')
        .replaceAll('۷', '7')
        .replaceAll('۸', '8')
        .replaceAll('۹', '9')
        .replaceAll('۰', '0');
  }

  static void printResponse(String? response) {
    if (kDebugMode) {
      print(response);
    }
  }

  static Map<String, String?> getHTTPHeaderWithoutToken() {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Accept-Encoding': 'gzip, deflate',
      'Cache-Control': 'no-store',
    };
    return headers;
  }

  static Future<SignModel?> signRequestBody(String text) async {
    SignModel? signData = SignModel();
    final String hashedText =
        sha256.convert(utf8.encode(text)).toString().toLowerCase();

    String provider = '0';
    switch (mainController.appEKycProvider!) {
      case EKycProvider.zoomId:
        signData = await signZoomIdRequestBody(hashedText);
        provider = '0';
        break;
      case EKycProvider.yekta:
        signData = kIsWeb
            ? await signYektaRequestBodyWeb(hashedText)
            : await signYektaRequestBody(
                hashedText, mainController.keyAliasModelList.first.keyAlias);
        provider = '1';
        break;
    }
    if (signData != null) {
      signData.provider = provider;
    }

    return signData;
  }

  static Future<SignModel?> signZoomIdRequestBody(String hashedText) async {
    SignModel? signData;
    try {
      if (Platform.isAndroid) {
        final sign = await ZoomId.sign(
          license: mainController.authInfoData!.zoomIdLicenseAndroid ??
              Constants.zoomIdLicense,
          phone: mainController.authInfoData!.mobile!,
          input: hashedText,
          nationalId: mainController.authInfoData!.nationalCode!,
        );
        if (sign != null) {
          final splited = sign.split(':');
          signData = SignModel();
          signData.sign = splited[0];
          signData.traceID = splited[1];
        }
      } else {
        final String? localTrace = await ZoomId.traceIdIos();
        if (localTrace != null) {
          final resultTrace = localTrace.split(':');
          final traceIdZoomId = resultTrace[0];
          final signZoomId = await ZoomId.signIos(hashedText);

          if (signZoomId != null) {
            signData = SignModel();
            signData.sign = signZoomId;
            signData.traceID = traceIdZoomId;
          }
        }
      }
    } on Exception catch (e) {
      AppUtil.printResponse(e.toString());
    }
    return signData;
  }

  static Future<SignModel?> signYektaRequestBody(
      String hashedText, String keyAlias) async {
    SignModel? signData;
    final response = await SecurePlugin.signText(
        plainText: hashedText, phoneNumber: keyAlias);
    if (response.isSuccess != null && response.isSuccess!) {
      signData = SignModel();
      signData.sign = response.data!;
      signData.traceID = const Uuid().v4();
    } else {
      AppUtil.printResponse(response.message ?? 'Secure plugin null message');
      if (response.statusCode != 10) {
        await Sentry.captureMessage('sign text error',
            params: [
              {'status code': response.statusCode},
              {'message': response.message},
            ],
            level: SentryLevel.warning);
      }
    }

    return signData;
  }

  /// todo: add later to pwa
  static Future<SignModel?> signYektaRequestBodyWeb(String hashedText) async {
    SignModel? signData;
    final response = await SecureWebPlugin.signData(hashedText);
    signData = SignModel();
    signData.sign = response;
    signData.traceID = const Uuid().v4();
    return signData;
  }

  /*static String getShaparakHubBaseUrl() {
    if (isProduction()) {
      return Constants.shaparakHubBaseUrl;
    } else {
      return Constants.shaparakHubBaseUrl;
    }
  }*/

  static String getClientRef(String token) {
    final int time = DateTime.now().millisecondsSinceEpoch;
    final bytes = utf8.encode(token.substring(0, 5) +
        time.toString() +
        token.substring(token.length - 6));
    return base64Encode(bytes);
  }

  static List<CustomContact> sortContacts(
      List<CustomContact> allContactsWithPhone) {
    allContactsWithPhone.sort((a, b) {
      return a.displayName
          .toString()
          .toLowerCase()
          .compareTo(b.displayName.toString().toLowerCase());
    });
    return allContactsWithPhone;
  }

  static List<CustomMatchContact> sortMatchContacts(
      List<CustomMatchContact> allContactsWithPhone) {
    allContactsWithPhone.sort((a, b) {
      return a.displayName
          .toString()
          .toLowerCase()
          .compareTo(b.displayName.toString().toLowerCase());
    });
    return allContactsWithPhone;
  }

  static int getVersionCode(String versionString) {
    final split = versionString.replaceAll('-dev', '').split('.');
    final int versionCode = int.parse(split[0]) * 10000 +
        int.parse(split[1]) * 100 +
        int.parse(split[2]);
    return versionCode;
  }

  static String getHeaderVersionCode(String version) {
    return version.replaceAll('-dev', '');
  }

  /*static String pardakhtsaziBaseUrl() {
    return Constants.pardakhtsaziBaseUrl;
  }*/

  static bool isProduction() {
    if (Platform.isIOS && !kIsWeb) {
      return true;
    } else {
      return ApplicationInfoUtil().applicationId == 'com.gardeshpay.app';
    }
  }

  static String? getCardNumberFromClipboard(String textMessage) {
    textMessage = textMessage
        .replaceAll('-', '')
        .replaceAll('_', '')
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll('۱', '1')
        .replaceAll('۲', '2')
        .replaceAll('۳', '3')
        .replaceAll('۴', '4')
        .replaceAll('۵', '5')
        .replaceAll('۶', '6')
        .replaceAll('۷', '7')
        .replaceAll('۸', '8')
        .replaceAll('۹', '9')
        .replaceAll('۰', '0');
    final RegExp exp = RegExp(r'\d{16}');
    final Iterable<Match> matches = exp.allMatches(textMessage);
    if (matches.isEmpty) {
      return null;
    } else {
      String? cardNumber;
      for (final matchedText in matches) {
        cardNumber = matchedText.group(0);
      }
      if (cardNumber != null &&
          cardNumber.length == Constants.cardNumberLength) {
        return cardNumber;
      } else {
        return null;
      }
    }
  }

  static bool checkSizeOfFile(File file) {
    if (file.lengthSync() >= 1048576) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkSizeOfFileWithInputSize(File file, int size) {
    AppUtil.printResponse(file.lengthSync().toString());
    if (file.lengthSync() > size) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> getFileCompressQuality(
      {required File file, required double maxFileSize}) async {
    final int fileSize = await file.length();
    if (fileSize > maxFileSize) {
      return (maxFileSize * 100 / fileSize).floor().toInt();
    } else {
      return 100;
    }
  }

  static String base64Decoding(String token) {
    token = token.substring(0, token.length - 2);
    final List<String> tokenSplit = token.split('');
    String randomNumberString = '';
    for (int i = 1; i < tokenSplit.length; i++) {
      if (_isNumeric(tokenSplit[i])) {
        randomNumberString += tokenSplit[i];
      } else {
        break;
      }
    }
    final int randomNumber = int.parse(randomNumberString);
    token = token.substring(randomNumberString.length + 2);
    final String firstPart = token.substring(token.length - randomNumber);
    final String secondPart =
        token.substring(0, token.length - randomNumber - 20);
    String plainText = firstPart + secondPart;
    plainText = plainText.split('').reversed.join();
    final String decoded = utf8.decode(base64Decode(addEqual(plainText)));
    return decoded;
  }

  static String getRandomString(int length) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    final math.Random rnd = math.Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static bool _isNumeric(String str) {
    return int.tryParse(str) != null;
  }

  static String addEqual(String plainText) {
    if (plainText.length % 4 != 0) {
      plainText += '==='.substring(0, 4 - (plainText.length % 4));
    }
    return plainText;
  }

  static String getDecodedString(String encodedString) {
    final ResponseData responseData = responseDataFromJson(encodedString);
    return base64Decoding(responseData.data!);
  }

  static String encodeString(String plainText) {
    final RequestData requestData = RequestData();
    requestData.data = genEncodedPlainText(plainText);

    return jsonEncode(requestData.toJson());
  }

  static String genEncodedPlainText(String plainText) {
    final String b64Text = base64Encode(utf8.encode(plainText));
    final String reversedB64Text = b64Text.split('').reversed.join();
    final String timestamp = DateTime.now()
        .millisecondsSinceEpoch
        .toInt()
        .toString()
        .substring(0, 10);
    final String reversedTimestamp = timestamp.split('').reversed.join();
    final int randomNumber = Random().nextInt(reversedB64Text.length - 1) + 1;
    final String randomString = genRandomString();
    String mixTSandRS = '';
    for (int i = 0; i < randomString.length; i++) {
      mixTSandRS += reversedTimestamp[i] + randomString[i];
    }
    final String firstPart = reversedB64Text.substring(randomNumber);
    final String secondPart = reversedB64Text.substring(0, randomNumber);
    return '${genRandomChar()}$randomNumber${genRandomChar()}$firstPart$mixTSandRS$secondPart==';
  }

  static String genRandomString() {
    const alphaChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();
    return Iterable.generate(
        10, (_) => alphaChars[rnd.nextInt(alphaChars.length)]).join();
  }

  static String genRandomChar() {
    const alphaChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final Random rnd = Random();
    return alphaChars[rnd.nextInt(alphaChars.length)];
  }

  static String? secureText(String value, bool? isShow) {
    if (isShow!) {
      return value;
    } else {
      return value.replaceAll(RegExp('[^]'), '*');
    }
  }

  static String getBase64OfFile(File file) {
    final List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static Future<String> decryptRSAData(String data) async {
    if (data.length < 16) {
      return data;
    } else {
      final String? customerKeyPairString =
          await StorageUtil.getEncryptionKeyPair();
      final EncryptionKeyPair keyPair =
          EncryptionKeyPair.fromJson(jsonDecode(customerKeyPairString!));
      final String decryptedData = _decryptWithRSA(
          privateKeyPem: keyPair.privateKey, encryptedMessage: data);
      return decryptedData;
    }
  }

  static String _decryptWithRSA(
      {required String privateKeyPem, required String encryptedMessage}) {
    final dynamic privateKey = encrypt.RSAKeyParser().parse(privateKeyPem);
    final encrypter = encrypt.Encrypter(encrypt.RSA(privateKey: privateKey));
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedMessage));
    return decrypted;
  }

  static Future<EncryptionKeyPair> generateRSAKeyPair() async {
    final AsymmetricKeyPair keyPair = CryptoUtils.generateRSAKeyPair();
    final String publicKeyString =
        CryptoUtils.encodeRSAPublicKeyToPem(keyPair.publicKey as RSAPublicKey);
    final String privateKeyString = CryptoUtils.encodeRSAPrivateKeyToPem(
        keyPair.privateKey as RSAPrivateKey);
    return EncryptionKeyPair(
        publicKey: publicKeyString, privateKey: privateKeyString);
  }

  /// todo: add later to pwa (util plugin)
  static Future<EncryptionKeyPair> generateRSAKeyPairWeb() async {
    final keyPair = await RSA.generate(2048);
    final rsaPublicKey =
        CryptoUtils.rsaPublicKeyFromPemPkcs1(keyPair.publicKey);
    final rsaPrivateKey =
        CryptoUtils.rsaPrivateKeyFromPemPkcs1(keyPair.privateKey);
    final String publicKeyString =
        CryptoUtils.encodeRSAPublicKeyToPem(rsaPublicKey);
    final String privateKeyString =
        CryptoUtils.encodeRSAPrivateKeyToPem(rsaPrivateKey);
    return EncryptionKeyPair(
        publicKey: publicKeyString, privateKey: privateKeyString);
  }

  static Future<bool> isTrust() async {
    String platform = detectPlatform();
    print("💥 $platform");

    if (kIsWeb) {
      /*if (Platform.isAndroid || Platform.isIOS) {
        return true;
      } else {
        return false;
      }*/
      return true;
    } else if (Platform.isIOS) {
      final bool isJailBroken = await SafeDevice.isJailBroken;
      return !isJailBroken;
    } else {
      final String? signature = await UtilPlugin.getSignature();
      try {
        if (foundation.kReleaseMode) {
          final bool isThereHarmfulApp = await isHarmfulAppInstalled();
          if (isThereHarmfulApp) {
            return false;
          }
          final bool isJailBroken = await SafeDevice.isJailBroken;
          final bool isRealDevice = await SafeDevice.isRealDevice;
          final bool isHashCorrect =
              Constants.signatureHash.contains(signature.toString().trim());
          return isRealDevice && !isJailBroken && isHashCorrect;
        } else {
          return true;
        }
      } on Exception catch (e) {
        AppUtil.printResponse(e.toString());
        return false;
      }
    }
  }

  static Future<bool> isHarmfulAppInstalled() async {
    if (foundation.kReleaseMode) {
      final bool one =
          await DeviceApps.isAppInstalled('stericson.busybox'); //Busybox
      final bool two =
          await DeviceApps.isAppInstalled('stericson.busybox.donate'); //Busybox
      final bool three =
          await DeviceApps.isAppInstalled('com.jozein.xedge'); //Xposed
      final bool four =
          await DeviceApps.isAppInstalled('com.jozein.xedgepro'); //Xposed pro
      final bool five = await DeviceApps.isAppInstalled(
          'de.robv.android.xposed.XposedBridge');

      return one || two || three || four || five;
    } else {
      return false;
    }
  }

  static BankData? getBankData(String? bankCode) {
    final List<BankData> bankDataList = DataConstants.getBankDataList()
        .where((element) => element.id == bankCode)
        .toList();
    if (bankDataList.length == 1) {
      return bankDataList[0];
    } else {
      return null;
    }
  }

  static GuaranteeStatusData? getGuaranteeStatusData(String guaranteeStatusId) {
    final List<GuaranteeStatusData> guaranteeStatusDataList =
        DataConstants.getGuaranteeStatusDataList()
            .where((element) => element.id == guaranteeStatusId)
            .toList();
    if (guaranteeStatusDataList.length == 1) {
      return guaranteeStatusDataList[0];
    } else {
      return null;
    }
  }

  static TransferActionData? getTransferActionData(int? transferActionId) {
    final List<TransferActionData> transferActionData =
        DataConstants.getTransferActionList()
            .where((element) => element.id == transferActionId)
            .toList();
    if (transferActionData.length == 1) {
      return transferActionData[0];
    } else {
      return null;
    }
  }

  static Future<bool> isNetworkConnect() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.isNotEmpty) {
      return connectivityResult[0] == ConnectivityResult.mobile ||
          connectivityResult[0] == ConnectivityResult.wifi;
    } else {
      return false;
    }
  }

  static Future<bool> isVpnConnected() async {
    if (Platform.isIOS) {
      return false;
    } else {
      return await VpnConnectionDetector.isVpnActive();
    }
  }

  static String encryptDataWithAES({
    required String data,
  }) {
    final key = encrypt.Key.fromUtf8(utf8.decode(Constants.aesKey.codeUnits));
    final iv = encrypt.IV.fromUtf8(utf8.decode(Constants.aesIV.codeUnits));
    final encrypter = encrypt.Encrypter(encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc,
      padding: null,
    ));
    final int dataLength = utf8.encode(data).length;
    final int remain = dataLength % 16;
    final int count = 16 - remain;
    for (int i = 0; i < count; i++) {
      data += '\u0000';
    }
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  static String decryptWithAES(String data) {
    final key = encrypt.Key.fromUtf8(utf8.decode((Constants.aesKey.codeUnits)));
    final iv = encrypt.IV.fromUtf8(utf8.decode(Constants.aesIV.codeUnits));
    final encrypted = encrypt.Encrypted.fromBase64(data);
    final encrypter = encrypt.Encrypter(encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc,
      padding: null,
    ));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted.replaceAll('\u0000', '');
  }

  static void setStatusBarColor(bool isDarkMode) {
    final systemUiOverlayStyle =
        isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    systemUiOverlayStyle.copyWith(
        statusBarColor: Get.context!.theme.colorScheme.surface);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static bool checkValidField(String text, RegExp regex) {
    if (text.isNotEmpty) {
      return regex.hasMatch(text);
    }
    return false;
  }

  static Future<void> saveShaparakHubPublicKey(String? publicKey) async {
    final String? shaparakHubString =
        await StorageUtil.getShaparakHubSecureStorage();
    ShaparakPublicKeyModel? shaparakPublicKeyModel;
    if (shaparakHubString != null) {
      shaparakPublicKeyModel =
          ShaparakPublicKeyModel.fromJson(jsonDecode(shaparakHubString));
    }
    if (shaparakPublicKeyModel != null) {
      shaparakPublicKeyModel.publicKey = publicKey;
    } else {
      shaparakPublicKeyModel = ShaparakPublicKeyModel();
      shaparakPublicKeyModel.publicKey = publicKey;
    }
    await StorageUtil.setShaparakHubSecureStorage(
        jsonEncode(shaparakPublicKeyModel.toJson()));
  }

  static String convertCharsPersian(String title) {
    return title.replaceAll('ي', 'ی').replaceAll('ك', 'ک');
  }

  static Color colorHexConvert(String? color) {
    if (color == null) {
      return Colors.transparent;
    }
    color = color.replaceAll('#', '');
    if (color.length == 6) {
      return Color(int.parse('0xFF$color'));
    } else if (color.length == 8) {
      return Color(int.parse('0x$color'));
    } else {
      return Colors.transparent;
    }
  }

  static Future<void> launchInBrowser({required String url}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void gotoPageController({
    required PageController pageController,
    required int page,
    required bool isClosed,
  }) {
    if (!isClosed) {
      pageController.jumpToPage(page);
    }
  }

  static Future<void> nextPageController(
    PageController pageController,
    bool isClosed,
  ) async {
    if (!isClosed) {
      await pageController.nextPage(
          duration: Constants.duration500, curve: Curves.easeInSine);
    }
  }

  static void previousPageController(
      PageController pageController, bool isClosed) {
    if (!isClosed) {
      pageController.previousPage(
          duration: Constants.duration500, curve: Curves.easeInSine);
    }
  }

  static void changePageController({
    required PageController pageController,
    required int page,
    required bool isClosed,
  }) {
    if (!isClosed) {
      pageController.animateToPage(page,
          duration: Constants.duration500, curve: Curves.easeInSine);
    }
  }

  static String getContents(String content) {
    return content.replaceAll('	', ' ');
  }

  static String getOTPFromMessage(String message) {
    final int index = message.indexOf('رمز');
    if (index.isNegative) {
      return RegExp(r'\d+').stringMatch(message) ?? '';
    } else {
      final List<String> list = message.substring(index + 3).split('\n');
      list.removeWhere((e) => !e.contains(RegExp(r'\d+')));
      return list.first.numericOnly(firstWordOnly: true);
    }
  }

  static String? detectOTPFromMessage(String message) {
    String? code;
    final split = message.split('\n');
    for (final String line in split) {
      if (line.contains(RegExp(r'[0-9]'))) {
        if (line.contains('رمز') ||
            line.contains('کد') ||
            line.trim().isNumericOnly) {
          if (line.contains(RegExp(r'\d{5,12}'))) {
            code = RegExp(r'\d{5,12}').stringMatch(line);
          }
        }
      }
    }
    return code;
  }

  static dynamic convertBase64ToImage(String base64String) {
    final decodedImage = base64Decode(base64String);
    return decodedImage;
  }

  static int getCrossAxisCount(BuildContext context) {
    if (context.isSmallTablet) {
      return 3;
    } else if (context.isLargeTablet) {
      return 4;
    } else {
      return 2;
    }
  }

  static void toggleThemeSwitcher(String themeCode) {
    StorageUtil.setThemeCode(themeCode: themeCode);
    if (themeCode == 'light') {
      Get.changeThemeMode(ThemeMode.light);
    } else if (themeCode == 'dark') {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
    final DashboardController dashboardController = Get.find();
    dashboardController.update();
  }

  static dynamic customAppBar(
      {required String title, required BuildContext context}) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.to(() => const SupportScreen());
          },
          child: Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon(
                SvgIcons.support,
                colorFilter: ColorFilter.mode(
                    context.theme.iconTheme.color!, BlendMode.srcIn),
                size: 24.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void showOverlaySnackbar({
    required String message,
    required Function callback,
    required String buttonText,
  }) {
    showOverlayNotification((context) {
      mainController.overlayContext = context;
      return MessageNotification(
        message: message,
        buttonText: buttonText,
        onReply: () {
          callback();
          OverlaySupportEntry.of(context)!.dismiss();
        },
      );
    },
        duration: const Duration(days: 365),
        position: NotificationPosition.bottom);
  }

  static void showSoonSnackbar() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    SnackBarUtil.showSnackBar(
        title: locale.announcement, message: locale.coming_soon_);
  }

  //>>>>>>>>

  static List<int> getAmountList(int amount) {
    final int slice = amount ~/ 4;
    final List<int> amountList = [];
    amountList.add(slice * 1);
    amountList.add(slice * 2);
    amountList.add(slice * 3);
    amountList.add(slice * 4);
    return amountList;
  }

  static String encryptDataWithRSA({
    required String data,
    required String rsaPublicKey,
  }) {
    final dynamic publicKey = encrypt.RSAKeyParser().parse(rsaPublicKey);
    final encryptor = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));
    final encrypted = encryptor.encrypt(data);
    return encrypted.base64;
  }

  static List<DocumentStateData> splitTaskData(
      List<TaskDataFormField> taskData) {
    final List<DocumentStateData> documentStateDataList = [];
    TaskDataFormField? id;
    TaskDataFormField? status;
    TaskDataFormField? description;
    for (final item in taskData) {
      if (item.id!.endsWith('DocumentId')) {
        id = item;
      } else if (item.id!.endsWith('DocumentStatus')) {
        status = item;
      } else if (item.id!.endsWith('DocumentDescription')) {
        description = item;
      } else {
        continue;
      }
      if (id != null &&
          status != null &&
          description != null &&
          id.value!.subValue != null) {
        final DocumentStateData documentStateData = DocumentStateData(
          id: id,
          status: status,
          description: description,
        );
        documentStateDataList.add(documentStateData);
        id = null;
        status = null;
        description = null;
      }
    }
    return documentStateDataList;
  }

  static Future<bool> isCertificatesEqual({required String certificate}) async {
    final String certPem =
        '${X509Utils.BEGIN_CERT}\n$certificate\n${X509Utils.END_CERT}';
    String? securePluginResponse;
    if (kIsWeb) {
      securePluginResponse = await SecureWebPlugin.getPublicKey();
    } else {
      final SecureResponseData temp = await SecurePlugin.getPublicKey(
          phoneNumber: mainController.keyAliasModelList.first.keyAlias);
      securePluginResponse = temp.data!;
    }
    if (securePluginResponse == null) {
      ///error on generate public key
      return false;
    }
    String publicKeyPem =
        '${CryptoUtils.BEGIN_PUBLIC_KEY}\n${securePluginResponse}\n${CryptoUtils.END_PUBLIC_KEY}';
    final cert = X509Utils.x509CertificateFromPem(certPem);

    final bytes =
        _stringAsBytes(cert.tbsCertificate!.subjectPublicKeyInfo.bytes!);
    final key = CryptoUtils.rsaPublicKeyFromDERBytes(Uint8List.fromList(bytes));
    String certPublicPem = CryptoUtils.encodeRSAPublicKeyToPem(key);

    publicKeyPem = publicKeyPem
        .replaceAll(CryptoUtils.BEGIN_PUBLIC_KEY, '')
        .replaceAll(CryptoUtils.END_PUBLIC_KEY, '')
        .replaceAll('\n', '')
        .replaceAll('\r', '')
        .trim();

    certPublicPem = certPublicPem
        .replaceAll(CryptoUtils.BEGIN_PUBLIC_KEY, '')
        .replaceAll(CryptoUtils.END_PUBLIC_KEY, '')
        .replaceAll('\n', '')
        .replaceAll('\r', '')
        .trim();
    final bool isCertificateEqualWithLocal = publicKeyPem == certPublicPem;
    return isCertificateEqualWithLocal;
  }

  static Uint8List _stringAsBytes(String s) {
    final list = StringUtils.chunk(s, 2);
    final bytes = <int>[];
    for (final e in list) {
      bytes.add(int.parse(e, radix: 16));
    }
    return Uint8List.fromList(bytes);
  }

  static Future<SecureResponseData> signPdf(
      {required SignDocumentData signDocumentData}) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String? signatureBase64 =
        await StorageUtil.getBase64UserSignatureImage();

    String documentBase64 = signDocumentData.documentBase64;

    // Sign Document (Add user signature image to pdf)
    final signLocations = signDocumentData.signLocations
        .where((element) => !element.digitalSignatureRequired)
        .toList();
    for (final signLocation in signLocations) {
      documentBase64 = await _signPdf(
        documentBase64: documentBase64,
        signLocation: signLocation,
        signatureBase64: signatureBase64,
      );
    }

    // Digital sign pdf
    final digitalSignLocation = signDocumentData.signLocations
        .firstWhereOrNull((element) => element.digitalSignatureRequired);
    if (digitalSignLocation != null) {
      if (mainController.appEKycProvider == EKycProvider.yekta) {
        return await _digitalSignYektaPdf(
          documentBase64: documentBase64,
          signLocation: digitalSignLocation,
          signatureBase64: signatureBase64!,
          reason: signDocumentData.reason,
        );
      } else {
        return await _digitalSignZoomIdPdf(
          documentBase64: documentBase64,
          signLocation: digitalSignLocation,
        );
      }
    } else {
      return SecureResponseData(
        statusCode: 200,
        data: documentBase64,
        message: locale.signature_applied_successfully,
        isSuccess: true,
      );
    }
  }

  static Future<String> _signPdf({
    required String documentBase64,
    required SignLocation signLocation,
    required String? signatureBase64,
  }) async {
    final Uint8List bytes = base64.decode(documentBase64);
    final PdfDocument document = PdfDocument(inputBytes: bytes.toList());

    final PdfPage page = document.pages[signLocation.signPageIndex];

    final SignRect signRect =
        Platform.isAndroid ? signLocation.android : signLocation.ios;
    final signatureRect =
        Rect.fromLTWH(signRect.x, signRect.y, signRect.width, signRect.height);

    Rect customerNameRect = signatureRect;

    final PdfGraphics graphics = page.graphics;
    final font = await rootBundle.load('fonts/IRANYekanMobileRegular.ttf');
    PdfTextAlignment nameTextAlignment = PdfTextAlignment.center;

    if (signatureBase64 != null) {
      const spaceWidth = 10;
      customerNameRect = Rect.fromLTWH(
        signatureRect.left,
        signatureRect.top,
        signatureRect.width / 2 - spaceWidth / 2,
        signatureRect.height,
      );
      final customerSignatureBase64Rect = Rect.fromLTWH(
        signatureRect.left + customerNameRect.width + spaceWidth,
        signatureRect.top,
        signatureRect.width - customerNameRect.width - spaceWidth,
        signatureRect.height,
      );

      final base64List = base64Decode(signatureBase64).toList();

      graphics.drawImage(
        PdfBitmap(base64List),
        customerSignatureBase64Rect,
      );

      nameTextAlignment = PdfTextAlignment.right;
    }

    graphics.drawString(
      '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}\n${Jalali.now().formatCompactDate()}',
      PdfTrueTypeFont(
        font.buffer.asUint8List(),
        10,
        style: PdfFontStyle.bold,
      ),
      brush: PdfSolidBrush(PdfColor(0, 0, 0, 100)),
      bounds: customerNameRect,
      format: PdfStringFormat(
          textDirection: PdfTextDirection.rightToLeft,
          alignment: nameTextAlignment,
          lineAlignment: PdfVerticalAlignment.middle,
          lineSpacing: 10),
    );

    final signedDocument = await document.save();
    final base64SignedPdf = base64Encode(signedDocument);
    document.dispose();

    return base64SignedPdf;
  }

  static Future<SecureResponseData> _digitalSignYektaPdf({
    required String documentBase64,
    required SignLocation signLocation,
    required String signatureBase64,
    required String reason,
  }) async {
    print("⭕ _digitalSignYektaPdf");
    final String? certificate =
        await StorageUtil.getAuthenticateCertificateModel();

    if (kIsWeb) {
      /*final String? hold = await SecureWebPlugin.signDataWithKeyWeb(
        textPlain: documentBase64,
        key: mainController.keyAliasModelList.first.keyAlias,
      );

      final SecureResponseData res = SecureResponseData(
        statusCode: 200,
        isSuccess: true,
        data: hold,
        message: "",
      );
      print("⭕ res");
      print(res.toString());
      return res;*/

      return _digitalSignYektaPdfWeb(
          documentBase64: documentBase64,
          reason: reason,
          signRect: signLocation.android,
          signPageIndex: signLocation.signPageIndex,
          certificate: certificate,
          signatureBase64: signatureBase64);
    } else if (Platform.isAndroid) {
      return await _digitalSignYektaPdfAndroid(
          documentBase64: documentBase64,
          reason: reason,
          signRect: signLocation.android,
          signPageIndex: signLocation.signPageIndex,
          certificate: certificate,
          signatureBase64: signatureBase64);
    } else {
      return await _digitalSignYektaPdfIOS(
        documentBase64: documentBase64,
        reason: reason,
        signRect: signLocation.ios,
        signPageIndex: signLocation.signPageIndex,
        certificate: certificate,
        signatureBase64: signatureBase64,
      );
    }
  }

  static Future<SecureResponseData> _digitalSignYektaPdfWeb({
    required String documentBase64,
    required String reason,
    required SignRect signRect,
    required int signPageIndex,
    required String? certificate,
    required String? signatureBase64,
  }) async {
    final String? userEnName =
        await StorageUtil.getAuthenticateUserEnglishName();

    // If you want to put name/reason/loc text, overlay via drawText in JS; see pdf-lib docs for that.

    print("⭕⭕⭕");
    print("x");
    print(signRect.x.toDouble());
    print("y");
    print(signRect.y.toDouble());
    print("w");
    print(signRect.width.toDouble());
    print("h");
    print(signRect.height.toDouble());

    final String resultPdfBase64 = await signPdfWithSignatureImg(
      pdfBase64: documentBase64,
      sigBase64: signatureBase64!,
      x: 430,
      y: 25,
      //width: signRect.width.toDouble(),
      width: 150,
      //height: signRect.height.toDouble(),
      height: 50,
      pageIndex: signPageIndex,
    );

    return SecureResponseData(
      statusCode: 200,
      isSuccess: true,
      message: 'Success (visual signature on web)',
      data: resultPdfBase64,
      // add more fields if you want
    );
  }

  static Future<SecureResponseData> _digitalSignZoomIdPdf({
    required String documentBase64,
    required SignLocation signLocation,
  }) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isAndroid) {
      return await _digitalSignZoomIdPdfAndroid(
          documentBase64: documentBase64,
          signRect: signLocation.android,
          signPageIndex: signLocation.signPageIndex);
    } else {
      return SecureResponseData(
          statusCode: 500,
          message: locale.authentication_signature_not_supported,
          isSuccess: false);
    }
  }

  static Future<SecureResponseData> _digitalSignZoomIdPdfAndroid({
    required String documentBase64,
    required SignRect signRect,
    required int signPageIndex,
  }) async {
    final SecureResponseData secureResponseData = SecureResponseData();

    final String tempPath = FileUtil().tempDir.path;
    final File inputFile = File('$tempPath/source.pdf');
    final File outputFile = File('$tempPath/destination.pdf');
    final Uint8List bytes = base64.decode(documentBase64);
    inputFile.writeAsBytesSync(bytes);
    final bool result = await ZoomId.signPdfWithSignature(
      nationalId: mainController.authInfoData!.nationalCode!,
      license: mainController.authInfoData!.zoomIdLicenseAndroid ??
          Constants.zoomIdLicense,
      phone: mainController.authInfoData!.mobile!,
      inputPath: inputFile.path,
      outputPath: outputFile.path,
      x: signRect.x,
      y: signRect.y,
      width: signRect.width,
      height: signRect.height,
      page: signPageIndex,
    );
    if (result) {
      secureResponseData.isSuccess = true;
      secureResponseData.statusCode = 200;
      secureResponseData.data = base64Encode(outputFile.readAsBytesSync());
    } else {
      secureResponseData.isSuccess = false;
      secureResponseData.statusCode = 500;
    }
    await inputFile.delete();
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }

    return secureResponseData;
  }

  static Future<SecureResponseData> _digitalSignYektaPdfAndroid({
    required String documentBase64,
    required String reason,
    required SignRect signRect,
    required int signPageIndex,
    required String? certificate,
    required String? signatureBase64,
  }) async {
    final String? userEnName =
        await StorageUtil.getAuthenticateUserEnglishName();
    return await SecurePlugin.newSignPdf(
      phoneNumber: mainController.keyAliasModelList.first.keyAlias,
      pdfBase64: documentBase64,
      cert: certificate!,
      name: 'User-Digital-Signature',
      reason: reason,
      location: 'IR',
      signatureBase64: signatureBase64!,
      signatureX: signRect.x.toInt(),
      signatureY: signRect.y.toInt(),
      signatureWidth: signRect.width.toInt(),
      signatureHeight: signRect.height.toInt(),
      signaturePage: signPageIndex,
      signatureNameFamily: userEnName ?? '',
    );
  }

  static Future<SecureResponseData> _digitalSignYektaPdfIOS({
    required String documentBase64,
    required String reason,
    required SignRect signRect,
    required int signPageIndex,
    required String? certificate,
    required String? signatureBase64,
  }) async {
    final Uint8List bytes = base64.decode(documentBase64);
    final PdfDocument document = PdfDocument(inputBytes: bytes.toList());

    final PdfPage page = document.pages[signPageIndex];

    final SecureResponseData privateKeyResponse =
        await SecurePlugin.getPrivateKey(
            phoneNumber: mainController.keyAliasModelList.first.keyAlias);

    if (!(privateKeyResponse.isSuccess ?? false)) {
      return privateKeyResponse;
    }

    final privateKey =
        '-----BEGIN RSA PRIVATE KEY-----\n${privateKeyResponse.data!}\n-----END RSA PRIVATE KEY-----';

    final rsaPrivateKey = CryptoUtils.rsaPrivateKeyFromPemPkcs1(privateKey);
    final externalSigner = ExternalSigner(rsaPrivateKey: rsaPrivateKey);
    final PdfSignature pdfSignature = PdfSignature(
        signedName: 'User-Digital-Signature',
        locationInfo: 'IR',
        reason: reason);
    pdfSignature.addExternalSigner(
        externalSigner, [base64Decode(certificate!).toList()]);

    final signatureRect =
        Rect.fromLTWH(signRect.x, signRect.y, signRect.width, signRect.height);

    const spaceWidth = 10;

    var customerNameRect = Rect.fromLTWH(
        0, 0, signatureRect.width / 2 - spaceWidth / 2, signatureRect.height);
    var customerSignatureBase64Rect = Rect.fromLTWH(
        customerNameRect.width + spaceWidth,
        0,
        signatureRect.width - customerNameRect.width - spaceWidth,
        signatureRect.height);

    if (page.rotation == PdfPageRotateAngle.rotateAngle90) {
      final width = signatureRect.height / 2 - spaceWidth / 2;
      customerSignatureBase64Rect =
          Rect.fromLTWH(-1.0 * width, 0, width, signatureRect.width);

      customerNameRect = Rect.fromLTWH(
          -2.0 * width + -1.0 * spaceWidth, 0, width, signatureRect.width);
    }

    final PdfSignatureField signatureField = PdfSignatureField(
      page,
      'User-Digital-Signature',
      bounds: signatureRect,
      signature: pdfSignature,
    );

    // add image to PdfSignature
    final PdfGraphics graphics = signatureField.appearance.normal.graphics!;
    final imageBase64File = await StorageUtil.getBase64UserSignatureImage();
    final base64List = base64Decode(imageBase64File!).toList();
    final font = await rootBundle.load('fonts/IRANYekanMobileRegular.ttf');

    if (page.rotation == PdfPageRotateAngle.rotateAngle90) {
      graphics.rotateTransform(-90);
    }

    graphics.drawString(
      '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}\n${Jalali.now().formatCompactDate()}',
      PdfTrueTypeFont(
        font.buffer.asUint8List(),
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfSolidBrush(PdfColor(0, 0, 0, 100)),
      bounds: customerNameRect,
      format: PdfStringFormat(
          textDirection: PdfTextDirection.rightToLeft,
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle,
          lineSpacing: 10),
    );

    graphics.drawImage(
      PdfBitmap(base64List),
      customerSignatureBase64Rect,
    );

    document.form.fields.add(signatureField);
    final signedDocument = await document.save();
    final base64SignedPdf = base64Encode(signedDocument);
    document.dispose();

    return SecureResponseData(
        isSuccess: true, message: '', statusCode: 200, data: base64SignedPdf);
  }

  //>>>>>>>>>

  static List<MenuData> getDepositServices({required bool hasCard}) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<MenuData> menuItemList = [];
    final MenuData menuItemData1 = MenuData(
      id: 1,
      title: locale.card_issue,
      icon: SvgIcons.requestCard,
      iconDark: SvgIcons.requestCardDark,
    );
    final MenuData menuItemData2 = MenuData(
      id: 2,
      title: locale.close_deposit,
      icon: SvgIcons.closeDeposit,
      iconDark: SvgIcons.closeDepositDark,
    );
    final MenuData menuItemData3 = MenuData(
      id: 3,
      title: locale.deposit_detail,
      icon: SvgIcons.depositDetail,
      iconDark: SvgIcons.depositDetailDark,
    );
    if (!hasCard) {
      menuItemList.add(menuItemData1);
    }
    menuItemList.add(menuItemData2);
    menuItemList.add(menuItemData3);
    return menuItemList;
  }

  static List<MenuData> getInternetBankServices() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<MenuData> menuItemList = [];
    final MenuData menuItemData1 = MenuData(
      id: 1,
      title: locale.issue_internet_bank_password,
      icon: SvgIcons.bankLock,
      iconDark: SvgIcons.bankLockDark,
    );
    final MenuData menuItemData2 = MenuData(
      id: 2,
      title: locale.recover_internet_bank_password,
      icon: SvgIcons.lockRetrieval,
      iconDark: SvgIcons.lockRetrievalDark,
    );
    menuItemList.add(menuItemData1);
    menuItemList.add(menuItemData2);
    return menuItemList;
  }

  static List<MenuData> getMobileBankServices() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<MenuData> menuItemList = [];
    final MenuData menuItemData1 = MenuData(
      id: 1,
      title: locale.issue_password_mobile_bank,
      icon: SvgIcons.bankLock,
      iconDark: SvgIcons.bankLockDark,
    );
    final MenuData menuItemData2 = MenuData(
      id: 2,
      title: locale.reset_password_mobile_bank,
      icon: SvgIcons.lockRetrieval,
      iconDark: SvgIcons.lockRetrievalDark,
    );
    menuItemList.add(menuItemData1);
    menuItemList.add(menuItemData2);
    return menuItemList;
  }

  static List<TransferMethodData> getTransferMethodDataList(
      List<int> supportedTransferTypes) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<TransferMethodData> transferMethodDataList = [];
    final TransferMethodData transferBank = TransferMethodData(
      id: 0,
      title: locale.intrabank_transfer,
      description: locale.intrabank_transfer_description,
      icon: SvgIcons.bankTransfer,
      iconDark: SvgIcons.bankTransferDark,
    );

    final TransferMethodData paya = TransferMethodData(
      id: 1,
      title: locale.paya_transfer,
      description: locale.paya_transfer_description,
      icon: SvgIcons.paya,
      iconDark: SvgIcons.payaDark,
    );

    final TransferMethodData satna = TransferMethodData(
      id: 2,
      title: locale.satna_transfer,
      description: locale.satna_transfer_description,
      icon: SvgIcons.satna,
      iconDark: SvgIcons.satnaDark,
    );

    final TransferMethodData pol = TransferMethodData(
      id: 4,
      title: locale.pol_tranfer,
      description: locale.pol_tranfer_message,
      icon: SvgIcons.bankTransfer,
      iconDark: SvgIcons.bankTransferDark,
    );

    for (final item in supportedTransferTypes) {
      if (item == 0) {
        transferMethodDataList.add(transferBank);
      } else if (item == 1) {
        transferMethodDataList.add(paya);
      } else if (item == 2) {
        transferMethodDataList.add(satna);
      } else if (item == 4) {
        transferMethodDataList.add(pol);
      }
    }
    return transferMethodDataList;
  }

  static List<TransferMethodData> transferMethodDataList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<TransferMethodData> transferMethodDataList = [];
    final TransferMethodData transferBank = TransferMethodData(
      id: 0,
      title: locale.intrabank_transfer,
      description: locale.intrabank_transfer_description,
      icon: SvgIcons.bankTransfer,
      iconDark: SvgIcons.bankTransferDark,
    );

    final TransferMethodData paya = TransferMethodData(
      id: 1,
      title: locale.paya_transfer,
      description: locale.paya_transfer_description,
      icon: SvgIcons.paya,
      iconDark: SvgIcons.payaDark,
    );

    final TransferMethodData satna = TransferMethodData(
      id: 2,
      title: locale.satna_transfer,
      description: locale.satna_transfer_description,
      icon: SvgIcons.satna,
      iconDark: SvgIcons.satnaDark,
    );
    final TransferMethodData pol = TransferMethodData(
      id: 4,
      title: locale.pol_tranfer,
      description: locale.pol_tranfer_message,
      icon: SvgIcons.bankTransfer,
      iconDark: SvgIcons.bankTransferDark,
    );
    transferMethodDataList.add(transferBank);
    transferMethodDataList.add(paya);
    transferMethodDataList.add(satna);
    transferMethodDataList.add(pol);
    return transferMethodDataList;
  }

  static List<PurposeData> getPurposeList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<PurposeData> purposeDataList = [];
    purposeDataList.add(
      PurposeData(
        id: 0,
        title: locale.salary_deposit,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 1,
        title: locale.insurance_services,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 2,
        title: locale.medical_expenses,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 3,
        title: locale.investment_and_stock,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 4,
        title: locale.foreign_exchange,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 5,
        title: locale.debt_repayment,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 6,
        title: locale.retirement,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 7,
        title: locale.movable_property_transactions,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 8,
        title: locale.immovable_property_transactions,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 9,
        title: locale.liquidity_management,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 10,
        title: locale.customs_duties,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 11,
        title: locale.tax_settlement,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 12,
        title: locale.government_services,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 13,
        title: locale.facilities_and_commitments,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 14,
        title: locale.depositing_collateral,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 15,
        title: locale.general_expenses,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 16,
        title: locale.charitable_donations,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 17,
        title: locale.goods_purchase,
      ),
    );
    purposeDataList.add(
      PurposeData(
        id: 18,
        title: locale.services_purchase,
      ),
    );
    return purposeDataList;
  }

  static List<CardBlockReasonData> getCardBlockReasonList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<CardBlockReasonData> cardBlockReasonList = [];
    // cardBlockReasonList.add(const CardBlockReasonData(title: 'عمومی', id: 0));
    cardBlockReasonList
        .add(CardBlockReasonData(title: locale.lost_card, id: 4));
    cardBlockReasonList
        .add(CardBlockReasonData(title: locale.stolen_card, id: 5));
    // cardBlockReasonList.add(const CardBlockReasonData(title: 'غیرفعال‌سازی موقت کارت', id: 7));
    return cardBlockReasonList;
  }

  static List<BPMSOwnershipData> getOwnershipList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<BPMSOwnershipData> ownershipData = [];
    ownershipData
        .add(BPMSOwnershipData(title: locale.owner, id: 0, key: 'OWNER'));
    ownershipData
        .add(BPMSOwnershipData(title: locale.rental, id: 1, key: 'RENTAL'));
    ownershipData
        .add(BPMSOwnershipData(title: locale.others_, id: 2, key: 'OTHERS'));
    return ownershipData;
  }

  static List<BPMSOwnershipData> getMarriageLoanProcedureOwnershipList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<BPMSOwnershipData> ownershipData = [];
    ownershipData
        .add(BPMSOwnershipData(title: locale.owner, id: 0, key: 'OWNER'));
    ownershipData
        .add(BPMSOwnershipData(title: locale.rental, id: 1, key: 'RENTAL'));
    ownershipData
        .add(BPMSOwnershipData(title: locale.others_, id: 2, key: 'OTHERS'));
    return ownershipData;
  }

  static List<BPMSOwnershipData> getChildrenLoanProcedureOwnershipList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<BPMSOwnershipData> ownershipData = [];
    ownershipData
        .add(BPMSOwnershipData(title: locale.owner, id: 0, key: 'OWNER'));
    ownershipData
        .add(BPMSOwnershipData(title: locale.rental, id: 1, key: 'RENTAL'));
    ownershipData
        .add(BPMSOwnershipData(title: locale.others_, id: 2, key: 'OTHERS'));
    return ownershipData;
  }

  static List<BPMSWarrantyData> getGuaranteeWarrantyList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<BPMSWarrantyData> guaranteeList = [];
    final BPMSWarrantyData warrantyData_4 = BPMSWarrantyData(
      title: locale.guarantor_cheque,
      id: 3,
      collateralType: 'cheque',
      guarantorType: 'Guarantor',
    );
    final BPMSWarrantyData warrantyData_5 = BPMSWarrantyData(
      title: locale.guarantor_salary_deduction,
      id: 4,
      collateralType: 'salaryDeductionCertificate',
      guarantorType: 'Guarantor',
    );
    guaranteeList.add(warrantyData_4);
    guaranteeList.add(warrantyData_5);
    return guaranteeList;
  }

  static List<BPMSWarrantyData> getApplicantWarrantyList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<BPMSWarrantyData> guaranteeList = [];
    final BPMSWarrantyData warrantyData_1 = BPMSWarrantyData(
      title: locale.applicant_cheque,
      id: 0,
      collateralType: 'cheque',
      guarantorType: 'Applicant',
    );
    final BPMSWarrantyData warrantyData_2 = BPMSWarrantyData(
      title: locale.applicant_promissory_note,
      id: 1,
      collateralType: 'promissoryNote',
      guarantorType: 'Applicant',
    );
    final BPMSWarrantyData warrantyData_3 = BPMSWarrantyData(
      title: locale.applicant_salary_deduction,
      id: 2,
      collateralType: 'salaryDeductionCertificate',
      guarantorType: 'Applicant',
    );
    guaranteeList.add(warrantyData_1);
    guaranteeList.add(warrantyData_2);
    guaranteeList.add(warrantyData_3);
    return guaranteeList;
  }

  static List<PromissoryFinalizedItemData> getPromissoryFinalizedServicesList(
      {required PromissoryRoleType promissoryRoleType,
      required PromissoryStateType? stateType,
      required bool isTransfable}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<PromissoryFinalizedItemData> promissoryFinalizedServiceList = [];

    promissoryFinalizedServiceList.add(PromissoryFinalizedItemData(
      eventId: 0,
      title: locale.detail,
      icon: SvgIcons.promissoryDetail,
      iconDark: SvgIcons.promissoryDetailDark,
    ));

    if (promissoryRoleType == PromissoryRoleType.currentOwner) {
      if (stateType == PromissoryStateType.published ||
          stateType == PromissoryStateType.partialSettled) {
        if (isTransfable) {
          promissoryFinalizedServiceList.add(PromissoryFinalizedItemData(
            eventId: 1,
            title: locale.endorsement,
            icon: SvgIcons.promissoryEndorsement,
            iconDark: SvgIcons.promissoryEndorsementDark,
          ));
        }
        promissoryFinalizedServiceList.add(PromissoryFinalizedItemData(
          eventId: 2,
          title: locale.full_settlement,
          icon: SvgIcons.promissorySettlement,
          iconDark: SvgIcons.promissorySettlementDark,
        ));
        promissoryFinalizedServiceList.add(PromissoryFinalizedItemData(
          eventId: 3,
          title: locale.gradual_settlement,
          icon: SvgIcons.promissorySettlementGradual,
          iconDark: SvgIcons.promissorySettlementGradualDark,
        ));
      }
    }

    return promissoryFinalizedServiceList;
  }

  static List<CloseDepositTypeItemData> getCloseTypeItems() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<CloseDepositTypeItemData> closeTypeItemDataList = [];
    closeTypeItemDataList.add(CloseDepositTypeItemData(
      title: locale.complete_closing,
      id: 1,
      value: 'COMPLETE_CLOSING',
    ));
    closeTypeItemDataList.add(CloseDepositTypeItemData(
      title: locale.partial_closing,
      id: 2,
      value: 'PARTIAL_CLOSING',
    ));
    return closeTypeItemDataList;
  }

  static List<MilitaryGuaranteeDepositTypeData>
      getMilitaryGuaranteeDepositTypeList() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<MilitaryGuaranteeDepositTypeData> depositTypeList = [];
    MilitaryGuaranteeDepositTypeData depositType1 =
        MilitaryGuaranteeDepositTypeData(
      title: locale.short_term_saving_title,
      description: locale.short_term_saving_description,
      id: 1,
    );
    MilitaryGuaranteeDepositTypeData depositType2 =
        MilitaryGuaranteeDepositTypeData(
      title: locale.long_term_saving_title,
      description: locale.long_term_saving_description,
      id: 2,
    );
    depositTypeList.add(depositType1);
    depositTypeList.add(depositType2);
    return depositTypeList;
  }

  static List<MenuData> getShareServices() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<MenuData> menuItemList = [];
    final MenuData menuItemData1 = MenuData(
      id: 1,
      title: locale.image,
      icon: SvgIcons.shareImage,
      iconDark: SvgIcons.shareImage,
    );
    final MenuData menuItemData2 = MenuData(
      id: 2,
      title: locale.text,
      icon: SvgIcons.shareText,
      iconDark: SvgIcons.shareText,
    );
    menuItemList.add(menuItemData1);
    menuItemList.add(menuItemData2);
    return menuItemList;
  }

  static String decodeBody(String body) {
    final jsonData = json.decode(body);
    String result = '';
    if (jsonData != null) {
      jsonData.forEach((key, value) {
        final bodyJsonData = json.decode(base64Decoding(value));
        if (bodyJsonData != null && bodyJsonData['data'] != null) {
          result = utf8.decode(base64.decode(bodyJsonData['data']));
        }
      });
    }
    return result;
  }

  static String twentyYearsBeforeNow() {
    final String startDateString = DateConverterUtil.getStartOfYearJalali(
        gregorianDate: intl.DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 20 * 365))));
    return startDateString;
  }

  static Future<void> checkCertificateExpire(
      {required CertificateCheckType certificateCheckType}) async {
    if (mainController.appEKycProvider == EKycProvider.yekta &&
        await mainController.isEnrollYekta() == true) {
      final String? certificate =
          await StorageUtil.getAuthenticateCertificateModel();
      if (certificate != null) {
        final String certPem =
            '${X509Utils.BEGIN_CERT}\n$certificate\n${X509Utils.END_CERT}';
        final cert = X509Utils.x509CertificateFromPem(certPem);
        final DateTime now = DateTime.now();
        final int remainingDays =
            cert.tbsCertificate!.validity.notAfter.difference(now).inDays;
        if (certificateCheckType == CertificateCheckType.login &&
            remainingDays <= Constants.expireDaysHazard) {
          showRenewCertificateBottomSheet(remainingDays);
          return;
        }
        if (certificateCheckType == CertificateCheckType.dashboard &&
            remainingDays <= Constants.expireDays) {
          showRenewCertificateBottomSheet(remainingDays);
          return;
        }
      }
    }
  }

  static void showRenewCertificateBottomSheet(int remainingDays) {
    Timer(const Duration(seconds: 1), () {
      showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor:
            Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: RenewCertificateBottomSheet(remainingDays: remainingDays),
        ),
      );
    });
  }

  static void handleBannerClick(BannerItem bannerItem) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (bannerItem.isDisable == true) {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: bannerItem.message!,
      );
    } else {
      if (bannerItem.type == Constants.externalUrl) {
        AppUtil.launchInBrowser(url: bannerItem.url!);
      } else if (bannerItem.type == Constants.internalUrl) {
        Get.to(
          () => InternalWebViewScreen(
              url: bannerItem.url!, screenTitle: bannerItem.screenTitle),
        );
      } else if (bannerItem.type == Constants.showScreen) {
        if (bannerItem.eventCode == DataConstants.cardToCardService) {
          Get.to(() => const CardToCardScreen());
        } else if (bannerItem.eventCode == DataConstants.cardBalanceService) {
          Get.to(() => const CardBalanceScreen());
        } else if (bannerItem.eventCode == DataConstants.simChargeService) {
          Get.to(() => const SimChargeScreen());
        } else if (bannerItem.eventCode == DataConstants.internetService) {
          Get.to(() => const InternetScreen());
        } else if (bannerItem.eventCode == DataConstants.giftCardService) {
          Get.to(() => const GiftCardMainScreen());
        } else if (bannerItem.eventCode == DataConstants.charityService) {
          Get.to(() => const CharityScreen());
        } else if (bannerItem.eventCode == DataConstants.invoiceService) {
          Get.to(() => const InvoiceScreen());
        } else if (bannerItem.eventCode ==
            DataConstants.paymentAcceptorService) {
          Get.to(() => const AcceptorScreen());
        } else if (bannerItem.eventCode == DataConstants.pichakService) {
          Get.to(() => const PichakScreen());
        } else if (bannerItem.eventCode == DataConstants.megagashtService) {
          Get.to(() => const MegaGashtScreen());
        } else if (bannerItem.eventCode == DataConstants.customerClubService) {
          Get.to(() => const CustomerClubScreen());
        } else if (bannerItem.eventCode == DataConstants.facilityServices) {
          Get.to(
            () => const FacilityScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => FacilityController());
            }),
          );
        } else if (bannerItem.eventCode == DataConstants.tobankServices) {
          Get.to(
            () => const TobankServicesScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => TobankServicesController());
            }),
          );
        } else {}
      }
    }
  }

  static void handleParsaTask(
      {required List<TaskList>? taskList, required String trackingNumber}) {
    if (taskList == null || taskList.isEmpty) {
      Get.back();
      return;
    }

    final task = taskList.first;

    switch (task.key) {
      case 'CustomerActiveAccountInquiry':
        Get.off(() => ParsaLoanAccessScreen(trackingNumber: trackingNumber));
        break;
      case 'CustomerLoanAccountNumber':
        Get.off(
            () => ParsaLoanSelectDepositScreen(trackingNumber: trackingNumber));
        break;
      case 'CustomerLoanInquiry':
        Get.off(() => ParsaLoanInquiryScreen(trackingNumber: trackingNumber));
        break;
      case 'LoanBranchInfo':
        Get.off(
            () => ParsaLoanBranchInfoScreen(trackingNumber: trackingNumber));
        break;
      case 'LoanRequestedInfo':
        Get.off(
            () => ParsaLoanSelectPlanScreen(trackingNumber: trackingNumber));
        break;
      case 'CustomerScore':
        Get.off(() =>
            ParsaLoanGetCustomerScoreScreen(trackingNumber: trackingNumber));
        break;
      case 'LoanRequestedAmount':
        Get.off(() => ParsaLoanAmountScreen(trackingNumber: trackingNumber));
        break;
      case 'CustomerCertificateDocument':
        Get.off(() =>
            ParsaLoanCustomerDocumentScreen(trackingNumber: trackingNumber));
        break;
      case 'CustomerAddressInfo':
        Get.off(() =>
            ParsaLoanCustomerAddressScreen(trackingNumber: trackingNumber));
        break;
      case 'CustomerJobType':
        Get.off(() =>
            ParsaLoanEmploymentTypeScreen(trackingNumber: trackingNumber));
        break;
      case 'PromissoryAssurance':
        Get.off(
            () => ParsaLoanPromissoryScreen(trackingNumber: trackingNumber));
        break;
      case 'signContract':
        Get.off(() => ParsaLoanContractScreen(trackingNumber: trackingNumber));
        break;
      default:
        break;
    }
  }

  static String detectPlatform() {
    if (kIsWeb) {
      print("💥 platform");
      // Web platform - use user agent to determine more details
      String userAgent = html.window.navigator.userAgent.toLowerCase();

      // Check for mobile devices first
      bool isMobile = userAgent.contains('mobile') ||
          userAgent.contains('android') ||
          userAgent.contains('iphone') ||
          userAgent.contains('ipad');

      if (isMobile) {
        if (userAgent.contains('android')) return 'web-android';
        if (userAgent.contains('iphone') ||
            userAgent.contains('ipad') ||
            userAgent.contains('ipod')) return 'web-ios';
        return 'web-mobile';
      }

      // Check for desktop platforms
      if (userAgent.contains('win')) return 'web-windows';
      if (userAgent.contains('mac')) return 'web-macos';
      if (userAgent.contains('linux') || userAgent.contains('x11'))
        return 'web-linux';

      return 'web-unknown';
    } else {
      // Native platform
      if (Platform.isAndroid) return 'android';
      if (Platform.isIOS) return 'ios';
      if (Platform.isMacOS) return 'macos';
      if (Platform.isWindows) return 'windows';
      if (Platform.isLinux) return 'linux';
      if (Platform.isFuchsia) return 'fuchsia';
      return 'unknown';
    }
  }

  static Future<bool?> isDeviceSecure() async {
    if (kIsWeb) {
      return true;
    } else if (Platform.isAndroid) {
      return await UtilPlugin.isSecure();
    } else {
      return await checkDeviceSecurity();
    }
  }

  ///change ENV hanlders
  static String baseUrlSSLFingerprint() {
    return getIt<AppConfigService>().config.sslFingerprint;
  }

  static String getShaparakHubBaseUrl() {
    return getIt<AppConfigService>().config.shaparakHubBaseUrl;
  }

  static String pardakhtsaziBaseUrl() {
    return getIt<AppConfigService>().config.pardakhtsaziBaseUrl;
  }

  static String baseUrlStatic() {
    return getIt<AppConfigService>().config.staticUrl;
  }

  static String baseUrl() {
    return getIt<AppConfigService>().config.baseUrl;
  }
}
