import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/credit_card_facility/request/complete_customer_additional_documents_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/document/request/upload_document_request_data.dart';
import '../../../model/document/response/upload_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CreditCardCustomerAdditionalDocumentController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;
  final List<AdditionalDocument> documents = [];
  final List<File?> documentFiles = [];
  final List<AdditionalDocument> approvedDocuments = [];

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isUploading = false;

  int selectedDocumentId = 0;

  bool isLoading = false;

  CreditCardCustomerAdditionalDocumentController({required this.task, required this.taskData}) {
    _handleAdditionalDocuments();
  }

  /// processes additional documents associated with a task,
  /// categorizing them into `documents` (pending or rejected)
  /// and `approvedDocuments` lists based on their status.
  void _handleAdditionalDocuments() {
    final subValue = SubValueDictionary.fromJson(taskData[0].value!.subValue);
    for (var i = 0; i < subValue.additionalDocuments!.length; i++) {
      final additionalDocument = subValue.additionalDocuments![i];
      additionalDocument.index = i; // for sorting
      switch (additionalDocument.status) {
        case null: // no document uploaded
          if (additionalDocument.id != null) {
            // document uploaded but not checked
            approvedDocuments.add(additionalDocument);
          } else {
            // no document uploaded
            documents.add(additionalDocument);
            documentFiles.add(null);
          }
          break;
        case 1: // rejected
          final temp = additionalDocument;
          temp.id = null;
          documents.add(temp);
          documentFiles.add(null);
          break;
        case 2: // approved
          approvedDocuments.add(additionalDocument);
          break;
        default:
          final temp = additionalDocument;
          temp.id = null;
          documents.add(temp);
          documentFiles.add(null);
          break;
      }
    }
  }

  /// Selects a document image from either the camera or gallery,crops it, and uploads it if the size is within limits.
  Future<void> selectDocumentImage({required int documentId, required ImageSource imageSource}) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    XFile? image;
    if (imageSource == ImageSource.camera) {
      final File? file = await Get.to(() => const CameraCaptureScreen());
      if (file != null) {
        image = XFile(file.path);
      }
    } else {
      if (Platform.isIOS) {
        image = await ImagePicker().pickImage(
          source: imageSource,
        );
      } else {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
        );
        if (result != null && result.files.length == 1) {
          image = XFile(result.files[0].path!);
        }
      }
    }
    if (image != null) {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        maxHeight: Constants.height1000,
        maxWidth: Constants.width1000,
        compressQuality: Constants.compressQuality80,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: locale.crop_picture,
              toolbarColor: Get.context!.theme.colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              hideBottomControls: false,
              lockAspectRatio: false),
          IOSUiSettings(rectX: 3, rectY: 1, title: locale.crop_picture, cancelButtonTitle: locale.cancel_laghv, doneButtonTitle: locale.confirmation)
        ],
      );
      if (croppedImage != null) {
        if (AppUtil.checkSizeOfFileWithInputSize(File(croppedImage.path), Constants.fileSize400)) {
          SnackBarUtil.showInfoSnackBar(
            locale.file_size_too_large,
          );
        } else {
          _uploadDocumentRequest(File(croppedImage.path), documentId);
        }
      }
    }
  }

  /// Initiates a request to upload a document using the `DocumentServices` class.
  void _uploadDocumentRequest(File image, int documentId) { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String base64 = AppUtil.getBase64OfFile(image);
    final UploadDocumentRequestData uploadDocumentRequestData = UploadDocumentRequestData();
    uploadDocumentRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    uploadDocumentRequestData.documentData = base64;
    uploadDocumentRequestData.trackingNumber = const Uuid().v4();

    isUploading = true;
    selectedDocumentId = documentId;
    update();

    DocumentServices.uploadDocumentRequest(
      uploadDocumentRequestData: uploadDocumentRequestData,
    ).then((result) {
      isUploading = false;
      selectedDocumentId = 0;
      update();

      switch (result) {
        case Success(value: (final UploadDocumentResponseData response, int _)):
          _setUploadedDocument(documentId, response, image);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _setUploadedDocument(int documentId, response, File image) {
    documents[documentId].id = response.data!.documentId;
    documentFiles[documentId] = image;
    update();
  }

  bool isUploaded(int documentId) {
    return documents[documentId].id != null;
  }

  void deleteDocument(int documentId) {
    documents[documentId].id = null;
    documentFiles[documentId] = null;
    update();
  }

  /// Checks if all required customer birth certificate documents have been uploaded.
  /// and either completes the document request or displays an error message.
  void validateCustomerBirthCertificate() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (!documents.map((e) => e.id).toList().contains(null)) {
      _completeCustomerDocumentsRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_and_upload_all_pages,
      );
    }
  }

  /// Initiates a request to complete the customer documents request using the `BPMSServices` class.
  void _completeCustomerDocumentsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final List<AdditionalDocument> tempDocuments = _handleTempDocuments();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteCustomerAdditionalDocumentsTaskData(
        value: ApplicantAdditionalDocumentsValue(
          documents: SubValueDictionary(
            additionalDocuments: tempDocuments,
          ),
        ),
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
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  List<AdditionalDocument> _handleTempDocuments() {
    final List<AdditionalDocument> tempDocuments = [];
    tempDocuments.addAll(documents);
    tempDocuments.addAll(approvedDocuments);
    tempDocuments.sort((a, b) => a.index!.compareTo(b.index!));
    return tempDocuments;
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
