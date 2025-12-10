import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/address/request/address_inquiry_request_data.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../service/core/api_core.dart';
import '../../../service/update_address_services.dart';
import '../../../ui/camera_capture/camera_capture_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/regexes.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_8_request_data.dart';
import '../../model/bpms/parsa_loan/request/upload_document_request_data.dart';
import '../../model/bpms/parsa_loan/response/residency_type_list_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/parsa_lending_upload_document_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/parsa_loan_services.dart';
import '../../util/dialog_util.dart';
import '../main/main_controller.dart';

class ParsaLoanCustomerAddressController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  String? errorTitle = '';
  bool hasError = false;

  TextEditingController customerPostalCodeController = TextEditingController();

  bool isPostalCodeLoading = false;

  TextEditingController provinceController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController customerAddressController = TextEditingController();

  ResidencyType? selectedCustomerOwnershipData;

  bool isSelectedCustomerOwnershipValid = true;

  TextEditingController descriptionOwnershipController = TextEditingController();

  bool isDescriptionOwnershipValid = true;

  TextEditingController trackingCodeCustomerOwnershipController = TextEditingController();

  bool isTrackingCodeCustomerOwnershipValid = true;

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  bool isPostalCodeValid = true;

  bool isProvinceValid = true;

  bool isCityValid = true;

  bool isAddressValid = true;

  bool isLoading = false;

  bool isUploading = false;

  int selectedDocumentId = 0;

  String? _documentFileUUID_1;

  File? documentFile_1;

  String customerPostalCodeErrorMessage = '';

  String? cityName;

  bool isAddressInquirySuccessful = false;

  List<ResidencyType> ownershipData = [];

  final String trackingNumber;

  ParsaLoanCustomerAddressController({required this.trackingNumber});

  bool isShowAddress = true;
  bool isShowOwnership = true;

  @override
  void onInit() {
    getResidencyTypeListRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void getResidencyTypeListRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    ParsaLoanServices.getResidencyTypeListRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ResidencyTypeListResponseData response, int _)):
          ownershipData = response.data!;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showAttentionDialogMessage(
              buildContext: Get.context!,
              description: apiException.displayMessage,
              positiveMessage: locale.understood_button,
              positiveFunction: () {
                Get.back();
                getResidencyTypeListRequest();
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

  void validateCustomerAddressInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (customerPostalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _customerAddressInquiryRequest();
    } else {
      isPostalCodeValid = false;
      customerPostalCodeErrorMessage = locale.invalid_postal_code;
    }
    update();
  }

  void _customerAddressInquiryRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = customerPostalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isAddressInquirySuccessful = false;
    update();

    UpdateAddressServices.addressInquiryRequest(addressInquiryRequestData: addressInquiryRequestData).then((result) {
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

  void setCustomerOwnershipData(ResidencyType ownershipData) {
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
      cityController.text = cityName ?? '';
      isCityValid = true;
      provinceController.text = customerAddressInquiryResponseData!.data!.detail!.province ?? '';
      isProvinceValid = true;
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
      customerPostalCodeErrorMessage = locale.invalid_postal_code;
      isPostalCodeValid = false;
      isValid = false;
    }
    if (cityController.text.trim().isNotEmpty) {
      isCityValid = true;
    } else {
      isCityValid = false;
      isValid = false;
    }
    if (provinceController.text.trim().isNotEmpty) {
      isProvinceValid = true;
    } else {
      isProvinceValid = false;
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
      if (selectedCustomerOwnershipData!.type == 'RENTAL') {
        if (trackingCodeCustomerOwnershipController.text.isNotEmpty) {
          isTrackingCodeCustomerOwnershipValid = true;
        } else {
          isTrackingCodeCustomerOwnershipValid = false;
          isValid = false;
        }
      } else if (selectedCustomerOwnershipData!.type == 'OTHERS') {
        if (descriptionOwnershipController.text.isNotEmpty) {
          isDescriptionOwnershipValid = true;
        } else {
          isDescriptionOwnershipValid = false;
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
        locale.please_upload_lease_or_document_image,
      );
    }
    update();
    if (isValid) {
      _completeTask();
    }
  }

  void _completeTask() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final taskCompleteState8RequestData = TaskCompleteState8RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerAddressInfo',
      taskData: [
        {
          'name': 'postalCode',
          'value': customerPostalCodeController.text,
        },
        {
          'name': 'address',
          'value': customerAddressController.text,
        },
        {
          'name': 'addressDocument',
          'value': _documentFileUUID_1,
        },
        {
          'name': 'residencyType',
          'value': selectedCustomerOwnershipData?.type,
        },
        {
          'name': 'description',
          'value': descriptionOwnershipController.text,
        },
        {
          'name': 'leaseTrackingCode',
          'value': trackingCodeCustomerOwnershipController.text,
        },
      ],
    );

    ParsaLoanServices.parsaLendingState8CompleteTaskRequest(
      taskCompleteState8RequestData: taskCompleteState8RequestData,
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
      _documentFileUUID_1 = response.data!.id;
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

  bool isNeedDescription() {
    return selectedCustomerOwnershipData != null && selectedCustomerOwnershipData!.needsDescription!;
  }

  void clearPostalCodeTextField() {
    customerPostalCodeController.clear();
    isAddressInquirySuccessful = false;
    resetCustomerAddressInputs();
  }

  void resetCustomerAddressInputs() {
    customerAddressController.clear();
    isProvinceValid = true;
    provinceController.clear();
    isCityValid = true;
    cityController.clear();
    isAddressValid = true;
    descriptionOwnershipController.clear();
    isDescriptionOwnershipValid = true;
    trackingCodeCustomerOwnershipController.clear();
    isTrackingCodeCustomerOwnershipValid = true;

    selectedCustomerOwnershipData = null;
    deleteDocument(1);
    update();
  }

  void toggleIsShowAddress() {
    isShowAddress = !isShowAddress;
    update();
  }

  void toggleIsShowOwnership() {
    isShowOwnership = !isShowOwnership;
    update();
  }
}
