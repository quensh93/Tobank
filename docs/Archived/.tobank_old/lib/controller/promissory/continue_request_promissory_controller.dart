import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/promissory/request/promissory_amount_request_data.dart';
import '../../model/promissory/request/promissory_endorsement_finalize_request_data.dart';
import '../../model/promissory/request/promissory_fetch_unsigned_document_request_data.dart';
import '../../model/promissory/request/promissory_guarantee_finalize_request_data.dart';
import '../../model/promissory/request/promissory_publish_finalize_request_data.dart';
import '../../model/promissory/request/promissory_publish_payment_request_data.dart';
import '../../model/promissory/request/promissory_settlement_finalize_request_data.dart';
import '../../model/promissory/request/promissory_settlement_gradual_finalize_request_data.dart';
import '../../model/promissory/response/promissory_amount_response_data.dart';
import '../../model/promissory/response/promissory_endorsement_finalize_response_data.dart';
import '../../model/promissory/response/promissory_fetch_unsigned_document_response_data.dart';
import '../../model/promissory/response/promissory_guarantee_finalize_response_data.dart';
import '../../model/promissory/response/promissory_internet_payment_response_data.dart';
import '../../model/promissory/response/promissory_publish_finalize_response_data.dart';
import '../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../model/promissory/response/promissory_settlement_finalize_response_data.dart';
import '../../model/promissory/response/promissory_settlement_gradual_finalize_response_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/promissory_services.dart';
import '../../service/transaction_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../ui/promissory/continue_request_promissory/widget/continue_promissory_select_payment_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ContinueRequestPromissoryController extends GetxController {
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

  PromissoryPublishFinalizeResponse? promissoryPublishFinalizeResponse;
  PromissoryEndorsementFinalizeResponse? promissoryEndorsementFinalizeResponse;
  PromissoryGuaranteeFinalizeResponseData? promissoryGuaranteeFinalizeResponse;
  PromissorySettlementFinalizeResponse? promissorySettlementFinalizeResponse;
  PromissorySettlementGradualFinalizeResponse? promissorySettlementGradualFinalizeResponse;

  ContinueRequestPromissoryController({
    required this.promissoryRequest,
  });

  int openBottomSheets = 0;

  @override
  void onInit() {
    fetchPromissoryUnsignedDocumentRequest();
    super.onInit();
  }

  /// Fetches the unsigned promissory document and proceeds with payment checks.
  Future<void> fetchPromissoryUnsignedDocumentRequest() async {
    hasError = false;
    isLoading = true;
    update();

    final PromissoryFetchUnsignedDocumentRequest promissoryFetchUnsignedDocumentRequest =
        PromissoryFetchUnsignedDocumentRequest(
      id: promissoryRequest.id!,
      docType: promissoryRequest.docType!.jsonValue,
    );

    PromissoryServices.fetchUnsignedDocumentRequest(
            promissoryFetchUnsignedDocumentRequest: promissoryFetchUnsignedDocumentRequest)
        .then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryFetchUnsignedDocumentResponse response, int _)):
          base64UnsignedPdf = response.data!.unSignedPdf!;
          update();
          _checkPayment();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
      }
    });
  }

  /// Checks the payment status of a promissory request and navigates accordingly.
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

  /// Retrieves the promissory amount details and initiates a wallet detail request.
  Future<void> _getPromissoryAmountRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    final PublishRequest publishRequest = (promissoryRequest as PublishRequest);

    final PromissoryAmountRequestData promissoryAmountRequestData = PromissoryAmountRequestData(
      amount: publishRequest.amount!,
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

  /// Validates an internet payment by fetching the transaction details.
  Future<void> validateInternetPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Retrieves transaction details by ID and handles the payment outcome.
  void _transactionDetailByIdRequest() {//locale
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

  /// Retrieves the user's payment deposits and displays a selection bottom sheet.
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

  /// Confirms the payment for issuing a promissory note.
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

  /// Initiates the promissory payment process.
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

  /// Initiates an internet payment for a promissory.
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

  /// Signs the PDF document and initiates the finalization process.
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

      // TODO: Refactor to one method
      switch (promissoryRequest.runtimeType) {
        case PublishRequest:
          _promissoryPublishFinalizeRequest();
          break;
        case EndorsementRequest:
          _promissoryEndorsementFinalizeRequest();
          break;
        case GuaranteeRequest:
          _promissoryGuaranteeFinalizeRequest();
          break;
        case SettlementRequest:
          _promissorySettlementFinalizeRequest();
          break;
        case SettlementGradualRequest:
          _promissorySettlementGradualFinalizeRequest();
          break;
      }
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

  /// Finalizes the promissory publish request.
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

  /// Finalizes the promissory endorsement request.
  void _promissoryEndorsementFinalizeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryEndorsementFinalizeRequestData promissoryEndorsementFinalizeRequestData =
        PromissoryEndorsementFinalizeRequestData(
      id: promissoryRequest.id!,
      signedPdf: base64SignedPdf!,
    );

    isLoading = true;
    update();

    PromissoryServices.promissoryEndorsementFinalizeRequest(
      promissoryEndorsementFinalizeRequestData: promissoryEndorsementFinalizeRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryEndorsementFinalizeResponse response, int _)):
          promissoryEndorsementFinalizeResponse = response;
          multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
            source: promissoryEndorsementFinalizeResponse!.data!.multiSignedPdf!,
          );
          update();
          Get.back();
          Timer(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.request_submit_successfully);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Finalizes the promissory guarantee request.
  void _promissoryGuaranteeFinalizeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryGuaranteeFinalizeRequestData promissoryGuaranteeFinalizeRequestData =
        PromissoryGuaranteeFinalizeRequestData(
      id: promissoryRequest.id!,
      signedPdf: base64SignedPdf!,
    );

    isLoading = true;
    update();

    PromissoryServices.promissoryGuaranteeFinalize(
            promissoryGuaranteeFinalizeRequestData: promissoryGuaranteeFinalizeRequestData)
        .then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryGuaranteeFinalizeResponseData response, int _)):
          promissoryGuaranteeFinalizeResponse = response;
          multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
            source: promissoryGuaranteeFinalizeResponse!.data!.multiSignedPdf!,
          );
          update();
          Get.back();
          Timer(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.request_submit_successfully);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Finalizes the promissory settlement request.
  void _promissorySettlementFinalizeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissorySettlementFinalizeRequest promissorySettlementFinalizeRequest = PromissorySettlementFinalizeRequest(
      id: promissoryRequest.id!,
      signedPdf: base64SignedPdf!,
    );

    isLoading = true;
    update();

    PromissoryServices.promissorySettlementFinalizeRequest(
      promissorySettlementFinalizeRequest: promissorySettlementFinalizeRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissorySettlementFinalizeResponse response, int _)):
          promissorySettlementFinalizeResponse = response;
          multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
            source: promissorySettlementFinalizeResponse!.data!.multiSignedPdf!,
          );
          update();
          Get.back();
          Timer(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.request_submit_successfully);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Finalizes the promissory settlement gradual request.
  void _promissorySettlementGradualFinalizeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissorySettlementGradualFinalizeRequest promissoryPublishFinalizeRequestData =
        PromissorySettlementGradualFinalizeRequest(
      id: promissoryRequest.id!,
      signedPdf: base64SignedPdf!,
    );

    isLoading = true;
    update();

    PromissoryServices.promissorySettlementGradualFinalizeRequest(
      promissorySettlementGradualFinalizeRequest: promissoryPublishFinalizeRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissorySettlementGradualFinalizeResponse response, int _)):
          promissorySettlementGradualFinalizeResponse = response;
          multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
            source: promissorySettlementGradualFinalizeResponse!.data!.multiSignedPdf!,
          );
          update();
          Get.back();
          Timer(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.request_submit_successfully);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the user's wallet details and updates payment options.
  Future<void> _getWalletDetailRequest() async {//locale
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
        child: const ContinuePromissorySelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  /// Handles the back button press event.
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
