import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/document_state_data.dart';
import '../../model/bpms/request/complete_edit_documents_request_data.dart';
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
import '../main/main_controller.dart';

class DocumentStateController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool isUploading = false;

  final Task task;
  final List<TaskDataFormField> taskData;
  List<DocumentStateData> documentStateDataList = [];

  DocumentStateController({
    required this.task,
    required this.taskData,
  });

  @override
  void onInit() {
    super.onInit();
    documentStateDataList = AppUtil.splitTaskData(taskData);
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Allows the user to select a document image, crop it, and initiate an upload request.
  Future<void> selectDocumentImage(
      {required DocumentStateData taskDataFormField, required ImageSource imageSource}) async {
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
        maxHeight: Constants.height700,
        maxWidth: Constants.width700,
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
        if (AppUtil.checkSizeOfFileWithInputSize(File(croppedImage.path), Constants.fileSize200)) {
          SnackBarUtil.showInfoSnackBar(
            locale.file_size_too_large,
          );
        } else {
          _uploadDocumentRequest(File(croppedImage.path), taskDataFormField);
        }
      }
    }
  }

  /// Uploads a document to the server.
  ///
  /// This function converts a document image to base64, creates an upload request, and sends it to the server.
  void _uploadDocumentRequest(File image, DocumentStateData taskDataFormField) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String base64 = AppUtil.getBase64OfFile(image);
    final UploadDocumentRequestData uploadDocumentRequestData = UploadDocumentRequestData();
    uploadDocumentRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    uploadDocumentRequestData.documentData = base64;
    uploadDocumentRequestData.trackingNumber = const Uuid().v4();

    taskDataFormField.isUploading = true;
    update();

    DocumentServices.uploadDocumentRequest(
      uploadDocumentRequestData: uploadDocumentRequestData,
    ).then((result) {
      taskDataFormField.isUploading = false;
      update();

      switch (result) {
        case Success(value: (final UploadDocumentResponseData response, int _)):
          taskDataFormField.documentId = response.data!.documentId;
          taskDataFormField.documentFile = image;
          update();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void deleteDocument(DocumentStateData taskDataFormField) {
    taskDataFormField.documentFile = null;
    taskDataFormField.documentId = null;
    update();
  }

  void validateDocumentEdit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;
    for (final DocumentStateData documentStateData in documentStateDataList) {
      if (documentStateData.isRejected() && documentStateData.documentId == null) {
        isValid = false;
        break;
      }
    }
    if (isValid) {
      _completeEditDocumentRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_re_upload_all_doc,
      );
    }
  }

  /// Sends a request to complete an edit document task,
  /// updates the UI, and potentially navigates back or shows an error message.
  void _completeEditDocumentRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<EditDocumentData> editDocumentDataList = [];
    for (final DocumentStateData documentStateData in documentStateDataList) {
      if (documentStateData.isRejected()) {
        editDocumentDataList.add(
          EditDocumentData(
            id: documentStateData.id.id!,
            documentId: documentStateData.documentId!,
          ),
        );
      } else {
        editDocumentDataList.add(
          EditDocumentData(
            id: documentStateData.id.id!,
            documentId: documentStateData.id.value!.subValue!,
          ),
        );
      }
    }

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteEditDocumentsTaskData(
        editDocumentList: editDocumentDataList,
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
