import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/credit_card_facility/request/credit_card_facility_check_deposit_request_data.dart';
import '../../../model/bpms/credit_card_facility/request/credit_card_facility_start_process_variables_data.dart';
import '../../../model/bpms/credit_card_facility/response/credit_card_facility_access_response_data.dart';
import '../../../model/bpms/credit_card_facility/response/credit_card_facility_check_deposit_response_data.dart';
import '../../../model/bpms/credit_card_facility/response/credit_card_facility_deposit_list_response_data.dart';
import '../../../model/bpms/enum_value_data.dart';
import '../../../model/bpms/request/applicant_task_list_request_data.dart';
import '../../../model/bpms/request/check_personal_info_request_data.dart';
import '../../../model/bpms/request/process_start_form_data_request_data.dart';
import '../../../model/bpms/request/start_process_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/process_start_form_data_response_data.dart';
import '../../../model/bpms/response/start_process_response_data.dart';
import '../../../model/common/error_response_data.dart';
import '../../../model/other/response/other_item_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/credit_card_services.dart';
import '../../../service/other_services.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../facility/facility_controller.dart';
import '../../main/main_controller.dart';
import '../task_list_controller.dart';

class CreditCardController extends GetxController {
  ScrollController scrollbarBankRuleController = ScrollController();
  ScrollController scrollbarRuleController = ScrollController();
  MainController mainController = Get.find();
  FacilityController facilityController = Get.find();

  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings webViewSettings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: false,
    cacheMode: CacheMode.LOAD_NO_CACHE,
    transparentBackground: true,
    supportZoom: false,
  );
  int progress = 0;

  OtherItemData? otherItemData;

  bool isRuleChecked = false;

  bool isLoading = false;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  TextEditingController branchNameController = TextEditingController();

  bool isCreditCardAmountValid = true;

  bool isCreditCardPaymentCountValid = true;

  EnumValue? selectedCreditCardAmountData;

  EnumValue? selectedCreditCardPaymentCountData;

  ProcessStartFormDataResponse? processStartFormDataResponse;

  List<EnumValue> creditCardAmountDataList = [];

  List<EnumValue> creditCardPaymentCountDataList = [];

  StartProcessResponse? startProcessResponse;

  ApplicantTaskListResponse? applicantTaskListResponse;

  static const String taskListControllerTag = 'CreditCardTasksTag';

  List<DepositList> depositList = [];

  DepositList? selectedDeposit;

  List<LoanData> loanDataList = [];

  int? averageDepositAmount = 0;

  @override
  void onInit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    super.onInit();
    branchNameController.text = locale.tehran_central_branch;
    Get.put(TaskListController(refreshCallback: (_) => refreshTaskList()), tag: taskListControllerTag);
    checkAccessRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<TaskListController>(force: true, tag: taskListControllerTag);
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  String getConditionUrl() {
    return 'https://tobank.ir/app/card-facility-conditions';
  }

  /// Retrieves credit card rules and handles the response
  Future<void> getCreditCardRulesRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getCreditCardRuleRequest().then((result) {
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

  void setChecked(bool ruleChecked) {
    isRuleChecked = ruleChecked;
    update();
  }

  void validateRules() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isRuleChecked) {
      _getStartFormData();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  String getCustomerInfo() {
    if (mainController.authInfoData!.firstName != null && mainController.authInfoData!.lastName != null) {
      return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    } else {
      return '';
    }
  }

  String getCustomerNationalCode() {
    return mainController.authInfoData!.nationalCode!;
  }

  void validateCustomerCheckPage() {
    bool isValid = true;
    AppUtil.hideKeyboard(Get.context!);
    if (selectedCreditCardAmountData != null) {
      isCreditCardAmountValid = true;
    } else {
      isCreditCardAmountValid = false;
      isValid = false;
    }
    if (selectedCreditCardPaymentCountData != null) {
      isCreditCardPaymentCountValid = true;
    } else {
      isCreditCardPaymentCountValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _checkCustomerCreditRequest();
    }
  }

  /// Checks customer credit and handles the response.
  void _checkCustomerCreditRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CheckPersonalInfoRequestData checkPersonalInfoRequestData = CheckPersonalInfoRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      birthDate: DateConverterUtil.getTimestampFromJalali(
          date: mainController.authInfoData!.birthdayDate!, extendDuration: const Duration(hours: 2)),
      nationalIdTrackingNumber: null,
      checkIdentificationData: false,
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
          _startProcess();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void validateFirstPage() {
    AppUtil.nextPageController(pageController, isClosed);
  }

  void setSelectedCreditCardAmountData(EnumValue? newValue) {
    selectedCreditCardAmountData = newValue;
    update();
  }

  void setSelectedCreditCardPaymentCountData(EnumValue? newValue) {
    selectedCreditCardPaymentCountData = newValue;
    update();
  }

  /// Retrieves start form data for a process and handles the response.
  void _getStartFormData() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final processDefinitions =
        facilityController.processDefinitions.firstWhereOrNull((element) => element.key == 'CreditCardReception');
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
          _handleStartFormDataResponse(processStartFormDataResponse!);
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

  void _handleStartFormDataResponse(ProcessStartFormDataResponse processStartFormDataResponse) {
    selectedCreditCardAmountData = null;
    selectedCreditCardPaymentCountData = null;
    creditCardAmountDataList = [];
    creditCardPaymentCountDataList = [];
    for (final formField in processStartFormDataResponse.data!.formFields!) {
      if (formField.id == 'requestAmount') {
        creditCardAmountDataList = formField.enumValues!;
        if (int.tryParse(creditCardAmountDataList.first.key) != null) {
          creditCardAmountDataList.sort((a, b) {
            return int.parse(a.key).compareTo(int.parse(b.key));
          });
        }
      }
      if (formField.id == 'paymentCount') {
        creditCardPaymentCountDataList = formField.enumValues!;
      }
    }
    update();
  }

  /// Initiates a request to start a process using the [BPMSServices] class.
  void _startProcess() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final StartProcessRequest startProcessRequest = StartProcessRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: 'CreditCardReception',
      businessKey: '1234567890',
      returnNextTasks: false,
      variables: CreditCardFacilityStartProcessVariables(
        branchCode: '110',
        requestAmount: selectedCreditCardAmountData!.key,
        paymentCount: selectedCreditCardPaymentCountData!.key,
        customerNumber: mainController.authInfoData!.customerNumber!,
      ),
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
          AppUtil.nextPageController(pageController, isClosed);
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

  /// Retrieves the applicant task list and handles the response.
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
            AppUtil.nextPageController(pageController, isClosed);
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

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 2 ||
          pageController.page == 3 ||
          pageController.page == 5 ||
          pageController.page == 6) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  /// Checks access for credit card facility and handles the response.
  void checkAccessRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CreditCardServices.creditCardFacilityCheckAccessRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CreditCardFacilityAccessResponseData _, int _)):
          _getDepositListRequest();
        case Failure(exception: final ApiException<ErrorResponseData> apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showPositiveDialogMessage(
              buildContext: Get.context!,
              description: apiException.errorResponse!.message ?? '',
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
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

  /// Retrieves the deposit list for credit card facility and handles the response.
  void _getDepositListRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    CreditCardServices.creditCardFacilityDepositListRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CreditCardFacilityDepositListResponseData response, int _)):
          depositList = response.data?.depositList ?? [];
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          DialogUtil.showPositiveDialogMessage(
            buildContext: Get.context!,
            description: apiException.displayMessage,
            positiveMessage: locale.understood_button,
            positiveFunction: () {
              Get.back();
              Get.back();
            },
          );
      }
    });
  }

  void setSelectedDeposit(DepositList deposit) {
    selectedDeposit = deposit;
    update();
  }

  void validateSelectDepositPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDeposit != null) {
      _checkDepositRequest();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.select_one_of_deposit,
      );
    }
  }

  /// Checks deposit information for credit card facility and handles the response.
  void _checkDepositRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CreditCardFacilityCheckDepositRequestData creditCardFacilityCheckDepositRequestData =
        CreditCardFacilityCheckDepositRequestData(
      depositNumber: selectedDeposit!.depositNumber,
    );

    isLoading = true;
    update();

    CreditCardServices.checkDepositRequest(
      creditCardFacilityCheckDepositRequestData: creditCardFacilityCheckDepositRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CreditCardFacilityCheckDepositResponseData response, int _)):
          if (response.success == true) {
            loanDataList = response.data!.loanData ?? [];
            averageDepositAmount = response.data!.averageDepositAmount ?? 0;
            // if (averageDepositAmount! < 129000000) {
            //   DialogUtil.showPositiveDialogMessage(
            //     buildContext: Get.context!,
            //     description:
            //         'کاربر گرامی، حداقل درخواست کارت اعتباری، ۱۰ میلیون تومان می‌باشد و میانگین موجودی شما کمتر از حداقل مجاز بوده و امکان ثبت درخواست را ندارید',
            //     positiveMessage: 'متوجه شدم',
            //     positiveFunction: () {
            //       Get.back();
            //     },
            //   );
            // } else {
            //   _showConfirmLoanAmountDialog();
            // }
            bool showDisabledDialog = true;
            for (final loanData in loanDataList) {
              if (loanData.amount! > 0) {
                showDisabledDialog = false;
                break;
              }
            }
            if (showDisabledDialog) {
              DialogUtil.showPositiveDialogMessage(
                buildContext: Get.context!,
                description:
                    locale.deposit_balance_not_eligible_to_receive_the_facility,
                positiveMessage: locale.understood_button,
                positiveFunction: () {
                  Get.back();
                  Get.back();
                },
              );
            } else {
              _showConfirmLoanAmountDialog();
            }
          } else {
            DialogUtil.showPositiveDialogMessage(
              buildContext: Get.context!,
              description: response.message ?? '',
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
                Get.back();
              },
            );
          }
        case Failure(exception: final ApiException apiException):
          DialogUtil.showPositiveDialogMessage(
            buildContext: Get.context!,
            description: apiException.displayMessage,
            positiveMessage: locale.understood_button,
            positiveFunction: () {
              Get.back();
            },
          );
      }
    });
  }

  void _showConfirmLoanAmountDialog() {
    DialogUtil.showCreditCardLoanAmountDialog(
      buildContext: Get.context!,
      loanDataList: loanDataList,
      averageDepositAmount: averageDepositAmount,
      confirmFunction: () {
        Get.back();
        AppUtil.nextPageController(pageController, isClosed);
        Timer(const Duration(milliseconds: 500), () {
          getCreditCardRulesRequest();
        });
      },
      backFunction: () {
        Get.back();
      },
    );
  }
}
