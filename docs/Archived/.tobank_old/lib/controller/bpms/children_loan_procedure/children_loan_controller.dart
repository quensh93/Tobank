// ignore_for_file: directives_ordering

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/children_loan/request/children_loan_start_process_variables_data.dart';
import '../../../model/bpms/enum_value_data.dart';
import '../../../model/bpms/request/applicant_task_list_request_data.dart';
import '../../../model/bpms/request/check_personal_info_request_data.dart';
import '../../../model/bpms/request/process_start_form_data_request_data.dart';
import '../../../model/bpms/request/start_process_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/process_start_form_data_response_data.dart';
import '../../../model/bpms/response/start_process_response_data.dart';
import '../../../model/common/base_response_data.dart';
import '../../../model/other/response/other_item_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_exception.dart';
import '../../../service/core/api_result_model.dart';
import '../../../service/other_services.dart';
import '../../../ui/bpms/children_loan_procedure/children_loan/widget/tracking_code_helper_bottom_sheet.dart';
import '../../../ui/bpms/children_loan_procedure/children_loan_amount_detail/children_loan_amount_detail_screen.dart';
import '../../../ui/bpms/common/cbs_low_rate_alert_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../facility/facility_controller.dart';
import '../../main/main_controller.dart';
import '../task_list_controller.dart';

class ChildrenLoanProcedureController extends GetxController {
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

  bool isMarriageLoanAmountValid = true;

  EnumValue? selectedChildrenLoanAmountData;
  EnumValue? selectedChildrenCount;

  ProcessStartFormDataResponse? processStartFormDataResponse;

  List<EnumValue> childrenLoanAmountDataList = [];
  List<EnumValue> childrenCountDataList = [];

  StartProcessResponse? startProcessResponse;

  ApplicantTaskListResponse? applicantTaskListResponse;

  static const String taskListControllerTag = 'ChildrenLoanTasksTag';

  TextEditingController trackingCodeBankController = TextEditingController();

  bool isTrackingCodeValid = true;

  @override
  void onInit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    super.onInit();
    branchNameController.text = locale.tehran_central_branch;
    Get.put(TaskListController(refreshCallback: (_) => refreshTaskList()), tag: taskListControllerTag);
    getChildrenLoanRulesRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<TaskListController>(force: true, tag: taskListControllerTag);
    Get.closeAllSnackbars();
  }

  Future<NavigationActionPolicy> overrodeUrlLoading(NavigationAction navigationAction) async {
    final uri = navigationAction.request.url!;
    if (uri.host.contains('tobank.com')) {
      return NavigationActionPolicy.ALLOW;
    } else {
      return NavigationActionPolicy.CANCEL;
    }
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  String getConditionUrl() {
    return 'https://tobank.ir/app/children-loan-conditions';
  }

  /// Retrieves the rules and information for children's loans.
  Future<void> getChildrenLoanRulesRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    OtherServices.getChildrenLoanRuleRequest().then((result) {
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
      SnackBarUtil.showInfoSnackBar(locale.please_read_and_accept_terms);
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
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;
    if (trackingCodeBankController.text.length == Constants.trackingCodeLength) {
      isTrackingCodeValid = true;
    } else {
      isValid = false;
      isTrackingCodeValid = false;
    }
    update();
    if (selectedChildrenLoanAmountData != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(locale.please_select_eligible_children_count);
    }
    if (isValid) {
      _checkPersonalInfoRequest();
    }
  }

  /// Checks personal information and initiates a process if successful.
  ///
  /// If an error occurs during the check, it displays an error message to the user.
  void _checkPersonalInfoRequest() { //locale
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

  void setSelectedChildrenCount(EnumValue? newValue) {
    selectedChildrenCount = newValue;
    _updateChildrenLoanAmountDataList();
    update();
  }

  void _updateChildrenLoanAmountDataList() {
    switch (selectedChildrenCount!.key) {
      case '1ST_CHILD':
        selectedChildrenLoanAmountData = childrenLoanAmountDataList[0];
        break;
      case '2ND_CHILD':
        selectedChildrenLoanAmountData = childrenLoanAmountDataList[1];
        break;
      case '3RD_CHILD':
        selectedChildrenLoanAmountData = childrenLoanAmountDataList[2];
        break;
      case '4TH_CHILD':
        selectedChildrenLoanAmountData = childrenLoanAmountDataList[3];
        break;
      case '5TH_CHILD_OR_MORE':
        selectedChildrenLoanAmountData = childrenLoanAmountDataList[4];
        break;
    }
  }

  /// Retrieves and processes start form data for a children's loan process.
  ///
  /// BPMS (Business Process Management System).
  void _getStartFormData() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final processDefinitions =
        facilityController.processDefinitions.firstWhereOrNull((element) => element.key == 'ChildrenLoan');
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
          _addToChildrenLoanAmountDataList(processStartFormDataResponse!);
          _addToChildrenCountDataList(processStartFormDataResponse!);
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

  /// Extracts the possible values for "childrenCount" from the provided `processStartFormDataResponse`.
  /// It also sorts the list numerically if the keys are parsable as integers.
  void _addToChildrenCountDataList(ProcessStartFormDataResponse processStartFormDataResponse) {
    selectedChildrenCount = null;
    childrenCountDataList = [];
    for (final formField in processStartFormDataResponse.data!.formFields!) {
      if (formField.id == 'childrenCount') {
        childrenCountDataList = formField.enumValues!;
        if (int.tryParse(childrenCountDataList.first.key) != null) {
          childrenCountDataList.sort((a, b) {
            return int.parse(a.key).compareTo(int.parse(b.key));
          });
        }
      }
    }
    update();
  }

  /// Extracts the possible loan amount values from the provided `processStartFormDataResponse`.
  /// It also sorts the list numerically if the keys are parsable as integers.
  void _addToChildrenLoanAmountDataList(ProcessStartFormDataResponse processStartFormDataResponse) {
    selectedChildrenLoanAmountData = null;
    childrenLoanAmountDataList = [];
    for (final formField in processStartFormDataResponse.data!.formFields!) {
      if (formField.id == 'requestAmount') {
        childrenLoanAmountDataList = formField.enumValues!;
        if (int.tryParse(childrenLoanAmountDataList.first.key) != null) {
          childrenLoanAmountDataList.sort((a, b) {
            return int.parse(a.key).compareTo(int.parse(b.key));
          });
        }
      }
    }
    update();
  }

  /// Starts a children's loan process and handles different server responses.
  ///
  /// This function initiates a children's loan process with specific variables like branch code, loan amount, and children count.
  void _startProcess() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final StartProcessRequest startProcessRequest = StartProcessRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: 'ChildrenLoan',
      businessKey: '1234567890',
      returnNextTasks: false,
      variables: ChildrenLoanStartProcessVariables(
          branchCode: '110',
          requestAmount: selectedChildrenLoanAmountData!.key,
          customerNumber: mainController.authInfoData!.customerNumber!,
          cbiTrackingNumber: trackingCodeBankController.text,
          childrenCount: selectedChildrenCount!.key),
    );
    isLoading = true;
    update();
    BPMSServices.startProcessWithCBSCheck(
      startProcessRequest: startProcessRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final StartProcessResponse response, 200)):
          AppUtil.nextPageController(pageController, isClosed);
          startProcessResponse = response;
          update();
          Future.delayed(Constants.duration200, () {
            getApplicantTaskListRequest();
          });
        case Success(value: (final BaseResponseData response, 409)):
          // CBS E Rate
          _showCBSLowRateAlertBottomSheet(response.message ?? '');
        case Success():
          // Will not happened
          break;
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _showCBSLowRateAlertBottomSheet(String message) {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
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
        child: CBSLowRateAlertBottomSheet(message: message),
      ),
    );
  }

  /// Retrieves the applicant's task list from the BPMS and handles navigation or success message.
  ///
  /// If no tasks are found, it assumes successful completion, closes the current screen, and displays a success message.
  /// In case of an error, displays an error message.
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
          if ((applicantTaskListResponse!.data!.taskList ?? []).isNotEmpty) {
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

  void showUrl() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.launchInBrowser(url: locale.ve_cbi_link);
  }

  void showRequestAmountDetailScreen() {
    Get.to(() => const ChildrenLoanAmountDetailScreen());
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 4 ||
          pageController.page == 5) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void showTrackingCodeHelperBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
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
        child: const TrackingCodeHelperBottomSheet(),
      ),
    );
  }
}
