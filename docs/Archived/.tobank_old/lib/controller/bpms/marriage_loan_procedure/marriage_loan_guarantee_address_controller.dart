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
import '../../../model/bpms/common/bpms_address.dart';
import '../../../model/bpms/common/bpms_address_value.dart';
import '../../../model/bpms/document_file_data.dart';
import '../../../model/bpms/marriage_loan/request/complete_guarantor_location_task_data.dart';
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
import '../../../util/snack_bar_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../main/main_controller.dart';

class MarriageLoanProcedureGuaranteeAddressController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  BPMSOwnershipData? selectedGuaranteeOwnershipData;

  bool isSelectedGuaranteeOwnershipValid = true;

  TextEditingController descriptionOwnershipController = TextEditingController();

  bool isDescriptionOwnershipValid = true;

  TextEditingController trackingCodeGuaranteeOwnershipController = TextEditingController();

  bool isTrackingCodeGuaranteeOwnershipValid = true;

  AddressInquiryResponseData? guaranteeAddressInquiryResponseData;

  TextEditingController guaranteePostalCodeController = TextEditingController();
  bool isPostalCodeValid = true;

  bool isPostalCodeLoading = false;
  String guaranteePostalCodeErrorMessage = '';

  String? cityName;

  TextEditingController guaranteeProvinceController = TextEditingController();
  bool isGuaranteeProvinceValid = true;

  TextEditingController guaranteeCityController = TextEditingController();
  bool isGuaranteeCityValid = true;

  TextEditingController guaranteeTownshipController = TextEditingController();
  bool isGuaranteeTownshipValid = true;

  TextEditingController guaranteeLastStreetController = TextEditingController();
  bool isGuaranteeLastStreetValid = true;

  TextEditingController guaranteeSecondLastStreetController = TextEditingController();
  bool isGuaranteeSecondLastStreetValid = true;

  TextEditingController guaranteePlaqueController = TextEditingController();
  bool isGuaranteePlaqueValid = true;

  TextEditingController guaranteeUnitController = TextEditingController();
  bool isGuaranteeUnitValid = true;

  bool isLoading = false;

  bool isUploading = false;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;
  File? documentFile_1;
  String? documentFileDescription_1;

  bool isGuaranteeAddressInquirySuccessful = false;

  List<BPMSOwnershipData> ownershipData = [];

  MarriageLoanProcedureGuaranteeAddressController({required this.task, required this.taskData});

  @override
  void onInit() {
    ownershipData = AppUtil.getOwnershipList();
    super.onInit();
  }

  /// Validates the guarantee's postal code and,
  /// if valid, initiates a guarantee address inquiry request.
  void validateGuaranteeAddressInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (guaranteePostalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _guaranteeAddressInquiryRequest();
    } else {
      isPostalCodeValid = false;
      guaranteePostalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  /// Sends a request to inquire about the guarantee's address based on the provided postal code.
  void _guaranteeAddressInquiryRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = guaranteePostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;
    isGuaranteeAddressInquirySuccessful = false;
    isPostalCodeLoading = true;
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

  String getGuaranteeCity() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (guaranteeAddressInquiryResponseData != null && cityName != null) {
      return cityName!;
    } else {
      return locale.verify_postal_code_hint;
    }
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

  void setGuaranteeOwnershipData(BPMSOwnershipData ownershipData) {
    selectedGuaranteeOwnershipData = ownershipData;
    update();
  }

  /// Sets the text controllers for the guarantee's address fields based on the address inquiry response data.
  void setGuaranteeTextControllers() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName = guaranteeAddressInquiryResponseData!.data!.detail?.townShip ??
        guaranteeAddressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && guaranteeAddressInquiryResponseData!.data!.detail!.province != null) {
      isGuaranteeAddressInquirySuccessful = true;
      guaranteeTownshipController.text = guaranteeAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isGuaranteeTownshipValid = true;
      guaranteeCityController.text = cityName ?? '';
      isGuaranteeCityValid = true;
      guaranteeProvinceController.text = guaranteeAddressInquiryResponseData!.data!.detail!.province ?? '';
      isGuaranteeProvinceValid = true;
      final detail = guaranteeAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        guaranteeLastStreetController =
            TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isGuaranteeLastStreetValid = true;
        guaranteeSecondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isGuaranteeSecondLastStreetValid = true;
      } else {
        guaranteeLastStreetController.text = '';
        guaranteeSecondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        guaranteeUnitController = TextEditingController(text: detail?.sideFloor);
        isGuaranteeUnitValid = true;
      } else {
        guaranteeUnitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      guaranteePlaqueController = TextEditingController(text: (plaqueInt).toString());
      isGuaranteePlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
      );
    }
  }

  /// Validates the guarantee's address information
  /// and if valid, proceeds to complete the edit guarantee location request.
  void validateGuaranteeAddress() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (guaranteePostalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
    } else {
      isPostalCodeValid = false;
      isValid = false;
    }
    if (guaranteeLastStreetController.text.trim().length > 3) {
      isGuaranteeLastStreetValid = true;
    } else {
      isGuaranteeLastStreetValid = false;
      isValid = false;
    }
    if (guaranteeSecondLastStreetController.text.trim().length > 3) {
      isGuaranteeSecondLastStreetValid = true;
    } else {
      isGuaranteeSecondLastStreetValid = false;
      isValid = false;
    }
    if (guaranteePlaqueController.text.trim().isNotEmpty) {
      isGuaranteePlaqueValid = true;
    } else {
      isGuaranteePlaqueValid = false;
      isValid = false;
    }
    if (guaranteeUnitController.text.trim().isNotEmpty) {
      isGuaranteeUnitValid = true;
    } else {
      isGuaranteeUnitValid = false;
      isValid = false;
    }
    if (guaranteeCityController.text.trim().isNotEmpty) {
      isGuaranteeCityValid = true;
    } else {
      isGuaranteeCityValid = false;
      isValid = false;
    }
    if (guaranteeTownshipController.text.trim().isNotEmpty) {
      isGuaranteeTownshipValid = true;
    } else {
      isGuaranteeTownshipValid = false;
      isValid = false;
    }
    if (guaranteeProvinceController.text.trim().isNotEmpty) {
      isGuaranteeProvinceValid = true;
    } else {
      isGuaranteeProvinceValid = false;
      isValid = false;
    }

    if (selectedGuaranteeOwnershipData != null) {
      isSelectedGuaranteeOwnershipValid = true;
      if (selectedGuaranteeOwnershipData!.id == 2) {
        if (descriptionOwnershipController.text.isNotEmpty) {
          isDescriptionOwnershipValid = true;
        } else {
          isDescriptionOwnershipValid = false;
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
    if (_documentFileUUID_1 != null) {
    } else {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.please_upload_rental_contract_or_document,
      );
    }
    update();
    if (isValid) {
      _completeEditGuaranteeLocationRequest();
    }
  }

  /// Completes the edit guarantee location request by sending a request
  /// to the backend with the updated address information.
  void _completeEditGuaranteeLocationRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteGuarantorLocationTaskData(
        guarantorAddress: BPMSAddress(
          value: BPMSAddressValue(
            postalCode: int.parse(guaranteePostalCodeController.text),
            province: guaranteeProvinceController.text,
            township: guaranteeTownshipController.text,
            city: guaranteeCityController.text,
            village: guaranteeAddressInquiryResponseData!.data!.detail?.village ?? '',
            localityName: guaranteeAddressInquiryResponseData!.data!.detail?.localityName ?? '',
            lastStreet: guaranteeLastStreetController.text,
            secondLastStreet: guaranteeSecondLastStreetController.text,
            alley: '',
            plaque: int.tryParse(guaranteePlaqueController.text) ?? 1,
            unit: int.tryParse(guaranteeUnitController.text) ?? 0,
            description: guaranteeAddressInquiryResponseData!.data!.detail?.description ?? '',
            latitude: null,
            longitude: null,
          ),
        ),
        guarantorResidencyType: selectedGuaranteeOwnershipData!.key,
        guarantorResidencyTrackingCode:
            selectedGuaranteeOwnershipData!.id == 1 ? trackingCodeGuaranteeOwnershipController.text : null,
        guarantorResidencyDescription:
            selectedGuaranteeOwnershipData!.id == 2 ? descriptionOwnershipController.text : null,
        guarantorResidencyDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_1,
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

  /// Uploads a document image to the server.
  ///
  /// This function converts a document image to base64,
  /// creates an upload request, and sends it to the server.
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

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
