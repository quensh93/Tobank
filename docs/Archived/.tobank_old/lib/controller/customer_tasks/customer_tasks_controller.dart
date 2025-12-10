import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/request/applicant_task_list_request_data.dart';
import '../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/bpms/common/task_list_page.dart';
import '../../ui/process_detail/process_detail_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../bpms/task_list_controller.dart';
import '../dashboard/dashboard_controller.dart';
import '../main/main_controller.dart';

class CustomerTasksController extends GetxController {
  bool isLoading = true;
  bool hasError = false;
  String errorTitle = '';
  List<List<Task>> tasksByProcessIds = [];
  MainController mainController = Get.find();
  static const String taskListControllerTag = 'CustomerTasksTag';

  PageController pageController = PageController();

  String? selectedProcessInstanceId;

  int openBottomSheets = 0;

  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void onInit() {
    super.onInit();
    Get.put(
        TaskListController(
            refreshCallback: (shouldUpdateCustomerStatus) =>
                refreshTaskList(shouldUpdateCustomerStatus: shouldUpdateCustomerStatus)),
        tag: taskListControllerTag);

    getCustomerTasks();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<TaskListController>(force: true, tag: taskListControllerTag);
    Get.closeAllSnackbars();
  }

  /// Sends a request to get customer information
  void _getCustomerInfoRequest({required bool clearServerCache}) { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: clearServerCache,
      forceInquireAddressInfo: false,
      getCustomerStartableProcesses: false,
      getCustomerDeposits: false,
      getCustomerActiveCertificate: false,
    );

    isLoading = true;
    update();

    AuthorizationServices.getCustomerInfo(customerInfoRequest: customerInfoRequest).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CustomerInfoResponse response, int _)):
          await _updateCustomerStatus(response);
          getCustomerTasks();
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

  Future<void> _updateCustomerStatus(CustomerInfoResponse customerInfoResponse) async {
    if (customerInfoResponse.data != null) {
      mainController.authInfoData!.shabahangCustomerStatus = customerInfoResponse.data!.customerStatus;

      mainController.update();

      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
      update();
    }
  }

  Future<void> getCustomerTasks() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.nationalCode != null && mainController.authInfoData!.customerNumber != null) {
      if (mainController.authInfoData!.shabahangCustomerStatus == 0 ||
          mainController.authInfoData!.shabahangCustomerStatus == 1 ||
          mainController.authInfoData!.shabahangCustomerStatus == 5) {
        _getCustomerTasksRequest();
      } else {
        isLoading = false;
        hasError = true;
        switch (mainController.authInfoData!.shabahangCustomerStatus) {
          case 2:
            errorTitle = locale.document_being_reviewd;
            break;
          case 3:
            errorTitle =
          locale.your_deposit_services_disable_call_support;
            break;
          case 6:
            errorTitle = locale.your_authentication_have_rejected;
            break;
          default:
            errorTitle = locale.prevent_authenticated_incomplete_documents;
            break;
        }
        update();
      }
    } else {
      isLoading = false;
      hasError = true;
      errorTitle = locale.initial_process_error;
      update();
    }
  }

  /// Sends a request to get customer tasks
  Future<void> _getCustomerTasksRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ApplicantTaskListRequest applicantTaskListRequest = ApplicantTaskListRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      processInstanceId: null,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
    );

    hasError = false;
    isLoading = true;
    update();

    BPMSServices.getApplicantTaskList(
      applicantTaskListRequest: applicantTaskListRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ApplicantTaskListResponse response, int _)):
          hasError = false;
          update();
          _handleTasks(response.data!.taskList ?? []);
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

  /// Processes a list of tasks, groups them by process instance ID,
  /// updates the UI, and potentially navigates to a specific page.
  Future<void> _handleTasks(List<Task> tasks) async {
    final Map<String, List<Task>> tempTasksByProcessIds = {};
    for (final element in tasks) {
      if (tempTasksByProcessIds[element.processInstanceId!] != null) {
        tempTasksByProcessIds[element.processInstanceId!]!.add(element);
      } else {
        tempTasksByProcessIds[element.processInstanceId!] = [];
        tempTasksByProcessIds[element.processInstanceId!]!.add(element);
      }
    }
    tasksByProcessIds = tempTasksByProcessIds.entries.map((e) => e.value).toList();
    update();
    if (selectedProcessInstanceId != null) {
      final selectedProcessTasks =
          tasks.where((element) => element.processInstanceId! == selectedProcessInstanceId).toList();

      if (selectedProcessTasks.isNotEmpty) {
        final TaskListController taskListController = Get.find(tag: taskListControllerTag);
        taskListController.taskList = selectedProcessTasks;
        taskListController.update();
        update();

        Future.delayed(Constants.duration200, () {
          AppUtil.gotoPageController(
            pageController: pageController,
            page: 2,
            isClosed: isClosed,
          );
          update();
        });
      } else {
        Future.delayed(Constants.duration200, () {
          AppUtil.nextPageController(pageController, isClosed);
          selectedProcessInstanceId = null;
          update();
        });
      }
    } else {
      Future.delayed(Constants.duration200, () {
        AppUtil.nextPageController(pageController, isClosed);
        update();
      });
    }
  }

  void onTapContinue({required List<Task> taskList}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.virtualBranchStatus == VirtualBranchStatus.registered &&
        !mainController.shouldMigrateZoomIdToYekta) {
      selectedProcessInstanceId = taskList.first.processInstanceId;
      final TaskListController taskListController = Get.find(tag: taskListControllerTag);
      taskListController.taskList = taskList;
      taskListController.update();
      update();
      _showTaskListBottomSheet();
    } else {
      SnackBarUtil.showInfoSnackBar(
          locale.authentication_error);
    }
  }

  Future<void> refreshTaskList({required bool shouldUpdateCustomerStatus}) async {
    _closeBottomSheet();
    AppUtil.gotoPageController(
      pageController: pageController,
      page: 0,
      isClosed: isClosed,
    );
    if (shouldUpdateCustomerStatus) {
      _getCustomerInfoRequest(clearServerCache: true);
    } else {
      getCustomerTasks();
    }
  }

  void showProcessDetailScreen(String processInstanceId) {
    Get.to(() => ProcessDetailScreen(processInstanceId: processInstanceId));
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (selectedProcessInstanceId != null) {
      AppUtil.previousPageController(pageController, isClosed);
    } else {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  Future<void> _showTaskListBottomSheet() async {
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
        child: TaskListPage(
          taskListControllerTag: CustomerTasksController.taskListControllerTag,
          showBottomSheet: true,
          returnBackFunction: () => AppUtil.previousPageController(pageController, isClosed),
        ),
      ),
    );
    openBottomSheets--;
    update();
  }

  void _closeBottomSheet() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void onBackPressed() {
    final DashboardController dashboardController = Get.find();
    dashboardController.onBackPressed(false, isClosed);
  }
}
