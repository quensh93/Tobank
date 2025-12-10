import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/document_file_data.dart';
import '../../../model/bpms/military_guarantee/request/complete_sign_contract_request_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/common/sign_document_data.dart';
import '../../../model/document/request/digital_document_request_data.dart';
import '../../../model/document/request/upload_document_request_data.dart';
import '../../../model/document/response/digital_document_response_data.dart';
import '../../../model/document/response/upload_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../ui/common/contract/contract_preview_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/file_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MillitaryGuaranteeSignContractsController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;
  bool hasError = false;
  String errorTitle = '';

  String? unsignedContractDocumentId;
  String? unsignedContractBase64;

  String? signedContractBase64;
  String? signedContractDocumentId;

  String? unsignedCollateralDocumentId;
  String? unsignedCollateralBase64;
  SignDocumentData? signCollateralDocumentData;
  String? signedCollateralBase64;
  String? signedCollateralDocumentId;

  MillitaryGuaranteeSignContractsController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.id == 'unsignedContractFile') {
        if (formField.value?.subValue != null) {
          final unsignedContractFile = DocumentFileValue.fromJson(formField.value!.subValue!);
          unsignedContractDocumentId = unsignedContractFile.id!;
        }
      } else if (formField.id == 'unsignedCollateralFile') {
        if (formField.value?.subValue != null) {
          final unsignedCollateralFile = DocumentFileValue.fromJson(formField.value!.subValue!);
          unsignedCollateralDocumentId = unsignedCollateralFile.id!;
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

  /// Retrieves the contract document from the server.
  void getContractDocumentRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final DigitalDocumentRequestData digitalDocumentRequestData = DigitalDocumentRequestData(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      documentId: unsignedContractDocumentId!,
    );

    DocumentServices.getDigitalDocumentRequest(
      digitalDocumentRequestData: digitalDocumentRequestData,
    ).then((result) {
      switch (result) {
        case Success(value: (final DigitalDocumentResponseData response, int _)):
          unsignedContractBase64 = response.data!.documentData!;
          update();
          getCollateralDocumentRequest();
        case Failure(exception: final ApiException apiException):
          isLoading = false;
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

  /// Retrieves the collateral document from the server.
  void getCollateralDocumentRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final DigitalDocumentRequestData digitalDocumentRequestData = DigitalDocumentRequestData(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      documentId: unsignedCollateralDocumentId!,
    );

    DocumentServices.getDigitalDocumentRequest(
      digitalDocumentRequestData: digitalDocumentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DigitalDocumentResponseData response, int _)):
          unsignedCollateralBase64 = response.data!.documentData!;
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

  Future<void> shareCollateralPdf() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    await FileUtil().shareContractPDF(
      bytes: base64Decode(unsignedCollateralBase64!).toList(),
      name: 'MillitaryLG Collateral',
      title: locale.file_collateral_contract,
    );
  }

  void showCollateralPreviewScreen() {
    Get.to(
      () => ContractPreviewScreen(
        pdfData: base64Decode(unsignedCollateralBase64!),
        templateName: 'MillitaryLG Collateral',
      ),
    );
  }

  Future<void> signCollateralDocument() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<SignLocation> signLocations = [
      SignLocation(
          android: SignRect(x: 460, y: 770, height: 100, width: 100),
          ios: SignRect(x: 430, y: 780, height: 70, width: 150),
          signPageIndex: 1,
          digitalSignatureRequired: true),
    ];

    final signContractDocumentData = SignDocumentData(
      documentBase64: unsignedCollateralBase64!,
      reason: 'MillitaryLG',
      signLocations: signLocations,
    );

    final SecureResponseData signResponse = await AppUtil.signPdf(signDocumentData: signContractDocumentData);

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      signedCollateralBase64 = signResponse.data;
      update();
      _uploadCollateralDocumentRequest();
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

  /// Uploads the signed collateral document to the server.
  void _uploadCollateralDocumentRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final UploadDocumentRequestData uploadDocumentRequestData = UploadDocumentRequestData();
    uploadDocumentRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    uploadDocumentRequestData.documentData = signedCollateralBase64;
    uploadDocumentRequestData.trackingNumber = const Uuid().v4();

    isLoading = true;
    update();

    DocumentServices.uploadDocumentRequest(
      uploadDocumentRequestData: uploadDocumentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final UploadDocumentResponseData response, int _)):
          signedCollateralDocumentId = response.data!.documentId!;
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

  Future<void> shareContractPdf() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    await FileUtil().shareContractPDF(
      bytes: base64Decode(unsignedContractBase64!).toList(),
      name: 'MillitaryLG Contract',
      title: locale.file_guarantee,
    );
  }

  void showContractPreviewScreen() {
    Get.to(
      () => ContractPreviewScreen(
        pdfData: base64Decode(unsignedContractBase64!),
        templateName: 'MillitaryLG Contract',
      ),
    );
  }

  /// Signs the contract document using a digital signature.
  Future<void> signContractDocument() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<SignLocation> signLocations = [
      SignLocation(
          android: SignRect(x: 460, y: 770, height: 100, width: 100),
          ios: SignRect(x: 430, y: 780, height: 70, width: 150),
          signPageIndex: 2,
          digitalSignatureRequired: true),
    ];

    final signContractDocumentData = SignDocumentData(
      documentBase64: unsignedContractBase64!,
      reason: 'MillitaryLG',
      signLocations: signLocations,
    );

    final SecureResponseData signResponse = await AppUtil.signPdf(signDocumentData: signContractDocumentData);

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      signedContractBase64 = signResponse.data;
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
  void _uploadContractDocumentRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final UploadDocumentRequestData uploadDocumentRequestData = UploadDocumentRequestData();
    uploadDocumentRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    uploadDocumentRequestData.documentData = signedContractBase64;
    uploadDocumentRequestData.trackingNumber = const Uuid().v4();

    isLoading = true;
    update();

    DocumentServices.uploadDocumentRequest(
      uploadDocumentRequestData: uploadDocumentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final UploadDocumentResponseData response, int _)):
          signedContractDocumentId = response.data!.documentId!;
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

  /// Completes the sign contract request by sending data to the backend.
  void completeSignContractRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteSignContractTaskData(
        collateralFile: DocumentFile(
          value: DocumentFileValue(
            id: signedCollateralDocumentId,
            status: null,
            title: 'collateralFile',
            description: null,
          ),
        ),
        contractFile: DocumentFile(
          value: DocumentFileValue(
            id: signedContractDocumentId,
            status: null,
            title: 'contractFile',
            description: null,
          ),
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

  /// Handles the back press action.
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
