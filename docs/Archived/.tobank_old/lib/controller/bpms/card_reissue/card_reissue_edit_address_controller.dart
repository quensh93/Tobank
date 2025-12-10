// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/address/request/address_inquiry_request_data.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../model/bpms/card/card_reissuance/request/complete_edit_address_task_data.dart';
import '../../../model/bpms/common/bpms_address.dart';
import '../../../model/bpms/common/bpms_address_value.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/update_address_services.dart';
import '../../../ui/common/location_picker_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CardReissueEditAddressController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();
  TextEditingController customerPostalCodeController = TextEditingController();

  bool isPostalCodeLoading = false;

  TextEditingController customerAddressController = TextEditingController();

  TextEditingController lastStreetController = TextEditingController();

  TextEditingController provinceController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController unitController = TextEditingController();

  TextEditingController townshipController = TextEditingController();

  TextEditingController secondLastStreetController = TextEditingController();

  TextEditingController plaqueController = TextEditingController();

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  bool isPostalCodeValid = true;

  bool isLastStreetValid = true;

  bool isSecondLastStreetValid = true;

  bool isUnitValid = true;

  bool isProvinceValid = true;

  bool isTownShipValid = true;

  bool isCityValid = true;

  bool isPlaqueValid = true;

  bool isAddressValid = true;

  bool isLoading = false;

  bool isUploading = false;

  String postalCodeErrorMessage = '';

  String? cityName;

  LatLng? selectedLocation;

  bool isLocationValid = true;

  bool isAddressInquirySuccessful = false;

  CardReissueEditAddressController({required this.task, required this.taskData});

  void validateCustomerAddressInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _customerAddressInquiryRequest();
    } else {
      isPostalCodeValid = false;
      postalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  void showSelectLocationScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(
      () => LocationPickerScreen(
        returnDataFunction: (latLng) {
          selectedLocation = latLng;
          isLocationValid = true;
          update();
        },
      ),
    );
  }

  /// Retrieves customer address information based on a postal code.
  void _customerAddressInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = customerPostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isAddressInquirySuccessful = false;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isPostalCodeLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          customerAddressInquiryResponseData = response;
          setCustomerTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          customerAddressInquiryResponseData = null;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getCustomerCity() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (customerAddressInquiryResponseData != null && cityName != null) {
      return cityName!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  String getCustomerProvince() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (customerAddressInquiryResponseData != null &&
        customerAddressInquiryResponseData!.data!.detail!.province != null) {
      return customerAddressInquiryResponseData!.data!.detail!.province!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  void setCustomerTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName = customerAddressInquiryResponseData!.data!.detail?.townShip ??
        customerAddressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && customerAddressInquiryResponseData!.data!.detail!.province != null) {
      isAddressInquirySuccessful = true;
      townshipController.text = customerAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isTownShipValid = true;
      cityController.text = cityName ?? '';
      isCityValid = true;
      provinceController.text = customerAddressInquiryResponseData!.data!.detail!.province ?? '';
      isProvinceValid = true;
      final detail = customerAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        lastStreetController = TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isLastStreetValid = true;
        secondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isSecondLastStreetValid = true;
      } else {
        lastStreetController.text = '';
        secondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        unitController = TextEditingController(text: detail?.sideFloor);
        isUnitValid = true;
      } else {
        unitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      plaqueController = TextEditingController(text: (plaqueInt).toString());
      isPlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
      );
    }
  }

  /// Validates the customer's address and related information.
  void validateCustomerAddress() {
    bool isValid = true;

    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
    } else {
      isPostalCodeValid = false;
      isValid = false;
    }
    if (lastStreetController.text.trim().length > 3) {
      isLastStreetValid = true;
    } else {
      isLastStreetValid = false;
      isValid = false;
    }
    if (secondLastStreetController.text.trim().length > 3) {
      isSecondLastStreetValid = true;
    } else {
      isSecondLastStreetValid = false;
      isValid = false;
    }
    if (plaqueController.text.trim().isNotEmpty) {
      isPlaqueValid = true;
    } else {
      isPlaqueValid = false;
      isValid = false;
    }
    if (unitController.text.trim().isNotEmpty) {
      isUnitValid = true;
    } else {
      isUnitValid = false;
      isValid = false;
    }
    if (cityController.text.trim().isNotEmpty) {
      isCityValid = true;
    } else {
      isCityValid = false;
      isValid = false;
    }
    if (townshipController.text.trim().isNotEmpty) {
      isTownShipValid = true;
    } else {
      isTownShipValid = false;
      isValid = false;
    }
    if (provinceController.text.trim().isNotEmpty) {
      isProvinceValid = true;
    } else {
      isProvinceValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _completeCustomerLocationRequest();
    }
  }

  /// Completes the customer location update request and handles the response,
  /// either displaying a success message and closing the screen or showing an error.
  void _completeCustomerLocationRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest<CompleteEditAddressTaskData> completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteEditAddressTaskData(
        customerAddress: BPMSAddress(
          value: BPMSAddressValue(
            postalCode: int.parse(customerPostalCodeController.text),
            province: provinceController.text,
            township: townshipController.text,
            city: cityController.text,
            village: customerAddressInquiryResponseData!.data!.detail?.village ?? '',
            localityName: customerAddressInquiryResponseData!.data!.detail?.localityName ?? '',
            lastStreet: lastStreetController.text,
            secondLastStreet: secondLastStreetController.text,
            alley: '',
            plaque: int.tryParse(plaqueController.text) ?? 1,
            unit: int.tryParse(unitController.text) ?? 0,
            description: customerAddressInquiryResponseData!.data!.detail?.description ?? '',
            longitude: selectedLocation?.longitude,
            latitude: selectedLocation?.latitude,
          ),
        ),
      ),
    );

    isLoading = true;
    update();
    BPMSServices.completeTask(
      completeTaskRequest: completeTaskRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          Get.back(closeOverlays: true);
          Future.delayed(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.register_successfully);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void removeSelectedMapLocation() {
    selectedLocation = null;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
