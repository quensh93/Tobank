import 'dart:async';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/authentication/kyc/request/get_ekyc_status_request_data.dart';
import '../../../model/authentication/kyc/response/get_ekyc_status_response_data.dart';
import '../../../service/authentication/kyc_services.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/storage_util.dart';
import '../authentication_register_controller.dart';
import 'certificate_generation_flow_methods.dart';

extension AuthenticationStatusFlowMethods on AuthenticationRegisterController {
  /// Sends a request to retrieve the EKYC status and handles the response.
  /// Updates UI state based on the response or displays errors.
  void getEkycStatusRequest() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    print('🔵 Starting EKYC status request');

    hasError = false;
    isLoading = true;
    update();

    final request = GetEkycStatusRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      deviceId: mainController.authInfoData!.ekycDeviceId!,
      returnHasNationalId: true,
    );

    KycServices.getEkycStatus(
      getEkycStatusRequestData: request,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {

        case Success(value: (final GetEkycStatusResponseData response, _)):
          _handleEkycStatus(response);
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

  /// Checks for EKYC status timeout and reinitiates the status request after a delay.
  /// This method preserves the current page before navigating to the initial page.
  void checkEkycStatusTimeout() {
    print('🔵 Checking EKYC status timeout');

    latestCurrentPage = pageController.page!.toInt();

    AppUtil.gotoPageController(
      pageController: pageController,
      page: 0,
      isClosed: isClosed,
    );

    Future.delayed(Constants.duration500, () {
      getEkycStatusRequest();
    });
  }

  /// Handles the EKYC status response by determining the appropriate page
  /// to navigate to based on the status. Updates UI state accordingly.
  Future<void> _handleEkycStatus(GetEkycStatusResponseData response) async {
    print('🔵 Handling EKYC status: ${response.data?.ekycStatus}');

    if (response.data!.hasNationalId != null) {
      isNationalSerialNumberUsed = response.data!.hasNationalId!;
    }

    int page = _determinePageFromStatus(response.data!.ekycStatus);

    if (page == latestCurrentPage) {
      SnackBarUtil.showTimeOutSnackBar();
    }

    // Special case handling for certificate status
    if (response.data!.ekycStatus == 230 ||
        response.data!.ekycStatus == 220 ||
        response.data!.ekycStatus == 210) {
      await _handleCertificateStatus(page);
    } else {
      _navigateToPage(page);
    }
  }

  /// Determines which page to show based on the EKYC status code
  int _determinePageFromStatus(int? status) {
    switch (status) {
      case null:
      case 0:  // OTP Requested
      case 10: // OTP Verified
      case 20: // Cellphone Number Verified
      case 30: // CR Info Fetched
        return 1; // Get OTP page

      case 40: // Additional Identification Data Provided
      case 50: // NationalID Front Image Received
        return 3; // NationalID Front Page

      case 60: // NationalID Front Image Verified
      case 70: // NationalID Back Image Received
        isNationalSerialNumberUsed = true;
        return 4; // NationalID Back Page

      case 80: // NationalID Back Image Verified
        isNationalSerialNumberUsed = true;
        return 5; // Person Image Page

      case 90:  // Person Image Recorded
      case 100: // LivenessVerified
      case 110: // CR Person Image Obtained
        return 5; // Person Image Page

      case 120: // PersonImage Matched
      case 130: // Birth Certificate Main Image Received
        return isNationalSerialNumberUsed ? 8 : 6; // Address Page or Birth Certificate Main page

      case 140: // Birth Certificate Main Image Verified
      case 150: // Birth Certificate Comments Image Received
        return 7; // Birth Certificate Comments page

      case 160: // Birth Certificate Comments Image Received
      case 170: // Postal Info Provided
      case 171:
        return 8; // Address Page

      case 180: // Postal Info Verified
        return 9; // Signature Page

      case 190: // Additional Postal Data Provided
      case 200: // Signature Image Received
        return 10; // Certificate Generator Page

      case 210: // Additional Steps Passed
      case 220: // EKYC Completed
      case 230: // EKYC Data Returned
        return 11; // Will be adjusted in _handleCertificateStatus if needed

      default:
        return 1;
    }
  }

  /// Handles special cases for certificate status
  Future<void> _handleCertificateStatus(int initialPage) async {
    final certificate = await StorageUtil.getAuthenticateCertificateModel();
    if (certificate != null) {
      zoomIdLogout();
      _navigateToPage(12);
    } else {
      _navigateToPage(11);
      Future.delayed(Constants.duration500, () {
        getCertificateRequest();
      });
    }
  }

  /// Navigates to the specified page using the page controller
  void _navigateToPage(int page) {
    print('🔵 Navigating to page: $page');

    AppUtil.gotoPageController(
      pageController: pageController,
      page: page,
      isClosed: isClosed,
    );
    update();
  }
}