import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/key_alias_model.dart';
import '../../model/renew_certificate/request/renew_certificate_request_data.dart';
import '../../model/renew_certificate/response/renew_certificate_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/renew_certificate_services.dart';
import '../../ui/register/register_screen.dart';
import '../../util/app_util.dart';
import '../../util/certificate_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class RenewCertificateController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = false;

  bool isEnglishFirstNameValidate = true;

  bool isEnglishLastNameValidate = true;

  PageController pageController = PageController();

  late KeyAliasModel newKeyAliasModel;
  late String csr;

  final int remainingDays;

  @override
  void onInit() {
    super.onInit();
    if (remainingDays <= 0) {
      _removeAuthentication();
    }
  }

  RenewCertificateController({required this.remainingDays});

  Future<void> renewCertificate() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    final bool? isDeviceSecure = await AppUtil.isDeviceSecure();
    if (isDeviceSecure == true) {
      _renewCertificateRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_security_method,
      );
    }
  }

  /// Renews the user's certificate by generating a new CSR and navigating to the next page.
  Future<void> _renewCertificateRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final Map<String, String> csrAttributes = {
      'CN': mainController.userEnglishName!,
      'O': 'Non-Governmental',
      'OU': 'ToBank',
      'C': 'IR',
      'T': locale.user,
      'G': mainController.authInfoData!.firstName!,
      'SN': mainController.authInfoData!.lastName!,
      'SERIALNUMBER': mainController.authInfoData!.nationalCode!,
    };
    String publicKey = '';
    final String currentKeyAlias = mainController.keyAliasModelList.first.keyAlias;
    String newKeyAlias = '';
    final split = currentKeyAlias.split('-');
    if (split.length == 2) {
      newKeyAlias = '${mainController.authInfoData!.mobile!}-${int.parse(split[1]) + 1}';
    } else {
      newKeyAlias = '${mainController.authInfoData!.mobile!}-1';
    }
    newKeyAliasModel = KeyAliasModel(keyAlias: newKeyAlias, timestamp: DateTime.now().millisecondsSinceEpoch);
    mainController.keyAliasModelList.add(newKeyAliasModel);
    final SecureResponseData secureKeysResponse = await SecurePlugin.generateKeys(
      phoneNumber: mainController.keyAliasModelList.last.keyAlias,
      nameEnglish: mainController.userEnglishName!,
    );
    if (secureKeysResponse.isSuccess ?? false) {
      publicKey = secureKeysResponse.data!;
    } else {
      SnackBarUtil.showSnackBar(title: locale.error, message: locale.error_in_saving);

      await Sentry.captureMessage('generate key error',
          params: [
            {'status code': secureKeysResponse.statusCode},
            {'message': secureKeysResponse.message},
          ],
          level: SentryLevel.warning);
      return;
    }

    publicKey = '-----BEGIN PUBLIC KEY-----\n$publicKey\n-----END PUBLIC KEY-----';
    final rsaPublicKey = CryptoUtils.rsaPublicKeyFromPem(publicKey);
    csr = await CertificateUtil.generateRsaCsrPem(
        csrAttributes, rsaPublicKey, mainController.keyAliasModelList.last.keyAlias);

    if (csr == '') {
      SnackBarUtil.showSnackBar(title: locale.error, message: locale.error_in_digital_signature);
      return;
    }

    csr = csr
        .replaceAll('-----BEGIN CERTIFICATE REQUEST-----', '')
        .replaceAll('-----END CERTIFICATE REQUEST-----', '')
        .replaceAll('\n', '')
        .replaceAll('\r', '')
        .trim();
    AppUtil.nextPageController(pageController, isClosed);
  }

  /// Submits the certificate renewal request and handles the response.
  void submitCertificateRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final RenewCertificateRequestData renewCertificateRequestData = RenewCertificateRequestData(
      trackingNumber: const Uuid().v4(),
      deviceId: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      certificateRequestData: csr,
    );
    RenewCertificateServices.renewCertificateRequest(
      renewCertificateRequestData: renewCertificateRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final RenewCertificateResponseData response, int _)):
          mainController.appEKycProvider = EKycProvider.yekta;
          mainController.update();
          await SecurePlugin.removeKey(phoneNumber: mainController.keyAliasModelList.first.keyAlias);
          mainController.keyAliasModelList = [];
          mainController.keyAliasModelList.add(newKeyAliasModel);
          await StorageUtil.setKeyAliasModel(mainController.keyAliasModelList);
          await StorageUtil.setAuthenticateCertificateModel(response.data!.certificate);
          Get.back();
          SnackBarUtil.showSnackBar(
            title: locale.announcement,
            message: locale.authentication_update_success,
          );
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> authentication() async {
    await _removeAuthentication();
    Get.off(() => const RegisterScreen());
  }

  /// Removes the user's authentication data and resets related information.
  Future<void> _removeAuthentication() async {
    await SecurePlugin.removeKey(phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    await StorageUtil.deleteAuthenticateCertificateModel();
    mainController.authInfoData!.ekycDeviceId = null;
    await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
    await mainController.getAppEkycProvider();
  }
}
