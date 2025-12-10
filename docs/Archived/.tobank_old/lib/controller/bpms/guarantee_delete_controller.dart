import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/request/complete_delete_guarantor_task_data.dart';
import '../../model/bpms/request/complete_task_request_data.dart';
import '../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../model/bpms/response/get_task_data_response_data.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_core.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class GuaranteeDeleteController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  TextEditingController descriptionGuaranteeController = TextEditingController();

  bool isGuaranteeDescriptionValid = true;

  String? guarantorNationalId;
  String? guarantorMobile;

  GuaranteeDeleteController({required this.task, required this.taskData});

  @override
  void onInit() {
    super.onInit();

    for (final TaskDataFormField taskDataFormField in taskData) {
      switch (taskDataFormField.id) {
        case 'guarantorNationalId':
          guarantorNationalId = taskDataFormField.value?.subValue;
          break;
        case 'guarantorMobile':
          guarantorMobile = taskDataFormField.value?.subValue;
          break;
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> validateDeletePage() async {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (descriptionGuaranteeController.text.length > 2) {
      isGuaranteeDescriptionValid = true;
    } else {
      isGuaranteeDescriptionValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _completeGuarantorDeleteRequest();
    }
  }

  /// Completes the guarantor delete request
  /// sending a complete task request to the server.
  void _completeGuarantorDeleteRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteDeleteGuarantorTaskData(
        deleteGuarantor: true,
        deleteGuarantorReasonDescription: descriptionGuaranteeController.text,
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
            SnackBarUtil.showSuccessSnackBar(locale.successfully_deleted);
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
