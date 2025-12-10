import 'dart:async';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/get_address_info_request_data.dart';
import '../../../model/authentication/kyc/response/get_address_info_response_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/regexes.dart';
import '../../../util/snack_bar_util.dart';
import '../authentication_extension/authentication_status_flow_methods.dart';
import '../authentication_register_controller.dart';
import 'certificate_generation_flow_methods.dart';
import 'helper_tutorial_flow_methods.dart';

extension AddressVerificationFlowMethods on AuthenticationRegisterController {
  /// Validates the postal code and optionally the address,
  /// and triggers the address information retrieval process
  /// if all validations pass.
  Future<void> getAddressInfo({required bool postOnly}) async {
    AppUtil.hideKeyboard(Get.context!);

    bool isValid = true;
    if (postalCodeEditingController.text.trim().length == Constants.postalCodeLength) {
      isPostalCodeValidate = true;
    } else {
      isPostalCodeValidate = false;
      isValid = false;
    }

    if (!postOnly) {
      if (addressTextEditingController.text.trim().isNotEmpty) {
        isAddressValidate = true;
      } else {
        isAddressValidate = false;
        isValid = false;
      }
    }

    update();

    if (isValid) {
      _getAddressInfoRequest(postOnly: postOnly);
    }
  }

  /// Sends a request to retrieve address information based on the postal code
  /// and optionally the address, and handles the response, either populating the address field,
  /// navigating to the next page, handling timeouts, or displaying errors.
  Future<void> _getAddressInfoRequest({required bool postOnly}) async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final GetAddressInfoRequestData getAddressInfoRequestData = GetAddressInfoRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      postalCode: postalCodeEditingController.text,
      declaredAddress: postOnly ? null : addressTextEditingController.text,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
    );

    if (postOnly) {
      isPostInquiryLoading = true;
    } else {
      isLoading = true;
    }
    update();

    KycServices.getAddressInfo(
      getAddressInfoRequestData: getAddressInfoRequestData,
    ).then((result) {
      isPostInquired = true;
      if (postOnly) {
        isPostInquiryLoading = false;
      } else {
        isLoading = false;
      }
      update();

      switch (result) {
        case Success(value: (final GetAddressInfoResponseData response, 200)):
          if (postOnly) {
            if (addressTextEditingController.text.isEmpty) {
              addressTextEditingController.text = response.data!.address ?? '';
            }
          } else {
            AppUtil.nextPageController(pageController, isClosed);
            stopPlayer();
          }
          update();
        case Success(value: (_, 421)):
          checkEkycStatusTimeout();
        case Success(value: _):
        // Will not happen
          break;
        case Failure(exception: final ApiException apiException):
          switch (apiException.type) {
            case ApiExceptionType.connectionTimeout:
              if (!postOnly) {
                checkEkycStatusTimeout();
              }
            default:
              if (!postOnly) {
                SnackBarUtil.showSnackBar(
                  title: locale.show_error(apiException.displayCode),
                  message: apiException.displayMessage,
                );
              }
          }
      }
    });
  }

  /// Validates the form data, including English name, email,and home phone number,
  /// and triggers the certificate request generation if all validations pass.
  Future<bool> validateFrom({bool needUpdate = true}) async {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (englishNameEditingController.text.trim().isNotEmpty) {
      isEnglishFirstNameValidate = true;
    } else {
      isEnglishFirstNameValidate = false;
      isValid = false;
    }

    if (englishFamilyTextEditingController.text.trim().isNotEmpty) {
      isEnglishLastNameValidate = true;
    } else {
      isEnglishLastNameValidate = false;
      isValid = false;
    }

    if (RegexValue.emailReg.hasMatch(
        AppUtil.getEnglishNumbers(emailEditingController.text.trim()))) {
      isEmailValidate = true;
    } else {
      isEmailValidate = false;
      isValid = false;
    }

    if (homePhoneNumberTextEditingController.text.trim().length == Constants.phoneNumberLength &&
        homePhoneNumberTextEditingController.text.trim()[0] == '0') {
      isHomePhoneNumberValidate = true;
    } else {
      isHomePhoneNumberValidate = false;
      isValid = false;
    }

    if(needUpdate){
      update();
    }

    if (isValid) {
      return await generateCertificateRequest(needUpdate : needUpdate);
    }
    return false;
  }
}