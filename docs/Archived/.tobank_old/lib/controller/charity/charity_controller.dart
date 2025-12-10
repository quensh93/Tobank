import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/charity/request/charity_payment_request_data.dart';
import '../../model/charity/response/charity_internet_pay_data.dart';
import '../../model/charity/response/list_charity_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/charity_wallet_pay_data.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/charity_services.dart';
import '../../service/core/api_core.dart';
import '../../service/transaction_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/charity/widget/charity_amount_bottom_sheet.dart';
import '../../ui/charity/widget/charity_select_payment_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class CharityController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  List<CharityData>? charityDataList = [];
  CharityData? selectedCharityData;
  CharityWalletPayData? charityWalletResponseData;
  TransactionData? transactionData;
  CharityInternetPayData? charityInternetResponseData;
  bool isLoading = false;
  int walletAmount = 0;
  int amount = 0;

  bool selectPlanValid = true;
  bool amountValid = true;

  TextEditingController amountController = TextEditingController();
  PaymentType currentPaymentType = PaymentType.wallet;

  String errorTitle = '';
  bool hasError = false;

  int openBottomSheets = 0;

  @override
  void onInit() {
    getCharityListRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    if (mainController.overlayContext != null) {
      Timer(Constants.duration200, () {
        OverlaySupportEntry.of(mainController.overlayContext!)?.dismiss();
      });
    }
    Get.closeAllSnackbars();
  }

  /// Retrieves a list of charities and handles success or error responses.
  ///
  /// Get data of [ListCharityData] from server request
  Future getCharityListRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CharityServices.getCharitiesRequest().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final ListCharityData response, int _)):
            charityDataList = response.data;
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
      },
    );
  }

  /// Check type of payment charity
  /// if is wallet, pay charity from wallet or not, pay from gateway
  void _validatePayMethod(CharityPaymentRequestData charityPaymentData) {
    if (currentPaymentType == PaymentType.wallet) {
      _charityWalletPaymentRequest(charityPaymentData);
    } else {
      _charityInternetPaymentRequest(charityPaymentData);
    }
  }

  /// Processes a charity donation payment using the user's wallet.
  ///
  /// Get data of [CharityWalletPayData] from server request
  void _charityWalletPaymentRequest(CharityPaymentRequestData charityPaymentRequestData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    CharityServices.charityWalletPaymentRequest(
      charityPaymentRequestData: charityPaymentRequestData,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            update();
            _closeBottomSheets();
            AppUtil.changePageController(
              pageController: pageController,
              page: 3,
              isClosed: isClosed,
            );
          case Failure(exception: final ApiException apiException):
            if (apiException.type == ApiExceptionType.noConnection) {
              _checkClientRefTransaction(charityPaymentRequestData.refId);
            } else {
              SnackBarUtil.showSnackBar(
                title: locale.show_error(apiException.displayCode),
                message: apiException.displayMessage,
              );
            }
        }
      },
    );
  }

  /// Checks the status of a transaction using its client reference ID.
  void _checkClientRefTransaction(String refId) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    TransactionServices.getTransactionByRefId(
      refId: refId,
    ).then((result) {
      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          update();
          AppUtil.changePageController(
            pageController: pageController,
            page: 3,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          if (apiException.statusCode == 404) {
            AppUtil.showOverlaySnackbar(
              message: locale.transaction_status_unknown,
              buttonText: locale.check_again_,
              callback: () {
                _checkClientRefTransaction(refId);
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

  /// Processes a charity donation payment using internet payment methods.
  ///
  /// Get data of [CharityInternetPayData] from server request
  void _charityInternetPaymentRequest(CharityPaymentRequestData charityPaymentData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    CharityServices.charityInternetPaymentRequest(
      charityPaymentRequestData: charityPaymentData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CharityInternetPayData response, int _)):
          charityInternetResponseData = response;
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

  Future<void> validateInternetPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Retrieves transaction details by its ID (obtained from charity internet payment response).
  ///
  /// This function retrieves detailed information about a transaction using its ID,
  /// which is obtained from the [charityInternetResponseData].
  void _transactionDetailByIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: charityInternetResponseData!.data!.transactionId!,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
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

  /// Retrieves the user's wallet balance and determines valid payment types.
  Future<void> _getWalletDetailRequest() async { //locale
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
            setValidPaymentType();
            _showPaymentBottomSheet();
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
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

  /// Validate values of form before request
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (amount >= Constants.minValidAmount) {
      amountValid = true;
    } else {
      isValid = false;
      amountValid = false;
    }
    update();
    if (isValid) {
      _getWalletDetailRequest();
    }
  }

  /// Displays a confirmation dialog for charity payment before paying.
  void payConfirm() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.charity_payment_confirmation_message,
        description: locale.charity_payment_confirmation_description,
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _validateAmount();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  /// Validates the payment amount based on the selected payment type.
  void _validateAmount() {
    if (currentPaymentType == PaymentType.wallet) {
      if (walletAmount >= amount) {
        returnData();
      } else {
        Timer(Constants.duration100, () {
          SnackBarUtil.showNotEnoughWalletMoneySnackBar();
        });
      }
    } else {
      returnData();
    }
  }

  /// Prepares data for charity payment and proceeds with payment validation.
  void returnData() {
    final String refId = AppUtil.getClientRef(mainController.authInfoData!.token!);
    final CharityPaymentRequestData charityPaymentData = CharityPaymentRequestData(
      amount: amount,
      discount: 0,
      wallet: currentPaymentType == PaymentType.wallet ? 1 : 0,
      refId: refId,
      charityId: selectedCharityData!.id!,
    );
    _validatePayMethod(charityPaymentData);
  }

  void setCurrentPaymentType(PaymentType value) {
    currentPaymentType = value;
    update();
  }

  int getCorrectAmount() {
    return amount;
  }

  void setSelectedCharityData(CharityData charityData) {
    selectedCharityData = charityData;
    update();
    _showBottomSheetAmount();
  }

  Future<void> _showBottomSheetAmount() async {
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
              child: const CharityAmountBottomSheetWidget(),
            ));
    openBottomSheets--;
  }

  /// Converts the entered amount to its word representation in Toman.
  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
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

  void setValidPaymentType() {
    final int correctAmount = getCorrectAmount();
    if (walletAmount < correctAmount) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
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
              child: const CharitySelectPaymentBottomSheet(),
            ));
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
