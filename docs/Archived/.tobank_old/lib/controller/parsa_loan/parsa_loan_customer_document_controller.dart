import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_7_request_data.dart';
import '../../model/bpms/parsa_loan/request/upload_document_request_data.dart';
import '../../model/bpms/parsa_loan/response/task/parsa_lending_upload_document_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/parsa_loan_services.dart';
import '../main/main_controller.dart';

class ParsaLoanCustomerDocumentController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isUploading = false;

  int selectedDocumentId = 0;

  File? documentFile_1;
  File? documentFile_2;
  File? documentFile_3;

  String? _documentFileUUID_1;
  String? _documentFileUUID_2;
  String? _documentFileUUID_3;

  bool isLoading = false;

  final String trackingNumber;

  ParsaLoanCustomerDocumentController({required this.trackingNumber});

  void confirmRequiredDocumentList() {
    AppUtil.nextPageController(pageController, isClosed);
  }

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

  void _uploadDocumentRequest(File image, int documentId) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String base64 = AppUtil.getBase64OfFile(image);
    final UploadDocumentRequestData uploadDocumentRequestData = UploadDocumentRequestData();
    uploadDocumentRequestData.document = base64;

    isUploading = true;
    selectedDocumentId = documentId;
    update();

    ParsaLoanServices.parsaLendingUploadDocumentRequest(
      uploadDocumentRequestData: uploadDocumentRequestData,
    ).then((result) {
      isUploading = false;
      selectedDocumentId = 0;
      update();

      switch (result) {
        case Success(value: (final ParsaLendingUploadDocumentResponseData response, int _)):
          _setUploadedDocument(documentId, response, image);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _setUploadedDocument(int documentId, ParsaLendingUploadDocumentResponseData response, File image) {
    if (documentId == 1) {
      _documentFileUUID_1 = response.data!.id!;
      documentFile_1 = image;
    } else if (documentId == 2) {
      _documentFileUUID_2 = response.data!.id!;
      documentFile_2 = image;
    } else if (documentId == 3) {
      _documentFileUUID_3 = response.data!.id!;
      documentFile_3 = image;
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
    }
    update();
  }

  void validateCustomerBirthCertificate() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (_documentFileUUID_1 != null && _documentFileUUID_2 != null && _documentFileUUID_3 != null) {
      _completeTask();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.upload_and_select_all_page,
      );
    }
  }

  void _completeTask() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final taskCompleteState7RequestData = TaskCompleteState7RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerCertificateDocument',
      taskData: [
        {
          'name': 'firstPageCertificateDocumentId',
          'value': _documentFileUUID_1,
        },
        {
          'name': 'secondPageCertificateDocumentId',
          'value': _documentFileUUID_2,
        },
        {
          'name': 'descriptionPageCertificateDocumentId',
          'value': _documentFileUUID_3,
        }
      ],
    );

    ParsaLoanServices.parsaLendingState7CompleteTaskRequest(
      taskCompleteState7RequestData: taskCompleteState7RequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TaskCompleteResponseData response, int _)):
          AppUtil.handleParsaTask(taskList: response.data!.taskList, trackingNumber: trackingNumber);
          break;
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
