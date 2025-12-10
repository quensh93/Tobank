import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/children_loan/request/complete_guarantor_acceptance_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/request/process_detail_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/bpms/response/process_detail_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_exception.dart';
import '../../../service/core/api_result_model.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class ChildrenLoanProcedureGuaranteeConfirmController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  late ProcessDetailResponse processDetailResponse;

  ChildrenLoanProcedureGuaranteeConfirmController({required this.task, required this.taskData});

  @override
  void onInit() {
    super.onInit();

    getProcessDetailRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  String getCustomerName() {
    if (mainController.authInfoData!.firstName != null && mainController.authInfoData!.lastName != null) {
      return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    } else {
      return '';
    }
  }

  /// Retrieves details for the loan process and navigates to the next page.
  void getProcessDetailRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final ProcessDetailRequest processDetailRequest = ProcessDetailRequest(
        customerNumber: mainController.authInfoData!.customerNumber!,
        processInstanceId: task.processInstanceId!,
        trackingNumber: const Uuid().v4());

    BPMSServices.getProcessDetail(
      processDetailRequest: processDetailRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ProcessDetailResponse response, int _)):
          processDetailResponse = response;
          AppUtil.nextPageController(pageController, isClosed);
          update();
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

  Future<void> validateConfirmPage({required bool isConfirm}) async {
    _completeGuarantorAcceptance(isConfirm);
  }

  /// Completes a guarantor acceptance task with confirmation status.
  ///
  /// This function submits a guarantor's acceptance or rejection of a guarantee based on the `isConfirm` parameter.
  /// It sends a request to complete a task, likely within a BPMS (Business Process Management System).
  void _completeGuarantorAcceptance(bool isConfirm) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      taskId: task.id!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskData: CompleteGuarantorAcceptanceTaskData(
        guarantorAcceptedGuarantee: isConfirm,
        guarantorCustomerNumber: mainController.authInfoData!.customerNumber!,
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
}
