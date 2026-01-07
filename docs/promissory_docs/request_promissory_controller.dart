import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/l10n/gen/app_localizations.dart';
import '../../model/common/error_response_data.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../model/promissory/request/dest_user_info_request_data.dart';
import '../../model/promissory/request/promissory_amount_request_data.dart';
import '../../model/promissory/request/promissory_company_inquiry_request_data.dart';
import '../../model/promissory/request/promissory_publish_finalize_request_data.dart';
import '../../model/promissory/request/promissory_publish_payment_request_data.dart';
import '../../model/promissory/request/promissory_request_data.dart';
import '../../model/promissory/response/dest_user_info_response_data.dart';
import '../../model/promissory/response/promissory_amount_response_data.dart';
import '../../model/promissory/response/promissory_company_inquiry_response_data.dart';
import '../../model/promissory/response/promissory_internet_payment_response_data.dart';
import '../../model/promissory/response/promissory_publish_finalize_response_data.dart';
import '../../model/promissory/response/promissory_response_data.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/other_services.dart';
import '../../service/promissory_services.dart';
import '../../service/transaction_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/common/date_selector_bottom_sheet.dart';
import '../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../ui/promissory/request_promissory/widget/request_promissory_deposit_bottom_sheet.dart';
import '../../ui/promissory/request_promissory/widget/request_promissory_select_payment_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/enums_constants.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class RequestPromissoryController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;

  bool hasError = false;
  String? errorTitle = '';

  ScrollController scrollbarController = ScrollController();

  OtherItemData? otherItemData;

  bool isRuleChecked = false;

  TextEditingController issuerDepositController = TextEditingController();

  TextEditingController issuerPostalCodeController = TextEditingController();

  TextEditingController issuerAddressController = TextEditingController();

  bool isIssuerAddressValid = true;

  PromissoryCustomerType selectedReceiverType = PromissoryCustomerType.individual;
  bool isGardeshgariSelected = false;

  String? receiverName;

  bool isReceiverNameValid = true;

  TextEditingController receiverMobileController = TextEditingController();

  bool isReceiverMobileValid = true;

  TextEditingController receiverNationalCodeController = TextEditingController();

  bool isReceiverNationalCodeValid = true;

  TextEditingController amountController = TextEditingController();

  int amount = 0;

  bool isAmountValid = true;

  bool isDateValid = true;

  TextEditingController dateController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  bool isBirthdayValid = true;
  String birthDateInitDateString = '';
  String initDateString = '';
  String startDateString = '';
  String endDateString = '';

  String dateJalaliString = '';

  PaymentType currentPaymentType = PaymentType.wallet;

  int walletAmount = 0;

  Deposit? selectedPaymentDeposit;

  TransactionData? transactionData;
  DestUserInfoResponse? destUserInfoResponse;

  bool isIssuerPostalCodeValid = true;

  TextEditingController descriptionController = TextEditingController();

  bool isDescriptionValid = true;

  PromissoryAmountResponseData? promissoryAmountResponseData;

  PromissoryInternetPaymentResponseData? promissoryInternetPaymentResponseData;
  PromissoryPublishFinalizeResponse? promissoryPublishFinalizeResponse;

  String? multiSignPath;

  CustomerInfoResponse? customerInfoResponse;

  bool isOnTime = false;

  TextEditingController paymentAddressController = TextEditingController();

  bool isPaymentAddressValid = true;

  PromissoryPublishResponseData? promissoryResponseData;
  List<Deposit> depositList = [];
  Deposit? selectedDeposit;

  String? base64SignedPdf;
  String? dateGregorian;

  bool isTransferable = true;

  int openBottomSheets = 0;

  @override
  void onInit() {
    birthDateInitDateString = AppUtil.twentyYearsBeforeNow();
    final DateTime dateTime = DateTime.now();
    initDateString = DateConverterUtil.getDateJalali(gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime));
    startDateString =
        DateConverterUtil.getStartOfYearJalali(gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime));
    endDateString = DateConverterUtil.getEndOfYearJalali(
        gregorianDate: intl.DateFormat('yyyy-MM-dd').format(dateTime.add(const Duration(days: 10 * 365))));
    getRulesRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void setChecked(bool isChecked) {
    isRuleChecked = isChecked;
    update();
  }

  /// Retrieves promissory note rules
  Future<void> getRulesRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getRequestPromissoryRuleRequest().then((result) {
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

  void validateRules() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isRuleChecked) {
      _checkUserSanaRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Checks the user's Sana status and proceeds with deposit list retrieval.
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

  /// Formatting value of amount with each three number one separation
  ///  1000 => 1,000
  void validateAmountValue(String value) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      amountController.text = AppUtil.formatMoney(value);
      amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
    }
    if (value != '') {
      amount = int.parse(value.replaceAll(',', ''));
    } else {
      amount = 0;
    }
    update();
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return AppUtil.getPersianNumbers(
              DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ')) ??
          '';
    }
  }

  /// Hide keyboard & show date picker dialog modal
  Future<void> showSelectDateDialog() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
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
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: initDateString,
            startDateString: startDateString,
            endDateString: endDateString,
            title: locale.select_payment_date,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              dateController.text = dateJalaliString;
              initDateString = dateJalaliString;
              update();
              Get.back();
            },
          );
        });
    openBottomSheets--;
  }

  Future<void> showSelectBirthDateDialog() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
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
        builder: (context) {
          return DateSelectorBottomSheet(
            initDateString: birthDateInitDateString,
            title: locale.birthdate_hint,
            onDateSelected: (selectedDate) {
              dateJalaliString = selectedDate;
            },
            callback: () {
              birthDateController.text = dateJalaliString;
              birthDateInitDateString = dateJalaliString;
              dateGregorian = DateConverterUtil.getDateGregorian(jalaliDate: dateJalaliString.replaceAll('-', '/'));
              update();
              Get.back();
            },
          );
        });
    openBottomSheets--;
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

  void setCurrentPaymentType(PaymentType paymentType) {
    currentPaymentType = paymentType;
    update();
  }

  Future<void> validateInternetPayment() async {
    _requestTransactionDetailById();
  }

  /// Requests transaction details by ID.
  void _requestTransactionDetailById() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: promissoryInternetPaymentResponseData!.data!.transactionId!,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            update();
            if (transactionData!.isSuccess == false) {
              _showPaymentBottomSheet();
              AppUtil.changePageController(
                pageController: pageController,
                page: 6,
                isClosed: isClosed,
              );
              SnackBarUtil.showSnackBar(
                title: locale.payment_error,
                message: transactionData?.message ?? locale.try_again2,
              );
            } else {
              AppUtil.changePageController(
                pageController: pageController,
                page: 8,
                isClosed: isClosed,
              );
            }
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  int getCorrectAmount() {
    if (promissoryAmountResponseData != null) {
      return promissoryAmountResponseData!.data!.totalAmount!;
    } else {
      return 0;
    }
  }

  /// Validates destination user information and updates the UI and navigation.
  void _validateDestUserInfoRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    final DestUserInfoRequestData destUserInfoRequestData = DestUserInfoRequestData(
      mobile: '',
      nationalCode: '',
      birthDate: '',
    );
    destUserInfoRequestData.mobile = receiverMobileController.text;
    destUserInfoRequestData.birthDate = birthDateController.text.replaceAll('/', '-');
    destUserInfoRequestData.nationalCode = receiverNationalCodeController.text;

    PromissoryServices.destUserInfo(
      destUserInfoRequestData: destUserInfoRequestData,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final DestUserInfoResponse response, int _)):
            destUserInfoResponse = response;
            receiverName = '${response.data!.firstName!} ${response.data!.lastName!}';
            AppUtil.nextPageController(pageController, isClosed);
            update();
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  // Retrieves legal entity information
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

  void validatePaymentPage() {
    AppUtil.hideKeyboard(Get.context!);
    switch (currentPaymentType) {
      case PaymentType.wallet:
        if (walletAmount >= promissoryAmountResponseData!.data!.totalAmount!) {
          _confirmPayment();
        } else {
          Timer(Constants.duration100, () {
            SnackBarUtil.showNotEnoughWalletMoneySnackBar();
          });
        }
      case PaymentType.gateway:
        _confirmPayment();
      case PaymentType.deposit:
        _getPaymentDepositsRequest();
    }
  }

  /// Retrieves customer payment deposits and displays a selection bottom sheet.
  void _getPaymentDepositsRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      trackingNumber: const Uuid().v4(),
    );

    DepositServices.getCustomerDeposits(customerDepositsRequest: customerDepositsRequest).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerDepositsResponse response, int _)):
          final filteredDeposits = response.data!.deposits!.where((deposit) => deposit.depositeKind != 3).toList();
          _showSelectDepositBottomSheet(depositList: filteredDeposits);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showSelectDepositBottomSheet({required List<Deposit> depositList}) async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: SelectDepositPaymentBottomSheet(
          depositList: depositList,
          selectDeposit: (Deposit deposit) {
            selectedPaymentDeposit = deposit;
            update();
            _confirmPayment();
          },
        ),
      ),
    );
    openBottomSheets--;
  }

  void _confirmPayment() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.promissory_payment_confirmation,
        description: locale.promissory_cancellation_info,
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _paymentMethod();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  Future<void> _paymentMethod() async {
    switch (currentPaymentType) {
      case PaymentType.gateway:
        _promissoryInternetPayment();
      case PaymentType.wallet:
      case PaymentType.deposit:
        _promissoryPayment();
    }
  }

  /// Initiates the promissory note payment process and handles the response.
  void _promissoryPayment() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryPublishPaymentRequestData promissoryPublishPaymentRequestData = PromissoryPublishPaymentRequestData(
      id: promissoryResponseData!.data!.id!,
      gssToYekta: false,
      transactionType: currentPaymentType,
      depositNumber: currentPaymentType == PaymentType.deposit ? selectedPaymentDeposit!.depositNumber! : null,
    );

    PromissoryServices.promissoryPaymentRequest(
      promissoryPublishPaymentRequestData: promissoryPublishPaymentRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          update();
          if (transactionData!.isSuccess == false) {
            SnackBarUtil.showSnackBar(
              title: locale.payment_error,
              message: transactionData?.message ?? locale.try_again2,
            );
          } else {
            _closeBottomSheets();
            pageController.jumpToPage(8);
            update();
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Initiates the promissory note internet payment process and handles the response.
  void _promissoryInternetPayment() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryPublishPaymentRequestData promissoryPublishPaymentRequestData = PromissoryPublishPaymentRequestData(
      id: promissoryResponseData!.data!.id!,
      gssToYekta: false,
      transactionType: currentPaymentType,
      depositNumber: null,
    );

    PromissoryServices.promissoryInternetRequest(
      promissoryPublishPaymentRequestData: promissoryPublishPaymentRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryInternetPaymentResponseData response, int _)):
          promissoryInternetPaymentResponseData = response;
          update();
          _closeBottomSheets();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void showConfirmDialog() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.promissory_signature_confirmation,
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

  /// Signs a PDF document and proceeds with the promissory note finalization.
  Future<void> _signPdf() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = false;
    update();

    final signDocumentData = SignDocumentData.fromPromissoryMainController(
      documentBase64: promissoryResponseData!.data!.unSignedPdf!,
    );
    final response = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (response.isSuccess != null && response.isSuccess!) {
      base64SignedPdf = response.data;

      final PromissoryPublishFinalizeRequestData promissoryPublishFinalizeRequestData =
          PromissoryPublishFinalizeRequestData(
        id: promissoryResponseData!.data!.id!,
        signedPdf: base64SignedPdf!,
      );

      _promissoryPublishFinalizeRequest(promissoryPublishFinalizeRequestData);
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

  /// Finalizes the promissory note publishing process and handles the response.
  ///
  /// If successful, it stores the response data, writes the multi-signed PDF
  /// to a file, updates the UI, and navigates to the next page.
  void _promissoryPublishFinalizeRequest(
    PromissoryPublishFinalizeRequestData promissoryPublishFinalizeRequestData,
  ) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    PromissoryServices.promissoryPublishFinalizeRequest(
      promissoryPublishFinalizeRequestData: promissoryPublishFinalizeRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryPublishFinalizeResponse response, int _)):
          promissoryPublishFinalizeResponse = response;
          multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
            source: promissoryPublishFinalizeResponse!.data!.multiSignedPdf!,
          );
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

  String getCustomerDetail() {
    return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
  }

  void validateIssuerPage() {
    AppUtil.hideKeyboard(Get.context!);
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
        isBirthdayValid = true;
      } else {
        isBirthdayValid = false;
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

  void validateDataPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (amount >= Constants.minValidPromissoryAmount) {
      isAmountValid = true;
    } else {
      isAmountValid = false;
      isValid = false;
    }
    if (!isOnTime) {
      if (dateController.text.isNotEmpty) {
        isDateValid = true;
      } else {
        isDateValid = false;
        isValid = false;
      }
    }
    if (paymentAddressController.text.trim().length >= 5) {
      isPaymentAddressValid = true;
    } else {
      isPaymentAddressValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _getPromissoryAmountRequest();
    }
  }

  /// Retrieves the wallet balance.
  /// If successful, it stores the wallet amount
  Future<void> getWalletDetailRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    WalletServices.getWalletBalance().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final WalletBalanceResponseData response, int _)):
            walletAmount = response.data!.amount!;
            update();
            setValidPaymentType();
            _showPaymentBottomSheet();
          case Failure(exception: final ApiException apiException):
            hasError = true;
            errorTitle = apiException.displayMessage;
            update();
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  /// Retrieves the promissory note amount details and updates the UI and navigation.
  Future<void> _getPromissoryAmountRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryAmountRequestData promissoryAmountRequestData = PromissoryAmountRequestData(
      amount: amount,
      gssToYekta: false,
    );

    PromissoryServices.getPromissoryPublishPriceRequest(
      promissoryAmountRequestData: promissoryAmountRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryAmountResponseData response, int _)):
          promissoryAmountResponseData = response;
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

  Future<void> validateConfirmPage() async {
    _submitRequestPromissoryRequest();
  }

  void _submitRequestPromissoryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryRequestData promissoryRequestData = PromissoryRequestData();

    // Issuer
    promissoryRequestData.issuerType = PromissoryCustomerType.individual;
    promissoryRequestData.issuerNn = mainController.authInfoData!.nationalCode;
    promissoryRequestData.issuerCellphone = mainController.authInfoData!.mobile!.substring(1);
    promissoryRequestData.issuerFullName =
        '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    promissoryRequestData.issuerAccountNumber = selectedDeposit!.depositIban;
    promissoryRequestData.issuerAddress = issuerAddressController.text;
    promissoryRequestData.issuerPostalCode = issuerPostalCodeController.text;
    promissoryRequestData.issuerSanaCheck = true; // Unnecessary value is set. this will be checked on the server side

    // Recipient
    promissoryRequestData.recipientType = selectedReceiverType;
    promissoryRequestData.recipientFullName = receiverName;
    promissoryRequestData.recipientNn = receiverNationalCodeController.text;
    promissoryRequestData.recipientCellphone = receiverMobileController.text;

    if (selectedReceiverType == PromissoryCustomerType.individual) {
      promissoryRequestData.recipientCellphone = promissoryRequestData.recipientCellphone!.substring(1);
    }

    // Promissory
    promissoryRequestData.paymentPlace = paymentAddressController.text.trim();
    promissoryRequestData.amount = amount;
    promissoryRequestData.dueDate = isOnTime ? null : dateController.text.replaceAll('/', '');
    promissoryRequestData.description = descriptionController.text;
    promissoryRequestData.transferable = isTransferable;
    promissoryRequestData.loanType = mainController.loanType;


    isLoading = true;
    update();
    PromissoryServices.promissoryRequest(
      promissoryRequestData: promissoryRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryPublishResponseData response, int _)):
          promissoryResponseData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
          getWalletDetailRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

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
          _closeBottomSheets();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getCustomerAddress() {
    if (customerInfoResponse != null && customerInfoResponse!.data!.address != null) {
      return customerInfoResponse!.data!.address!;
    } else {
      return '-';
    }
  }

  String getPostalCode() {
    if (customerInfoResponse != null && customerInfoResponse!.data!.postalCode != null) {
      return customerInfoResponse!.data!.postalCode!;
    } else {
      return '-';
    }
  }

  void setIsOnTime(value) {
    isOnTime = value;
    update();
  }

  void setIsTransferable(value) {
    isTransferable = value;
    update();
  }

  void _setValueOfCustomerInfo(CustomerInfoResponse? customerInfoResponse) {
    if (customerInfoResponse != null) {
      issuerPostalCodeController.text = customerInfoResponse.data!.postalCode ?? '';
      issuerAddressController.text = customerInfoResponse.data!.address ?? '';
    }
  }

  /// Retrieves the customer's deposit list and displays a promissory deposit bottom sheet.
  void _getDepositListRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
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
          _showRequestPromissoryDepositBottomSheet();
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
      issuerDepositController.text = selectedDeposit!.depositNumber ?? '';
      _getCustomerInfoRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_account,
      );
    }
  }

  void setValidPaymentType() {
    final int correctAmount = promissoryAmountResponseData!.data!.totalAmount!;
    if (walletAmount < correctAmount) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  /// Handles the back press action, navigating back or to the previous page.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 7 ||
          pageController.page == 8 ||
          pageController.page == 9) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  Future<void> _showRequestPromissoryDepositBottomSheet() async {
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
        child: const RequestPromissoryDepositBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> _showPaymentBottomSheet() async {
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
        child: const RequestPromissorySelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void clearAmountTextField() {
    amountController.clear();
    amount = 0;
    update();
  }
}
