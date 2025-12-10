import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/document_completion/customer_document.dart';
import '../../../model/bpms/document_completion/request/complete_get_customer_documents_task_data.dart';
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
import '../../../util/file_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../main/main_controller.dart';

class DocumentCompletionGetCustomerDocumentsController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;
  final List<CustomerDocument> documents = [];
  final List<File?> documentFiles = [];
  final List<CustomerDocument> approvedDocuments = [];

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isUploading = false;

  int selectedDocumentId = 0;

  bool isLoading = false;

  DocumentCompletionGetCustomerDocumentsController({required this.task, required this.taskData}) {
    _handleAdditionalDocuments();
  }

  void _handleAdditionalDocuments() {
    final tempDocuments =
        List<CustomerDocument>.from(taskData[0].value!.subValue.map((x) => CustomerDocument.fromJson(x)));

    for (var i = 0; i < tempDocuments.length; i++) {
      final tempDocument = tempDocuments[i];
      tempDocument.index = i; // for sorting
      switch (tempDocument.status) {
        case null: // no document uploaded
          if (tempDocument.id != null) {
            // document uploaded but not checked
            approvedDocuments.add(tempDocument);
          } else {
            // no document uploaded
            documents.add(tempDocument);
            documentFiles.add(null);
          }
          break;
        case 1: // rejected
          final temp = tempDocument;
          temp.id = null;
          documents.add(temp);
          documentFiles.add(null);
          break;
        case 2: // approved
          approvedDocuments.add(tempDocument);
          break;
        default:
          final temp = tempDocument;
          temp.id = null;
          documents.add(temp);
          documentFiles.add(null);
          break;
      }
    }
  }

  /// Allows the user to select a document image, either by taking a new picture
  /// with the camera or choosing an existing image from the gallery.
  /// The selected image is then cropped and, if it meets the size requirements, uploaded.
  Future<void> selectDocumentImage({required int documentId, required ImageSource imageSource}) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    XFile? image;

    CropAspectRatio? cropAspectRatio;

    switch (documents[documentId].type) {
      // national card front image
      case 0:
        cropAspectRatio = const CropAspectRatio(ratioY: 3, ratioX: 5);
        break;
      case 1:
        // national card back image
        cropAspectRatio = const CropAspectRatio(ratioY: 3, ratioX: 5);
        break;
      case 2:
        // birth certificate main image
        cropAspectRatio = null;
        break;
      case 3:
        // birth certificate comments image
        cropAspectRatio = null;
        break;
      default:
        break;
    }

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
        aspectRatio: cropAspectRatio,
        compressQuality: Constants.compressQuality100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: locale.crop_picture,
              toolbarColor: ThemeUtil.primaryColor,
              toolbarWidgetColor: Colors.white,
              hideBottomControls: false,
              lockAspectRatio: false),
          IOSUiSettings(title: locale.crop_picture, cancelButtonTitle: locale.cancel_laghv, doneButtonTitle: locale.confirmation)
        ],
      );
      if (croppedImage != null) {
        File? tempUserFile;
        final compressQuality = await AppUtil.getFileCompressQuality(
            file: File(croppedImage.path), maxFileSize: Constants.customerDocumentMaxSize);
        if (compressQuality < 100) {
          final result = await FlutterImageCompress.compressAndGetFile(
              croppedImage.path, FileUtil().generateImageUuidJpgPath(),
              quality: compressQuality);
          if (result != null) {
            tempUserFile = File(result.path);
          }
        } else {
          tempUserFile = File(croppedImage.path);
        }

        _uploadDocumentRequest(tempUserFile!, documentId);
      }
    }
  }

  /// Uploads a document to the server.
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

  void validateFirstPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (!documents.map((e) => e.id).toList().contains(null)) {
      _completeGetCustomerDocumentsRequest();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.warning,
        message: locale.upload_and_select_all_page,
      );
    }
  }

  /// Completes the "GetCustomer Documents" request by sending a request
  /// to the backend with the customer's document information.
  void _completeGetCustomerDocumentsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final List<CustomerDocument> tempDocuments = _handleTempDocuments();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: GetCustomerDocumentsTaskData(
        requiredCustomerDocuments: RequiredCustomerDocuments(
          value: CustomerDocumentValue(
            customerDocuments: tempDocuments,
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
          mainController.authInfoData!.shabahangCustomerStatus = 2;
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

  List<CustomerDocument> _handleTempDocuments() {
    final List<CustomerDocument> tempDocuments = [];
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
