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
import '../../../model/bpms/rayan_card_facility/request/complete_customer_location_task_data.dart';
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

class RayanCardCustomerAddressController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();
  TextEditingController customerPostalCodeController = TextEditingController();

  bool isPostalCodeLoading = false;

  TextEditingController customerAddressController = TextEditingController();

  BPMSOwnershipData? selectedCustomerOwnershipData;

  bool isSelectedCustomerOwnershipValid = true;

  TextEditingController descriptionOwnershipController = TextEditingController();

  bool isDescriptionOwnershipValid = true;

  TextEditingController trackingCodeCustomerOwnershipController = TextEditingController();

  bool isTrackingCodeCustomerOwnershipValid = true;

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  bool isPostalCodeValid = true;

  bool isAddressValid = true;

  bool isLoading = false;

  bool isUploading = false;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;

  File? documentFile_1;

  String customerPostalCodeErrorMessage = '';

  String? cityName;

  bool isAddressInquirySuccessful = false;

  List<BPMSOwnershipData> ownershipData = [];

  RayanCardCustomerAddressController({required this.task, required this.taskData});

  @override
  void onInit() {
    ownershipData = AppUtil.getOwnershipList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void validateCustomerAddressInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _customerAddressInquiryRequest();
    } else {
      isPostalCodeValid = false;
      customerPostalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  /// Performs a customer address inquiry request based on the provided postal code.
  void _customerAddressInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = customerPostalCodeController.text;
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
          customerAddressInquiryResponseData = response;
          setCustomerTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          customerAddressInquiryResponseData = null;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getCustomerCity() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (customerAddressInquiryResponseData != null && cityName != null) {
      return cityName!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  String getCustomerProvince() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (customerAddressInquiryResponseData != null &&
        customerAddressInquiryResponseData!.data!.detail!.province != null) {
      return customerAddressInquiryResponseData!.data!.detail!.province!;
    } else {
      return locale.verify_postal_code_hint;
    }
  }

  void setCustomerOwnershipData(BPMSOwnershipData ownershipData) {
    selectedCustomerOwnershipData = ownershipData;
    update();
  }

  void setCustomerTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName = customerAddressInquiryResponseData!.data!.detail?.townShip ??
        customerAddressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && customerAddressInquiryResponseData!.data!.detail!.province != null) {
      isAddressInquirySuccessful = true;
      if (customerAddressInquiryResponseData!.data!.detail!.subLocality != null &&
          customerAddressInquiryResponseData!.data!.detail!.street != null &&
          customerAddressInquiryResponseData!.data!.detail!.street2 != null &&
          customerAddressInquiryResponseData!.data!.detail!.houseNumber != null &&
          customerAddressInquiryResponseData!.data!.detail!.floor != null) {
        customerAddressController.text =
            '${customerAddressInquiryResponseData!.data!.detail!.subLocality!}، ${customerAddressInquiryResponseData!.data!.detail!.street!}، ${customerAddressInquiryResponseData!.data!.detail!.street2!}،  پلاک ${customerAddressInquiryResponseData!.data!.detail!.houseNumber}، طبقه ${customerAddressInquiryResponseData!.data!.detail!.floor!}';
      }
    } else {
      customerAddressInquiryResponseData = null;
      update();
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_found_for_postal_code2,
      );
    }
  }

  /// Validates the customer's address and related information.
  void validateCustomerAddress() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      if (customerAddressInquiryResponseData != null) {
        isPostalCodeValid = true;
      } else {
        customerPostalCodeErrorMessage = locale.querying_zip_code;
        isPostalCodeValid = false;
        isValid = false;
      }
    } else {
      customerPostalCodeErrorMessage = locale.enter_valid_postal_code;
      isPostalCodeValid = false;
      isValid = false;
    }
    if (customerAddressController.text.length >= 3 &&
        RegexValue.virtualBranchAddressRegex.hasMatch(customerAddressController.text)) {
      isAddressValid = true;
    } else {
      isAddressValid = false;
      isValid = false;
    }
    if (selectedCustomerOwnershipData != null) {
      isSelectedCustomerOwnershipValid = true;
      if (selectedCustomerOwnershipData!.id == 2) {
        if (descriptionOwnershipController.text.isNotEmpty) {
          isDescriptionOwnershipValid = true;
        } else {
          isDescriptionOwnershipValid = false;
          isValid = false;
        }
      } else if (selectedCustomerOwnershipData!.id == 1) {
        if (trackingCodeCustomerOwnershipController.text.isNotEmpty) {
          isTrackingCodeCustomerOwnershipValid = true;
        } else {
          isTrackingCodeCustomerOwnershipValid = false;
          isValid = false;
        }
      }
    } else {
      isSelectedCustomerOwnershipValid = false;
      isValid = false;
    }
    if (_documentFileUUID_1 != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.please_upload_rental_contract_or_document,
      );
    }
    update();
    if (isValid) {
      _completeCustomerLocationRequest();
    }
  }

  /// Completes the customer location request by sending a complete task request to the server.
  void _completeCustomerLocationRequest() {
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
      taskData: CompleteCustomerLocationTaskData(
        applicantProvince: getCustomerProvince(),
        applicantCity: getCustomerCity(),
        applicantAddress: customerAddressController.text,
        applicantResidencyType: selectedCustomerOwnershipData!.key,
        applicantResidencyTrackingCode:
            selectedCustomerOwnershipData!.id == 1 ? trackingCodeCustomerOwnershipController.text : null,
        applicantResidencyDescription:
            selectedCustomerOwnershipData!.id == 2 ? descriptionOwnershipController.text : null,
        applicantResidencyDocumentId: _documentFileUUID_1!,
        applicantPostalCode: customerPostalCodeController.text,
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
    return selectedCustomerOwnershipData != null && selectedCustomerOwnershipData!.id == 2;
  }

  void clearPostalCodeTextField() {
    customerPostalCodeController.clear();
    isAddressInquirySuccessful = false;
    resetCustomerAddressInputs();
  }

  void resetCustomerAddressInputs() {
    customerAddressController.clear();
    isAddressValid = true;
    descriptionOwnershipController.clear();
    isDescriptionOwnershipValid = true;
    trackingCodeCustomerOwnershipController.clear();
    isTrackingCodeCustomerOwnershipValid = true;

    selectedCustomerOwnershipData = null;
    deleteDocument(1);
    update();
  }
}
