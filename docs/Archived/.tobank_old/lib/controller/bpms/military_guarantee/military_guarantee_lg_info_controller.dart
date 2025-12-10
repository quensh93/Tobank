import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/address/request/address_inquiry_request_data.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../model/bpms/common/bpms_address.dart';
import '../../../model/bpms/common/bpms_address_value.dart';
import '../../../model/bpms/military_guarantee/request/complete_lg_info_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/update_address_services.dart';
import '../../../ui/common/date_selector_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/digit_to_word.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MilitaryGuaranteeLGInfoController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  int amount = 0;

  TextEditingController amountController = TextEditingController();
  bool isAmountValid = true;

  TextEditingController militaryLetterCodeController = TextEditingController();

  bool isMilitaryLetterCodeValid = true;

  TextEditingController issueDateController = TextEditingController();

  bool isIssueDateValid = true;

  TextEditingController dueDateController = TextEditingController();

  bool isDueDateValid = true;

  String startDateString = '';
  String endDateString = '';

  String initDateIssueString = '';
  String initDateDueString = '';

  String dateJalaliString = '';

  TextEditingController beneficiaryNameController = TextEditingController();

  bool isBeneficiaryNameValid = true;

  TextEditingController nnCodeController = TextEditingController();

  bool isNNCodeValid = true;

  TextEditingController beneficiaryMobileController = TextEditingController();

  bool isBeneficiaryMobileValid = true;

  TextEditingController beneficiaryPostalCodeController = TextEditingController();
  bool isBeneficiaryPostalCodeValid = true;

  bool isPostalCodeLoading = false;
  String beneficiaryPostalCodeErrorMessage = '';

  AddressInquiryResponseData? beneficiaryAddressInquiryResponseData;

  String? cityName;

  TextEditingController beneficiaryProvinceController = TextEditingController();
  bool isBeneficiaryProvinceValid = true;

  TextEditingController beneficiaryCityController = TextEditingController();
  bool isBeneficiaryCityValid = true;

  TextEditingController beneficiaryTownshipController = TextEditingController();
  bool isBeneficiaryTownshipValid = true;

  TextEditingController beneficiaryLastStreetController = TextEditingController();
  bool isBeneficiaryLastStreetValid = true;

  TextEditingController beneficiarySecondLastStreetController = TextEditingController();
  bool isBeneficiarySecondLastStreetValid = true;

  TextEditingController beneficiaryPlaqueController = TextEditingController();
  bool isBeneficiaryPlaqueValid = true;

  TextEditingController beneficiaryUnitController = TextEditingController();
  bool isBeneficiaryUnitValid = true;

  bool isBeneficiaryAddressInquirySuccessful = false;

  MilitaryGuaranteeLGInfoController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.value?.subValue != null) {
        switch (formField.id) {
          case 'lGAmount':
            validateAmountValue((formField.value!.subValue! as double).toInt().toString());
            break;
          case 'letterNumber':
            militaryLetterCodeController.text = formField.value!.subValue!;
            break;
          case 'letterDate':
            dateJalaliString =
                DateConverterUtil.getDibaliteDateFromMilisecondsTimestamp(formField.value!.subValue! as int)
                    .replaceAll('-', '/');
            issueDateController.text = dateJalaliString;
            initDateIssueString = dateJalaliString;
            break;
          case 'lGDueDate':
            dateJalaliString =
                DateConverterUtil.getDibaliteDateFromMilisecondsTimestamp(formField.value!.subValue! as int)
                    .replaceAll('-', '/');
            dueDateController.text = dateJalaliString;
            initDateDueString = dateJalaliString;
            break;
          case 'beneficiaryName':
            beneficiaryNameController.text = formField.value!.subValue!;
            break;
          case 'beneficiaryNationalCode':
            nnCodeController.text = formField.value!.subValue!;
            break;
          case 'beneficiaryPhone':
            beneficiaryMobileController.text = formField.value!.subValue!;
            break;
          case 'beneficiaryAddress':
            final addressValue = formField.value!.subValue! as Map<String, dynamic>;

            beneficiaryPostalCodeController.text = addressValue['postalCode'];
            break;
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    final DateTime dateTime = DateTime.now();
    initDateIssueString =
        DateConverterUtil.getDateJalali(gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime));
    initDateDueString = DateConverterUtil.getDateJalali(gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime));

    startDateString = DateConverterUtil.getStartOfYearJalali(
        gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime.subtract(const Duration(days: 2 * 365))));
    endDateString = DateConverterUtil.getEndOfYearJalali(
        gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime.add(const Duration(days: 2 * 365))));
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
  }

  void validateAmountValue(String value) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      amountController.text = AppUtil.formatMoney(value);
      amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
    }
    if (value != '') {
      amount = int.parse(value.replaceAll(',', ''));
    } else {
      amount = 0;
    }
    update();
  }

  void showSelectFirstDateDialog() {
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
            initDateString: initDateIssueString,
            startDateString: startDateString,
            endDateString: endDateString,
            title: locale.military_letter_issue_date,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              issueDateController.text = dateJalaliString;
              initDateIssueString = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
  }

  void showSelectSecondDateDialog() {
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
            initDateString: initDateDueString,
            startDateString: startDateString,
            endDateString: endDateString,
            title: locale.military_letter_due_date,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              dueDateController.text = dateJalaliString;
              initDateDueString = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
  }

  void validateLGInfoPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (amount > 0) {
      isAmountValid = true;
    } else {
      isAmountValid = false;
      isValid = false;
    }

    if (militaryLetterCodeController.text.trim().isNotEmpty) {
      isMilitaryLetterCodeValid = true;
    } else {
      isMilitaryLetterCodeValid = false;
      isValid = false;
    }

    if (issueDateController.text.trim().isNotEmpty) {
      isIssueDateValid = true;
    } else {
      isIssueDateValid = false;
      isValid = false;
    }

    if (dueDateController.text.trim().isNotEmpty) {
      isDueDateValid = true;
    } else {
      isDueDateValid = false;
      isValid = false;
    }

    update();
    if (isValid) {
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void validateBeneficiaryPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (beneficiaryNameController.text.trim().isNotEmpty) {
      isBeneficiaryNameValid = true;
    } else {
      isBeneficiaryNameValid = false;
      isValid = false;
    }

    if (nnCodeController.text.trim().isNotEmpty && nnCodeController.text.trim().length == 11) {
      isNNCodeValid = true;
    } else {
      isNNCodeValid = false;
      isValid = false;
    }

    if (beneficiaryMobileController.text.trim().isNotEmpty) {
      isBeneficiaryMobileValid = true;
    } else {
      isBeneficiaryMobileValid = false;
      isValid = false;
    }

    update();
    if (isValid) {
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void validatePostalCodeInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (beneficiaryPostalCodeController.text.length == Constants.postalCodeLength) {
      isBeneficiaryPostalCodeValid = true;
      _beneficiaryPostalCodeInquiryRequest();
    } else {
      isBeneficiaryPostalCodeValid = false;
      beneficiaryPostalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  /// Performs a postal code inquiry for the beneficiary's address.
  void _beneficiaryPostalCodeInquiryRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = beneficiaryPostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isBeneficiaryAddressInquirySuccessful = false;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isPostalCodeLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          beneficiaryAddressInquiryResponseData = response;
          setCustomerTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          beneficiaryAddressInquiryResponseData = null;
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
    if (beneficiaryAddressInquiryResponseData != null && cityName != null) {
      return cityName!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  String getCustomerProvince() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (beneficiaryAddressInquiryResponseData != null &&
        beneficiaryAddressInquiryResponseData!.data!.detail!.province != null) {
      return beneficiaryAddressInquiryResponseData!.data!.detail!.province!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  void setCustomerTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName = beneficiaryAddressInquiryResponseData!.data!.detail?.townShip ??
        beneficiaryAddressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && beneficiaryAddressInquiryResponseData!.data!.detail!.province != null) {
      isBeneficiaryAddressInquirySuccessful = true;
      beneficiaryTownshipController.text = beneficiaryAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isBeneficiaryTownshipValid = true;
      beneficiaryCityController.text = cityName ?? '';
      isBeneficiaryCityValid = true;
      beneficiaryProvinceController.text = beneficiaryAddressInquiryResponseData!.data!.detail!.province ?? '';
      isBeneficiaryProvinceValid = true;
      final detail = beneficiaryAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        beneficiaryLastStreetController =
            TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isBeneficiaryLastStreetValid = true;
        beneficiarySecondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isBeneficiarySecondLastStreetValid = true;
      } else {
        beneficiaryLastStreetController.text = '';
        beneficiarySecondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        beneficiaryUnitController = TextEditingController(text: detail?.sideFloor);
        isBeneficiaryUnitValid = true;
      } else {
        beneficiaryUnitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      beneficiaryPlaqueController = TextEditingController(text: (plaqueInt).toString());
      isBeneficiaryPlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
      );
    }
  }

  void validateBeneficiaryAddressPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (beneficiaryPostalCodeController.text.length == Constants.postalCodeLength) {
      isBeneficiaryPostalCodeValid = true;
    } else {
      isBeneficiaryPostalCodeValid = false;
      isValid = false;
    }
    if (beneficiaryLastStreetController.text.trim().length > 3) {
      isBeneficiaryLastStreetValid = true;
    } else {
      isBeneficiaryLastStreetValid = false;
      isValid = false;
    }
    if (beneficiarySecondLastStreetController.text.trim().length > 3) {
      isBeneficiarySecondLastStreetValid = true;
    } else {
      isBeneficiarySecondLastStreetValid = false;
      isValid = false;
    }
    if (beneficiaryPlaqueController.text.trim().isNotEmpty) {
      isBeneficiaryPlaqueValid = true;
    } else {
      isBeneficiaryPlaqueValid = false;
      isValid = false;
    }
    if (beneficiaryUnitController.text.trim().isNotEmpty) {
      isBeneficiaryUnitValid = true;
    } else {
      isBeneficiaryUnitValid = false;
      isValid = false;
    }
    if (beneficiaryCityController.text.trim().isNotEmpty) {
      isBeneficiaryCityValid = true;
    } else {
      isBeneficiaryCityValid = false;
      isValid = false;
    }
    if (beneficiaryTownshipController.text.trim().isNotEmpty) {
      isBeneficiaryTownshipValid = true;
    } else {
      isBeneficiaryTownshipValid = false;
      isValid = false;
    }
    if (beneficiaryProvinceController.text.trim().isNotEmpty) {
      isBeneficiaryProvinceValid = true;
    } else {
      isBeneficiaryProvinceValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _completeLGInfoTaskRequest();
    }
  }

  /// Completes the LG info task by sending a request to the backend.
  void _completeLGInfoTaskRequest() {
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
      taskData: CompleteLGInfoTaskData(
        lGAmount: amount.toDouble(),
        letterNumber: militaryLetterCodeController.text.trim(),
        letterDate: DateConverterUtil.getTimestampFromJalali(
          date: issueDateController.text.trim(),
          extendDuration: const Duration(hours: 2),
        ),
        lGDueDate: DateConverterUtil.getTimestampFromJalali(
          date: dueDateController.text.trim(),
          extendDuration: const Duration(hours: 2),
        ),
        beneficiaryName: beneficiaryNameController.text.trim(),
        beneficiaryNationalCode: nnCodeController.text.trim(),
        beneficiaryPhone: beneficiaryMobileController.text.trim(),
        beneficiaryAddress: BPMSAddress(
          value: BPMSAddressValue(
              postalCode: int.parse(beneficiaryPostalCodeController.text),
              province: beneficiaryProvinceController.text,
              township: beneficiaryTownshipController.text,
              city: beneficiaryCityController.text,
              village: beneficiaryAddressInquiryResponseData!.data!.detail?.village ?? '',
              localityName: beneficiaryAddressInquiryResponseData!.data!.detail?.localityName ?? '',
              lastStreet: beneficiaryLastStreetController.text,
              secondLastStreet: beneficiarySecondLastStreetController.text,
              alley: '',
              plaque: int.tryParse(beneficiaryPlaqueController.text) ?? 1,
              unit: int.tryParse(beneficiaryUnitController.text) ?? 0,
              description: beneficiaryAddressInquiryResponseData!.data!.detail?.description ?? '',
              latitude: null,
              longitude: null),
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

  /// Handles the back press action,
  /// navigating to the previous page or closing the current screen.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void clearAmountTextField() {
    amountController.clear();
    amount = 0;
    update();
  }
}
