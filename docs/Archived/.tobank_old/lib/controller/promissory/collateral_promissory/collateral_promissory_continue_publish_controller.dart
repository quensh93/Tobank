import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/common/sign_document_data.dart';
import '../../../model/deposit/request/customer_deposits_request_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../model/promissory/request/promissory_amount_request_data.dart';
import '../../../model/promissory/request/promissory_fetch_unsigned_document_request_data.dart';
import '../../../model/promissory/request/promissory_publish_finalize_request_data.dart';
import '../../../model/promissory/request/promissory_publish_payment_request_data.dart';
import '../../../model/promissory/response/promissory_amount_response_data.dart';
import '../../../model/promissory/response/promissory_asset_response_data.dart';
import '../../../model/promissory/response/promissory_fetch_unsigned_document_response_data.dart';
import '../../../model/promissory/response/promissory_internet_payment_response_data.dart';
import '../../../model/promissory/response/promissory_publish_finalize_response_data.dart';
import '../../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../model/transaction/response/transaction_data_response.dart';
import '../../../model/wallet/response/wallet_balance_response_data.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../service/promissory_services.dart';
import '../../../service/transaction_services.dart';
import '../../../service/wallet_services.dart';
import '../../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../../ui/promissory/collateral_promissory/collateral_promissory_continue_publish/widget/collateral_promissory_continue_publish_select_payment_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/dialog_util.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CollateralPromissoryContinuePublishController extends GetxController {

  PageController pageController = PageController();
  MainController mainController = Get.find();

  String? errorTitle = '';
  bool hasError = false;

  bool isLoading = false;

  PromissoryInternetPaymentResponseData? promissoryInternetPaymentResponseData;

  TransactionData? transactionData;

  String? multiSignPath;

  PromissoryAmountResponseData? promissoryAmountResponseData;

  PaymentType currentPaymentType = PaymentType.wallet;

  var walletAmount = 0;

  Deposit? selectedPaymentDeposit;

  String? base64UnsignedPdf;
  String? base64SignedPdf;

  final PromissoryRequest promissoryRequest;
  final void Function(CollateralPromissoryPublishResultData collateralPromissoryPublishResultData) resultCallback;

  CollateralPromissoryContinuePublishController({
    required this.promissoryRequest,
    required this.resultCallback,
  });

  int openBottomSheets = 0;

  @override
  void onInit() {
    fetchPromissoryUnsignedDocumentRequest();
    super.onInit();
  }

  /// Sends a request to fetch an unsigned promissory document.
  Future<void> fetchPromissoryUnsignedDocumentRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryFetchUnsignedDocumentRequest promissoryFetchUnsignedDocumentRequest =
        PromissoryFetchUnsignedDocumentRequest(
      id: promissoryRequest.id!,
      docType: promissoryRequest.docType!.jsonValue,
    );

    hasError = false;
    isLoading = true;
    update();

    PromissoryServices.fetchUnsignedDocumentRequest(
      promissoryFetchUnsignedDocumentRequest: promissoryFetchUnsignedDocumentRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryFetchUnsignedDocumentResponse response, int _)):
          base64UnsignedPdf = response.data!.unSignedPdf!;
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

  /// Sends a request to get promissory assets.
  void _getPromissoryAssetRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = true;
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
          _checkPayment();
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

  /// Checks if the promissory request is a PublishRequest and if it has been paid.
  void _checkPayment() {
    if (promissoryRequest is PublishRequest) {
      final PublishRequest publishRequest = (promissoryRequest as PublishRequest);
      if (publishRequest.isPayed ?? false) {
        transactionData = publishRequest.transaction;
        Future.delayed(const Duration(milliseconds: 300), () {
          pageController.jumpToPage(2);
        });
      } else {
        _getPromissoryAmountRequest();
      }
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        pageController.jumpToPage(2);
      });
    }
  }

  /// Sends a request to get the promissory amount.
  Future<void> _getPromissoryAmountRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PublishRequest publishRequest = (promissoryRequest as PublishRequest);

    final PromissoryAmountRequestData promissoryAmountRequestData = PromissoryAmountRequestData(
      amount: publishRequest.amount!,
      gssToYekta: false,
    );

    hasError = false;
    isLoading = true;
    update();

    PromissoryServices.getPromissoryPublishPriceRequest(
      promissoryAmountRequestData: promissoryAmountRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryAmountResponseData response, int _)):
          promissoryAmountResponseData = response;
          update();
          _getWalletDetailRequest();
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

  Future<void> validateInternetPayment() async {
    _requestTransactionDetailById();
  }

  /// Sends a request to get transaction details by ID.
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
              SnackBarUtil.showSnackBar(
                title: locale.payment_error,
                message: transactionData?.message ?? locale.try_again2,
              );
              _showContinuePromissoryDepositBottomSheet();
              AppUtil.changePageController(
                pageController: pageController,
                page: 0,
                isClosed: isClosed,
              );
            } else {
              AppUtil.changePageController(
                pageController: pageController,
                page: 2,
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

  void setCurrentPaymentType(PaymentType paymentType) {
    currentPaymentType = paymentType;
    update();
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

  /// Sends a request to get payment deposits for the customer.
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

  /// Sends a request to make a promissory payment.
  void _promissoryPayment() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryPublishPaymentRequestData promissoryPublishPaymentRequestData = PromissoryPublishPaymentRequestData(
      id: promissoryRequest.id!,
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
            pageController.jumpToPage(2);
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

  /// Sends a request to initiate an internet payment for a promissory.
  void _promissoryInternetPayment() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryPublishPaymentRequestData promissoryPublishPaymentRequestData = PromissoryPublishPaymentRequestData(
      id: promissoryRequest.id!,
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
        positiveMessage:  locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _signPdf();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  /// Sends a request to sign a PDF document.
  Future<void> _signPdf() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final signDocumentData = SignDocumentData.fromPromissoryMainController(
      documentBase64: base64UnsignedPdf!,
    );
    final response = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (response.isSuccess != null && response.isSuccess!) {
      base64SignedPdf = response.data;

      isLoading = false;
      update();

      _promissoryPublishFinalizeRequest();
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
  void _promissoryPublishFinalizeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryPublishFinalizeRequestData promissoryPublishFinalizeRequestData =
        PromissoryPublishFinalizeRequestData(
      id: promissoryRequest.id!,
      signedPdf: base64SignedPdf!,
    );

    isLoading = true;
    update();

    PromissoryServices.promissoryPublishFinalizeRequest(
      promissoryPublishFinalizeRequestData: promissoryPublishFinalizeRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryPublishFinalizeResponse response, int _)):
          final result = CollateralPromissoryPublishResultData(
              isSuccess: true,
              message: locale.issued_successfulyy,
              promissoryId: response.data!.promissoryId!,
              promissoryPdfBase64: response.data!.multiSignedPdf);
          resultCallback(result);
          Get.back();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _getWalletDetailRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
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
            _showContinuePromissoryDepositBottomSheet();
            hasError = true;
            update();
          case Failure(exception: final ApiException apiException):
            hasError = true;
            update();
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void setValidPaymentType() {
    final int correctAmount = promissoryAmountResponseData!.data!.totalAmount!;
    if (walletAmount < correctAmount) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  Future<void> _showContinuePromissoryDepositBottomSheet() async {
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
        child: const CollateralPromissoryContinuePublishSelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }
}
