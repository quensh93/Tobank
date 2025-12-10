import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/request/user_process_instances_request_data.dart';
import '../../model/bpms/response/user_process_instances_response_data.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_exception.dart';
import '../../service/core/api_result_model.dart';
import '../../ui/process_detail/process_detail_screen.dart';
import '../../util/app_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import 'dashboard_controller.dart';

class ProcessController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = false;

  bool hasError = false;

  String errorTitle = '';

  PageController pageController = PageController();

  RequestStatusFilter currentRequestStatusFilter = RequestStatusFilter.all;

  List<ProcessInstance> processInstances = [];

  List<ProcessInstance> allProcessInstances = [];

  @override
  void onInit() {
    getCustomerProcess();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> getCustomerProcess() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.nationalCode != null && mainController.authInfoData!.customerNumber != null) {
      if (mainController.authInfoData!.shabahangCustomerStatus == 1) {
        _getCustomerProcessesRequest();
      } else {
        isLoading = false;
        hasError = true;
        switch (mainController.authInfoData!.shabahangCustomerStatus) {
          case 0:
          case 5:
            errorTitle = locale.due_to_document_deficiency_process_prevented;
            break;
          case 2:
            errorTitle = locale.documents_under_review_please_wait;
            break;
          case 3:
            errorTitle =
                locale.services_disabled_due_to_sheba_documents;
            break;
          case 6:
            errorTitle = locale.authentication_documents_rejected_need_to_reauthenticate;
            break;
          default:
            errorTitle = locale.prevent_authenticated_incomplete_documents;
            break;
        }
        update();
      }
    } else {
      hasError = true;
      errorTitle = locale.initial_process_error;
      update();
    }
  }

  /// Retrieves the customer's active processes from the server.
  void _getCustomerProcessesRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final UserProcessInstancesRequest customerRequestsRequest = UserProcessInstancesRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      trackingNumber: const Uuid().v4(),
    );

    hasError = false;
    isLoading = true;
    update();

    BPMSServices.getUserProcessInstances(
      userProcessInstances: customerRequestsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final UserProcessInstancesResponse response, int _)):
          processInstances = response.data!.processInstances ?? [];
          allProcessInstances = response.data!.processInstances ?? [];
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

  void showProcessDetailScreen(ProcessInstance processInstance) {
    Get.to(() => ProcessDetailScreen(processInstanceId: processInstance.processInstanceId!));
  }

  void onBackPressed() {
    final DashboardController dashboardController = Get.find();
    dashboardController.onBackPressed(false, isClosed);
  }

  void setRequestStatusFilter(RequestStatusFilter requestStatusFilter) {
    if (allProcessInstances.isNotEmpty) {
      switch (requestStatusFilter) {
        case RequestStatusFilter.open:
          processInstances = allProcessInstances.where((element) => element.state == 'ACTIVE').toList();
          break;
        case RequestStatusFilter.close:
          processInstances = allProcessInstances
              .where((element) =>
                  element.state == 'COMPLETED' ||
                  element.state == 'EXTERNALLY_TERMINATED' ||
                  element.state == 'INTERNALLY_TERMINATED')
              .toList();
          break;
        case RequestStatusFilter.all:
          processInstances = allProcessInstances;
          break;
      }
    }
    currentRequestStatusFilter = requestStatusFilter;
    update();
  }
}
