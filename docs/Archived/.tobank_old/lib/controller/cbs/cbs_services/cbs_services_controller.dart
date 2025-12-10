import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/cbs/request/credit_inquiry_request_data.dart';
import '../../../model/cbs/request/third_person_notify_request_data.dart';
import '../../../model/cbs/response/credit_inquiry_internet_response_data.dart';
import '../../../model/cbs/response/third_person_notify_response_data.dart';
import '../../../model/contact_match/custom_contact.dart';
import '../../../model/deposit/request/customer_deposits_request_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../model/transaction/response/transaction_data_response.dart';
import '../../../model/wallet/response/wallet_balance_response_data.dart';
import '../../../service/cbs_services.dart';
import '../../../service/core/api_core.dart';
import '../../../service/deposit_services.dart';
import '../../../service/transaction_services.dart';
import '../../../service/wallet_services.dart';
import '../../../ui/cbs/cbs_transaction_detail/cbs_transaction_detail_screen.dart';
import '../../../ui/cbs/cbs_waiting/cbs_waiting_screen.dart';
import '../../../ui/cbs/widget/cbs_select_payment_bottom_sheet.dart';
import '../../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../../ui/contact/contact_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/dialog_util.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CBSServicesController extends GetxController {
  MainController mainController = Get.find();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isPhoneNumberValid = true;
  bool isNationalCodeValid = true;
  bool isOtpValid = true;

  int openBottomSheets = 0;

  bool isLoading = false;

  String errorTitle = '';
  bool hasError = false;

  PaymentType currentPaymentType = PaymentType.wallet;
  TransactionData? transactionDataCharge;
  int walletAmount = 0;

  Deposit? selectedPaymentDeposit;

  CreditInquiryInternetResponseData? creditInquiryInternetResponseData;

  bool isOwner = true;

  PageController pageController = PageController();

  DateTime time = DateTime(2022);
  Timer? timer;
  int counter = 0;
  bool isLoadingOtp = false;

  void setMinePhoneNumber() {
    AppUtil.hideKeyboard(Get.context!);
    phoneNumberController.text = mainController.authInfoData!.mobile!;
    isOwner = true;
    update();
  }

  void showSelectContactScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(
      () => ContactScreen(
        returnDataFunction: (contact) {
          setSelectedPhoneNumber(contact);
        },
      ),
    )!
        .then((value) => AppUtil.hideKeyboard(Get.context!));
  }

  /// Show selected phone number in TextField
  /// remove space and replace +98 & 0098 with 0
  void setSelectedPhoneNumber(CustomContact contact) {
    phoneNumberController.text =
        contact.phones!.toList()[0].replaceAll(' ', '').replaceAll(Constants.iranCountryCode, '0');
    update();
  }

  Future<void> showPaymentBottomSheet() async {
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
        child: const CBSSelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void validatePhonePage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (phoneNumberController.text == mainController.authInfoData!.mobile!) {
      isPhoneNumberValid = true;
      isValid = true;
    } else {
      if (phoneNumberController.text.length == Constants.mobileNumberLength &&
          phoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
        isPhoneNumberValid = true;
      } else {
        isPhoneNumberValid = false;
        isValid = false;
      }
      if (nationalCodeController.text.length == Constants.nationalCodeLength &&
          AppUtil.validateNationalCode(nationalCodeController.text)) {
        isNationalCodeValid = true;
        isValid = true;
      } else {
        isNationalCodeValid = false;
        isValid = false;
      }
    }
    update();
    if (isValid) {
      if (phoneNumberController.text == mainController.authInfoData!.mobile!) {
        isOwner = true;
      } else {
        isOwner = false;
      }
      update();
      _getWalletDetailRequest();
    }
  }

  /// Sends a request to get wallet details, updates the UI,
  /// and potentially shows a payment bottom sheet or a notification.
  Future<void> _getWalletDetailRequest() async {
//locale
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
            if (walletAmount < mainController.creditInquiryPrice!) {
              currentPaymentType = PaymentType.gateway;
            }
            update();
            if (isOwner) {
              showPaymentBottomSheet();
            } else {
              thirdPersonNotify(isFirst: true);
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

  /// Sends a notification to a third person and handles the response.
  void thirdPersonNotify({required bool isFirst}) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ThirdPersonNotifyRequestData thirdPersonNotifyRequestData = ThirdPersonNotifyRequestData(
      mobile: phoneNumberController.text,
    );
    isLoadingOtp = true;
    update();
    CBSServices.thirdPersonNotifyRequest(
      thirdPersonNotifyRequestData,
    ).then((result) {
      isLoadingOtp = false;
      update();

      switch (result) {
        case Success(value: (final ThirdPersonNotifyResponseData _, int _)):
          _startTimer();
          update();
          if (isFirst) {
            AppUtil.nextPageController(pageController, isClosed);
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Starts a timer for a specified duration and updates the UI periodically.
  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    counter = 120;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (counter < 1) {
        timer.cancel();
      } else {
        counter = counter - 1;
      }
      update();
    });
  }

  String? getTimerString() {
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: counter)));
    return timer;
  }

  void setCurrentPaymentType(PaymentType value) {
    currentPaymentType = value;
    update();
  }

  void validatePayment() {
    AppUtil.hideKeyboard(Get.context!);
    if (!isOwner) {
      if (otpController.text.trim().length != Constants.otpLength) {
        isOtpValid = false;
        update();
        return;
      } else {
        isOtpValid = true;
        update();
      }
    }

    switch (currentPaymentType) {
      case PaymentType.wallet:
        if (walletAmount >= mainController.creditInquiryPrice!) {
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

  /// Sends a request to get payment deposits,
  /// updates the UI, and shows a bottom sheet to select a deposit.
  void _getPaymentDepositsRequest() {
//locale
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

  void _confirmPayment() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.sure_about_paying_inquiry_fee,
        description: '',
        positiveMessage:locale.confirmation,
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
        _creditInquiryInternetRequest();
      case PaymentType.wallet:
      case PaymentType.deposit:
        _creditInquiryPaymentRequest();
    }
  }

  /// Sends a request for credit inquiry payment,
  /// updates the UI, and potentially shows a payment screen or an error message.
  void _creditInquiryPaymentRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final CreditInquiryRequestData creditInquiryRequestData;
    if (isOwner) {
      creditInquiryRequestData = CreditInquiryRequestData(
        verifyCode: null,
        mobile: mainController.authInfoData!.mobile!,
        nationalCode: mainController.authInfoData!.nationalCode!,
        transactionType: currentPaymentType,
        depositNumber: currentPaymentType == PaymentType.deposit ? selectedPaymentDeposit!.depositNumber! : null,
      );
    } else {
      creditInquiryRequestData = CreditInquiryRequestData(
        verifyCode: otpController.text,
        mobile: phoneNumberController.text,
        nationalCode: nationalCodeController.text,
        transactionType: currentPaymentType,
        depositNumber: currentPaymentType == PaymentType.deposit ? selectedPaymentDeposit!.depositNumber! : null,
      );
    }

    CBSServices.creditInquiryPaymentRequest(
      creditInquiryRequestData: creditInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionDataCharge = response.data;
          update();
          if (transactionDataCharge!.isSuccess == false) {
            SnackBarUtil.showSnackBar(
              title: locale.payment_error,
              message: transactionDataCharge?.message ?? locale.try_again2,
            );
          } else {
            _showCBSPaymentScreen();
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request for credit inquiry via internet, updates the UI,
  /// and potentially navigates to a different page or shows an error message.
  void _creditInquiryInternetRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final CreditInquiryRequestData creditInquiryRequestData;
    if (isOwner) {
      creditInquiryRequestData = CreditInquiryRequestData(
        verifyCode: null,
        mobile: mainController.authInfoData!.mobile!,
        nationalCode: mainController.authInfoData!.nationalCode!,
        transactionType: currentPaymentType,
        depositNumber: null,
      );
    } else {
      creditInquiryRequestData = CreditInquiryRequestData(
        verifyCode: otpController.text,
        mobile: phoneNumberController.text,
        nationalCode: nationalCodeController.text,
        transactionType: currentPaymentType,
        depositNumber: null,
      );
    }

    CBSServices.creditInquiryInternetRequest(
      creditInquiryRequestData: creditInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CreditInquiryInternetResponseData response, int _)):
          creditInquiryInternetResponseData = response;
          update();
          _closeBottomSheets();
          if (isOwner) {
            AppUtil.changePageController(pageController: pageController, page: 2, isClosed: isClosed);
          } else {
            AppUtil.nextPageController(pageController, isClosed);
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showCBSPaymentScreen() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (transactionDataCharge!.isSuccess == true) {
      _closeBottomSheets();
      Get.back();
      if (transactionDataCharge!.extraField!.openbankingResponse!.status == 200) {
        Get.off(() => CBSTransactionDetailScreen(
              transactionData: transactionDataCharge!,
              displayDescription: true,
            ));
      } else {
        Get.off(() => CBSWaitingScreen(
              transactionData: transactionDataCharge!,
            ));
      }
    } else {
      _closeBottomSheets();
      Get.back();
      SnackBarUtil.showSnackBar(
        title: locale.payment_error,
        message: transactionDataCharge?.message ?? locale.try_again2,
      );
    }
  }

  Future<void> validateInternetPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Sends a request to get transaction details by ID, updates the UI,
  /// and potentially shows a payment screen or an error message.
  void _transactionDetailByIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: creditInquiryInternetResponseData!.data!.transactionId!,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionDataCharge = response.data;
            update();
            _showCBSPaymentScreen();
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  bool isEnabled() {
    return phoneNumberController.text.length == Constants.mobileNumberLength &&
        (phoneNumberController.text == mainController.authInfoData!.mobile! ||
            nationalCodeController.text.length == Constants.nationalCodeLength);
  }

  bool isVerifyCodeButtonEnabled() {
    return otpController.text.trim().length == Constants.otpLength;
  }

  void clearPhoneNumberTextField() {
    phoneNumberController.clear();
    nationalCodeController.clear();
    update();
  }
}
