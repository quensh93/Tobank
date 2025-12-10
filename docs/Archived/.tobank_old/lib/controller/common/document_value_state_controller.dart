import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/document_file_data.dart';
import '../../model/bpms/document_value_state_data.dart';
import '../../model/bpms/request/complete_edit_documents_request_data.dart';
import '../../model/bpms/request/complete_edit_documents_value_request_data.dart';
import '../../model/bpms/request/complete_task_request_data.dart';
import '../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../model/bpms/response/get_task_data_response_data.dart';
import '../../model/document/request/upload_document_request_data.dart';
import '../../model/document/response/upload_document_response_data.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_core.dart';
import '../../service/document_services.dart';
import '../../ui/camera_capture/camera_capture_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/theme/theme_util.dart';
import '../main/main_controller.dart';

class DocumentValueStateController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool isUploading = false;

  final Task task;
  final List<TaskDataFormField> taskData;
  final List<DocumentValueStateData> documents = [];
  final List<File?> documentFiles = [];

  int selectedDocumentId = 0;

  DocumentValueStateController({
    required this.task,
    required this.taskData,
  }) {
    _handleDocuments();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Processes a list of documents, filters them based on status,
  /// and updates two lists: [documents] and [documentFiles].
  void _handleDocuments() {
    final filteredTaskData = taskData.where((element) => element.value?.subValue != null).toList();
    for (var i = 0; i < filteredTaskData.length; i++) {
      final data = filteredTaskData[i];
      final document = DocumentValueStateData(
        id: data.id!,
        index: i, // for sorting
        documentValue: DocumentFileValue.fromJson(data.value!.subValue),
      );
      switch (document.documentValue.status) {
        case null: // optional
        case 0: // unconfirmed
        case 2: // approved
          // ignore
          break;
        case 1: // rejected
          final temp = document;
          temp.documentValue.id = null;
          documents.add(temp);
          documentFiles.add(null);
          break;
        default:
          final temp = document;
          temp.documentValue.id = null;
          documents.add(temp);
          documentFiles.add(null);
          break;
      }
    }
  }

  /// Allows the user to select a document image, crop it, and initiate an upload request.
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
              toolbarColor: ThemeUtil.primaryColor,
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

  /// Uploads a document to the server.
  ///
  /// This function converts a document image to base64, creates an upload request, and sends it to the server.
  void _uploadDocumentRequest(File image, int documentId) {
//locale
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

  void _setUploadedDocument(int documentId, UploadDocumentResponseData response, File image) {
    documents[documentId].documentValue.id = response.data!.documentId!;
    documentFiles[documentId] = image;
    update();
  }

  bool isUploaded(int documentId) {
    return documents[documentId].documentValue.id != null;
  }

  void deleteDocument(int documentId) {
    documents[documentId].documentValue.id = null;
    documentFiles[documentId] = null;
    update();
  }

  void validateEditDocument() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (!documents.map((e) => e.documentValue.id).toList().contains(null)) {
      _completeCustomerDocumentsRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.upload_and_select_all_page,
      );
    }
  }

  /// Completes the customer documents request by sending a complete task request to the server.
  void _completeCustomerDocumentsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<DocumentValueStateData> tempDocuments = _handleTempDocuments();
    final List<EditDocumentData> tempEditDocument =
        tempDocuments.map((e) => EditDocumentData(id: e.id, documentId: e.documentValue.id!)).toList();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteEditDocumentsValueTaskData(editDocumentList: tempEditDocument),
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

  List<DocumentValueStateData> _handleTempDocuments() {
    final List<DocumentValueStateData> tempDocuments = [];
    tempDocuments.addAll(documents);
    tempDocuments.sort((a, b) => a.index.compareTo(b.index));
    return tempDocuments;
  }
}
