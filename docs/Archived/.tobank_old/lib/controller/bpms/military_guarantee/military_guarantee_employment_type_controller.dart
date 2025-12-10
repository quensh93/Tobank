import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/enum_value_data.dart';
import '../../../model/bpms/military_guarantee/request/complete_employment_type_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MilitaryGuaranteeEmploymentTypeController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  List<EnumValue> employmentTypeDataList = [];

  EnumValue? selectedMilitaryGuaranteeEmploymentData;

  bool isSelectedEmploymentValid = true;

  bool isShowEmploymentList = false;

  MilitaryGuaranteeEmploymentTypeController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.id == 'applicantEmploymentType') {
        employmentTypeDataList = formField.enumValues!;
      }
    }
    update();
  }

  void toggleShowEmploymentList() {
    isShowEmploymentList = !isShowEmploymentList;
    update();
  }

  void setSelectedEmploymentType(EnumValue? newValue) {
    selectedMilitaryGuaranteeEmploymentData = newValue;
    isShowEmploymentList = false;
    update();
  }

  void validateEmploymentTypePage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (selectedMilitaryGuaranteeEmploymentData != null) {
      _completeEmploymentTypeTaskRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_job_type_applicant,
      );
    }
  }

  /// Completes the employment type task by sending a request to the backend.
  void _completeEmploymentTypeTaskRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      taskId: task.id!,
      trackingNumber: const Uuid().v4(),
      taskData: CompleteEmploymentTypeTaskData(
        applicantEmploymentType: selectedMilitaryGuaranteeEmploymentData!.key,
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
