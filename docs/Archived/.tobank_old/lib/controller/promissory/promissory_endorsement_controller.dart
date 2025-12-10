import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/error_response_data.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../model/promissory/promissory_list_info.dart';
import '../../model/promissory/request/dest_user_info_request_data.dart';
import '../../model/promissory/request/promissory_company_inquiry_request_data.dart';
import '../../model/promissory/request/promissory_endorsement_finalize_request_data.dart';
import '../../model/promissory/request/promissory_endorsement_request_data.dart';
import '../../model/promissory/response/dest_user_info_response_data.dart';
import '../../model/promissory/response/promissory_company_inquiry_response_data.dart';
import '../../model/promissory/response/promissory_endorsement_finalize_response_data.dart';
import '../../model/promissory/response/promissory_endorsement_response_data.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/other_services.dart';
import '../../service/promissory_services.dart';
import '../../ui/common/date_selector_bottom_sheet.dart';
import '../../ui/promissory/promissory_endorsement/widget/promissory_endorsement_deposit_bottom_sheet.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryEndorsementController extends GetxController {
  final PromissoryListInfo promissoryInfo;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool hasError = false;
  String? errorTitle = '';

  PromissoryCustomerType selectedReceiverType = PromissoryCustomerType.individual;
  bool isGardeshgariSelected = false;

  TextEditingController receiverNationalCodeController = TextEditingController();

  bool isReceiverNationalCodeValid = true;

  TextEditingController receiverMobileController = TextEditingController();

  bool isReceiverMobileValid = true;
  bool isIssuerPostalCodeValid = true;
  bool isIssuerAddressValid = true;

  TextEditingController birthDateController = TextEditingController();

  TextEditingController paymentAddressController = TextEditingController();

  bool isPaymentAddressValid = true;
  bool isBirthdayDateValid = true;

  TextEditingController descriptionController = TextEditingController();

  bool isDescriptionValid = true;

  String? multiSignPath;

  String initDateString = '';

  String dateJalaliString = '';
  String? dateGregorian;

  String? base64SignedPdf;

  PromissoryEndorsementResponseData? promissoryEndorsementResponseData;

  PromissoryEndorsementFinalizeResponse? promissoryEndorsementFinalizeResponseData;

  String? receiverName;

  OtherItemData? otherItemData;

  bool isRuleChecked = false;

  List<Deposit> depositList = [];
  Deposit? selectedDeposit;

  TextEditingController issuerDepositController = TextEditingController();

  CustomerInfoResponse? customerInfoResponse;

  TextEditingController issuerPostalCodeController = TextEditingController();

  TextEditingController issuerAddressController = TextEditingController();

  ScrollController scrollbarController = ScrollController();

  PromissoryEndorsementController({
    required this.promissoryInfo,
  });

  @override
  void onInit() {
    getRulesRequest();
    initDateString = AppUtil.twentyYearsBeforeNow();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  //// Fetches the endorsement rules.
  /// If successful, it stores the rules data and navigates to the next page.
  Future<void> getRulesRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getRequestPromissoryEndorsementRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  void setChecked(bool isChecked) {
    isRuleChecked = isChecked;
    update();
  }

  void validateRules() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isRuleChecked) {
      _checkUserSanaRequest();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.warning,
        message: locale.please_read_and_accept_terms,
      );
    }
  }

  /// Checks the user's Sana status and retrieves the deposit list if eligible.
  void _checkUserSanaRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    PromissoryServices.checkUserSana().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          _getDepositListRequest();
        case Failure(exception: final ApiException<ErrorResponseData> apiException):
          if (apiException.type == ApiExceptionType.badRequest) {
            DialogUtil.showPositiveDialogMessage(
              buildContext: Get.context!,
              description: apiException.errorResponse!.message ?? '',
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

  void validateIssuerPage() {
    bool isValid = true;
    if (issuerPostalCodeController.text.isNotEmpty) {
      if (issuerPostalCodeController.text.length == Constants.postalCodeLength) {
        isIssuerPostalCodeValid = true;
      } else {
        isIssuerPostalCodeValid = false;
        isValid = false;
      }
    } else {
      isIssuerPostalCodeValid = true;
    }
    if (issuerAddressController.text.isNotEmpty) {
      isIssuerAddressValid = true;
    } else {
      isIssuerAddressValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  /// Retrieves the list of customer deposits and displays a bottom sheet.
  void _getDepositListRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    final CustomerDepositsRequest customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber ?? '',
      trackingNumber: const Uuid().v4(),
    );

    isLoading = true;
    update();

    DepositServices.getCustomerDeposits(
      customerDepositsRequest: customerDepositsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          depositList = response.data!.deposits!;
          update();
          _showPromissoryEndorsementDepositBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedDeposit(Deposit deposit) {
    selectedDeposit = deposit;
    update();
  }

  void validateDepositPage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDeposit != null) {
      issuerDepositController.text = selectedDeposit!.depositIban!;
      _getCustomerInfoRequest();
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.warning,
        message: locale.select_account,
      );
    }
  }

  /// Retrieves customer information.
  void _getCustomerInfoRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: false,
      forceInquireAddressInfo: true,
      getCustomerStartableProcesses: false,
      getCustomerDeposits: false,
      getCustomerActiveCertificate: false,
    );
    isLoading = true;
    update();

    AuthorizationServices.getCustomerInfo(customerInfoRequest: customerInfoRequest).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CustomerInfoResponse response, int _)):
          customerInfoResponse = response;
          _setValueOfCustomerInfo(customerInfoResponse);
          update();
          Get.back();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _setValueOfCustomerInfo(CustomerInfoResponse? customerInfoResponse) {
    if (customerInfoResponse != null) {
      issuerPostalCodeController.text = customerInfoResponse.data!.postalCode ?? '';
      issuerAddressController.text = customerInfoResponse.data!.address ?? '';
    }
  }

  /// Returns the customer's address
  String getCustomerAddress() {
    if (customerInfoResponse != null && customerInfoResponse!.data!.address != null) {
      return customerInfoResponse!.data!.address!;
    } else {
      return '-';
    }
  }

  String getCustomerDetail() {
    return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
  }

  String getPostalCode() {
    if (customerInfoResponse != null && customerInfoResponse!.data!.postalCode != null) {
      return customerInfoResponse!.data!.postalCode!;
    } else {
      return '-';
    }
  }

  void showSelectBirthDateDialog() {//locale
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
              birthDateController.text = dateJalaliString;
              initDateString = dateJalaliString;
              dateGregorian = DateConverterUtil.getDateGregorian(jalaliDate: dateJalaliString.replaceAll('-', '/'));
              update();
              Get.back();
            },
          );
        });
  }

  void setSelectedReceiverType(PromissoryCustomerType receiverType) {
    if (selectedReceiverType == receiverType) {
      return;
    }
    selectedReceiverType = receiverType;
    receiverMobileController.text = '';
    receiverNationalCodeController.text = '';
    paymentAddressController.text = '';
    receiverName = '';
    update();
  }

  void setTourismBankLegal(bool value) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isGardeshgariSelected = value;
    if (isGardeshgariSelected) {
      final tourismBankDetails = mainController.promissoryAssetResponseData!.data!.tourismBankDetails!;

      receiverMobileController.text = tourismBankDetails.legalPhoneNumber!;
      receiverNationalCodeController.text = tourismBankDetails.legalNationalNumber!;
      paymentAddressController.text = tourismBankDetails.paymentAddress!;

      receiverName = locale.bank_gardeshgari;
    } else {
      receiverMobileController.text = '';
      receiverNationalCodeController.text = '';
      paymentAddressController.text = '';
      receiverName = '';
    }
    update();
  }

  void validateReceiverPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (selectedReceiverType == PromissoryCustomerType.individual) {
      if (receiverNationalCodeController.text.length == Constants.nationalCodeLength &&
          AppUtil.validateNationalCode(receiverNationalCodeController.text)) {
        isReceiverNationalCodeValid = true;
      } else {
        isReceiverNationalCodeValid = false;
        isValid = false;
      }
      if (receiverMobileController.text.length == Constants.mobileNumberLength &&
          receiverMobileController.text.startsWith(Constants.mobileStartingDigits)) {
        isReceiverMobileValid = true;
      } else {
        isReceiverMobileValid = false;
        isValid = false;
      }

      if (birthDateController.text.trim().isNotEmpty) {
        isBirthdayDateValid = true;
      } else {
        isBirthdayDateValid = false;
        isValid = false;
      }
    } else {
      if (receiverNationalCodeController.text.length == Constants.companyNationalCodeLength) {
        isReceiverNationalCodeValid = true;
      } else {
        isReceiverNationalCodeValid = false;
        isValid = false;
      }
      if (receiverMobileController.text.length == Constants.phoneNumberLength &&
          receiverMobileController.text.startsWith('0')) {
        isReceiverMobileValid = true;
      } else {
        isReceiverMobileValid = false;
        isValid = false;
      }
    }

    update();
    if (isValid) {
      if (selectedReceiverType == PromissoryCustomerType.individual) {
        _validateDestUserInfoRequest();
      } else {
        if (isGardeshgariSelected) {
          AppUtil.nextPageController(pageController, isClosed);
        } else {
          _getLegalInfoRequest();
        }
      }
    }
  }

  void _validateDestUserInfoRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    final DestUserInfoRequestData destUserInfoRequestData = DestUserInfoRequestData(
      mobile: receiverMobileController.text,
      nationalCode: receiverNationalCodeController.text,
      birthDate: birthDateController.text.replaceAll('/', '-'),
    );

    PromissoryServices.destUserInfo(
      destUserInfoRequestData: destUserInfoRequestData,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final DestUserInfoResponse response, int _)):
            receiverName = '${response.data!.firstName!} ${response.data!.lastName!}';
            AppUtil.nextPageController(pageController, isClosed);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  /// Fetches legal information for a company using the provided national ID.
  void _getLegalInfoRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryCompanyInquiryRequestData promissoryCompanyInquiryRequestData = PromissoryCompanyInquiryRequestData(
      nationalId: receiverNationalCodeController.text,
    );

    isLoading = true;
    update();

    PromissoryServices.companyInquiryRequest(
      promissoryCompanyInquiryRequestData: promissoryCompanyInquiryRequestData,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final PromissoryCompanyInquiryResponseData response, int _)):
            paymentAddressController.text = response.data!.address!;
            receiverName = response.data!.companyTitle;
            update();
            AppUtil.nextPageController(pageController, isClosed);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void validateConfirmPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (paymentAddressController.text.trim().length >= 5) {
      isPaymentAddressValid = true;
    } else {
      isPaymentAddressValid = false;
      isValid = false;
    }

    update();
    if (isValid) {
      _promissoryEndorsementRequest();
    }
  }

  void showConfirmDialog() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.endorsement_signature_confirmation,
        description: '',
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _signPdf();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void showPreviewScreen() {
    Get.to(() => PromissoryPreviewScreen(
          pdfData: File(multiSignPath!).readAsBytesSync(),
          promissoryId: promissoryInfo.promissoryId,
        ));
  }

  void sharePromissoryPdf() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isIOS) {
      Share.shareXFiles([XFile(multiSignPath!)], subject: locale.promissory_file);
    } else {
      Share.shareXFiles([XFile(multiSignPath!)], text: locale.promissory_file);
    }
  }

  /// Signs a PDF document and proceeds with the endorsement finalization.
  Future<void> _signPdf() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final signDocumentData = SignDocumentData.fromPromissoryMainController(
      documentBase64: promissoryEndorsementResponseData!.data!.unSignedPdf!,
    );
    final response = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (response.isSuccess != null && response.isSuccess!) {
      base64SignedPdf = response.data;
      final PromissoryEndorsementFinalizeRequestData promissoryEndorsementFinalizeRequestData =
          PromissoryEndorsementFinalizeRequestData(
        id: promissoryEndorsementResponseData!.data!.id!,
        signedPdf: base64SignedPdf!,
      );

      _promissoryEndorsementFinalizeRequest(promissoryEndorsementFinalizeRequestData);
    } else {
      isLoading = false;
      update();

      SnackBarUtil.showSnackBar(title: locale.error, message: response.message ?? locale.error_in_signature);

      await Sentry.captureMessage('sign pdf error',
          params: [
            {'status code': response.statusCode},
            {'message': response.message},
          ],
          level: SentryLevel.warning);
    }
  }

  /// Finalize the endorsement process using the provided data.
  /// If successful, it stores the finalization response data,
  void _promissoryEndorsementFinalizeRequest(//locale

      PromissoryEndorsementFinalizeRequestData promissoryEndorsementFinalizeRequestData) {
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    PromissoryServices.promissoryEndorsementFinalizeRequest(
      promissoryEndorsementFinalizeRequestData: promissoryEndorsementFinalizeRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryEndorsementFinalizeResponse response, int _)):
          promissoryEndorsementFinalizeResponseData = response;
          await setValues();
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> setValues() async {
    multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
      source: promissoryEndorsementFinalizeResponseData!.data!.multiSignedPdf!,
    );
  }

  /// Initiates a promissory note endorsement request.
  void _promissoryEndorsementRequest() {  final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryEndorsementRequestData promissoryEndorsementRequestData = PromissoryEndorsementRequestData();

    // Owner
    promissoryEndorsementRequestData.ownerCellphone = mainController.authInfoData!.mobile!;
    promissoryEndorsementRequestData.ownerNn = mainController.authInfoData!.nationalCode;
    promissoryEndorsementRequestData.ownerAddress = issuerAddressController.text;
    promissoryEndorsementRequestData.ownerAccountNumber = selectedDeposit!.depositIban;
    promissoryEndorsementRequestData.ownerSanaCheck =
        true; // Unnecessary value is set. this will be checked on the server side

    // Recipient
    promissoryEndorsementRequestData.recipientType = selectedReceiverType;
    promissoryEndorsementRequestData.recipientFullName = receiverName;
    promissoryEndorsementRequestData.recipientNn = receiverNationalCodeController.text;
    promissoryEndorsementRequestData.recipientCellphone = receiverMobileController.text;

    if (selectedReceiverType == PromissoryCustomerType.individual) {
      promissoryEndorsementRequestData.recipientCellphone =
          promissoryEndorsementRequestData.recipientCellphone!.substring(1);
    }

    // Promissory
    promissoryEndorsementRequestData.promissoryId = promissoryInfo.promissoryId;
    promissoryEndorsementRequestData.paymentPlace = paymentAddressController.text.trim();
    promissoryEndorsementRequestData.description = descriptionController.text.trim();

    isLoading = true;
    update();
    PromissoryServices.promissoryEndorsementRequest(
      promissoryEndorsementRequestData: promissoryEndorsementRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryEndorsementResponseData response, int _)):
          promissoryEndorsementResponseData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<File> getPromissoryPdf() async {
    final String output = await FileUtil().writeAsBytesFile(
      bytes: base64.decode(promissoryEndorsementResponseData!.data!.unSignedPdf!),
      name: '${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    return File(output);
  }

  /// Handles the back press action based on the current page.
  ///
  /// If the back press was already handled (`didPop` is true), it does nothing.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 5 ||
          pageController.page == 6) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void _showPromissoryEndorsementDepositBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
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
        child: const PromissoryEndorsementDepositBottomSheet(),
      ),
    );
  }
}
