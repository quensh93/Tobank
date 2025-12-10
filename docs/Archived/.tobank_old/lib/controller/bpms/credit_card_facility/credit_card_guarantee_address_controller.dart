import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/address/request/address_inquiry_request_data.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../model/bpms/bpms_ownership_data.dart';
import '../../../model/bpms/credit_card_facility/request/complete_guarantor_location_task_data.dart';
import '../../../model/bpms/request/complete_task_request_data.dart';
import '../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../model/document/request/upload_document_request_data.dart';
import '../../../model/document/response/upload_document_response_data.dart';
import '../../../service/bpms_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/document_services.dart';
import '../../../service/update_address_services.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/regexes.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CreditCardGuaranteeAddressController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  TextEditingController guaranteePostalCodeController = TextEditingController();

  bool isPostalCodeLoading = false;

  bool isGuaranteePostalCodeValid = true;

  TextEditingController guaranteeAddressController = TextEditingController();

  bool isGuaranteeAddressValid = true;
  BPMSOwnershipData? selectedGuaranteeOwnershipData;

  bool isSelectedGuaranteeOwnershipValid = true;

  TextEditingController guaranteeDescriptionOwnershipController = TextEditingController();

  bool isGuaranteeDescriptionOwnershipValid = true;

  AddressInquiryResponseData? guaranteeAddressInquiryResponseData;

  TextEditingController trackingCodeGuaranteeOwnershipController = TextEditingController();

  bool isTrackingCodeGuaranteeOwnershipValid = true;

  bool isUploading = false;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;
  File? documentFile_1;

  String guaranteePostalCodeErrorMessage = '';

  String? cityName;

  bool isAddressInquirySuccessful = false;

  List<BPMSOwnershipData> ownershipData = [];

  CreditCardGuaranteeAddressController({required this.task, required this.taskData});

  @override
  void onInit() {
    ownershipData = AppUtil.getOwnershipList();
    super.onInit();
  }

  /// Validates the guarantee's postal code
  /// and if valid, initiates an address inquiry request.
  void validateGuaranteeAddressInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (guaranteePostalCodeController.text.length == Constants.postalCodeLength) {
      isGuaranteePostalCodeValid = true;
      _guaranteeAddressInquiryRequest();
    } else {
      guaranteePostalCodeErrorMessage = locale.enter_valid_postal_code;
      isGuaranteePostalCodeValid = false;
    }
    update();
  }

  /// Performs an address inquiry request for the guarantee using the provided postal code.
  void _guaranteeAddressInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = guaranteePostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isAddressInquirySuccessful = false;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isPostalCodeLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          guaranteeAddressInquiryResponseData = response;
          setGuaranteeTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          guaranteeAddressInquiryResponseData = null;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getGuaranteeProvince() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (guaranteeAddressInquiryResponseData != null &&
        guaranteeAddressInquiryResponseData!.data!.detail!.province != null) {
      return guaranteeAddressInquiryResponseData!.data!.detail!.province!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  String getGuaranteeCity() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (guaranteeAddressInquiryResponseData != null && cityName != null) {
      return cityName!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  void setOwnershipData(BPMSOwnershipData ownershipData) {
    selectedGuaranteeOwnershipData = ownershipData;
    update();
  }

  /// Validates the guarantee's address information
  /// and, if valid, proceeds with the guarantor location request.
  void validateGuaranteeAddress() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (guaranteePostalCodeController.text.length == Constants.postalCodeLength) {
      if (guaranteeAddressInquiryResponseData != null) {
        isGuaranteePostalCodeValid = true;
      } else {
        guaranteePostalCodeErrorMessage = locale.verify_postal_code_hint;
        isGuaranteePostalCodeValid = false;
        isValid = false;
      }
    } else {
      guaranteePostalCodeErrorMessage = locale.enter_valid_postal_code;
      isGuaranteePostalCodeValid = false;
      isValid = false;
    }
    if (guaranteeAddressController.text.length >= 3 &&
        RegexValue.virtualBranchAddressRegex.hasMatch(guaranteeAddressController.text)) {
      isGuaranteeAddressValid = true;
    } else {
      isGuaranteeAddressValid = false;
      isValid = false;
    }
    if (selectedGuaranteeOwnershipData != null) {
      isSelectedGuaranteeOwnershipValid = true;
      if (selectedGuaranteeOwnershipData!.id == 2) {
        if (guaranteeDescriptionOwnershipController.text.isNotEmpty) {
          isGuaranteeDescriptionOwnershipValid = true;
        } else {
          isGuaranteeDescriptionOwnershipValid = false;
          isValid = false;
        }
      } else if (selectedGuaranteeOwnershipData!.id == 1) {
        if (trackingCodeGuaranteeOwnershipController.text.isNotEmpty) {
          isTrackingCodeGuaranteeOwnershipValid = true;
        } else {
          isTrackingCodeGuaranteeOwnershipValid = false;
          isValid = false;
        }
      }
    } else {
      isSelectedGuaranteeOwnershipValid = false;
      isValid = false;
    }
    update();
    if (_documentFileUUID_1 != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.please_upload_rental_contract_or_document,
      );
    }
    if (isValid) {
      _completeGuarantorLocationRequest();
    }
  }

  /// Completes the guarantor location request by sending a request
  /// to the backend with the guarantor's address information.
  void _completeGuarantorLocationRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteGuarantorLocationTaskData(
        guarantorProvince: getGuaranteeProvince(),
        guarantorCity: getGuaranteeCity(),
        guarantorAddress: guaranteeAddressController.text,
        guarantorResidencyType: selectedGuaranteeOwnershipData!.key,
        guarantorResidencyTrackingCode:
            selectedGuaranteeOwnershipData!.id == 1 ? trackingCodeGuaranteeOwnershipController.text : null,
        guarantorResidencyDescription:
            selectedGuaranteeOwnershipData!.id == 2 ? guaranteeDescriptionOwnershipController.text : null,
        guarantorResidencyDocumentId: _documentFileUUID_1!,
        guarantorPostalCode: guaranteePostalCodeController.text,
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

  /// Sets the guarantee's address information in the UI text controllers
  /// based on the address inquiry response data.
  void setGuaranteeTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName = guaranteeAddressInquiryResponseData!.data!.detail?.townShip ??
        guaranteeAddressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && guaranteeAddressInquiryResponseData!.data!.detail!.province != null) {
      isAddressInquirySuccessful = true;
      if (guaranteeAddressInquiryResponseData!.data!.detail!.subLocality != null &&
          guaranteeAddressInquiryResponseData!.data!.detail!.street != null &&
          guaranteeAddressInquiryResponseData!.data!.detail!.street2 != null &&
          guaranteeAddressInquiryResponseData!.data!.detail!.houseNumber != null &&
          guaranteeAddressInquiryResponseData!.data!.detail!.floor != null) {
        guaranteeAddressController.text =
            '${guaranteeAddressInquiryResponseData!.data!.detail!.subLocality!}، ${guaranteeAddressInquiryResponseData!.data!.detail!.street!}، ${guaranteeAddressInquiryResponseData!.data!.detail!.street2!}،  پلاک ${guaranteeAddressInquiryResponseData!.data!.detail!.houseNumber}، طبقه ${guaranteeAddressInquiryResponseData!.data!.detail!.floor!}';
      }
    } else {
      guaranteeAddressInquiryResponseData = null;
      update();
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_found_for_postal_code2,
      );
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
    }
    update();
  }

  bool isUploaded(int documentId) {
    if (documentId == 1) {
      return _documentFileUUID_1 != null;
    }
    return false;
  }

  void deleteDocument(int documentId) {
    if (documentId == 1) {
      _documentFileUUID_1 = null;
      documentFile_1 = null;
    }
    update();
  }

  bool isOtherOwnershipSelected() {
    return selectedGuaranteeOwnershipData != null && selectedGuaranteeOwnershipData!.id == 2;
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
