import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
///secure_plugin
import 'package:secure_plugin/secure_plugin.dart';
///secure_plugin
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../model/authentication/kyc/request/get_active_certificate_request_data.dart';
import '../../../model/authentication/kyc/request/issue_certificate_request_data.dart';
import '../../../model/authentication/kyc/response/get_active_certificate_response_data.dart';
import '../../../model/authentication/kyc/response/issue_certificate_response_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/secure_web_plugin.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/storage_util.dart';
import '../authentication_extension/authentication_status_flow_methods.dart';
import '../authentication_register_controller.dart';
import 'csr_security_flow_methods.dart';
import 'helper_tutorial_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
//locale
final locale = AppLocalizations.of(Get.context!)!;
extension CertificateGenerationFlowMethods on AuthenticationRegisterController {
  /// Generates a certificate request, including key generation, CSR creation,
  /// and submission to the server, and handles the response,
  /// either proceeding with certificate issuance or handling errors.
  Future<bool> generateCertificateRequest({bool needUpdate = true}) async {
    isLoading = true;
    update();

    final Map<String, String> csrAttributes = {
      'CN': '${englishNameEditingController.text.trim()} ${englishFamilyTextEditingController.text.trim()}',
      'O': 'Non-Governmental',
      'OU': 'ToBank',
      'C': 'IR',
      'T': locale.user,
      'G': mainController.authInfoData!.firstName!,
      'SN': mainController.authInfoData!.lastName!,
      'SERIALNUMBER': mainController.authInfoData!.nationalCode!,
    };
    print("🔵 SERIALNUMBER : ${mainController.authInfoData!.nationalCode!}");
    print("🔵 csrAttributes : ${csrAttributes}");

    String publicKey = '';
    String csr = '';

    try {
      if (kIsWeb) {
        await SecureWebPlugin.removePairKey();
        String rawPublicKey = await SecureWebPlugin.generatePairKey();
        print("🔵 raw publicKey : ${rawPublicKey}");

        // Format the public key to match the working non-web format
        if (!rawPublicKey.contains('-----BEGIN PUBLIC KEY-----')) {
          publicKey = '-----BEGIN PUBLIC KEY-----\n$rawPublicKey\n-----END PUBLIC KEY-----';
        } else {
          publicKey = rawPublicKey;
        }

        print("🔵 formatted publicKey : $publicKey");

        final rsaPublicKey = CryptoUtils.rsaPublicKeyFromPem(publicKey);
        print("🔵 rsaPublicKey : $rsaPublicKey");

        csr = await generateRsaCsrPem(csrAttributes, rsaPublicKey);
        print("🔵 generated csr : $csr");

      } else {
        await SecurePlugin.removeKey(
            phoneNumber: mainController.keyAliasModelList.first.keyAlias);

        final SecureResponseData secureKeysResponse = await SecurePlugin.generateKeys(
          phoneNumber: mainController.keyAliasModelList.first.keyAlias,
          nameEnglish: '${englishNameEditingController.text.trim()} ${englishFamilyTextEditingController.text.trim()}',
        );
        if (secureKeysResponse.isSuccess ?? false) {
          publicKey = secureKeysResponse.data!;
        } else {
          isLoading = false;
          update();
          SnackBarUtil.showSnackBar(title: locale.error_occurred, message: locale.error_in_saving);

          await Sentry.captureMessage('generate key error',
              params: [
                {'status code': secureKeysResponse.statusCode},
                {'message': secureKeysResponse.message},
              ],
              level: SentryLevel.warning);

          return false; // Return false if key generation fails
        }

        publicKey = '-----BEGIN PUBLIC KEY-----\n$publicKey\n-----END PUBLIC KEY-----';
        final rsaPublicKey = CryptoUtils.rsaPublicKeyFromPem(publicKey);
        csr = await generateRsaCsrPem(csrAttributes, rsaPublicKey);
      }

      if (csr.isEmpty) {
        isLoading = false;
        update();
        SnackBarUtil.showSnackBar(title: locale.error_occurred, message: locale.error_in_digital_signature);
        return false; // Return false if CSR generation fails
      }

      csr = csr
          .replaceAll('-----BEGIN CERTIFICATE REQUEST-----', '')
          .replaceAll('-----END CERTIFICATE REQUEST-----', '')
          .replaceAll('\n', '')
          .replaceAll('\r', '')
          .trim();

      print("🔵 final formatted csr : $csr");

      final IssueCertificateRequestData issueCertificateRequestData = IssueCertificateRequestData(
        trackingNumber: const Uuid().v4(),
        nationalCode: mainController.authInfoData!.nationalCode!,
        globalFirstName: englishNameEditingController.text.trim(),
        globalLastName: englishFamilyTextEditingController.text.trim(),
        occupation: null,
        email: AppUtil.getEnglishNumbers(emailEditingController.text.trim()),
        landLineNumber: homePhoneNumberTextEditingController.text.trim(),
        certificateRequestData: csr,
        deviceId: mainController.authInfoData!.ekycDeviceId!,
      );

      print("🔵 issueCertificateRequestData : ${issueCertificateRequestData.toJson()}");

      await StorageUtil.setAuthenticateUserEnglishName(
          '${englishNameEditingController.text.trim()} ${englishFamilyTextEditingController.text.trim()}'
      );

      final result = await KycServices.issueCertificate(
        issueCertificateRequestData: issueCertificateRequestData,
      );

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final IssueCertificateResponseData response, 200)):
          await handleIssueCertificateResponse(response , needUpdate: needUpdate);
          return true; // Return true on success
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
          return true; //Considered a success since we are checking status
        case Success(value: _):
        // Will not happen
          return false; //Or should we throw exception here? since it is unhandled case?
          break;
        case Failure(exception: final ApiException apiException):
          switch (apiException.type) {
            case ApiExceptionType.connectionTimeout:
              checkEkycStatusTimeout();
              return true; //Considered a success since we are checking status
            default:
              SnackBarUtil.showSnackBar(
                title: locale.show_error(apiException.displayCode),
                message: apiException.displayMessage,
              );
              return false; // Return false on failure
          }
      }
    } catch (e) {
      // General error handling
      isLoading = false;
      update();
      SnackBarUtil.showSnackBar(title: locale.error_occurred, message: 'An unexpected error occurred.');
      print('Error in generateCertificateRequest: $e');
      return false; // Return false on error
    }
  }


  /// Handles the response received after successfully issuing a certificate.
  /// It stores the certificate data in local storage using `StorageUtil.setAuthenticateCertificateModel()`,
  /// navigates to the next page
  Future<void> handleIssueCertificateResponse(IssueCertificateResponseData response ,
      {bool needUpdate = true}) async {
    await StorageUtil.setAuthenticateCertificateModel(response.data!.certificate);
    if(needUpdate){
      AppUtil.gotoPageController(
        pageController: pageController,
        page: 12,
        isClosed: isClosed,
      );
    }

    stopPlayer();
    update();
    zoomIdLogout();
  }

  /// Sends a request to retrieve the active certificate request and handles the response,
  /// either processing the certificate or displaying errors.
  void getCertificateRequest() {
    hasError = false;
    isLoading = true;
    update();

    final GetActiveCertificateRequestData getActiveCertificateRequestData = GetActiveCertificateRequestData(
      trackingNumber: const Uuid().v4(),
      personType: 0,
    );

    KycServices.getActiveCertificate(
      getActiveCertificateRequestData: getActiveCertificateRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetActiveCertificateResponseData response, _)):
          _handleCertificate(response);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Handles the active certificate response, either navigating to the appropriate page
  /// based on certificate equality or resetting the EKYC device ID and navigating to the start page.
  Future<void> _handleCertificate(GetActiveCertificateResponseData response) async {
    int page = 1;
    if (await AppUtil.isCertificatesEqual(certificate: response.data!.token!)) {
      // timeout
      await StorageUtil.setAuthenticateCertificateModel(response.data!.token!);
      page = 12;
      zoomIdLogout();
    } else {
      // some other device requested ekyc or some app,server-side exception happened
      mainController.authInfoData!.ekycDeviceId = null;
      page = 1;
    }
    update();
    await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
    mainController.update();
    AppUtil.gotoPageController(
      pageController: pageController,
      page: page,
      isClosed: isClosed,
    );
  }
}