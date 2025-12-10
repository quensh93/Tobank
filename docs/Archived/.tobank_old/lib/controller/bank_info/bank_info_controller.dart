// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/address/request/address_inquiry_request_data.dart';
import '../../model/address/response/address_inquiry_response_data.dart';
import '../../model/common/normalized_address.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../service/update_address_services.dart';
import '../../ui/bank_info/widget/customer_address_bottom_sheet.dart';
import '../../ui/bank_info/widget/postal_code_bottom_sheet.dart';
import '../../ui/update_address/update_address_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class BankInfoController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;

  bool hasError = false;

  String errorTitle = '';

  CustomerInfoResponse? customerInfoResponse;

  TextEditingController postalCodeController = TextEditingController();

  bool isPostalCodeValid = true;

  AddressInquiryResponseData? addressInquiryResponseData;

  int openBottomSheets = 0;

  @override
  void onInit() {
    getCustomerInfoRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves customer information and handles the response,
  /// either updating the UI with the customer data or displaying an error.
  void getCustomerInfoRequest() {
    hasError = false;
    isLoading = true;
    update();

    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: false,
      forceInquireAddressInfo: true,
      getCustomerStartableProcesses: false,
      getCustomerDeposits: false,
      getCustomerActiveCertificate: false,
    );

    AuthorizationServices.getCustomerInfo(customerInfoRequest: customerInfoRequest).then((result) {
      //locale
      final locale = AppLocalizations.of(Get.context!)!;
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CustomerInfoResponse response, int _)):
          customerInfoResponse = response;
          update();
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

  String? getCustomerNumber() {
    return mainController.authInfoData!.customerNumber;
  }

  Future<void> handleCustomerAddress() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const CustomerAddressBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  String getCustomerAddress() {
    if (customerInfoResponse != null && customerInfoResponse!.data!.address != null) {
      return customerInfoResponse!.data!.address!;
    } else {
      return '-';
    }
  }

  String getPostalCode() {
    if (customerInfoResponse != null && customerInfoResponse!.data!.postalCode != null) {
      return customerInfoResponse!.data!.postalCode!;
    } else {
      return '-';
    }
  }

  Future<void> showUpdateAddressScreen() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (!mainController.isCustomerHasFullAccess()) {
      SnackBarUtil.showInfoSnackBar(locale.complete_identity_verification_from_deposit_section);
      return;
    }
    _closeBottomSheets();
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const PostalCodeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  /// Validates the postal code entered by the user and either proceeds with
  /// an address inquiry or marks the postal code as invalid.
  void validatePostalCode() {
    AppUtil.hideKeyboard(Get.context!);
    if (postalCodeController.text.trim().length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _addressInquiryRequest();
    } else {
      isPostalCodeValid = false;
    }
    update();
  }

  /// Initiates an address inquiry request and handles the response,
  /// either closing the bottom sheet
  /// and showing the update address screen or displaying an error.
  void _addressInquiryRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = postalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isLoading = true;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          addressInquiryResponseData = response;
          _closeBottomSheets();
          _showUpdateAddressScreen();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showUpdateAddressScreen() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    try {
      final NormalizedAddress normalizedAddress;
      normalizedAddress =
          NormalizedAddress.fromAddressInquiry(addressDetail: addressInquiryResponseData!.data!.detail!);
      final bool? result = await Get.to(() => UpdateAddressScreen(
            addressInquiryResponseData: addressInquiryResponseData!,
            postalCode: postalCodeController.text.trim(),
            normalizedAddress: normalizedAddress,
          ));
      if (result == true) {
        getCustomerInfoRequest();
      }
    } on Exception catch (exception, stackTrace) {
      // city or province is null
      Sentry.captureException(exception, stackTrace: stackTrace);
      SnackBarUtil.showInfoSnackBar(locale.no_address_found_for_postal_code);
    }
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }
}
