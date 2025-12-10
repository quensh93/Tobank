import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/address/request/update_address_request_data.dart';
import '../../model/address/response/address_inquiry_response_data.dart';
import '../../model/common/normalized_address.dart';
import '../../service/core/api_core.dart';
import '../../service/update_address_services.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class UpdateAddressController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isPostalCodeValid = true;

  var isLoading = false;

  TextEditingController phoneNumberController = TextEditingController();

  bool isPhoneNumberValid = true;

  TextEditingController streetController = TextEditingController();

  bool isStreetValid = true;

  TextEditingController sideStreetController = TextEditingController();

  bool isSideStreetValid = true;

  TextEditingController plaqueController = TextEditingController();

  bool isPlaqueValid = true;

  TextEditingController floorSideController = TextEditingController();

  bool isFloorSideValid = true;

  TextEditingController floorController = TextEditingController();

  bool isFloorValid = true;

  AddressInquiryResponseData addressInquiryResponseData;
  NormalizedAddress normalizedAddress;
  String postalCode;

  TextEditingController postalCodeController = TextEditingController();

  UpdateAddressController(
      {required this.addressInquiryResponseData, required this.normalizedAddress, required this.postalCode});

  @override
  void onInit() {
    _setTextControllers();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void _setTextControllers() {
    postalCodeController.text = postalCode;
    streetController.text = normalizedAddress.street ?? '';
    sideStreetController.text = normalizedAddress.sideStreet ?? '';
    plaqueController.text = (normalizedAddress.plaque ?? '').toString();
    floorSideController.text = (normalizedAddress.sideFloor ?? '').toString();
    floorController.text = (normalizedAddress.floor ?? '').toString();
    update();
  }

  void validateAddressInfoPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (phoneNumberController.text.length == Constants.phoneNumberLength &&
        phoneNumberController.text.startsWith('0')) {
      isPhoneNumberValid = true;
    } else {
      isPhoneNumberValid = false;
      isValid = false;
    }

    if (streetController.text.trim().length > 3) {
      isStreetValid = true;
    } else {
      isStreetValid = false;
      isValid = false;
    }

    if (sideStreetController.text.trim().length > 3) {
      isSideStreetValid = true;
    } else {
      isSideStreetValid = false;
      isValid = false;
    }

    if (plaqueController.text.trim().isNotEmpty) {
      isPlaqueValid = true;
    } else {
      isPlaqueValid = false;
      isValid = false;
    }

    if (floorSideController.text.trim().isNotEmpty) {
      isFloorSideValid = true;
    } else {
      isFloorSideValid = false;
      isValid = false;
    }

    if (floorController.text.trim().isNotEmpty) {
      isFloorValid = true;
    } else {
      isFloorValid = false;
      isValid = false;
    }

    update();

    if (isValid) {
      _updateAddressRequest();
    }
  }

  /// Sends a request to update the customer's address.
  void _updateAddressRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final UpdateAddressRequestData updateAddressRequestData = UpdateAddressRequestData();
    updateAddressRequestData.trackingNumber = const Uuid().v4();
    updateAddressRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    updateAddressRequestData.postalCode = postalCode;
    updateAddressRequestData.landLineNumber = phoneNumberController.text;
    updateAddressRequestData.province = normalizedAddress.province;
    updateAddressRequestData.city = normalizedAddress.city;
    updateAddressRequestData.lastStreet = sideStreetController.text;
    updateAddressRequestData.secondLastStreet = streetController.text;
    updateAddressRequestData.plaque = int.tryParse(plaqueController.text) ?? 0;
    updateAddressRequestData.floor = int.tryParse(floorController.text) ?? 0;
    updateAddressRequestData.floorSide = int.tryParse(floorSideController.text) ?? 0;
    updateAddressRequestData.buildingName = normalizedAddress.buildingName;
    isLoading = true;
    update();
    UpdateAddressServices.updateAddressRequest(
      updateAddressRequestData: updateAddressRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          Get.back(result: true);
          SnackBarUtil.showSuccessSnackBar(
            locale.address_updated_successfully,
          );
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}
