import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/core/api_core.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../model/address/request/address_inquiry_request_data.dart';
import '../../model/address/response/address_inquiry_response_data.dart';
import '../../model/bpms/parsa_loan/loan_detail.dart';
import '../../model/bpms/parsa_loan/request/task/task_complete_state_9_request_data.dart';
import '../../model/bpms/parsa_loan/request/upload_document_request_data.dart';
import '../../model/bpms/parsa_loan/response/occupation_list_response_data.dart';
import '../../model/bpms/parsa_loan/response/parsa_lending_get_loan_detail_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/parsa_lending_upload_document_response_data.dart';
import '../../model/bpms/parsa_loan/response/task/task_complete_response_data.dart';
import '../../service/parsa_loan_services.dart';
import '../../service/update_address_services.dart';
import '../../ui/camera_capture/camera_capture_screen.dart';
import '../../ui/parsa_loan/parsa_loan_employment_type/parsa_loan_select_employment_type_bottom_sheet.dart';
import '../../util/regexes.dart';
import '../../util/theme/theme_util.dart';
import '../main/main_controller.dart';

class ParsaLoanEmploymentTypeController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  String? errorTitle = '';
  bool hasError = false;

  List<OccupationData> employmentTypeDataList = [];

  OccupationData? selectedEmploymentData;

  bool isSelectedEmploymentValid = true;

  TextEditingController employmentTypeController = TextEditingController();

  // bool isEmploymentTypeValid = true;

  int openBottomSheets = 0;

  bool isUploading = false;

  int selectedDocumentId = 0;

  File? documentFile_1;
  File? documentFile_2;
  File? documentFile_3;
  File? documentFile_4;

  String? _documentFileUUID_1;
  String? _documentFileUUID_2;
  String? _documentFileUUID_3;
  String? _documentFileUUID_4;

  final String trackingNumber;

  bool isShowAddress = true;
  bool isPostalCodeValid = true;
  bool isProvinceValid = true;
  bool isCityValid = true;
  bool isAddressValid = true;

  TextEditingController jobPostalCodeController = TextEditingController();

  bool isPostalCodeLoading = false;

  TextEditingController provinceController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController jobAddressController = TextEditingController();

  bool isAddressInquirySuccessful = false;

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  String? cityName;

  String customerPostalCodeErrorMessage = '';

  LoanDetail? loanDetail;

  ParsaLoanEmploymentTypeController({required this.trackingNumber});

  @override
  void onInit() {
    getOccupationListRequest();
    super.onInit();
  }

  void getOccupationListRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    ParsaLoanServices.getOccupationListRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OccupationListResponseData response, int _)):
          employmentTypeDataList = response.data!;
          update();
          _getLoanDetailRequest();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _getLoanDetailRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ParsaLoanServices.getLoanDetailRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ParsaLendingGetLoanDetailResponseData response, int _)):
          loanDetail = response.data!.loanDetail!;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedEmploymentType(OccupationData? newValue) {
    selectedEmploymentData = newValue;
    employmentTypeController.text = newValue!.faTitle!;
    update();
    Get.back();
  }

  void validateEmploymentTypeScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (selectedEmploymentData != null) {
      if (selectedEmploymentData!.jobType == '1') {
        bool isValid = true;
        if (jobPostalCodeController.text.length == Constants.postalCodeLength) {
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
        if (jobAddressController.text.length >= 3 &&
            RegexValue.virtualBranchAddressRegex.hasMatch(jobAddressController.text)) {
          isAddressValid = true;
        } else {
          isAddressValid = false;
          isValid = false;
        }
        update();
        if (isValid) {
          if (_documentFileUUID_1 != null || _documentFileUUID_2 != null) {
          } else {
            SnackBarUtil.showInfoSnackBar(
              locale.please_upload_all_required_documents,
            );
            return;
          }
        } else {
          return;
        }
      } else if (selectedEmploymentData!.jobType == '3') {
        if (_documentFileUUID_3 != null) {
        } else {
          SnackBarUtil.showInfoSnackBar(
            locale.please_upload_all_required_documents,
          );
          return;
        }
      } else if (selectedEmploymentData!.jobType == '26') {
        if (_documentFileUUID_4 != null) {
        } else {
          SnackBarUtil.showInfoSnackBar(
            locale.please_upload_all_required_documents,
          );
          return;
        }
      }
      _completeTask();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_job_type_applicant,
      );
    }
  }

  void _completeTask() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final taskCompleteState9RequestData = TaskCompleteState9RequestData(
      returnNextTasks: true,
      trackingNumber: trackingNumber,
      processId: 1,
      taskKey: 'CustomerJobType',
      taskData: [
        {
          'name': 'jobType',
          'value': selectedEmploymentData!.jobType,
        },
        {
          'name': 'postalCode',
          'value': jobPostalCodeController.text,
        },
        {
          'name': 'address',
          'value': jobAddressController.text,
        },
        {
          'name': 'jobCertificate',
          'value': _documentFileUUID_1,
        },
        {
          'name': 'certificateSalaryDeduction',
          'value': _documentFileUUID_2,
        },
        {
          'name': 'retirementDoc',
          'value': _documentFileUUID_3,
        },
        {
          'name': 'businessLicense',
          'value': _documentFileUUID_4,
        },
      ],
    );

    ParsaLoanServices.parsaLendingState9CompleteTaskRequest(
      taskCompleteState9RequestData: taskCompleteState9RequestData,
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

  Future<void> showSelectEmploymentTypeBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const SelectEmploymentTypeBottomSheet(),
      ),
    );
    openBottomSheets--;
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
    } else if (documentId == 2) {
      _documentFileUUID_2 = response.data!.id;
      documentFile_2 = image;
    } else if (documentId == 3) {
      _documentFileUUID_3 = response.data!.id;
      documentFile_3 = image;
    } else if (documentId == 4) {
      _documentFileUUID_4 = response.data!.id;
      documentFile_4 = image;
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
    }
    update();
  }

  String getCertificateSalaryDeductionAmount() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return locale.certificate_salary_deduction_amount(AppUtil.formatMoney(loanDetail!.extra!.shownPrice));
  }

  void toggleIsShowAddress() {
    isShowAddress = !isShowAddress;
    update();
  }

  void resetCustomerAddressInputs() {
    jobAddressController.clear();
    isProvinceValid = true;
    provinceController.clear();
    isCityValid = true;
    cityController.clear();
    isAddressValid = true;
    update();
  }

  void clearPostalCodeTextField() {
    jobPostalCodeController.clear();
    isAddressInquirySuccessful = false;
    resetCustomerAddressInputs();
  }

  void validateCustomerAddressInquiry() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (jobPostalCodeController.text.length == Constants.postalCodeLength) {
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
    addressInquiryRequestData.postalCode = jobPostalCodeController.text;
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
        jobAddressController.text =
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
}
