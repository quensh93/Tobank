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
import '../../../model/bpms/military_guarantee/request/complete_edit_customer_location_task_data.dart';
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

class MillitaryGuaranteeCustomerAddressController extends GetxController {
  final Task task;
  final List<TaskDataFormField> taskData;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  BPMSOwnershipData? selectedCustomerOwnershipData;

  bool isSelectedCustomerOwnershipValid = true;

  TextEditingController descriptionOwnershipController = TextEditingController();

  bool isDescriptionOwnershipValid = true;

  TextEditingController trackingCodeCustomerOwnershipController = TextEditingController();

  bool isTrackingCodeCustomerOwnershipValid = true;

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  TextEditingController customerPostalCodeController = TextEditingController();
  bool isPostalCodeValid = true;

  bool isPostalCodeLoading = false;
  String customerPostalCodeErrorMessage = '';

  String? cityName;

  TextEditingController customerProvinceController = TextEditingController();
  bool isCustomerProvinceValid = true;

  TextEditingController customerCityController = TextEditingController();
  bool isCustomerCityValid = true;

  TextEditingController customerTownshipController = TextEditingController();
  bool isCustomerTownshipValid = true;

  TextEditingController customerLastStreetController = TextEditingController();
  bool isCustomerLastStreetValid = true;

  TextEditingController customerSecondLastStreetController = TextEditingController();
  bool isCustomerSecondLastStreetValid = true;

  TextEditingController customerPlaqueController = TextEditingController();
  bool isCustomerPlaqueValid = true;

  TextEditingController customerUnitController = TextEditingController();
  bool isCustomerUnitValid = true;

  bool isLoading = false;

  bool isUploading = false;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;
  File? documentFile_1;
  String? documentFileDescription_1;

  bool isCustomerAddressInquirySuccessful = false;

  List<BPMSOwnershipData> ownershipData = [];

  MillitaryGuaranteeCustomerAddressController({required this.task, required this.taskData}) {
    _getDataFromTaskData();
  }

  @override
  void onInit() {
    ownershipData = AppUtil.getOwnershipList();
    super.onInit();
  }

  void _getDataFromTaskData() {
    for (final formField in taskData) {
      if (formField.value?.subValue != null) {
        switch (formField.id) {
          case 'applicantResidencyType':
            final ownershipList = AppUtil.getOwnershipList();
            final selectedOwnership =
                ownershipList.firstWhereOrNull((element) => element.key == formField.value!.subValue!);
            if (selectedOwnership != null) {
              setCustomerOwnershipData(selectedOwnership);
            }
            break;
          case 'applicantResidencyDescription':
            descriptionOwnershipController.text = formField.value!.subValue!;
            break;
          case 'applicantResidencyTrackingCode':
            trackingCodeCustomerOwnershipController.text = formField.value!.subValue!;
            break;
          case 'applicantResidencyDocument':
            final documentValue = formField.value!.subValue! as Map<String, dynamic>;
            documentFileDescription_1 = documentValue['description'];
            break;
        }
      }
    }
    update();
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

  /// Performs a postal code inquiry to retrieve address information for a customer.
  void _customerAddressInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = customerPostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;
    isCustomerAddressInquirySuccessful = false;
    isPostalCodeLoading = true;
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
      isCustomerAddressInquirySuccessful = true;
      customerTownshipController.text = customerAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isCustomerTownshipValid = true;
      customerCityController.text = cityName ?? '';
      isCustomerCityValid = true;
      customerProvinceController.text = customerAddressInquiryResponseData!.data!.detail!.province ?? '';
      isCustomerProvinceValid = true;
      final detail = customerAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        customerLastStreetController =
            TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isCustomerLastStreetValid = true;
        customerSecondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isCustomerSecondLastStreetValid = true;
      } else {
        customerLastStreetController.text = '';
        customerSecondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        customerUnitController = TextEditingController(text: detail?.sideFloor);
        isCustomerUnitValid = true;
      } else {
        customerUnitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      customerPlaqueController = TextEditingController(text: (plaqueInt).toString());
      isCustomerPlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
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
      isPostalCodeValid = true;
    } else {
      isPostalCodeValid = false;
      isValid = false;
    }
    if (customerLastStreetController.text.trim().length > 3) {
      isCustomerLastStreetValid = true;
    } else {
      isCustomerLastStreetValid = false;
      isValid = false;
    }
    if (customerSecondLastStreetController.text.trim().length > 3) {
      isCustomerSecondLastStreetValid = true;
    } else {
      isCustomerSecondLastStreetValid = false;
      isValid = false;
    }
    if (customerPlaqueController.text.trim().isNotEmpty) {
      isCustomerPlaqueValid = true;
    } else {
      isCustomerPlaqueValid = false;
      isValid = false;
    }
    if (customerUnitController.text.trim().isNotEmpty) {
      isCustomerUnitValid = true;
    } else {
      isCustomerUnitValid = false;
      isValid = false;
    }
    if (customerCityController.text.trim().isNotEmpty) {
      isCustomerCityValid = true;
    } else {
      isCustomerCityValid = false;
      isValid = false;
    }
    if (customerTownshipController.text.trim().isNotEmpty) {
      isCustomerTownshipValid = true;
    } else {
      isCustomerTownshipValid = false;
      isValid = false;
    }
    if (customerProvinceController.text.trim().isNotEmpty) {
      isCustomerProvinceValid = true;
    } else {
      isCustomerProvinceValid = false;
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
      _completeEditCustomerLocationRequest();
    }
  }

  /// Completes the edit customer location request by sending a complete task request to the server.
  void _completeEditCustomerLocationRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CompleteTaskRequest completeTaskRequest = CompleteTaskRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      nationalId: mainController.authInfoData!.nationalCode!,
      personalityType: 0,
      trackingNumber: const Uuid().v4(),
      taskId: task.id!,
      taskData: CompleteEditCustomerLocationTaskData(
        applicantAddress: BPMSAddress(
          value: BPMSAddressValue(
            postalCode: int.parse(customerPostalCodeController.text),
            province: customerProvinceController.text,
            township: customerTownshipController.text,
            city: customerCityController.text,
            village: customerAddressInquiryResponseData!.data!.detail?.village ?? '',
            localityName: customerAddressInquiryResponseData!.data!.detail?.localityName ?? '',
            lastStreet: customerLastStreetController.text,
            secondLastStreet: customerSecondLastStreetController.text,
            alley: '',
            plaque: int.tryParse(customerPlaqueController.text) ?? 1,
            unit: int.tryParse(customerUnitController.text) ?? 0,
            description: customerAddressInquiryResponseData!.data!.detail?.description ?? '',
            latitude: null,
            longitude: null,
          ),
        ),
        applicantResidencyType: selectedCustomerOwnershipData!.key,
        applicantResidencyTrackingCode:
            selectedCustomerOwnershipData!.id == 1 ? trackingCodeCustomerOwnershipController.text : null,
        applicantResidencyDescription:
            selectedCustomerOwnershipData!.id == 2 ? descriptionOwnershipController.text : null,
        applicantResidencyDocument: DocumentFile(
          value: DocumentFileValue(
            id: _documentFileUUID_1,
            status: 0,
            title: 'residencyDocument',
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

  /// Selects a document image from either the camera or gallery.
  Future<void> selectDocumentImage({required int documentId, required ImageSource imageSource}) async {
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
    if (image != null) {//locale
      final locale = AppLocalizations.of(Get.context!)!;
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
