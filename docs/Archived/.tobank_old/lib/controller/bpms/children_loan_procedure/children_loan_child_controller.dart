import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/children_loan/request/complete_children_info_task_data.dart';
import '../../../model/bpms/document_file_data.dart';
import '../../../model/bpms/request/check_personal_info_request_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/document/request/upload_document_request_data.dart';
import '../../../model/document/response/upload_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../ui/common/date_selector_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class ChildrenLoanProcedureChildController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool isUploading = false;

  TextEditingController nationalCodeChildController = TextEditingController();

  bool isChildNationalCodeValid = true;

  TextEditingController birthdayDateChildController = TextEditingController();

  bool isChildDateValid = true;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;
  String? _documentFileUUID_2;
  String? _documentFileUUID_3;

  File? documentFile_1;
  File? documentFile_2;
  File? documentFile_3;

  String initDateString = '';

  String dateJalaliString = '';

  ChildrenLoanProcedureChildController({required this.task, required this.taskData});

  @override
  void onInit() {
    initDateString = AppUtil.twentyYearsBeforeNow();
    super.onInit();
  }

  /// Hide keyboard & show date picker dialog modal
  void showSelectDateDialog({required int birthDayId}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
        elevation: 0,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initDateString,
            title: locale.select_birth_date,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              birthdayDateChildController.text = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
  }

  void validateChildCheck() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (nationalCodeChildController.text.length == Constants.nationalCodeLength &&
        AppUtil.validateNationalCode(nationalCodeChildController.text)) {
      isChildNationalCodeValid = true;
    } else {
      isChildNationalCodeValid = false;
      isValid = false;
    }
    if (birthdayDateChildController.text.isNotEmpty) {
      isChildDateValid = true;
    } else {
      isValid = false;
      isChildDateValid = false;
    }
    update();
    if (isValid) {
      _checkPersonalInfoChildRequest();
    }
  }

  /// Verifies personal information of a child and proceeds based on the result.
  void _checkPersonalInfoChildRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CheckPersonalInfoRequestData checkPersonalInfoRequestData = CheckPersonalInfoRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: nationalCodeChildController.text,
      birthDate: DateConverterUtil.getTimestampFromJalali(
          date: birthdayDateChildController.text, extendDuration: const Duration(hours: 2)),
      nationalIdTrackingNumber: null,
      checkIdentificationData: true,
      checkBadCredit: false,
      checkBankCIF: false,
    );

    isLoading = true;
    update();

    BPMSServices.checkPersonalInfo(
      checkPersonalInfoRequestData: checkPersonalInfoRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showPositiveDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  void validateChildBirthCertificate() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = false;
    if (_documentFileUUID_1 != null && _documentFileUUID_2 != null && _documentFileUUID_3 != null) {
      isValid = true;
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(locale.upload_and_select_all_page);
    }
    if (isValid) {
      _completeChildrenInfoRequest();
    }
  }

  /// Completes a task with child information and document IDs.
  void _completeChildrenInfoRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteChildrenInfoTaskData(
        childNationalId: nationalCodeChildController.text,
        childBirthDate: DateConverterUtil.getTimestampFromJalali(
            date: birthdayDateChildController.text, extendDuration: const Duration(hours: 2)),
        childBirthCertificateFirstDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_1!,
            status: null,
            title: null,
            description: null,
          ),
        ),
        childBirthCertificateSecondDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_2!,
            status: null,
            title: null,
            description: null,
          ),
        ),
        childBirthCertificateThirdDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_3!,
            status: null,
            title: null,
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
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Allows the user to select and process an image for a document.
  ///
  /// This function handles selecting an image from either the camera or the gallery based on the `imageSource`.
  /// After selection, it crops the image and checks its size.
  /// If the size is within the allowed limit, it calls `_uploadDocumentRequest` to upload the image.
  /// Otherwise, it shows a snackBar indicating that the file size is too large.
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
  /// This function converts a document image to base64, creates an upload request, and sends it to the server.
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
    if (documentId == 1) {
      _documentFileUUID_1 = response.data!.documentId;
      documentFile_1 = image;
    } else if (documentId == 2) {
      _documentFileUUID_2 = response.data!.documentId;
      documentFile_2 = image;
    } else if (documentId == 3) {
      _documentFileUUID_3 = response.data!.documentId;
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

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
