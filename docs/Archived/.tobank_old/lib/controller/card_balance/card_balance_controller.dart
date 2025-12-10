import 'dart:async';
import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:otp_plugin/otp_plugin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

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
import '../../util/file_util.dart';
import '../../util/persian_date.dart';
import '../../util/snack_bar_util.dart';
import '../../util/web_only_utils/image_share_util.dart';
import '../main/main_controller.dart';

class CardBalanceController extends GetxController {
  CardBalanceController({
    this.customerCard,
    this.bankInfo,
  });

  String? sourceCardSymbol;
  CustomerCard? customerCard;
  BankInfo? bankInfo;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  CustomerCard? selectedCustomerCard;
  bool isLoading = false;
  bool isLoadingOtp = false;
  int counter = 0;
  CardBalanceRequestModel cardBalanceRequestModel = CardBalanceRequestModel();
  late CardBalanceResponseModel cardBalanceResponseModel;

  String errorTitle = '';

  bool hasError = false;

  TextEditingController sourceCardController = TextEditingController();

  bool isSourceCardNumberValid = true;
  DateTime dateTime = DateTime.now();
  GlobalKey globalKey = GlobalKey();

  bool isPasswordValid = true;
  bool isCardExpYearValid = true;
  bool isCardExpValid = true;
  bool isCardExpMonthValid = true;
  bool isCvvValid = true;

  TextEditingController expireDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cvv2Controller = TextEditingController();

  DateTime time = DateTime(2020);
  Timer? timer;

  @override
  Future<void> onInit() async {
    if (customerCard != null) {
      _setCardDataModel(customerCard!, bankInfo!);
    } else {
      // if (mainController.walletDetailData != null &&
      //     mainController.walletDetailData!.data!.cardDefault != null) {
      //   _setCardDataModel(mainController.walletDetailData!.data!.cardDefault!);
      // }
    }
    await FkUserAgent.init();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Starts a timer that counts down from120 seconds and updates the UI.
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

  /// Retrieves the card balance for a given card.
  void _getBalanceRequest(cardBalanceRequestModel) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    CardBalanceServices.getCardBalance(cardBalanceRequestModel: cardBalanceRequestModel).then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CardBalanceResponseModel response, int _)):
          dateTime = DateTime.now();
          cardBalanceResponseModel = response;
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

  String getTimer() {
    String timer = '0';
    if (counter < 10) {
      timer = '0$counter';
    } else {
      timer = '$counter';
    }
    return timer;
  }

  /// Validate values of form before request
  void validate() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (selectedCustomerCard != null) {
      isSourceCardNumberValid = true;
    } else {
      isValid = false;
      isSourceCardNumberValid = false;
    }
    if (passwordController.text.trim().isNotEmpty) {
      isPasswordValid = true;
    } else {
      isValid = false;
      isPasswordValid = false;
    }
    if (expireDateController.text.isNotEmpty) {
      isCardExpValid = true;
    } else {
      isValid = false;
      isCardExpYearValid = false;
    }
    if (cvv2Controller.text.trim().isNotEmpty) {
      isCvvValid = true;
    } else {
      isValid = false;
      isCvvValid = false;
    }
    update();

    /// Show confirm message before request to server
    if (isValid) {
      cardBalanceRequestModel = CardBalanceRequestModel();
      cardBalanceRequestModel.imei = const Uuid().v4();
      cardBalanceRequestModel.platform = Platform.isAndroid ? '1' : '2';
      cardBalanceRequestModel.pin2 = passwordController.text;
      cardBalanceRequestModel.expireDate =
          expireDateController.text.split('/')[0] + expireDateController.text.split('/')[1];
      cardBalanceRequestModel.cvv2 = cvv2Controller.text;
      cardBalanceRequestModel.cardId = selectedCustomerCard!.cardNumber;
      cardBalanceRequestModel.isManaToken = false;
      cardBalanceRequestModel.nationalId = mainController.authInfoData!.nationalCode;
      _getBalanceRequest(cardBalanceRequestModel);
    }
  }

  /// Requests an OTP (One-Time Password) for card balance inquiries.
  void _getOtpRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoadingOtp = true;
    update();

    final CardBalanceOTPRequestModel cardBalanceOTPRequestModel = CardBalanceOTPRequestModel();
    cardBalanceOTPRequestModel.cardNumber = selectedCustomerCard!.cardNumber;

    CardBalanceServices.getDynamicPassword(
      cardBalanceOTPRequestModel: cardBalanceOTPRequestModel,
    ).then((result) {
      isLoadingOtp = false;
      update();
      switch (result) {
        case Success(value: (final CardBalanceOTPResponseModel response, int _)):
          SnackBarUtil.showInfoSnackBar(
            response.data!.description ?? '',
          );
          //_readOTP();
          _startTimer();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void showExpireDateBottomSheet() {
    if (isClosed) {
      return;
    }
    AppUtil.hideKeyboard(Get.context!);
    final ExpireData expireData = ExpireData();
    if (expireDateController.text.isNotEmpty) {
      expireData.expireMonth = expireDateController.text.split('/')[1];
      expireData.expireYear = expireDateController.text.split('/')[0];
    }
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
            expireDateController.text = selectedExpireData.expireYear == null || selectedExpireData.expireMonth == null
                ? ''
                : '${selectedExpireData.expireYear!}/${selectedExpireData.expireMonth!}';
          },
        ),
      ),
    );
  }

  void requestOpt() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (sourceCardController.text.isNotEmpty) {
      if (counter <= 0) {
        _getOtpRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_bank_card_first,
      );
    }
  }

  /// Formats a time duration into minutes and seconds.
  String getMinutesAndSecond() {
    return intl.DateFormat('mm:ss').format(time.add(Duration(seconds: counter)));
  }

  void showSelectSourceCardScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    Get.to(() => SourceCardSelectorScreen(
          title: locale.select_card_,
          description: locale.saved_cards,
          checkIsTransfer: false,
          isPichak: false,
          returnDataFunction: (customerCard, bankInfo) {
            _setCardDataModel(customerCard, bankInfo);
          },
        ));
  }

  void _setCardDataModel(CustomerCard customerCard, BankInfo bankInfo) {
    expireDateController.text = customerCard.cardExpYear == null || customerCard.cardExpMonth == null
        ? ''
        : '${customerCard.cardExpYear!}/${customerCard.cardExpMonth!}';
    selectedCustomerCard = customerCard;
    sourceCardController.text = AppUtil.splitCardNumber(customerCard.cardNumber!, '-');
    sourceCardSymbol = bankInfo.symbol;
    update();
  }

  String? getNowDateTime() {
    final PersianDate persianDate = PersianDate();
    return persianDate.parseToFormat(dateTime.toString().split('+')[0], 'd MM yyyy - HH:nn');
  }

  Future<void> captureAndSharePng() async {
    try {
      await ImageShareUtil.captureAndShareWidget(
        globalKey: globalKey,
        pixelRatio: 6.0,
        fileName: 'image.png',
        shareText: '',
      );
    } on Exception catch (e) {
      AppUtil.printResponse(e.toString());
    }
  }

  /// Reads OTP (One-Time Password) from SMS messages on Android devices.
  Future<void> readOTP() async {
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

  Future<void> _handleException() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    SnackBarUtil.showSnackBar(
      title: locale.error,
      message: locale.reading_sms_error,
    );
    await Sentry.captureMessage(
      'otpReadFailed',
      params: [sourceCardController.text.replaceAll('-', '').substring(0, 6)],
    );
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
