import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/address/request/address_inquiry_request_data.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../model/bpms/common/bpms_address.dart';
import '../../../model/bpms/common/bpms_address_value.dart';
import '../../../model/bpms/military_guarantee/military_guarantee_person_type_item_data.dart';
import '../../../model/bpms/military_guarantee/request/military_guarantee_start_process_variables_data.dart';
import '../../../model/bpms/request/applicant_task_list_request_data.dart';
import '../../../model/bpms/request/check_personal_info_request_data.dart';
import '../../../model/bpms/request/process_start_form_data_request_data.dart';
import '../../../model/bpms/request/start_process_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/check_personal_info_response_data.dart';
import '../../../model/bpms/response/process_start_form_data_response_data.dart';
import '../../../model/bpms/response/start_process_response_data.dart';
import '../../../model/other/response/other_item_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/other_services.dart';
import '../../../service/update_address_services.dart';
import '../../../ui/common/date_selector_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';
import '../../tobank_services/tobank_services_controller.dart';
import '../task_list_controller.dart';

class MilitaryGuaranteeStartController extends GetxController {
  // TODO separate event ids into two controller

  PageController pageController = PageController();
  String? errorTitle;
  bool hasError = false;
  bool isLoading = false;
  MainController mainController = Get.find();

  ScrollController scrollbarController = ScrollController();

  OtherItemData? otherItemData;

  bool isRuleChecked = false;

  ProcessStartFormDataResponse? processStartFormDataResponse;

  bool isApplicantSameGuarantee = false;

  bool noNationalCard = false;

  TextEditingController personNationalCodeController = TextEditingController();

  bool isPersonNationalCodeValid = true;

  TextEditingController personBirthDateController = TextEditingController();

  bool isPersonBirthdayValid = true;

  String initBirthDateString = '';
  String dateJalaliString = '';

  String dateGregorian = '';

  TextEditingController personNationalIdTrackingNumberController = TextEditingController();
  bool isPersonNationalIdTrackingNumberValid = true;

  TextEditingController personMobileController = TextEditingController();
  bool isPersonMobileValid = true;

  CheckPersonalInfoResponseData? checkPersonalInfoResponseData;

  String? personFirstName;
  String? personLastName;

  TextEditingController personPostalCodeController = TextEditingController();
  bool isPersonPostalCodeValid = true;

  bool isPostalCodeLoading = false;
  String personPostalCodeErrorMessage = '';

  AddressInquiryResponseData? personAddressInquiryResponseData;

  String? personCityName;

  TextEditingController personProvinceController = TextEditingController();
  bool isPersonProvinceValid = true;

  TextEditingController personCityController = TextEditingController();
  bool isPersonCityValid = true;

  TextEditingController personTownshipController = TextEditingController();
  bool isPersonTownshipValid = true;

  TextEditingController personLastStreetController = TextEditingController();
  bool isPersonLastStreetValid = true;

  TextEditingController personSecondLastStreetController = TextEditingController();
  bool isPersonSecondLastStreetValid = true;

  TextEditingController personPlaqueController = TextEditingController();
  bool isPersonPlaqueValid = true;

  TextEditingController personUnitController = TextEditingController();
  bool isPersonUnitValid = true;

  TextEditingController customerPostalCodeController = TextEditingController();
  bool isCustomerPostalCodeValid = true;

  String customerPostalCodeErrorMessage = '';

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  String? customerCityName;

  TextEditingController customerProvinceController = TextEditingController();
  bool isCustomerProvinceValid = true;

  TextEditingController customerCityController = TextEditingController();
  bool isCustomerCityValid = true;

  TextEditingController customerTownshipController = TextEditingController();
  bool isCustomerTownshipValid = true;

  TextEditingController customerLastStreetController = TextEditingController();
  bool isCustomerLastStreetValid = true;

  TextEditingController customerSecondLastStreetController = TextEditingController();
  bool isCustomerSecondLastStreetValid = true;

  TextEditingController customerPlaqueController = TextEditingController();
  bool isCustomerPlaqueValid = true;

  TextEditingController customerUnitController = TextEditingController();
  bool isCustomerUnitValid = true;

  StartProcessResponse? startProcessResponse;
  ApplicantTaskListResponse? applicantTaskListResponse;

  bool isPersonAddressInquirySuccessful = false;
  bool isCustomerAddressInquirySuccessful = false;

  static const String taskListControllerTag = 'MilitaryGuaranteeTasksTag';

  @override
  void onInit() {
    super.onInit();
    getMilitaryGuaranteeStartRulesRequest();
    Get.put(TaskListController(refreshCallback: (_) => refreshTaskList()), tag: taskListControllerTag);
    initBirthDateString = AppUtil.twentyYearsBeforeNow();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the military guarantee start rules from the server.
  Future<void> getMilitaryGuaranteeStartRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getMilitaryGuaranteeRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
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

  void setChecked(bool isChecked) {
    isRuleChecked = isChecked;
    update();
  }

  /// Validates whether the user has checked the rules checkbox.
  void validateRules() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isRuleChecked) {
      _getStartFormData();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.warning,
        message: locale.please_read_and_accept_terms,
      );
    }
  }

  void _getStartFormData() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final TobankServicesController tobankServicesController = Get.find();
    final processDefinitions =
        tobankServicesController.processDefinitions.firstWhereOrNull((element) => element.key == 'MilitaryLG');
    if (processDefinitions == null) {
      // Happens when server bpms request has error
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.processing_not_found,
      );
      return;
    }

    final ProcessStartFormDataRequest processStartFormDataRequest = ProcessStartFormDataRequest(
      processDefinitionKey: processDefinitions.key!,
      processDefinitionVersion: processDefinitions.version!,
      trackingNumber: const Uuid().v4(),
    );

    isLoading = true;
    update();

    BPMSServices.getProcessStartFormData(
      processStartFormDataRequest: processStartFormDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ProcessStartFormDataResponse response, int _)):
          processStartFormDataResponse = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void handleServiceItemClick(
    MilitaryGuaranteePersonTypeItemData militaryGuaranteePersonTypeItemData,
  ) {
    if (militaryGuaranteePersonTypeItemData.eventId == 1) {
      isApplicantSameGuarantee = true;

      // set own data
      personNationalCodeController.text = mainController.authInfoData!.nationalCode!;
      personMobileController.text = mainController.authInfoData!.mobile!;
      personBirthDateController.text = mainController.authInfoData!.birthdayDate!;
      personFirstName = mainController.authInfoData!.firstName!;
      personLastName = mainController.authInfoData!.lastName!;
      update();
      AppUtil.gotoPageController(pageController: pageController, page: 5, isClosed: isClosed);
    } else if (militaryGuaranteePersonTypeItemData.eventId == 2) {
      isApplicantSameGuarantee = false;

      personNationalCodeController.text = '';
      personMobileController.text = '';
      personBirthDateController.text = '';
      personFirstName = null;
      personLastName = null;
      update();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void setNoNationalCard(bool value) {
    noNationalCard = value;
    update();
  }

  void showSelectBirthDateDialog({required int birthDayId}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Get.isDarkMode ? Get.context!.theme.colorScheme.surface : Colors.white,
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initBirthDateString,
            title:locale.enter_birth_date_beneficiary ,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              personBirthDateController.text = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
  }

  void validatePersonInfoPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (personNationalCodeController.text.trim().length == Constants.nationalCodeLength &&
        AppUtil.validateNationalCode(personNationalCodeController.text.trim())) {
      isPersonNationalCodeValid = true;
    } else {
      isPersonNationalCodeValid = false;
      isValid = false;
    }

    if (personBirthDateController.text.trim().isNotEmpty) {
      isPersonBirthdayValid = true;
    } else {
      isPersonBirthdayValid = false;
      isValid = false;
    }

    if (personMobileController.text.trim().length == Constants.mobileNumberLength &&
        personMobileController.text.trim().startsWith(Constants.mobileStartingDigits)) {
      isPersonMobileValid = true;
    } else {
      isPersonMobileValid = false;
      isValid = false;
    }

    if (personNationalIdTrackingNumberController.text.trim().isNotEmpty) {
      isPersonNationalIdTrackingNumberValid = true;
    } else {
      isPersonNationalIdTrackingNumberValid = false;
      isValid = false;
    }

    update();
    if (isValid) {
      _checkPersonalInfoRequest();
    }
  }

  /// Checks personal information against the backend.
  void _checkPersonalInfoRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CheckPersonalInfoRequestData checkPersonalInfoRequestData = CheckPersonalInfoRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: personNationalCodeController.text.trim(),
      birthDate: DateConverterUtil.getTimestampFromJalali(
          date: personBirthDateController.text.trim(), extendDuration: const Duration(hours: 2)),
      nationalIdTrackingNumber: personNationalIdTrackingNumberController.text.trim().toUpperCase(),
      checkIdentificationData: true,
      checkBadCredit: false,
      checkBankCIF: false,
    );

    isLoading = true;
    update();
    BPMSServices.checkPersonalInfo(
      checkPersonalInfoRequestData: checkPersonalInfoRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CheckPersonalInfoResponseData response, _)):
          checkPersonalInfoResponseData = response;
          personFirstName = checkPersonalInfoResponseData!.data!.firstName!;
          personLastName = checkPersonalInfoResponseData!.data!.lastName!;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String personName() {
    return '$personFirstName $personLastName';
  }

  void validatePersonInfoConfirmPage() {
    AppUtil.nextPageController(pageController, isClosed);
  }

  void validatePersonPostalCodeInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (personPostalCodeController.text.length == Constants.postalCodeLength) {
      isPersonPostalCodeValid = true;
      _personPostalCodeInquiryRequest();
    } else {
      isPersonPostalCodeValid = false;
      personPostalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  /// Performs a postal code inquiry to retrieve address information for a person.
  void _personPostalCodeInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = personPostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isPersonAddressInquirySuccessful = false;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isPostalCodeLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          personAddressInquiryResponseData = response;
          setPersonTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          personAddressInquiryResponseData = null;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getPersonCity() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (personAddressInquiryResponseData != null && personCityName != null) {
      return personCityName!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  String getPersonProvince() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (personAddressInquiryResponseData != null && personAddressInquiryResponseData!.data!.detail!.province != null) {
      return personAddressInquiryResponseData!.data!.detail!.province!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  void setPersonTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    personCityName = personAddressInquiryResponseData!.data!.detail?.townShip ??
        personAddressInquiryResponseData!.data!.detail?.localityName;
    if (personCityName != null && personAddressInquiryResponseData!.data!.detail!.province != null) {
      isPersonAddressInquirySuccessful = true;
      personTownshipController.text = personAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isPersonTownshipValid = true;
      personCityController.text = personCityName ?? '';
      isPersonCityValid = true;
      personProvinceController.text = personAddressInquiryResponseData!.data!.detail!.province ?? '';
      isPersonProvinceValid = true;
      final detail = personAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        personLastStreetController =
            TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isPersonLastStreetValid = true;
        personSecondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isPersonSecondLastStreetValid = true;
      } else {
        personLastStreetController.text = '';
        personSecondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        personUnitController = TextEditingController(text: detail?.sideFloor);
        isPersonUnitValid = true;
      } else {
        personUnitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      personPlaqueController = TextEditingController(text: (plaqueInt).toString());
      isPersonPlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
      );
    }
  }

  void validatePersonAddressPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (personPostalCodeController.text.length == Constants.postalCodeLength) {
      isPersonPostalCodeValid = true;
    } else {
      isPersonPostalCodeValid = false;
      isValid = false;
    }
    if (personLastStreetController.text.trim().length > 3) {
      isPersonLastStreetValid = true;
    } else {
      isPersonLastStreetValid = false;
      isValid = false;
    }
    if (personSecondLastStreetController.text.trim().length > 3) {
      isPersonSecondLastStreetValid = true;
    } else {
      isPersonSecondLastStreetValid = false;
      isValid = false;
    }
    if (personPlaqueController.text.trim().isNotEmpty) {
      isPersonPlaqueValid = true;
    } else {
      isPersonPlaqueValid = false;
      isValid = false;
    }
    if (personUnitController.text.trim().isNotEmpty) {
      isPersonUnitValid = true;
    } else {
      isPersonUnitValid = false;
      isValid = false;
    }
    if (personCityController.text.trim().isNotEmpty) {
      isPersonCityValid = true;
    } else {
      isPersonCityValid = false;
      isValid = false;
    }
    if (personTownshipController.text.trim().isNotEmpty) {
      isPersonTownshipValid = true;
    } else {
      isPersonTownshipValid = false;
      isValid = false;
    }
    if (personProvinceController.text.trim().isNotEmpty) {
      isPersonProvinceValid = true;
    } else {
      isPersonProvinceValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      if (isApplicantSameGuarantee) {
        _startProcess();
      } else {
        AppUtil.nextPageController(pageController, isClosed);
      }
    }
  }

  /// Validates the customer's postal code and initiates an inquiry if valid.
  void validateCustomerPostalCodeInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      isCustomerPostalCodeValid = true;
      _customerPostalCodeInquiryRequest();
    } else {
      isCustomerPostalCodeValid = false;
      customerPostalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  /// Performs a postal code inquiry to retrieve address information for a customer.
  void _customerPostalCodeInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = customerPostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isCustomerAddressInquirySuccessful = false;
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
    if (customerAddressInquiryResponseData != null && customerCityName != null) {
      return customerCityName!;
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
    customerCityName = customerAddressInquiryResponseData!.data!.detail?.townShip ??
        customerAddressInquiryResponseData!.data!.detail?.localityName;
    if (customerCityName != null && customerAddressInquiryResponseData!.data!.detail!.province != null) {
      isCustomerAddressInquirySuccessful = true;
      customerTownshipController.text = customerAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isCustomerTownshipValid = true;
      customerCityController.text = customerCityName ?? '';
      isCustomerCityValid = true;
      customerProvinceController.text = customerAddressInquiryResponseData!.data!.detail!.province ?? '';
      isCustomerProvinceValid = true;
      final detail = customerAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        customerLastStreetController =
            TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isCustomerLastStreetValid = true;
        customerSecondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isCustomerSecondLastStreetValid = true;
      } else {
        customerLastStreetController.text = '';
        customerSecondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        customerUnitController = TextEditingController(text: detail?.sideFloor);
        isCustomerUnitValid = true;
      } else {
        customerUnitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      customerPlaqueController = TextEditingController(text: (plaqueInt).toString());
      isCustomerPlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
      );
    }
  }

  void validateCustomerAddressPage() {

    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      isCustomerPostalCodeValid = true;
    } else {
      isCustomerPostalCodeValid = false;
      isValid = false;
    }
    if (customerLastStreetController.text.trim().length > 3) {
      isCustomerLastStreetValid = true;
    } else {
      isCustomerLastStreetValid = false;
      isValid = false;
    }
    if (customerSecondLastStreetController.text.trim().length > 3) {
      isCustomerSecondLastStreetValid = true;
    } else {
      isCustomerSecondLastStreetValid = false;
      isValid = false;
    }
    if (customerPlaqueController.text.trim().isNotEmpty) {
      isCustomerPlaqueValid = true;
    } else {
      isCustomerPlaqueValid = false;
      isValid = false;
    }
    if (customerUnitController.text.trim().isNotEmpty) {
      isCustomerUnitValid = true;
    } else {
      isCustomerUnitValid = false;
      isValid = false;
    }
    if (customerCityController.text.trim().isNotEmpty) {
      isCustomerCityValid = true;
    } else {
      isCustomerCityValid = false;
      isValid = false;
    }
    if (customerTownshipController.text.trim().isNotEmpty) {
      isCustomerTownshipValid = true;
    } else {
      isCustomerTownshipValid = false;
      isValid = false;
    }
    if (customerProvinceController.text.trim().isNotEmpty) {
      isCustomerProvinceValid = true;
    } else {
      isCustomerProvinceValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _startProcess();
    }
  }

  /// Starts the military guarantee process.
  void _startProcess() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    BPMSAddressValue personAddress;
    BPMSAddressValue applicantAddress;

    personAddress = BPMSAddressValue(
      postalCode: int.parse(personPostalCodeController.text),
      province: personProvinceController.text,
      township: personTownshipController.text,
      city: personCityController.text,
      village: personAddressInquiryResponseData!.data!.detail?.village ?? '',
      localityName: personAddressInquiryResponseData!.data!.detail?.localityName ?? '',
      lastStreet: personLastStreetController.text,
      secondLastStreet: personSecondLastStreetController.text,
      alley: '',
      plaque: int.tryParse(personPlaqueController.text) ?? 1,
      unit: int.tryParse(personUnitController.text) ?? 0,
      description: personAddressInquiryResponseData!.data!.detail?.description ?? '',
      latitude: null,
      longitude: null,
    );

    final MilitaryGuaranteeStartProcessVariables militaryGuaranteeVariables = MilitaryGuaranteeStartProcessVariables(
      customerNumber: mainController.authInfoData!.customerNumber!,
      isApplicantSameGuarantee: isApplicantSameGuarantee,
    );

    if (isApplicantSameGuarantee) {
      militaryGuaranteeVariables.applicantAddress = BPMSAddress(value: personAddress);

      militaryGuaranteeVariables.guaranteeNationalCode = '';
      militaryGuaranteeVariables.guaranteeMobile = '';
      militaryGuaranteeVariables.guaranteeFirstName = '';
      militaryGuaranteeVariables.guaranteeLastName = '';
      militaryGuaranteeVariables.guaranteeFatherName = '';
      militaryGuaranteeVariables.guaranteeBookNumber = '';
      militaryGuaranteeVariables.guaranteeOfficeName = '';
      militaryGuaranteeVariables.guaranteeAddress = BPMSAddress(
        value: BPMSAddressValue(
            province: '',
            township: '',
            city: '',
            village: '',
            localityName: '',
            lastStreet: '',
            secondLastStreet: '',
            alley: '',
            plaque: 0,
            unit: 0,
            postalCode: 0,
            longitude: 0,
            latitude: 0,
            description: ''),
      );
    } else {
      applicantAddress = BPMSAddressValue(
        postalCode: int.parse(customerPostalCodeController.text),
        province: customerProvinceController.text,
        township: customerTownshipController.text,
        city: customerCityController.text,
        village: customerAddressInquiryResponseData!.data!.detail?.village ?? '',
        localityName: customerAddressInquiryResponseData!.data!.detail?.localityName ?? '',
        lastStreet: customerLastStreetController.text,
        secondLastStreet: customerSecondLastStreetController.text,
        alley: '',
        plaque: int.tryParse(customerPlaqueController.text) ?? 1,
        unit: int.tryParse(customerUnitController.text) ?? 0,
        description: customerAddressInquiryResponseData!.data!.detail?.description ?? '',
        latitude: null,
        longitude: null,
      );
      militaryGuaranteeVariables.guaranteeNationalCode = personNationalCodeController.text.trim();
      militaryGuaranteeVariables.guaranteeBirthDate = DateConverterUtil.getTimestampFromJalali(
        date: personBirthDateController.text.trim(),
        extendDuration: const Duration(hours: 2),
      );
      militaryGuaranteeVariables.guaranteeMobile = personMobileController.text.trim();
      militaryGuaranteeVariables.guaranteeFirstName = personFirstName!.trim();
      militaryGuaranteeVariables.guaranteeLastName = personLastName!.trim();
      militaryGuaranteeVariables.guaranteeFatherName = checkPersonalInfoResponseData!.data!.fatherName!;
      militaryGuaranteeVariables.guaranteeBookNumber = checkPersonalInfoResponseData!.data!.birthCertificateNumber!;
      militaryGuaranteeVariables.guaranteeOfficeName = checkPersonalInfoResponseData!.data!.officeName!;
      militaryGuaranteeVariables.guaranteeAddress = BPMSAddress(value: personAddress);
      militaryGuaranteeVariables.applicantAddress = BPMSAddress(value: applicantAddress);
    }

    final StartProcessRequest startProcessRequest = StartProcessRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: 'MilitaryLG',
      businessKey: '1234567890',
      returnNextTasks: false,
      variables: militaryGuaranteeVariables,
    );

    isLoading = true;
    update();
    BPMSServices.startProcess(
      startProcessRequest: startProcessRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final StartProcessResponse response, int _)):
          if (isApplicantSameGuarantee) {
            AppUtil.gotoPageController(pageController: pageController, page: 7, isClosed: isClosed);
          } else {
            AppUtil.nextPageController(pageController, isClosed);
          }

          startProcessResponse = response;
          update();
          Future.delayed(Constants.duration200, () {
            getApplicantTaskListRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the applicant's task list.
  void getApplicantTaskListRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final ApplicantTaskListRequest applicantTaskListRequest = ApplicantTaskListRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      processInstanceId: startProcessResponse!.data!.processInstanceId!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
    );

    BPMSServices.getApplicantTaskList(
      applicantTaskListRequest: applicantTaskListRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ApplicantTaskListResponse response, int _)):
          // TODO refactor this

          applicantTaskListResponse = response;
          if (applicantTaskListResponse!.data!.taskList!.isNotEmpty) {
            final TaskListController taskListController = Get.find(tag: taskListControllerTag);
            taskListController.taskList = applicantTaskListResponse!.data!.taskList!;
            taskListController.update();
            update();
            Future.delayed(Constants.duration200, () {
              AppUtil.nextPageController(pageController, isClosed);
            });
          } else {
            Get.back(closeOverlays: true);
            Future.delayed(Constants.duration200, () {
              SnackBarUtil.showSuccessSnackBar(locale.documents_registered_successfully);
            });
          }
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

  void refreshTaskList() {
    AppUtil.previousPageController(pageController, isClosed);
    Future.delayed(Constants.duration200, () {
      getApplicantTaskListRequest();
    });
  }

  /// Handles the back press action.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 7 ||
          pageController.page == 8) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        if (pageController.page == 5 && isApplicantSameGuarantee) {
          AppUtil.gotoPageController(pageController: pageController, page: 2, isClosed: isClosed);
        } else {
          AppUtil.previousPageController(pageController, isClosed);
        }
      }
    }
  }

  void clearPersonPostalCodeTextField() {
    personPostalCodeController.clear();
    isPersonAddressInquirySuccessful = false;
    resetPersonAddressInputs();
  }

  /// Resets the person's address input fields and their validation states.
  void resetPersonAddressInputs() {
    personTownshipController.clear();
    isPersonTownshipValid = true;

    personLastStreetController.clear();
    isPersonLastStreetValid = true;

    personSecondLastStreetController.clear();
    isPersonSecondLastStreetValid = true;

    personPlaqueController.clear();
    isPersonPlaqueValid = true;

    personUnitController.clear();
    isPersonUnitValid = true;

    update();
  }

  void clearCustomerPostalCodeTextField() {
    customerPostalCodeController.clear();
    isCustomerAddressInquirySuccessful = false;
    resetCustomerAddressInputs();
  }

  /// Resets the customer's address input fields and their validation states.
  void resetCustomerAddressInputs() {
    customerTownshipController.clear();
    isCustomerTownshipValid = true;

    customerLastStreetController.clear();
    isCustomerLastStreetValid = true;

    customerSecondLastStreetController.clear();
    isCustomerSecondLastStreetValid = true;

    customerPlaqueController.clear();
    isCustomerPlaqueValid = true;

    customerUnitController.clear();
    isCustomerUnitValid = true;

    update();
  }
}
