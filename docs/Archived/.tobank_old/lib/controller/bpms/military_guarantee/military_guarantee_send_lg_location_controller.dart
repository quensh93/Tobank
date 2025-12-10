import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/address/request/address_inquiry_request_data.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../model/bpms/common/bpms_address.dart';
import '../../../model/bpms/common/bpms_address_value.dart';
import '../../../model/bpms/military_guarantee/request/complete_send_lg_location_task_data.dart';
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

class MilitaryGuaranteeSendLGLocationController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MilitaryGuaranteeSendLGLocationController({required this.task, required this.taskData});

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  TextEditingController postalCodeController = TextEditingController();
  bool isPostalCodeValid = true;

  bool isPostalCodeLoading = false;
  String postalCodeErrorMessage = '';

  AddressInquiryResponseData? addressInquiryResponseData;

  String? cityName;

  TextEditingController provinceController = TextEditingController();
  bool isProvinceValid = true;

  TextEditingController cityController = TextEditingController();
  bool isCityValid = true;

  TextEditingController townshipController = TextEditingController();
  bool isTownshipValid = true;

  TextEditingController lastStreetController = TextEditingController();
  bool isLastStreetValid = true;

  TextEditingController secondLastStreetController = TextEditingController();
  bool isSecondLastStreetValid = true;

  TextEditingController plaqueController = TextEditingController();
  bool isPlaqueValid = true;

  TextEditingController unitController = TextEditingController();
  bool isUnitValid = true;

  LatLng? selectedLocation;
  bool isLocationValid = true;

  bool isAddressInquirySuccessful = false;

  void validatePostalCodeInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (postalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _postalCodeInquiryRequest();
    } else {
      isPostalCodeValid = false;
      postalCodeErrorMessage = locale.invalid_postal_code;
    }
    update();
  }

  /// Performs a postal code inquiry to retrieve address information.
  void _postalCodeInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = postalCodeController.text;
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
          addressInquiryResponseData = response;
          setTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          addressInquiryResponseData = null;
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
    if (addressInquiryResponseData != null && cityName != null) {
      return cityName!;
    } else {
      return locale.check_postal_code;
    }
  }

  String getCustomerProvince() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (addressInquiryResponseData != null && addressInquiryResponseData!.data!.detail!.province != null) {
      return addressInquiryResponseData!.data!.detail!.province!;
    } else {
      return locale.check_postal_code;
    }
  }

  void setTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName =
        addressInquiryResponseData!.data!.detail?.townShip ?? addressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && addressInquiryResponseData!.data!.detail!.province != null) {
      isAddressInquirySuccessful = true;
      townshipController.text = addressInquiryResponseData!.data!.detail!.townShip ?? '';
      isTownshipValid = true;
      cityController.text = cityName ?? '';
      isCityValid = true;
      provinceController.text = addressInquiryResponseData!.data!.detail!.province ?? '';
      isProvinceValid = true;
      final detail = addressInquiryResponseData?.data?.detail;
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

  /// Validates the address information entered by the user.
  void validateAddressPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (postalCodeController.text.length == Constants.postalCodeLength) {
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
      isTownshipValid = true;
    } else {
      isTownshipValid = false;
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
      _completeSendLGLocationTaskRequest();
    }
  }

  /// Completes the sendLG location task request by sending data to the backend.
  void _completeSendLGLocationTaskRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteSendLGLocationTaskData(
        sendLGAddress: BPMSAddress(
          value: BPMSAddressValue(
            postalCode: int.parse(postalCodeController.text),
            province: provinceController.text,
            township: townshipController.text,
            city: cityController.text,
            village: addressInquiryResponseData!.data!.detail?.village ?? '',
            localityName: addressInquiryResponseData!.data!.detail?.localityName ?? '',
            lastStreet: lastStreetController.text,
            secondLastStreet: secondLastStreetController.text,
            alley: '',
            plaque: int.tryParse(plaqueController.text) ?? 1,
            unit: int.tryParse(unitController.text) ?? 0,
            description: addressInquiryResponseData!.data!.detail?.description ?? '',
            latitude: selectedLocation?.latitude,
            longitude: selectedLocation?.longitude,
          ),
        ),
      ),
    );

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
    // isLocationValid = false;
    update();
  }
}
