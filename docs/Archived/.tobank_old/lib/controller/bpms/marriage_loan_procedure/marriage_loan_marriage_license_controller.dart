import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/document_file_data.dart';
import '../../../model/bpms/marriage_loan/request/complete_marriage_license_task_data.dart';
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

class MarriageLoanProcedureMarriageLicenseController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool isUploading = false;

  bool licenseIsSinglePage = true;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;
  String? _documentFileUUID_2;
  String? _documentFileUUID_3;
  String? _documentFileUUID_4;
  String? _documentFileUUID_5;

  File? documentFile_1;
  File? documentFile_2;
  File? documentFile_3;
  File? documentFile_4;
  File? documentFile_5;

  MarriageLoanProcedureMarriageLicenseController({required this.task, required this.taskData});

  void setLicenseIsSinglePage() {
    licenseIsSinglePage = true;
    update();
  }

  void setLicenseIsMultiPage() {
    licenseIsSinglePage = false;
    update();
  }

  void radioOnChanged(bool? value) {
    licenseIsSinglePage = value!;
    update();
  }

  void validateMarriageLicense() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (licenseIsSinglePage) {
      if (_documentFileUUID_1 != null && _documentFileUUID_2 != null) {
      } else {
        isValid = false;
        SnackBarUtil.showInfoSnackBar(
          locale.upload_all_pages_,
        );
      }
    } else {
      if (_documentFileUUID_3 != null && _documentFileUUID_4 != null && _documentFileUUID_5 != null) {
      } else {
        isValid = false;
        SnackBarUtil.showInfoSnackBar(
          locale.upload_all_pages_,
        );
      }
    }

    if (isValid) {
      _completeMarriageLicenseRequest();
    }
  }

  /// Completes the marriage license request by sending a request
  /// to the backend with the uploaded document data.
  void _completeMarriageLicenseRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteompleMarriageLicenseTaskData taskData;

    if (licenseIsSinglePage) {
      taskData = CompleteompleMarriageLicenseTaskData(
        marriageLicenseType: '0',
        marriageNewLicenseFrontDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_1!,
            status: null,
            title: null,
            description: null,
          ),
        ),
        marriageNewLicenseBackDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_2!,
            status: null,
            title: null,
            description: null,
          ),
        ),
        marriageLicenseFirstDocument: null,
        marriageLicenseSecondDocument: null,
        marriageLicenseThirdDocument: null,
      );
    } else {
      taskData = CompleteompleMarriageLicenseTaskData(
        marriageLicenseType: '1',
        marriageNewLicenseFrontDocument: null,
        marriageNewLicenseBackDocument: null,
        marriageLicenseFirstDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_3!,
            status: null,
            title: null,
            description: null,
          ),
        ),
        marriageLicenseSecondDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_4!,
            status: null,
            title: null,
            description: null,
          ),
        ),
        marriageLicenseThirdDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_5!,
            status: null,
            title: null,
            description: null,
          ),
        ),
      );
    }

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: taskData,
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

  /// Allows the user to select a document image,
  /// either by taking a new picture with the camera
  /// or choosing an existing image from the gallery.
  /// The selected image is then cropped and, if it meets the size requirements, uploaded.
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

  /// Uploads a document to the server.
  ///
  /// @param documentId The ID of the document being uploaded.
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

  void _setUploadedDocument(int documentId, response, File image) {
    if (documentId == 1) {
      _documentFileUUID_1 = response.data!.documentId;
      documentFile_1 = image;
    } else if (documentId == 2) {
      _documentFileUUID_2 = response.data!.documentId;
      documentFile_2 = image;
    } else if (documentId == 3) {
      _documentFileUUID_3 = response.data!.documentId;
      documentFile_3 = image;
    } else if (documentId == 4) {
      _documentFileUUID_4 = response.data!.documentId;
      documentFile_4 = image;
    } else if (documentId == 5) {
      _documentFileUUID_5 = response.data!.documentId;
      documentFile_5 = image;
    }
    update();
  }

  bool isUploaded(int documentId) {
    if (documentId == 1) {
      return _documentFileUUID_1 != null;
    } else if (documentId == 2) {
      return _documentFileUUID_2 != null;
    } else if (documentId == 3) {
      return _documentFileUUID_3 != null;
    } else if (documentId == 4) {
      return _documentFileUUID_4 != null;
    } else if (documentId == 5) {
      return _documentFileUUID_5 != null;
    }
    return false;
  }

  void deleteDocument(int documentId) {
    if (documentId == 1) {
      _documentFileUUID_1 = null;
      documentFile_1 = null;
    } else if (documentId == 2) {
      _documentFileUUID_2 = null;
      documentFile_2 = null;
    } else if (documentId == 3) {
      _documentFileUUID_3 = null;
      documentFile_3 = null;
    } else if (documentId == 4) {
      _documentFileUUID_4 = null;
      documentFile_4 = null;
    } else if (documentId == 5) {
      _documentFileUUID_5 = null;
      documentFile_5 = null;
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
