import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/credit_card_facility/request/complete_guarantor_info_task_data.dart';
import '../../../model/bpms/request/check_personal_info_request_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/common/date_selector_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CreditCardAddGuaranteeController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  TextEditingController mobileGuaranteeController = TextEditingController();

  bool isGuaranteeMobileValid = true;

  TextEditingController birthdayDateGuaranteeController = TextEditingController();

  bool isBirthdayGuaranteeValid = true;

  TextEditingController nationalCodeGuaranteeController = TextEditingController();

  bool isNationalCodeGuaranteeValid = true;

  String initDateString = '';
  String dateJalaliString = '';

  CreditCardAddGuaranteeController({required this.task, required this.taskData});

  @override
  void onInit() {
    initDateString = AppUtil.twentyYearsBeforeNow();
    super.onInit();
  }

  /// Hide keyboard & show date picker dialog modal
  void showSelectDateDialog() {
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
        backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initDateString,
            title: locale.birthdate_hint,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              birthdayDateGuaranteeController.text = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
  }

  /// Validates the guarantee information entered by the user,
  /// including national code, birthday, and mobile number.
  /// displays a confirmation dialog if valid.
  void validateGuaranteeCheck() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (nationalCodeGuaranteeController.text.length == Constants.nationalCodeLength &&
        AppUtil.validateNationalCode(nationalCodeGuaranteeController.text)) {
      isNationalCodeGuaranteeValid = true;
    } else {
      isNationalCodeGuaranteeValid = false;
      isValid = false;
    }
    if (birthdayDateGuaranteeController.text.isNotEmpty) {
      isBirthdayGuaranteeValid = true;
    } else {
      isBirthdayGuaranteeValid = false;
      isValid = false;
    }
    if (mobileGuaranteeController.text.length == Constants.mobileNumberLength &&
        mobileGuaranteeController.text.startsWith(Constants.mobileStartingDigits)) {
      isGuaranteeMobileValid = true;
    } else {
      isGuaranteeMobileValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      DialogUtil.showGuaranteeDialog(
        buildContext: Get.context!,
        positiveFunction: () {
          Get.back();
          _checkPersonalInfoGuaranteeRequest();
        },
        negativeFunction: () {
          Get.back();
        },
        description:
            locale.guarantor_confirmation_description,
        confirmMessage: locale.confirm_message,
        cancelMessage: locale.close,
        copyFunction: () {
          var text = locale.tobank_address_download_link;
          Clipboard.setData( ClipboardData(text: text));
          SnackBarUtil.showInfoSnackBar(locale.copy_snackbar_message);
        },
        shareFunction: () {
          var text = locale.tobank_address_download_link;
          Share.share(text, subject: locale.share_subject);
        },
      );
    }
  }

  /// Checks personal information for a guarantee request and handles the response.
  void _checkPersonalInfoGuaranteeRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CheckPersonalInfoRequestData checkPersonalInfoRequestData = CheckPersonalInfoRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: nationalCodeGuaranteeController.text,
      birthDate: DateConverterUtil.getTimestampFromJalali(
          date: birthdayDateGuaranteeController.text, extendDuration: const Duration(hours: 2)),
      nationalIdTrackingNumber: null,
      checkIdentificationData: true,
      checkBadCredit: true,
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
        case Success(value: _):
          _completeGuaranteeInfo();
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showPositiveDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  /// initiates a request to complete the guarantee information using the [BPMSServices] class.
  /// and handles the response
  void _completeGuaranteeInfo() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteGuarantorInfoTaskData(
        guarantorBirthDate: DateConverterUtil.getTimestampFromJalali(
            date: birthdayDateGuaranteeController.text, extendDuration: const Duration(hours: 2)),
        guarantorNationalId: nationalCodeGuaranteeController.text,
        guarantorMobile: mobileGuaranteeController.text,
        personalityType: '0',
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
}
