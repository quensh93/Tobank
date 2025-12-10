import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/enum_value_data.dart';
import '../../../model/bpms/request/applicant_task_list_request_data.dart';
import '../../../model/bpms/request/check_personal_info_request_data.dart';
import '../../../model/bpms/request/get_average_minimum_deposit_amount_for_loan_request_data.dart';
import '../../../model/bpms/request/process_start_form_data_request_data.dart';
import '../../../model/bpms/request/start_process_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_average_minimum_deposit_amount_for_loan_response_data.dart';
import '../../../model/bpms/response/process_start_form_data_response_data.dart';
import '../../../model/bpms/response/start_process_response_data.dart';
import '../../../model/bpms/retail_loan/request/retail_loan_start_process_variables_data.dart';
import '../../../model/deposit/request/customer_deposits_request_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/other/response/other_item_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../service/other_services.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../facility/facility_controller.dart';
import '../../main/main_controller.dart';
import '../task_list_controller.dart';

class RetailLoanController extends GetxController {
  ScrollController scrollbarController = ScrollController();
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

  EnumValue? selectedCreditCardAmountData;

  ProcessStartFormDataResponse? processStartFormDataResponse;

  List<EnumValue> creditCardAmountDataList = [];

  StartProcessResponse? startProcessResponse;

  ApplicantTaskListResponse? applicantTaskListResponse;

  List<Deposit> depositList = [];
  Deposit? selectedDeposit;

  static const String taskListControllerTag = 'RetailLoanTasksTag';

  @override
  void onInit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    super.onInit();
    branchNameController.text = locale.tehran_central_branch;
    Get.put(TaskListController(refreshCallback: (_) => refreshTaskList()), tag: taskListControllerTag);
    getRetailLoanRulesRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<TaskListController>(force: true, tag: taskListControllerTag);
    Get.closeAllSnackbars();
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  String getConditionUrl() {
    return 'https://tobank.ir/app/retail-loan-conditions';
  }

  /// Retrieves retail loan rules from the server.
  Future<void> getRetailLoanRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getRetailLoanRuleRequest().then((result) {
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
      _getDepositListRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Retrieves the customer's deposit list from the server.
  void _getDepositListRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerDepositsRequest customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber ?? '',
      trackingNumber: const Uuid().v4(),
    );

    isLoading = true;
    update();

    DepositServices.getCustomerDeposits(
      customerDepositsRequest: customerDepositsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          _handleResponse(response);
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _handleResponse(CustomerDepositsResponse response) {
    selectedDeposit = null;
    depositList.clear();
    depositList.addAll(response.data!.deposits!
        .where((element) => element.depositNumber!.startsWith('110') && element.depositeKind! != 3));
    update();
  }

  void setSelectedDeposit(Deposit deposit) {
    selectedDeposit = deposit;
    update();
  }

  void validateSelectDepositPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (selectedDeposit != null) {
      _getAverageMinimumDepositAmountForLoanRequest();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.warning,
        message: locale.please_select_deposit,
      );
    }
  }

  /// Retrieves the average minimum deposit amount for a loan request.
  void _getAverageMinimumDepositAmountForLoanRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final GetAverageMinimumDepositAmountForLoanRequest getAverageMinimumDepositAmountForLoanRequest =
        GetAverageMinimumDepositAmountForLoanRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      trackingNumber: const Uuid().v4(),
      deposit: selectedDeposit!.depositNumber!,
      processKey: 'RetailLoan',
    );

    isLoading = true;
    update();

    BPMSServices.getAverageMinimumDepositAmountForLoan(
      getAverageMinimumDepositAmountForLoanRequest: getAverageMinimumDepositAmountForLoanRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetAverageMinimumDepositAmountForLoanResponse response, int _)):
          if (response.data!.isConfirmed!) {
            _getStartFormData();
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.error,
              message: locale.minimum_balance_below_loan_conditions,
            );
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
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
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedCreditCardAmountData != null) {
      _checkCustomerCreditRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_loan_amount_type,
      );
    }
  }

  /// Checks the customer's credit status.
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
    BPMSServices.checkPersonalInfo(checkPersonalInfoRequestData: checkPersonalInfoRequestData).then((result) {
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

  void setSelectedAmountData(EnumValue? newValue) {
    selectedCreditCardAmountData = newValue;
    update();
  }

  void _getStartFormData() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final processDefinitions =
        facilityController.processDefinitions.firstWhereOrNull((element) => element.key == 'RetailLoan');
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
    creditCardAmountDataList = [];
    for (final formField in processStartFormDataResponse.data!.formFields!) {
      if (formField.id == 'requestAmount') {
        creditCardAmountDataList = formField.enumValues!;
        if (int.tryParse(creditCardAmountDataList.first.key) != null) {
          creditCardAmountDataList.sort((a, b) {
            return int.parse(a.key).compareTo(int.parse(b.key));
          });
        }
      }
    }
    update();
  }

  void _startProcess() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final StartProcessRequest startProcessRequest = StartProcessRequest(

      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: 'RetailLoan',
      businessKey: '1234567890',
      returnNextTasks: false,
      variables: RetailLoanStartProcessVariables(
        branchCode: '110',
        requestAmount: selectedCreditCardAmountData!.key,
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

  /// Retrieves the applicant's task list from the server.
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

  /// Handles the back press event.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 5 ||
          pageController.page == 6) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }
}
