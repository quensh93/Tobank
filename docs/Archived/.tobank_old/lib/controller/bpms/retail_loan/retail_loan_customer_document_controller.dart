import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/bpms/retail_loan/request/complete_customer_documents_task_data.dart';
import '../../../model/document/request/upload_document_request_data.dart';
import '../../../model/document/response/upload_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../main/main_controller.dart';

class RetailLoanCustomerDocumentController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isUploading = false;

  int selectedDocumentId = 0;

  File? documentFile_1;
  File? documentFile_2;
  File? documentFile_3;
  File? documentFile_4;
  File? documentFile_5;

  String? _documentFileUUID_1;
  String? _documentFileUUID_2;
  String? _documentFileUUID_3;
  String? _documentFileUUID_4;
  String? _documentFileUUID_5;

  bool isLoading = false;

  RetailLoanCustomerDocumentController({required this.task, required this.taskData});

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

  void validateCustomerBirthCertificate() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (_documentFileUUID_1 != null &&
        _documentFileUUID_2 != null &&
        _documentFileUUID_3 != null &&
        _documentFileUUID_4 != null) {
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
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteCustomerDocumentsTaskData(
        applicantBirthCertificateMarriageDocumentId: _documentFileUUID_1!,
        applicantBirthCertificateChildrenDocumentId: _documentFileUUID_2!,
        applicantBirthCertificateDeathInfoDocumentId: _documentFileUUID_3!,
        applicantEmploymentDocumentId: _documentFileUUID_4!,
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

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
