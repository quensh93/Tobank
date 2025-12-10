import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../model/bpms/bpms_warranty_data.dart';
import '../../../model/bpms/marriage_loan/request/complete_customer_collateral_info_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/document/request/upload_document_request_data.dart';
import '../../../model/document/response/upload_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../ui/bpms/marriage_loan_procedure/marriage_loan_add_warranty/warranty_view/customer_cheque_warranty_widget.dart';
import '../../../ui/bpms/marriage_loan_procedure/marriage_loan_add_warranty/warranty_view/customer_demand_note_warranty_widget.dart';
import '../../../ui/bpms/marriage_loan_procedure/marriage_loan_add_warranty/warranty_view/customer_salary_warranty_widget.dart';
import '../../../ui/bpms/marriage_loan_procedure/marriage_loan_add_warranty/warranty_view/support_cheque_warranty_widget.dart';
import '../../../ui/bpms/marriage_loan_procedure/marriage_loan_add_warranty/warranty_view/support_salary_warranty_widget.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class MarriageLoanProcedureAddWarrantyController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool isSelectedWarrantyDataValid = true;

  bool isUploading = false;

  BPMSWarrantyData? selectedWarrantyData;

  List<CollateralInfoElement> collaterals = [];
  List<File?> collateralsImages = [];

  int selectedDocumentId = 0;

  bool isShowWarrantyList = false;

  TextEditingController chequeIdController = TextEditingController();

  bool isChequeIdValid = true;

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  MarriageLoanProcedureAddWarrantyController({required this.task, required this.taskData}) {
    final tempCollaterals = List<CollateralInfoElement>.from(
        jsonDecode(taskData[0].value!.subValue).map((x) => CollateralInfoElement.fromJson(x)));
    collaterals.addAll(tempCollaterals);
    collateralsImages = List.filled(collaterals.length, null);
  }

  Widget getWarrantyWidget(int pageIndex) {
    if (selectedWarrantyData == null) {
      return Container();
    } else {
      if (selectedWarrantyData!.id == 0) {
        return CustomerChequeWarrantyWidget(pageIndex: pageIndex);
      } else if (selectedWarrantyData!.id == 1) {
        return CustomerDemandNoteWarrantyWidget(pageIndex: pageIndex);
      } else if (selectedWarrantyData!.id == 2) {
        return CustomerSalaryWarrantyWidget(pageIndex: pageIndex);
      } else if (selectedWarrantyData!.id == 3) {
        return SupportChequeWarrantyWidget(pageIndex: pageIndex);
      } else if (selectedWarrantyData!.id == 4) {
        return SupportSalaryWarrantyWidget(pageIndex: pageIndex);
      } else {
        return Container();
      }
    }
  }

  /// Validates the warranty information on the specified page and,
  /// if valid, adds the guarantee to the list.
  void validateWarrantyPage(int indexPage) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (selectedWarrantyData != null) {
      if (selectedWarrantyData!.id == 0) {
        if (collaterals[indexPage].collateralDocumentId != null) {
        } else {
          isValid = false;
          SnackBarUtil.showInfoSnackBar(
            locale.please_select_cheque,
          );
        }
        if (chequeIdController.text.trim().isNotEmpty) {
          isChequeIdValid = true;
        } else {
          isValid = false;
          isChequeIdValid = false;
        }
      } else if (selectedWarrantyData!.id == 1) {
      } else if (selectedWarrantyData!.id == 2) {
        if (collaterals[indexPage].collateralDocumentId != null) {
        } else {
          isValid = false;
          SnackBarUtil.showInfoSnackBar(
            locale.please_select_applicant_salary_certificate,
          );
        }
      } else if (selectedWarrantyData!.id == 3) {
        if (collaterals[indexPage].collateralDocumentId != null) {
        } else {
          isValid = false;
          SnackBarUtil.showInfoSnackBar(
            locale.please_select_guarantor_cheque,
          );
        }
        if (chequeIdController.text.trim().isNotEmpty) {
          isChequeIdValid = true;
        } else {
          isValid = false;
          isChequeIdValid = false;
        }
      } else if (selectedWarrantyData!.id == 4) {
        if (collaterals[indexPage].collateralDocumentId != null) {
        } else {
          isValid = false;
          SnackBarUtil.showInfoSnackBar(
            locale.please_select_guarantor_salary_certificate,
          );
        }
      }
      update();
      if (isValid) {
        _addGuaranteeToList(indexPage);
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_guarantee_type,
      );
    }
  }

  /// Adds the guarantee information to the list
  /// and either proceeds to the next step
  /// or completes the customer collateral information request.
  void _addGuaranteeToList(int indexPage) {
    if (selectedWarrantyData!.id == 0 || selectedWarrantyData!.id == 3) {
      collaterals[indexPage].chequeNumber = chequeIdController.text;
    }
    collaterals[indexPage].collateralType = selectedWarrantyData!.collateralType;
    if (indexPage == collaterals.length - 1) {
      _completeCustomerCollateralInfoRequest();
    } else {
      chequeIdController.text = '';
      selectedWarrantyData = null;
      isShowWarrantyList = true;
      isSelectedWarrantyDataValid = true;
      isChequeIdValid = true;
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  /// Completes the customer collateral information request by sending a request
  /// to the backend with the collected collateral data.
  void _completeCustomerCollateralInfoRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteCustomerCollateralInfoTaskData(
        collateralInfo: collaterals,
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

  /// Allows the user to select a document image,
  /// either by taking a new picture with the camera or choosing an existing image from the gallery.
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
          _uploadDocumentRequest(File(croppedImage.path), documentId, collaterals[documentId].customerNumber!);
        }
      }
    }
  }

  /// Uploads a document to the server.
  void _uploadDocumentRequest(File image, int documentId, String customerNumber) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String base64 = AppUtil.getBase64OfFile(image);
    final UploadDocumentRequestData uploadDocumentRequestData = UploadDocumentRequestData();
    uploadDocumentRequestData.customerNumber = customerNumber;
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
    collaterals[documentId].collateralDocumentId = response.data!.documentId;
    collateralsImages[documentId] = image;
    update();
  }

  bool isUploaded(int documentId) {
    return collaterals[documentId].collateralDocumentId != null;
  }

  void deleteDocument(int documentId) {
    collaterals[documentId].collateralDocumentId = null;
    collateralsImages[documentId] = null;
    update();
  }

  void setWarrantyData(BPMSWarrantyData selectedWarrantyData) {
    this.selectedWarrantyData = selectedWarrantyData;
    isShowWarrantyList = false;
    update();
  }

  void toggleShowWarrantyList() {
    isShowWarrantyList = !isShowWarrantyList;
    update();
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    final NavigatorState navigator = Navigator.of(Get.context!);
    navigator.pop();
  }
}
