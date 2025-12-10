import 'dart:async';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../model/common/sign_document_data.dart';
import '../../../model/deposit/request/customer_deposits_request_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/other/response/other_item_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../../model/promissory/request/promissory_amount_request_data.dart';
import '../../../model/promissory/request/promissory_company_inquiry_request_data.dart';
import '../../../model/promissory/request/promissory_publish_finalize_request_data.dart';
import '../../../model/promissory/request/promissory_publish_payment_request_data.dart';
import '../../../model/promissory/request/promissory_request_data.dart';
import '../../../model/promissory/response/promissory_amount_response_data.dart';
import '../../../model/promissory/response/promissory_asset_response_data.dart';
import '../../../model/promissory/response/promissory_company_inquiry_response_data.dart';
import '../../../model/promissory/response/promissory_internet_payment_response_data.dart';
import '../../../model/promissory/response/promissory_publish_finalize_response_data.dart';
import '../../../model/promissory/response/promissory_response_data.dart';
import '../../../model/register/request/customer_info_request_data.dart';
import '../../../model/register/response/customer_info_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../model/transaction/response/transaction_data_response.dart';
import '../../../model/wallet/response/wallet_balance_response_data.dart';
import '../../../service/authorization_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../service/other_services.dart';
import '../../../service/promissory_services.dart';
import '../../../service/transaction_services.dart';
import '../../../service/wallet_services.dart';
import '../../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../../ui/promissory/collateral_promissory/collateral_promissory_publish/widget/promissory_deposit_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/dialog_util.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/string_constants.dart';
import '../../main/main_controller.dart';

class CollateralPromissoryPublishController extends GetxController {
  final CollateralPromissoryRequestData collateralPromissoryRequestData;
  final void Function(CollateralPromissoryPublishResultData collateralPromissoryPublishResultData) resultCallback;

  MainController mainController = Get.find();
  PageController pageController = PageController();
  ScrollController scrollbarController = ScrollController();

  String errorTitle = '';
  bool hasError = false;
  bool isLoading = false;

  OtherItemData? otherItemData;
  bool isRuleChecked = false;

  String? recipientName;
  String? paymentAddress;

  PaymentType currentPaymentType = PaymentType.wallet;

  int walletAmount = 0;

  Deposit? selectedPaymentDeposit;

  TransactionData? transactionData;

  PromissoryAmountResponseData? promissoryAmountResponseData;

  PromissoryInternetPaymentResponseData? promissoryInternetPaymentResponseData;

  CustomerInfoResponse? customerInfoResponse;

  PromissoryPublishResponseData? promissoryResponseData;
  List<Deposit> depositList = [];
  Deposit? selectedDeposit;

  String? base64SignedPdf;
  String? dateGregorian;

  int openBottomSheets = 0;

  CollateralPromissoryPublishController({
    required this.collateralPromissoryRequestData,
    required this.resultCallback,
  });

  @override
  Future<void> onInit() async {
    getRules();
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

  Future<void> getRules() async {
    final connectivityResult = await AppUtil.isNetworkConnect();
    if (connectivityResult) {
      getRulesRequest();
    } else {
      hasError = true;
      errorTitle = StringConstants.noInternetMessage;
      update();
      SnackBarUtil.showNoInternetSnackBar();
    }
  }

  /// Sends a request to retrieve promissory rules.
  Future<void> getRulesRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    hasError = false;
    update();

    OtherServices.getRequestPromissoryRuleRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
          update();
          _getPromissoryAssetRequest();
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

  /// Sends a request to retrieve promissory assets.
  void _getPromissoryAssetRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    PromissoryServices.getPromissoryAssets().then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryAssetResponseData response, int _)):
          mainController.promissoryAssetResponseData = response;
          hasError = false;
          update();
          Future.delayed(Constants.duration300, () {
            AppUtil.nextPageController(pageController, isClosed);
          });
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
      _getDepositListRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Sends a request to retrieve the customer's deposit list.
  void _getDepositListRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerDepositsRequest customerDepositsRequest = CustomerDepositsRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
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
          _showPromissoryDepositBottomSheet();
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
      _getCustomerInfoRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_account,
      );
    }
  }

  /// Sends a request to retrieve customer information.
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
          update();
          _closeBottomSheets();
          AppUtil.nextPageController(pageController, isClosed);
          Future.delayed(Constants.duration300, () {
            getLegalInfoRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request to retrieve legal information for a company.
  void getLegalInfoRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryCompanyInquiryRequestData promissoryCompanyInquiryRequestData = PromissoryCompanyInquiryRequestData(
      nationalId: collateralPromissoryRequestData.recipientNN,
    );

    isLoading = true;
    hasError = false;
    update();
    PromissoryServices.companyInquiryRequest(
      promissoryCompanyInquiryRequestData: promissoryCompanyInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryCompanyInquiryResponseData response, int _)):
          paymentAddress = response.data!.address!;
          recipientName = response.data!.companyTitle;
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

  void setCurrentPaymentType(PaymentType paymentType) {
    currentPaymentType = paymentType;
    update();
  }

  Future<void> validateInternetPayment() async {
    _requestTransactionDetailById();
  }

  /// Get data of [TransactionDataResponse] from server request
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
              AppUtil.previousPageController(pageController, isClosed);
              SnackBarUtil.showSnackBar(
                title: locale.payment_error,
                message: transactionData?.message ?? locale.try_again2,
              );
            } else {
              AppUtil.nextPageController(pageController, isClosed);
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

  // Sends a request to retrieve the customer's payment deposits,
  // excluding those with 'deposit Kind' equal to 3.
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

  /// Initiates a promissory payment request.
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
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            update();
            if (transactionData!.isSuccess == false) {
              SnackBarUtil.showSnackBar(
                title: locale.payment_error,
                message: transactionData?.message ??locale.try_again2,
              );
            } else {
              pageController.jumpToPage(7);
              update();
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

  /// Initiates a promissory internet payment request.
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
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title:locale.show_error(apiException.displayCode),
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

  /// Initiates the PDF signing process for a promissory.
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

  /// Sends a request to finalize the promissory publish process.
  void _promissoryPublishFinalizeRequest(
    PromissoryPublishFinalizeRequestData promissoryPublishFinalizeRequestData,
  ) {
    //locale
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
          final CollateralPromissoryPublishResultData collateralPromissoryPublishResultData =
              CollateralPromissoryPublishResultData(
                  isSuccess: true,
                  message: locale.issued_successfulyy,
                  promissoryId: response.data!.promissoryId!,
                  promissoryPdfBase64: response.data!.multiSignedPdf);
          resultCallback(collateralPromissoryPublishResultData);
          Get.back();
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

  /// Sends a request to retrieve the user's wallet balance.
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
            _getPromissoryAmountRequest();
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

  /// Sends a request to retrieve the promissory amount details, including the price for publishing.
  Future<void> _getPromissoryAmountRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final PromissoryAmountRequestData promissoryAmountRequestData = PromissoryAmountRequestData(
      amount: collateralPromissoryRequestData.amount,
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
          _setValidPaymentType();
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

  /// Send a Submit promissory request to the server.
  void submitRequestPromissory() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryRequestData promissoryRequestData = PromissoryRequestData();

    // Issuer
    promissoryRequestData.issuerType = PromissoryCustomerType.individual;
    promissoryRequestData.issuerNn = mainController.authInfoData!.nationalCode;
    promissoryRequestData.issuerCellphone = mainController.authInfoData!.mobile!.substring(1); // 9123456789
    promissoryRequestData.issuerFullName =
        '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    promissoryRequestData.issuerAccountNumber = selectedDeposit!.depositIban;
    promissoryRequestData.issuerAddress = customerInfoResponse!.data!.address;
    promissoryRequestData.issuerPostalCode = customerInfoResponse!.data!.postalCode;
    promissoryRequestData.issuerSanaCheck = true; // Unnecessary value is set. this will be checked on the server side

    // Recipient
    promissoryRequestData.recipientType = PromissoryCustomerType.company;
    promissoryRequestData.recipientFullName = recipientName;

    promissoryRequestData.recipientNn = collateralPromissoryRequestData.recipientNN;
    promissoryRequestData.recipientCellphone = collateralPromissoryRequestData.recipientCellPhone;

    // Promissory
    promissoryRequestData.paymentPlace = paymentAddress;
    promissoryRequestData.amount = collateralPromissoryRequestData.amount;
    promissoryRequestData.dueDate = collateralPromissoryRequestData.dueDate;
    promissoryRequestData.description = collateralPromissoryRequestData.description;
    promissoryRequestData.transferable = collateralPromissoryRequestData.transferable;

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
          Future.delayed(Constants.duration300, () {
            getWalletDetailRequest();
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Determines and sets the valid payment type
  /// base don the promissory amount and the user's wallet balance.
  void _setValidPaymentType() {
    final int correctAmount = promissoryAmountResponseData!.data!.totalAmount!;
    if (walletAmount < correctAmount) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  /// Handles back press events.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  Future<void> _showPromissoryDepositBottomSheet() async {
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
        child: const PromissoryDepositBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }
}
