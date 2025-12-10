import 'dart:async';
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:otp_plugin/otp_plugin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../model/automatic_dynamic_pin/automatic_dynamic_pin_stored_data_model.dart';
import '../../../model/automatic_dynamic_pin/request/automatic_dynamic_pin_transfer_request_data.dart';
import '../../../model/bank_list_data.dart';
import '../../../model/card/expire_data.dart';
import '../../../model/card/response/customer_card_response_data.dart';
import '../../../model/card_to_card/request/card_owner_request_data.dart';
import '../../../model/card_to_card/request/card_to_card_dynamic_password_request_data.dart';
import '../../../model/card_to_card/request/card_to_card_request_data.dart';
import '../../../model/card_to_card/response/card_owner_data.dart';
import '../../../model/card_to_card/response/otp_bank_data.dart';
import '../../../model/common/card_scanner_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../model/transaction/response/transaction_data_response.dart';
import '../../../service/automatic_dynamic_pin_services.dart';
import '../../../service/card_services.dart';
import '../../../service/card_to_card_services.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/automatic_dynamic_pin/automatic_dynamic_pin_active_screen.dart';
import '../../../ui/card/add_card_screen.dart';
import '../../../ui/card_scanner/card_scanner_screen.dart';
import '../../../ui/common/card_expire_select_view.dart';
import '../../../ui/common/dynamic_pin_type_select_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/dialog_util.dart';
import '../../../util/digit_to_word.dart';
import '../../../util/snack_bar_util.dart';
import '../../../util/storage_util.dart';
import '../../main/main_controller.dart';

class CardTransferController extends GetxController with WidgetsBindingObserver {
  String? sourceCardSymbol;
  String? destinationCardSymbol;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  CardOwnerResponseData? cardOwnerResponseData;
  TransactionData? transactionData;
  bool isLoading = false;
  bool isLoadingOtp = false;
  bool isCardsLoading = false;
  int counter = 0;
  String? expireDate;
  String errorTitle = '';
  bool hasError = false;

  bool isAutomaticDynamicPinAvailable = true;
  AutomaticDynamicPinStoredData? automaticDynamicPinStoredData;

  int amount = 0;

  bool isDestinationCardNumberValid = true;
  bool isAmountValid = true;

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isSelectedDestination = false;
  bool isAvailableCard = false;

  bool isPasswordValid = true;
  bool isExpireDateValid = true;
  bool isCvvValid = true;

  TextEditingController expireDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cvv2Controller = TextEditingController();
  bool storeDestinationCard = false;

  DateTime time = DateTime(2020);

  Timer? timer;

  TextEditingController destinationCardController = TextEditingController();

  bool isDestinationCardValid = true;

  bool isEnabled = true;

  bool isSourceCardValid = true;

  CustomerCard? sourceCustomerCard;

  List<CustomerCard> destinationCustomerCardList = [];
  List<CustomerCard> allDestinationCustomerCardList = [];
  List<BankInfo> bankInfoList = [];

  ExpireData? selectedExpireDataValue;

  int openBottomSheets = 0;

  bool showAddButton = true;

  List<BankDataItem> bankDataItemList = [];

  BankInfo? selectedSourceBankInfo;

  final Deposit? deposit;

  final Function(bool isHideTabView) hideTabViewFunction;

  CardTransferController({
    required this.deposit,
    required this.hideTabViewFunction,
  });

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    await _getBankListData();
    getCustomerCardRequest();
    _setDestinationCardNumberFromClipboard();
    await FkUserAgent.init();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Requests an OTP (One-Time Password) for card balance inquiries.
  void _getOtpRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoadingOtp = true;
    update();
    final CardToCardDynamicPasswordRequestData cardToCardDynamicPasswordRequestData =
        CardToCardDynamicPasswordRequestData(
      sourcePAN: sourceCustomerCard!.cardNumber!,
      destinationPAN: destinationCardController.text.trim().replaceAll('-', ''),
      amount: amount,
    );
    CardToCardServices.getDynamicPassword(
      cardToCardDynamicPasswordRequestData: cardToCardDynamicPasswordRequestData,
    ).then((result) {
      isLoadingOtp = false;
      update();

      switch (result) {
        case Success(value: (final OtpBankResponse response, int _)):
          //_readOTP();
          SnackBarUtil.showInfoSnackBar(response.msg ?? '');
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

  /// Sends a request to get customer cards, updates the UI,
  /// and potentially handles the list of cards or shows an error message.
  Future getCustomerCardRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isCardsLoading = true;
    update();
    CardServices.getCustomerCardsRequest().then(
      (result) async {
        isCardsLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerCardResponseData response, int _)):
            hasError = false;
            bankInfoList = response.data!.bankInfo ?? [];
            update();
            await _handleListOfCards(response.data!.cards);
            if (sourceCustomerCard == null) {
              SnackBarUtil.showInfoSnackBar(
                locale.only_for_deposits_with_active_bank_cards,
              );
            } else {
              _setSourceCustomerCard(sourceCustomerCard!);
              AppUtil.nextPageController(pageController, isClosed);
            }
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

  void _setSourceCustomerCard(CustomerCard customerCard) {
    selectedSourceBankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    sourceCardSymbol = selectedSourceBankInfo?.symbol;
    if (customerCard.cardExpYear != null && customerCard.cardExpMonth != null) {
      expireDateController.text = '${customerCard.cardExpYear}/${customerCard.cardExpMonth}';
    }
    update();
  }

  /// Processes a list of customer cards,
  /// identifies source and destination cards, and updates related lists.
  Future<void> _handleListOfCards(List<CustomerCard>? customerCardList) async {
    sourceCustomerCard = null;
    destinationCustomerCardList = [];
    allDestinationCustomerCardList = [];
    for (final CustomerCard customerCard in customerCardList!) {
      if (customerCard.isMine == true) {
        if (customerCard.cardNumber == deposit!.cardInfo?.pan && customerCard.gardeshgaryCardData?.status == 1) {
          sourceCustomerCard = customerCard;
        }
      } else {
        allDestinationCustomerCardList.add(customerCard);
      }
    }
    destinationCustomerCardList = allDestinationCustomerCardList;
    update();
    return;
  }

  /// Sends a request to get card owner information
  /// Get data of [CardOwnerData] from server request
  Future<void> _getCardOwnerRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String? userAgent = 'flutter';
    String? deviceId = '';
    try {
      userAgent = FkUserAgent.userAgent;
      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        final String? androidId = await androidIdPlugin.getId();
        deviceId = androidId;
      } else {
        final data = await deviceInfoPlugin.iosInfo;
        deviceId = data.identifierForVendor;
      }
    } on Exception catch (error) {
      error.printError();
    }
    final CardOwnerRequestData cardOwnerRequestData = CardOwnerRequestData();
    cardOwnerRequestData.dstCard = destinationCardController.text.trim().replaceAll('-', '');
    cardOwnerRequestData.srcCard = sourceCustomerCard!.cardNumber;
    cardOwnerRequestData.amount = amount;
    cardOwnerRequestData.userAgent = userAgent;
    cardOwnerRequestData.platform = Platform.isAndroid ? 'ANDROID' : 'IOS';
    cardOwnerRequestData.deviceId = deviceId;

    isLoading = true;
    update();

    CardToCardServices.getCardOwnerRequest(
      cardOwnerRequestData: cardOwnerRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CardOwnerResponseData response, int _)):
          if (response.data!.isSuccess!) {
            cardOwnerResponseData = response;
            update();
            AppUtil.nextPageController(pageController, isClosed);
          } else {
            SnackBarUtil.showInfoSnackBar(
              response.message ?? locale.operation_failed,
            );
          }
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a card-to-card request
  /// Get data of [TransactionData] from server request
  void _cardToCardRequest(CardToCardRequestData cardToCardRequestData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    CardToCardServices.cardToCardGardeshgaryRequest(
      cardToCardData: cardToCardRequestData,
    ).then((result) {
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
    });
  }

  String getCardOwnerName() {
    String cardOwnerName = '';
    if (cardOwnerResponseData != null) {
      cardOwnerName = cardOwnerResponseData!.data!.data!.split('#')[0];
    }
    return cardOwnerName;
  }

  Future _setDestinationCardNumberFromClipboard() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null) {
      final String? cardNumber = AppUtil.getCardNumberFromClipboard(data.text!);
      if (cardNumber != null) {
        final BankDataItem? bankDataItem =
            bankDataItemList.firstWhereOrNull((element) => element.preCode == cardNumber.substring(0, 6));
        if (bankDataItem != null) {
          destinationCardController.text = AppUtil.splitCardNumber(cardNumber, '-');
          destinationCardSymbol = bankDataItem.symbol;
          WidgetsBinding.instance.removeObserver(this);
        }
      }
    }
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

  /// Handles changes in the app's lifecycle state,
  /// potentially setting the destination card number from the clipboard when the app resumes.
  /// used when copy the  destination card number from another app
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      Timer(Constants.duration200, () {
        _setDestinationCardNumberFromClipboard();
      });
    }
  }

  /// Validate values of form before request
  void validatePaymentPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (passwordController.text.trim().isNotEmpty) {
      isPasswordValid = true;
    } else {
      isValid = false;
      isPasswordValid = false;
    }
    if (expireDateController.text.isNotEmpty) {
      isExpireDateValid = true;
    } else {
      isValid = false;
      isExpireDateValid = false;
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
      DialogUtil.showCardToCardConfirm(
        amount: amount,
        destinationCardNumber: destinationCardController.text.trim().replaceAll('-', ''),
        cardOwnerName: cardOwnerResponseData!.data!.data!.split('#')[0],
        buildContext: Get.context!,
        confirmFunction: () {
          Get.back();
          _requestTransfer();
        },
        denyFunction: () {
          Get.back();
        },
      );
    }
  }

  /// Initiates a transfer request by preparing the request data
  /// and calling the _cardToCardRequest function.
  Future<void> _requestTransfer() async {
    final CardToCardRequestData cardToCardRequestData = CardToCardRequestData();
    cardToCardRequestData.category = 'gpay';
    cardToCardRequestData.sourceCardNumber = sourceCustomerCard!.cardNumber;
    cardToCardRequestData.saveDestinationName = cardOwnerResponseData!.data!.data!.split('#')[0];
    cardToCardRequestData.transactionId = cardOwnerResponseData!.data!.transactionId;
    cardToCardRequestData.destinationCardNumber = destinationCardController.text.replaceAll('-', '');
    cardToCardRequestData.amount = amount;
    cardToCardRequestData.srcDescription = descriptionController.text;
    cardToCardRequestData.isSelectedDestination = isSelectedDestination;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String? userAgent = 'flutter';
    String? deviceId = '';
    try {
      userAgent = FkUserAgent.userAgent;
      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        final String? androidId = await androidIdPlugin.getId();
        deviceId = androidId;
      } else {
        final data = await deviceInfoPlugin.iosInfo;
        deviceId = data.identifierForVendor;
      }
    } on Exception catch (error) {
      error.printError();
    }
    cardToCardRequestData.userAgent = userAgent;
    cardToCardRequestData.platform = Platform.isAndroid ? 'ANDROID' : 'IOS';
    cardToCardRequestData.deviceId = deviceId;
    cardToCardRequestData.refNumber = cardOwnerResponseData!.data!.refNumber;
    cardToCardRequestData.password = passwordController.text;
    cardToCardRequestData.cardExpMonth = expireDateController.text.split('/')[1];
    cardToCardRequestData.cardExpYear = expireDateController.text.split('/')[0];
    cardToCardRequestData.cvv2 = cvv2Controller.text;
    cardToCardRequestData.saveDestinationCard = storeDestinationCard == true ? '1' : '0';
    _cardToCardRequest(cardToCardRequestData);
  }

  void showExpireDateBottomSheet() {
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
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
            expireDateController.text = '${selectedExpireData.expireYear}/${selectedExpireData.expireMonth}';
            selectedExpireDataValue = selectedExpireData;
          },
        ),
      ),
    );
  }

  /// Requests an OTP (One-Time Password),
  /// potentially using automatic dynamic PIN
  /// or prompting the user to select an OTP type.
  Future<void> requestOtp() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (sourceCustomerCard != null) {
      if (counter <= 0) {
        if (mainController.walletDetailData!.data!.isDirectOtpActive == true &&
            isAutomaticDynamicPinAvailable &&
            sourceCustomerCard!.cardNumber!.startsWith('505416')) {
          final String? automaticDynamicPinString = await StorageUtil.getAutomaticDynamicPinStored();
          if (automaticDynamicPinString != null) {
            automaticDynamicPinStoredData = automaticDynamicPinStoredDataFromJson(automaticDynamicPinString);
            _getAutomaticOTPRequest();
          } else {
            showOtpTypeSelectBottomSheet();
          }
        } else {
          _getOtpRequest();
        }
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.only_for_deposits_with_active_bank_cards,
      );
    }
  }

  Future<void> showOtpTypeSelectBottomSheet() async {
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DynamicPinTypeSelectBottomSheet(
          onSmsButton: () {
            _getOtpRequest();
          },
          onAutomaticDynamicPinButton: () {
            Get.to(() => const AutomaticDynamicPinActiveScreen());
          },
        ),
      ),
    );
    openBottomSheets--;
  }

  /// Requests an OTP automatically using stored dynamic PIN information.
  void _getAutomaticOTPRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final automaticDynamicPinTransferRequest = AutomaticDynamicPinTransferRequest(
      amount: amount,
      cardAcceptorName: sourceCustomerCard!.owner ?? getCustomerName(),
      cardNumber: sourceCustomerCard!.cardNumber!,
      keyId: automaticDynamicPinStoredData!.keyId,
      payeeCard: destinationCardController.text.trim().replaceAll('-', ''),
    );
    isLoadingOtp = true;
    update();
    AutomaticDynamicPinServices.getTransferDynamicPinRequest(
            automaticDynamicPinTransferRequest: automaticDynamicPinTransferRequest,
            privateKeyPem: automaticDynamicPinStoredData!.privateKey)
        .then((response) {
      isLoadingOtp = false;
      update();
      if (response.statusCode == 200) {
        passwordController.text = response.data!.otp!;
        update();
        _startTimer();
      } else if (response.statusCode == 408) {
        SnackBarUtil.showTimeOutSnackBar();
        isAutomaticDynamicPinAvailable = false;
        update();
      } else if (response.statusCode == 400) {
        SnackBarUtil.showSnackBar(
          title: locale.show_error(response.statusCode??400),
          message: response.errorResponseData.message ?? '',
        );
        isAutomaticDynamicPinAvailable = false;
        update();
      } else {
        SnackBarUtil.showExceptionErrorSnackBar(response.statusCode);
        isAutomaticDynamicPinAvailable = false;
        update();
      }
    });
  }

  String getMinutesAndSecond() {
    return intl.DateFormat('mm:ss').format(time.add(Duration(seconds: counter)));
  }

  void setCVV(String value) {
    update();
  }

  /// Encrypts a key using RSA encryption with a provided public key.
  static String encryptKeyWithRSA({
    required String? publicKeyString,
    required String key,
  }) {
    final dynamic publicKey =
        encrypt.RSAKeyParser().parse('-----BEGIN PUBLIC KEY-----\n$publicKeyString\n-----END PUBLIC KEY-----');
    final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(key);
    return encrypted.base64;
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
  }

  /// Handles the back press action, potentially navigating back in the page controller or closing the current screen.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1 || pageController.page == 4) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        if (pageController.page == 2) {
          hideTabViewFunction(false);
        }
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  /// Reads OTP from SMS messages on Android.
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
      params: [sourceCustomerCard!.cardNumber!.replaceAll('-', '').substring(0, 6)],
    );
  }

  void setStoreDestinationCard(bool value) {
    storeDestinationCard = value;
    update();
  }

  void validateDestinationCard() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (destinationCardController.text.trim().replaceAll('-', '').length == Constants.cardNumberLength) {
      if (destinationCardController.text.trim().replaceAll('-', '') != sourceCustomerCard!.cardNumber) {
        hideTabViewFunction(true);
        AppUtil.nextPageController(pageController, isClosed);
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.source_and_destination_card_numbers_cannot_be_same,
        );
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.enter_valid_destination_card_number,
      );
    }
  }

  void validateAmountPage() {
    AppUtil.hideKeyboard(Get.context!);
    if (amount >= Constants.minValidAmount) {
      isAmountValid = true;
      _getCardOwnerRequest();
    } else {
      isAmountValid = false;
    }
    update();
  }

  Future<void> setSelectedDestinationCustomerCard(CustomerCard customerCard) async {
    destinationCardController.text = AppUtil.splitCardNumber(customerCard.cardNumber!, '-');
    final selectedDestinationBankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    destinationCardSymbol = selectedDestinationBankInfo?.symbol;
    update();
    validateDestinationCard();
  }

  Future<void> showAddCardScreen() async {
    await Get.to(() => const AddCardScreen());
    AppUtil.previousPageController(pageController, isClosed);
    getCustomerCardRequest();
  }

  void setAddButtonVisible(bool value) {
    showAddButton = value;
    update();
  }

  Future<void> _getBankListData() async {
    final String data = await DefaultAssetBundle.of(Get.context!).loadString('assets/json/bank_list_data.json');
    final BankListData bankListData = bankListDataFromJson(data);
    bankDataItemList = bankListData.data ?? [];
  }

  void detectDestinationBank(String text) {
    text = text.replaceAll('-', '');
    if (text.length >= 6) {
      final String preCode = text.substring(0, 6);
      final BankDataItem? bankDataItem = bankDataItemList.firstWhereOrNull((element) => element.preCode == preCode);
      if (bankDataItem != null) {
        destinationCardSymbol = bankDataItem.symbol;
      }
    } else {
      destinationCardSymbol = null;
    }
    destinationCustomerCardList =
        allDestinationCustomerCardList.where((element) => element.cardNumber!.contains(text)).toList();
    update();
  }

  String getCustomerName() {
    return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
  }

  void showScannerScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(() => CardScannerScreen(
          returnDataFunction: (CardScannerData cardScannerData) {
            final BankDataItem? bankDataItem = bankDataItemList
                .firstWhereOrNull((element) => element.preCode == cardScannerData.cardNumber!.substring(0, 6));
            if (cardScannerData.isSuccess == true && cardScannerData.cardNumber != null && bankDataItem != null) {
              destinationCardController.text = AppUtil.splitCardNumber(cardScannerData.cardNumber!, '-');
              detectDestinationBank(destinationCardController.text);
            } else {
              SnackBarUtil.showSnackBar(
                title: locale.announcement,
                message: locale.card_scan_failed,
              );
            }
          },
        ));
  }

  void clearAmountTextField() {
    amountController.clear();
    amount = 0;
    update();
  }

  void clearDestinationCardTextField() {
    destinationCardController.clear();
    detectDestinationBank('');
  }
}
