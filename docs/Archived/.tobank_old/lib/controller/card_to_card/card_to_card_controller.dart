import 'dart:async';
import 'dart:convert';
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

import '../../model/automatic_dynamic_pin/automatic_dynamic_pin_stored_data_model.dart';
import '../../model/automatic_dynamic_pin/request/automatic_dynamic_pin_transfer_request_data.dart';
import '../../model/bank_list_data.dart';
import '../../model/card/expire_data.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/card_to_card/request/card_owner_request_data.dart';
import '../../model/card_to_card/request/card_to_card_dynamic_password_request_data.dart';
import '../../model/card_to_card/request/card_to_card_request_data.dart';
import '../../model/card_to_card/response/card_owner_data.dart';
import '../../model/card_to_card/response/otp_bank_data.dart';
import '../../model/common/card_scanner_data.dart';
import '../../model/shaparak_hub/request/card_to_card/shaparak_hub_card_inquiry_request.dart';
import '../../model/shaparak_hub/request/card_to_card/shaparak_hub_transfer_request.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_renew_card_id_request.dart';
import '../../model/shaparak_hub/response/card_to_card/shaparak_hub_card_inquiry_response.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_renew_card_id_response.dart';
import '../../model/shaparak_hub/shaparak_public_key_model.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../service/automatic_dynamic_pin_services.dart';
import '../../service/card_services.dart';
import '../../service/card_to_card_services.dart';
import '../../service/core/api_core.dart';
import '../../service/shaparak_hub_services.dart';
import '../../ui/automatic_dynamic_pin/automatic_dynamic_pin_active_screen.dart';
import '../../ui/card/add_card_screen.dart';
import '../../ui/card_scanner/card_scanner_screen.dart';
import '../../ui/card_to_card/widget/card_to_card_gardeshgary_guide_bottom_sheet.dart';
import '../../ui/common/card_expire_select_view.dart';
import '../../ui/common/dynamic_pin_type_select_bottom_sheet.dart';
import '../../ui/destination_card_selector/destination_card_selector_screen.dart';
import '../../ui/shaparak_hub/shaparak_hub_submit_screen.dart';
import '../../ui/source_card_selector/source_card_selector_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class CardToCardController extends GetxController with WidgetsBindingObserver {
//locale
  //locale
  final locale = AppLocalizations.of(Get.context!)!;
  String? sourceCardSymbol;
  String? destinationCardSymbol;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  CardOwnerResponseData? cardOwnerResponseData;
  TransactionData? transactionData;
  bool isLoading = false;
  bool isLoadingOtp = false;
  bool isCardsLoading = false;
  bool isSaved = false;
  String destinationName = '';
  int counter = 0;
  String? expireDate;
  String? _publicKey;
  String errorTitle = '';
  bool hasError = false;

  TextEditingController sourceCardController = TextEditingController();

  bool isAutomaticDynamicPinAvailable = true;
  AutomaticDynamicPinStoredData? automaticDynamicPinStoredData;

  int amount = 0;

  bool isAmountValid = true;

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isSelectedDestination = false;

  bool isPasswordValid = true;
  bool isExpireDateValid = true;
  bool isCvvValid = true;

  TextEditingController expireDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cvv2Controller = TextEditingController();
  bool storeDestinationCard = false;

  DateTime time = DateTime(2020);

  String? _transferTransactionId;
  String? destinationCardHolderName;
  String? _approvalCode;
  int? _registrationDate;

  TextEditingController shaparakHubMonthExpireController = TextEditingController();
  TextEditingController shaparakHubYearExpireController = TextEditingController();
  TextEditingController shaparakHubPasswordController = TextEditingController();
  TextEditingController shaparakHubCvv2Controller = TextEditingController();

  bool shaparakHubIsPasswordValid = true;
  bool shaparakHubIsCVVValid = true;
  Timer? timer;

  TextEditingController destinationCardController = TextEditingController();

  bool isDestinationCardValid = true;

  bool isEnabled = true;

  bool isSourceCardValid = true;

  List<CustomerCard> customerCardList = [];
  List<BankInfo> bankInfoList = [];
  CustomerCard? selectedSourceCustomerCard;

  ExpireData? selectedExpireDataValue;

  int openBottomSheets = 0;

  bool showAddButton = true;

  List<BankDataItem> bankDataItemList = [];

  BankInfo? selectedSourceBankInfo;

  CardToCardController({this.selectedSourceCustomerCard});

  bool isHub() {
    return selectedSourceBankInfo?.inShaparakHub ?? false;
  }

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    await _getBankListData();
    getCustomerCard();
    await FkUserAgent.init();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Requests a one-time password (OTP) for a card-to-card transaction.
  void _getOtpRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoadingOtp = true;
    update();
    final CardToCardDynamicPasswordRequestData cardToCardDynamicPasswordRequestData =
        CardToCardDynamicPasswordRequestData(
      sourcePAN: selectedSourceCustomerCard!.cardNumber!,
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

  Future<void> getCustomerCard() async {
    final String? data = await StorageUtil.getShaparakHubSecureStorage();
    if (data != null) {
      _publicKey = ShaparakPublicKeyModel.fromJson(jsonDecode(data)).publicKey;
    }
    _getCustomerCardRequest();
  }

  /// Retrieves the customer's card information and handles the response.
  Future _getCustomerCardRequest() async {
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
            _handleListOfCards(response.data!.cards);
            AppUtil.nextPageController(pageController, isClosed);
            update();
          case Failure(exception: final ApiException apiException):
            hasError = true;
            errorTitle = apiException.displayMessage;
            update();
            SnackBarUtil.showSnackBar(
              title:locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  /// Processes a list of customer cards to select a source card and potentially set a destination card from the clipboard.
  ///
  /// This function iterates through a list of customer cards, identifies the default card and the previously selected card (if any), and sets the selected source card accordingly.
  /// It then attempts to set the destination card number from the clipboard content.
  Future<void> _handleListOfCards(List<CustomerCard>? customerCardList) async {
    CustomerCard? customerCardDefault;
    for (final CustomerCard customerCard in customerCardList!) {
      if (customerCard.isMine == true) {
        if (customerCard.isDefault == true) {
          customerCardDefault = customerCard;
        }
        if (selectedSourceCustomerCard != null) {
          if (selectedSourceCustomerCard!.cardNumber == customerCard.cardNumber) {
            selectedSourceCustomerCard = customerCard;
          }
        }
      }
    }
    if (selectedSourceCustomerCard != null) {
      _setSourceCustomerCard(selectedSourceCustomerCard!);
    } else {
      if (customerCardDefault != null) {
        _setSourceCustomerCard(customerCardDefault);
      }
    }
    _setDestinationCardNumberFromClipboard();
  }

  Future<void> _checkSourceCustomerCard() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    selectedSourceBankInfo =
        bankInfoList.firstWhereOrNull((element) => element.id == selectedSourceCustomerCard!.bankId);
    if (selectedSourceBankInfo?.isTransfer ?? false) {
      await _checkShaparakHubStored();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.card_to_card_not_available_,
      );
    }
  }

  // Verifies the status of Shaparak Hub registration and takes appropriate action.
  ///
  /// This function checks if the selected source bank is part of the Shaparak Hub system and if the card has valid registration data.
  /// It handles different scenarios: card already registered and valid, card registered but expired, card not registered, or bank not in Shaparak Hub.
  /// Depending on the case, it might renew registration, prompt for registration,or proceed with validation.
  Future<void> _checkShaparakHubStored() async {
    if (selectedSourceBankInfo!.inShaparakHub!) {
      if (selectedSourceCustomerCard!.hubCardData != null) {
        if (_publicKey != null) {
          final referenceDateTime =
              DateTime.fromMillisecondsSinceEpoch(int.parse(selectedSourceCustomerCard!.hubCardData!.hubRefExpDate!));
          if (referenceDateTime.isAfter(DateTime.now())) {
            expireDate =
                DateConverterUtil.getExpireDateFromTimestamp(selectedSourceCustomerCard!.hubCardData!.hubRefExpDate!);
            shaparakHubYearExpireController.text = expireDate!.substring(0, 2);
            shaparakHubMonthExpireController.text = expireDate!.substring(2, 4);
            validateDestinationCard();
          } else {
            _shaparakCardRenewRequest();
          }
        } else {
          _showShaparakHubAppReactivationScreen();
        }
      } else {
        _showShaparakHubSubmitScreen();
      }
    } else {
      validateDestinationCard();
    }
  }

  void _showShaparakHubSubmitScreen() {
    Get.to(
      () => ShaparakHubSubmitScreen(
        cardNumber: selectedSourceCustomerCard!.cardNumber,
        hasPublicKey: _publicKey != null,
        isReactivation: false,
      ),
    )!
        .then((value) {
      AppUtil.previousPageController(pageController, isClosed);
      Future.delayed(Constants.duration500, () {
        getCustomerCard();
      });
    });
  }

  void _showShaparakHubAppReactivationScreen() {
    Get.to(
      () => ShaparakHubSubmitScreen(
        cardNumber: selectedSourceCustomerCard!.cardNumber,
        hasPublicKey: _publicKey != null,
        isReactivation: true,
      ),
    )!
        .then((value) {
      AppUtil.previousPageController(pageController, isClosed);
      Future.delayed(Constants.duration500, () {
        getCustomerCard();
      });
    });
  }

  /// Renews the Shaparak Hub registration for a card.
  ///
  /// This function sends a request to renew the Shaparak Hub registration for the selected source customer card.
  /// It sets a loading state, constructs the request with card details, and sends the request to the server.
  /// If successful, it navigates back to the previous page and refreshes the customer's card data.
  /// If an error occurs, it displays an error message and resets the loading state.
  void _shaparakCardRenewRequest() {
    final ShaparakHubRenewCardIdRequest requestData = ShaparakHubRenewCardIdRequest();
    requestData.sourceCard = selectedSourceCustomerCard!.cardNumber;
    requestData.cardId = selectedSourceCustomerCard!.hubCardData!.hubCardId;
    requestData.referenceExpiryDate = selectedSourceCustomerCard!.hubCardData!.hubRefExpDate;
    isLoading = true;
    update();
    ShaparakHubServices.renewCardId(
      requestData,
    ).then((result) async {
      switch (result) {
        case Success(value: (final ShaparakHubRenewCardIdResponse response, int _)):
          if (response.data?.cardId != null) {
            AppUtil.previousPageController(pageController, isClosed);
            Future.delayed(Constants.duration500, () {
              getCustomerCard();
            });
          } else {
            isLoading = false;
            update();
            var message = response.message;
            if (message == null || message == '') {
              message = locale.error_occurred_try_again;
            }
            SnackBarUtil.showInfoSnackBar(
              message,
            );
          }

        case Failure(exception: final ApiException apiException):
          isLoading = false;
          update();
          SnackBarUtil.showSnackBar(
            title:locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Get data of [CardOwnerData] from server request
  Future<void> _getCardOwnerRequest() async {
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
    cardOwnerRequestData.srcCard = selectedSourceCustomerCard!.cardNumber;
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

  /// Retrieves card owner information for a card-to-card transaction.
  ///
  /// This function sends a request to get the owner information of the destination card in a card-to-card transaction.
  /// It gathers device information (user agent, platform, device ID), creates a request with source and destination card details, the amount, and device information, and sends the request.
  /// If successful and the operation is successful on the server-side,it stores the response and navigates to the next page.
  /// If the server-side operation fails or an error occurs during the request, it displays an appropriate error message.
  void _cardToCardRequest(CardToCardRequestData cardToCardRequestData) {
    isLoading = true;
    update();

    CardToCardServices.cardToCardRequest(
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
    if (isHub()) {
      cardOwnerName = destinationCardHolderName ?? '';
    } else {
      if (cardOwnerResponseData != null) {
        cardOwnerName = cardOwnerResponseData!.data!.data!.split('#')[0];
      }
    }
    return cardOwnerName;
  }

  Future _setDestinationCardNumberFromClipboard() async {
    if (destinationCardController.text.isEmpty) {
      final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data != null) {
        final String? cardNumber = AppUtil.getCardNumberFromClipboard(data.text!);
        if (cardNumber != null) {
          final BankDataItem? bankDataItem =
              bankDataItemList.firstWhereOrNull((element) => element.preCode == cardNumber.substring(0, 6));
          if (bankDataItem != null) {
            destinationCardController.text = AppUtil.splitCardNumber(cardNumber, '-');
            detectDestinationBank(destinationCardController.text);
            WidgetsBinding.instance.removeObserver(this);
          }
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

  /// Initiates a card-to-card transfer request.
  Future<void> _requestTransfer() async {
    final CardToCardRequestData cardToCardRequestData = CardToCardRequestData();
    cardToCardRequestData.category = 'gpay';
    cardToCardRequestData.sourceCardNumber = selectedSourceCustomerCard!.cardNumber;
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

  /// Requests a one-time password (OTP) for a transaction, potentially using automatic OTP retrieval if available.
  Future<void> requestOtp() async {
    AppUtil.hideKeyboard(Get.context!);
    if (selectedSourceCustomerCard != null) {
      if (counter <= 0) {
        if (mainController.walletDetailData!.data!.isDirectOtpActive == true &&
            isAutomaticDynamicPinAvailable &&
            selectedSourceCustomerCard!.cardNumber!.startsWith('505416')) {
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
        locale.select_bank_card_first,
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

  Future<void> requestShaparakHubOtp() async {
    AppUtil.hideKeyboard(Get.context!);
    if (selectedSourceCustomerCard != null) {
      if (counter <= 0) {
        _getOtpRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_bank_card_first,
      );
    }
  }

  /// Requests an OTP automatically using stored dynamic PIN data.
  void _getAutomaticOTPRequest() {
    final automaticDynamicPinTransferRequest = AutomaticDynamicPinTransferRequest(
      amount: amount,
      cardAcceptorName: selectedSourceCustomerCard!.owner ?? getCustomerName(),
      cardNumber: selectedSourceCustomerCard!.cardNumber!,
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

  /// Initiates a card inquiry request, enforcing a time limit between requests.
  ///
  /// If two Shaparak Hub owner requests have been made within the last 30 seconds,
  /// it displays a message asking the user to wait before making another request.
  Future<void> _getCardInquiry() async {
//locale
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int checkTimestamp = mainController.timestampShaparakHubRequest + 30000;
    if (mainController.shaparakHubOwnerCount == 2 && timestamp < checkTimestamp) {
      SnackBarUtil.showInfoSnackBar(
        locale.wait_30_sec,
      );
    } else {
      _getCardInquiryRequest();
    }
  }

  /// Sends a card inquiry request to ShaparakHub to retrieve information about the destination card.
  void _getCardInquiryRequest() {
//locale
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ShaparakHubCardInquiryRequest request = ShaparakHubCardInquiryRequest();
    request.bankName = selectedSourceBankInfo!.shaparakHubBank;
    request.amount = amount;
    request.destinationPan = destinationCardController.text.trim().replaceAll('-', '');
    request.sourcePan = selectedSourceCustomerCard!.hubCardData!.hubCardId;

    isLoading = true;
    update();
    ShaparakHubServices.cardInquiry(
      request,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ShaparakHubCardInquiryResponse response, int _)):
          if (response.data!.status == 1) {
            destinationCardHolderName = response.data!.cardHolderName;
            _transferTransactionId = response.data!.transactionId;
            _registrationDate = response.data!.registrationDate;
            _approvalCode = response.data!.approvalCode;
            mainController.shaparakHubOwnerCount = 0;
            mainController.timestampShaparakHubRequest = 0;
            update();
            AppUtil.nextPageController(pageController, isClosed);
          } else {
            _setTryAttempt();
            var message = response.message;
            if (message == null || message == '') {
              message = locale.error_in_destination_card_inquiry_recheck_accuracy_of_destination_card_number;
            }
            SnackBarUtil.showInfoSnackBar(
              message,
            );
          }
        case Failure(exception: final ApiException apiException):
          _setTryAttempt();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Tracks Shaparak Hub owner request attempts and sets a timestamp for rate limiting.
  void _setTryAttempt() {
    mainController.shaparakHubOwnerCount++;
    if (mainController.shaparakHubOwnerCount == 2) {
      mainController.timestampShaparakHubRequest = DateTime.now().millisecondsSinceEpoch;
    }
  }

  /// Sends a transfer request through the Shaparak Hub system
  void _requestShaparakTransfer() {
    final ShaparakHubTransferRequest keyRequestData = ShaparakHubTransferRequest();
    keyRequestData.approvalCode = _approvalCode;
    keyRequestData.amount = amount;
    keyRequestData.bankName = selectedSourceBankInfo!.shaparakHubBank;
    keyRequestData.sourcePan = selectedSourceCustomerCard!.hubCardData!.hubCardId;
    keyRequestData.expiryDate = expireDate;
    keyRequestData.destinationPan = destinationCardController.text.trim().replaceAll('-', '');
    final cvvPlainText =
        '${shaparakHubCvv2Controller.text}|${shaparakHubPasswordController.text}|$amount|${destinationCardController.text.trim().replaceAll('-', '')}|';

    keyRequestData.cvv2 = encryptKeyWithRSA(publicKeyString: _publicKey, key: cvvPlainText);
    keyRequestData.sourceDescription = descriptionController.text.trim();
    keyRequestData.sourceCard = selectedSourceCustomerCard!.cardNumber;
    keyRequestData.destinationCardHolderName = destinationCardHolderName;
    keyRequestData.saveDestinationCard = storeDestinationCard == true ? '1' : '0';
    keyRequestData.registrationDate = _registrationDate;
    keyRequestData.transactionId = _transferTransactionId;
    keyRequestData.category = 'tsm';

    isLoading = true;
    update();
    ShaparakHubServices.transfer(
      keyRequestData,
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
            title:locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void validateShaparakHubSecondPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (shaparakHubPasswordController.text.trim().isNotEmpty) {
      shaparakHubIsPasswordValid = true;
    } else {
      isValid = false;
      shaparakHubIsPasswordValid = false;
    }
    if (shaparakHubCvv2Controller.text.trim().isNotEmpty) {
      shaparakHubIsCVVValid = true;
    } else {
      isValid = false;
      shaparakHubIsCVVValid = false;
    }
    update();

    /// Show confirm message before request to server
    if (isValid) {
      DialogUtil.showCardToCardConfirm(
        destinationCardNumber: destinationCardController.text.trim().replaceAll('-', ''),
        amount: amount,
        cardOwnerName: destinationCardHolderName ?? '',
        buildContext: Get.context!,
        confirmFunction: () {
          Get.back(closeOverlays: true);
          _requestShaparakTransfer();
        },
        denyFunction: () {
          Get.back(closeOverlays: true);
        },
      );
    }
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

  void _setSourceCustomerCard(CustomerCard customerCard) {
    sourceCardController.text = AppUtil.splitCardNumber(customerCard.cardNumber!, '-');
    selectedSourceBankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    if (selectedSourceBankInfo != null) {
      sourceCardSymbol = selectedSourceBankInfo!.symbol;
    }
    selectedSourceCustomerCard = customerCard;
    if (selectedSourceCustomerCard!.cardExpYear != null && selectedSourceCustomerCard!.cardExpMonth != null) {
      expireDateController.text =
          '${selectedSourceCustomerCard!.cardExpYear}/${selectedSourceCustomerCard!.cardExpMonth}';
    }
    update();
  }

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
      if (pageController.page == 0 || pageController.page == 1 || pageController.page == 4) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

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
    SnackBarUtil.showSnackBar(
      title: locale.error,
      message: locale.reading_sms_error,
    );
    await Sentry.captureMessage(
      'otpReadFailed',
      params: [sourceCardController.text.replaceAll('-', '').substring(0, 6)],
    );
  }

  void setStoreDestinationCard(bool value) {
    storeDestinationCard = value;
    update();
  }

  /// Checks if the card number has the correct length and is not the same as the source card number.
  Future<void> validateDestinationCard() async {
    AppUtil.hideKeyboard(Get.context!);
    if (destinationCardController.text.trim().replaceAll('-', '').length == Constants.cardNumberLength) {
      if (destinationCardController.text.trim().replaceAll('-', '') != selectedSourceCustomerCard!.cardNumber) {
        await AppUtil.nextPageController(pageController, isClosed);
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.source_and_destination_card_numbers_cannot_be_same,
        );
      }
      isDestinationCardValid = true;
      update();
    } else {
      isDestinationCardValid = false;
      update();
    }
  }

  /// Validates the entered amount and proceeds with either a card inquiry or card owner request
  /// based on the transaction type.
  void validateAmountPage() {
    AppUtil.hideKeyboard(Get.context!);
    if (amount >= Constants.minValidAmount) {
      isAmountValid = true;
      if (isHub()) {
        _getCardInquiry();
      } else {
        _getCardOwnerRequest();
      }
    } else {
      isAmountValid = false;
    }
    update();
  }

  Future<void> validateSelectCardsPage() async {
    if (selectedSourceBankInfo != null) {
      if (isHub() && (selectedSourceCustomerCard?.cardNumber?.startsWith('505416') ?? false)) {
        await _checkCardToCardGardeshgaryBottomSheet();
      }
      await _checkSourceCustomerCard();
      isSourceCardValid = true;
      update();
    } else {
      isSourceCardValid = false;
      update();
    }
  }

  Future<void> showAddCardScreen() async {
    await Get.to(() => const AddCardScreen());
    AppUtil.previousPageController(pageController, isClosed);
    getCustomerCard();
  }

  void setAddButtonVisible(bool value) {
    showAddButton = value;
    update();
  }

  Future<void> _checkCardToCardGardeshgaryBottomSheet() async {
    final bool isSeen = await StorageUtil.getCardToCardGardeshgaryGuideSeen();
    if (isSeen) {
      await _showCardToCardGardeshgaryBottomSheet();
    }
  }

  Future<void> _showCardToCardGardeshgaryBottomSheet() async {
    AppUtil.hideKeyboard(Get.context!);
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
        child: const CardToCardGardeshgaryGuideBottomSheet(),
      ),
    );
    openBottomSheets--;
    StorageUtil.setCardToCardGardeshgaryGuideSeen(true);
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
      } else {
        destinationCardSymbol = null;
      }
    } else {
      destinationCardSymbol = null;
    }
    update();
  }

  String getCustomerName() {
    return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
  }

  void showScannerScreen() {
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

  void showSelectSourceCardScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(() => SourceCardSelectorScreen(
          title: locale.select_origin_card,
          description: locale.saved_cards,
          checkIsTransfer: true,
          isPichak: false,
          returnDataFunction: (customerCard, bankInfo) {
            _setSourceCustomerCard(customerCard);
          },
        ));
  }

  void showDestinationSelectScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(() => DestinationCardSelectorScreen(
          returnDataFunction: (destinationCardNumber,destinationNameText) {
            destinationName = destinationNameText;
            isSaved = true;
            detectDestinationBank(destinationCardNumber);
            destinationCardController.text = AppUtil.splitCardNumber(destinationCardNumber, '-');
            update();
          },
        ));
  }
}
