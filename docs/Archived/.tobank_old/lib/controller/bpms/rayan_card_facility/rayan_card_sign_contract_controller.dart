import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/document_file_data.dart';
import '../../../model/bpms/rayan_card_facility/request/complete_sign_contract_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/request/get_task_contract_document_request_data.dart';
import '../../../model/bpms/request/upload_task_contract_document_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_contract_document_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/bpms/response/upload_task_contract_document_response_data.dart';
import '../../../model/common/sign_document_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_exception.dart';
import '../../../service/core/api_result_model.dart';
import '../../../ui/common/contract/contract_preview_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/file_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class RayanCardSignContractController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;
  bool hasError = false;
  String errorTitle = '';

  String? signedDocumentBase64;
  String? uploadedContractDocumentId;

  String? rejectReason;

  GetTaskContractDocumentResponse? getTaskContractDocumentResponse;

  RayanCardSignContractController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.id == 'contractFile') {
        if (formField.value?.subValue != null) {
          final contractFile = DocumentFileValue.fromJson(formField.value!.subValue!);
          if (contractFile.status == 1) {
            rejectReason = contractFile.description;
          }
        }
      }
    }

    update();
  }

  @override
  void onInit() {
    getContractDocumentRequest();
    super.onInit();
  }

  /// Retrieves the contract document for a task.
  void getContractDocumentRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final getTaskContractDocumentRequest = GetTaskContractDocumentRequest(taskId: task.id!);

    BPMSServices.getTaskContractDocument(
      templateName: 'rayan',
      getTaskContractDocumentRequest: getTaskContractDocumentRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetTaskContractDocumentResponse response, int _)):
          getTaskContractDocumentResponse = response;
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

  Future<void> sharePdf() async {
    await FileUtil().shareContractPDF(
      bytes: base64Decode(getTaskContractDocumentResponse!.data!.base64Data!).toList(),
      name: 'Rayan Card Facility',
    );
  }

  void showPreviewScreen() {
    Get.to(() => ContractPreviewScreen(
          pdfData: base64Decode(getTaskContractDocumentResponse!.data!.base64Data!),
          templateName: 'Rayan Card',
        ));
  }

  /// Signs the document using a digital signature and initiates an upload request.
  Future<void> signDocument() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<SignLocation> signLocations = [getTaskContractDocumentResponse!.data!.signLocation!];

    final SignDocumentData signDocumentData = SignDocumentData(
      documentBase64: getTaskContractDocumentResponse!.data!.base64Data!,
      reason: 'Rayan Card Facility Request',
      signLocations: signLocations,
    );

    final SecureResponseData signResponse = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      signedDocumentBase64 = signResponse.data;
      update();
      _uploadContractDocumentRequest();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: signResponse.message ?? locale.error_in_signature,
      );

      await Sentry.captureMessage('sign pdf error',
          params: [
            {'status code': signResponse.statusCode},
            {'message': signResponse.message},
          ],
          level: SentryLevel.warning);
    }
  }

  /// Uploads the signed contract document to the server.
  void _uploadContractDocumentRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final uploadTaskContractDocumentRequestData = UploadTaskContractDocumentRequestData(
        trackingNumber: const Uuid().v4(),
        customerNumber: mainController.authInfoData!.customerNumber!,
        documentData: signedDocumentBase64!,
        documentId: getTaskContractDocumentResponse!.data!.id!);

    isLoading = true;
    update();

    BPMSServices.uploadTaskContractDocument(
      uploadTaskContractDocumentRequestData: uploadTaskContractDocumentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final UploadTaskContractDocumentResponse response, int _)):
          uploadedContractDocumentId = response.data!.documentId!;
          update();
          AppUtil.nextPageController(pageController, isClosed);
          Future.delayed(Constants.duration300, () {
            completeSignContractRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Completes the sign contract request by sending a complete task request to the server.
  void completeSignContractRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteSignContractTaskData(
        contractFile: DocumentFile(
          value: DocumentFileValue(
            id: uploadedContractDocumentId,
            status: null,
            title: 'contractTitle',
            description: null,
          ),
        ),
        finalApprovalRejectReason: null,
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

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
