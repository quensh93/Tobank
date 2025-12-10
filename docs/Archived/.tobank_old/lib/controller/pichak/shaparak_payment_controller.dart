import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:otp_plugin/otp_plugin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/expire_data.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/card_balance/request/card_balance_otp_request_model.dart';
import '../../model/card_balance/request/card_balance_request_model.dart';
import '../../model/card_balance/response/card_balance_otp_response.dart';
import '../../model/card_balance/response/card_balance_response_model.dart';
import '../../service/card_balance_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/common/card_expire_select_view.dart';
import '../../ui/source_card_selector/source_card_selector_screen.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ShaparakPaymentController extends GetxController {
  MainController mainController = Get.find();
  List<Widget> cardItemWidgetList = [];
  bool isLoading = false;
  bool isCardsLoading = false;
  bool isLoadingOtp = false;

  PageController pageController = PageController();

  bool isCardNumberValid = true;

  TextEditingController cardNumberController = TextEditingController();

  CustomerCard? selectedSourceCustomerCard;

  ShaparakPaymentController({required this.returnDataFunction});

  int counter = 0;

  DateTime time = DateTime(2021);

  TextEditingController passwordController = TextEditingController();
  TextEditingController cvv2Controller = TextEditingController();
  TextEditingController monthExpireController = TextEditingController();
  TextEditingController yearExpireController = TextEditingController();

  bool isCvvValid = true;
  bool isPasswordValid = true;
  bool isCardExpYearValid = true;
  bool isCardExpMonthValid = true;

  Function(bool isPay, String? manaId) returnDataFunction;
  Timer? timer;

  @override
  Future<void> onInit() async {
    // if (mainController.walletDetailData != null &&
    //     mainController.walletDetailData!.data!.cardDefault != null) {
    //   if (mainController.walletDetailData!.data!.cardDefault!.hubCardId !=
    //       null) {
    //     _setCardDataModel(mainController.walletDetailData!.data!.cardDefault!);
    //   }
    // }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Formats the remaining time into minutes and seconds using the `intl` package.
  String getMinutesAndSecond() {
    return intl.DateFormat('mm:ss').format(time.add(Duration(seconds: counter)));
  }

  /// Requests an OTP (One-Time Password) if the card number is provided and the counter is zero.
  Future<void> requestOtp() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (cardNumberController.text.isNotEmpty) {
      if (counter <= 0) {
        _getOtpRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_bank_card_first,
      );
    }
  }

  void showExpireDateBottomSheet() {
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    final ExpireData expireData = ExpireData();
    expireData.expireMonth = monthExpireController.text;
    expireData.expireYear = yearExpireController.text;
    showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 9 / 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CardExpireSelectWidget(
          expireData: expireData,
          returnData: (selectedExpireData) {
            yearExpireController.text = selectedExpireData.expireYear ?? '';
            monthExpireController.text = selectedExpireData.expireMonth ?? '';
          },
        ),
      ),
    );
  }

  /// Requests an OTP for card balance and handles the response,
  /// displaying a success message and starting a timer on success.
  void _getOtpRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoadingOtp = true;
    update();

    final CardBalanceOTPRequestModel cardBalanceOTPRequestModel = CardBalanceOTPRequestModel();
    cardBalanceOTPRequestModel.cardNumber = selectedSourceCustomerCard!.cardNumber;

    CardBalanceServices.getDynamicPassword(
      cardBalanceOTPRequestModel: cardBalanceOTPRequestModel,
    ).then((result) {
      isLoadingOtp = false;
      update();
      switch (result) {
        case Success(value: (final CardBalanceOTPResponseModel _, int _)):
          //_readOTP();
          SnackBarUtil.showInfoSnackBar(
            locale.dynamic_password_sent,
          );
          _startTimer();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Starts a timer that counts down from 120 seconds.
  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    counter = 120;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (counter < 1) {
          timer.cancel();
        } else {
          counter = counter - 1;
        }
        update();
      },
    );
  }

  /// Validates card information and initiates a balance request if all fields are valid.
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (passwordController.text.trim().isNotEmpty) {
      isPasswordValid = true;
    } else {
      isPasswordValid = false;
      isValid = false;
    }

    if (monthExpireController.text.length == 2) {
      isCardExpMonthValid = true;
    } else {
      isValid = false;
      isCardExpMonthValid = false;
    }

    if (yearExpireController.text.length == 2) {
      isCardExpYearValid = true;
    } else {
      isValid = false;
      isCardExpYearValid = false;
    }

    if (cvv2Controller.text.trim().isNotEmpty) {
      isCvvValid = true;
    } else {
      isCvvValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _getBalanceRequest();
    }
  }

  /// Sends a card balance request and handles the response, returning data and navigating back.
  Future _getBalanceRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CardBalanceRequestModel cardBalanceRequestModel = CardBalanceRequestModel();
    cardBalanceRequestModel.imei = const Uuid().v4();
    cardBalanceRequestModel.platform = Platform.isAndroid ? '1' : '2';
    cardBalanceRequestModel.cvv2 = cvv2Controller.text;
    cardBalanceRequestModel.expireDate = yearExpireController.text + monthExpireController.text;
    cardBalanceRequestModel.cardId = selectedSourceCustomerCard!.hubCardData!.hubCardId;
    cardBalanceRequestModel.pin2 = passwordController.text;
    cardBalanceRequestModel.isManaToken = true;
    cardBalanceRequestModel.nationalId = mainController.authInfoData!.nationalCode;

    isLoading = true;
    update();

    CardBalanceServices.getCardBalance(cardBalanceRequestModel: cardBalanceRequestModel).then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CardBalanceResponseModel response, int _)):
          if (response.data != null && response.data!.status != null && response.data!.status!) {
            Get.back();
            returnDataFunction(true, response.data!.manaId);
          } else {
            SnackBarUtil.showInfoSnackBar(locale.operation_failed);
            Get.back();
            returnDataFunction(false, null);
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void showSelectCardScreen() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    Get.to(() => SourceCardSelectorScreen(
          title: locale.select_bank_card,
          description: locale.registered_cards,
          checkIsTransfer: false,
          isPichak: true,
          returnDataFunction: (customerCard, bankInfo) {
            _setCardDataModel(
              customerCard,
            );
          },
        ));
  }

  /// Sets the card data model and updates the UI with the card information.
  void _setCardDataModel(CustomerCard customerCard) {
    selectedSourceCustomerCard = customerCard;
    yearExpireController.text = customerCard.cardExpYear ?? '';
    monthExpireController.text = customerCard.cardExpMonth ?? '';
    counter = 0;
    cardNumberController.text = AppUtil.splitCardNumber(customerCard.cardNumber!, '-');
    update();
  }

  /// Reads OTP from SMS messages on Android using the `OtpPlugin` and handles exceptions.
  Future<void> readOTP() async {
    _handleException();
    if (Platform.isAndroid) {
      final String? message = await OtpPlugin().getOTP();
      if (message != null) {
        final String code = AppUtil.getOTPFromMessage(message);
        if (code.isNumericOnly) {
          passwordController.text = code;
        } else {
          _handleException();
        }
      } else {
        _handleException();
      }
    }
  }

  Future<void> _handleException() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    SnackBarUtil.showSnackBar(
      title: locale.error,
      message: locale.sms_code_reading_failed,
    );
    await Sentry.captureMessage(
      'otpReadFailed',
      params: [cardNumberController.text.replaceAll('-', '').substring(0, 6)],
    );
  }
}
