import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/document_file_data.dart';
import '../../../model/bpms/military_guarantee/request/complete_draft_file_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/document/request/digital_document_request_data.dart';
import '../../../model/document/response/digital_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../ui/common/contract/contract_preview_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MilitaryGuaranteeDraftFileController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MilitaryGuaranteeDraftFileController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool hasError = false;
  String? errorTitle = '';

  DocumentFileValue? draftFile;
  String? draftBase64;

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.id == 'draftFile') {
        if (formField.value?.subValue != null) {
          draftFile = DocumentFileValue.fromJson(formField.value!.subValue!);
        }
      }
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getDraftFileRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the draft file and proceeds to the next step.
  void getDraftFileRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final DigitalDocumentRequestData digitalDocumentRequestData = DigitalDocumentRequestData(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      documentId: draftFile!.id!,
    );

    DocumentServices.getDigitalDocumentRequest(
      digitalDocumentRequestData: digitalDocumentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DigitalDocumentResponseData response, int _)):
          draftBase64 = response.data!.documentData!;
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

  void showPreviewScreen() {
    Get.to(
      () => ContractPreviewScreen(
        pdfData: base64Decode(draftBase64!),
        templateName: 'Military Guarantee Draft',
        showStore: false,
        showShare: false,
      ),
    );
  }

  void validateDraftFile({required bool isAccepted}) {
    AppUtil.hideKeyboard(Get.context!);
    draftFile!.status = isAccepted ? 2 : 1;
    update();
    _completeDraftFileTaskRequest();
  }

  /// Completes the draft file task by sending a request to the backend.
  void _completeDraftFileTaskRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteDraftFileTaskData(
        draftFile: DocumentFile(
          value: draftFile!,
        ),
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

  /// Handles the back press action,
  /// navigating back to the previous screen if not loading.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }
}
