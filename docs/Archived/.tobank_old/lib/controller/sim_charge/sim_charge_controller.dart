import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/operator_data.dart';
import '../../model/contact_match/custom_contact.dart';
import '../../model/contact_match/list_stored_contact_data.dart';
import '../../model/customer_club/response/customer_club_discount_effect_response.dart';
import '../../model/sim_charge/charge_amount_data.dart';
import '../../model/sim_charge/request/charge_sim_data.dart';
import '../../model/sim_charge/response/charge_static_data.dart';
import '../../model/sim_charge/response/sim_charge_internet_pay_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../service/core/api_core.dart';
import '../../service/customer_club_services.dart';
import '../../service/sim_charge_services.dart';
import '../../service/transaction_services.dart';
import '../../ui/contact/contact_screen.dart';
import '../../ui/sim_charge/widget/select_amount_bottom_sheet.dart';
import '../../ui/sim_charge/widget/select_operator_bottom_sheet.dart';
import '../../ui/sim_charge/widget/sim_charge_select_payment_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class SimChargeController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  late ChargeStaticResponseData _chargeStaticResponseData;
  TransactionData? transactionData;
  SimChargeInternetData? chargeInternetResponseData;
  bool isLoading = false;
  int walletAmount = 0;
  List<StoredContactData> storedContactDataList = [];
  CustomerClubDiscountEffectResponse? customerClubDiscountEffectResponse;

  bool useDiscount = false;

  String errorTitle = '';

  bool hasError = false;

  OperatorData? selectedOperatorData;

  bool isStorePhone = false;

  TextEditingController phoneNumberController = TextEditingController();
  PlanDatum? chargeTypeDataSelected;
  ChargeAmountData? selectedChargeAmountData;
  PaymentType currentPaymentType = PaymentType.wallet;

  int openBottomSheets = 0;

  final _operatorsNames = [
    'Mtn',
    'Mci',
    'Rightel',
    'Shatel',
  ];

  bool isPhoneNumberValid = true;
  String _selectedOperatorName = 'Mtn';
  List<PlanDatum> chargeTypeList = [];
  List<ChargeAmountData> chargeAmountList = [];
  bool isOneOption = false;

  @override
  void onInit() {
    getChargeStaticDataRequest();
    _getStoredContactDataList();
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

  /// Retrieves static data for charging operations and initializes variables.
  Future<void> getChargeStaticDataRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    SimChargeServices.getChargeStaticResponseDataRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ChargeStaticResponseData response, int _)):
          _chargeStaticResponseData = response;
          update();
          _initVariables();
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

  /// Determines the payment method and initiates the corresponding charging request.
  /// if paymentType = [PaymentType.wallet] the amount will be pay from wallet
  /// if paymentType = [PaymentType.gateway] the amount will be pay from gateway
  void _validatePaymentMethod(ChargeSimData chargeSimData) {
    if (currentPaymentType == PaymentType.wallet) {
      chargeSimData.wallet = '1';
      _chargeSimWalletPayRequest(chargeSimData);
    } else {
      chargeSimData.wallet = '0';
      _requestChargeSimInternetPay(chargeSimData);
    }
  }

  /// Processes a sim card charge request using wallet payment.
  void _chargeSimWalletPayRequest(ChargeSimData chargeSimData) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    SimChargeServices.simCardChargeWalletPayRequest(
      chargeSimData: chargeSimData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          if (useDiscount) {
            mainController.updateWallet();
          }
          update();
          _closeBottomSheets();
          AppUtil.changePageController(
            pageController: pageController,
            page: 3,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.connectionTimeout) {
            _checkClientRefTransaction(chargeSimData.clientRef!);
          } else {
            SnackBarUtil.showSnackBar(
              title:locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  /// Checks the status of a transaction using its client reference ID.
  void _checkClientRefTransaction(String refId) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    TransactionServices.getTransactionByRefId(
      refId: refId,
    ).then((result) {
      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          transactionData!.message = response.data!.message;
          update();
          AppUtil.changePageController(
            pageController: pageController,
            page: 3,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          if (apiException.statusCode == 404) {
            AppUtil.showOverlaySnackbar(
              message: locale.unknown_transaction_status,
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

  /// Processes a sim card charge request using internet payment.
  void _requestChargeSimInternetPay(ChargeSimData chargeSimData) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    SimChargeServices.simCardChargeInternetPayRequest(
      chargeSimData: chargeSimData,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final SimChargeInternetData response, int _)):
            chargeInternetResponseData = response;
            update();
            _closeBottomSheets();
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

  Future<void> validateInternetPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Retrieves transaction details by its ID.
  void _transactionDetailByIdRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: chargeInternetResponseData!.data!.transactionId!,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            if (useDiscount) {
              mainController.updateWallet();
            }
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

  /// Retrieves the discount effect for a given amount and determines valid payment types.
  Future<void> _getDiscountEffectRequest(int amount) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    CustomerClubServices.getDiscountEffectRest(amount: amount).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerClubDiscountEffectResponse response, int _)):
            walletAmount = response.data!.wallet!;
            customerClubDiscountEffectResponse = response;
            setValidPaymentType();
            update();
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
        child: const SimChargeSelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
    useDiscount = false;
    update();
  }

  /// Check type of sim card that selected & show charge plan with
  /// list of amount that can be selected according to it
  void _initVariables() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    List<int>? price;
    chargeAmountList = [];
    if (_selectedOperatorName == 'Mtn') {
      chargeTypeList = _chargeStaticResponseData.data!.mtnChargePlan!.mtnPlanData!;
      price = _chargeStaticResponseData.data!.mtnChargePlan!.price;
    } else if (_selectedOperatorName == 'Mci') {
      chargeTypeList = _chargeStaticResponseData.data!.mciChargePlan!.mciPlanData!;
      price = _chargeStaticResponseData.data!.mciChargePlan!.price;
    } else if (_selectedOperatorName == 'Rightel') {
      chargeTypeList = [];
      chargeTypeList.add(_chargeStaticResponseData.data!.rightelChargePlan!.rightelPlanData![0]);
      price = _chargeStaticResponseData.data!.rightelChargePlan!.price;
    } else if (_selectedOperatorName == 'Shatel') {
      chargeTypeList = _chargeStaticResponseData.data!.shatelChargePlan!.shatelPlanData!;
      price = _chargeStaticResponseData.data!.shatelChargePlan!.price;
    }
    chargeTypeDataSelected = chargeTypeList[0];
    if (chargeTypeList.length == 1) {
      isOneOption = true;
    } else {
      isOneOption = false;
    }

    int i = 1;
    for (final int amount in price!) {
      final String amountString = AppUtil.formatMoney(amount);
      final ChargeAmountData chargeAmountData1 = ChargeAmountData(
        '$amountString  ${locale.rial}',
        amount,
        i,
      );
      chargeAmountList.add(chargeAmountData1);
      i++;
    }

    selectedChargeAmountData = chargeAmountList[0];
    update();
  }

  /// compare first four digits with [DataConstants.simCardData] and detect
  /// type of phone number operator
  void detectOperator(String phoneNumber) {
    final String? operatorName = DataConstants.simCardData[phoneNumber];
    if (operatorName == 'mtn') {
      selectedOperatorData = DataConstants.getOperatorDataList()[0];
    } else if (operatorName == 'mci') {
      selectedOperatorData = DataConstants.getOperatorDataList()[1];
    } else if (operatorName == 'rightel') {
      selectedOperatorData = DataConstants.getOperatorDataList()[2];
    } else if (operatorName == 'shatel') {
      selectedOperatorData = DataConstants.getOperatorDataList()[3];
    }
    if (selectedOperatorData != null) {
      _selectedOperatorName = _operatorsNames[selectedOperatorData!.id!];
      _initVariables();
    }
    update();
  }

  /// Show selected phone number in TextField
  /// remove space and replace +98 & 0098 with 0
  void setSelectedPhoneNumber(CustomContact contact) {
    phoneNumberController.text =
        contact.phones!.toList()[0].replaceAll(' ', '').replaceAll(Constants.iranCountryCode, '0');
    if (phoneNumberController.text.length == Constants.mobileNumberLength) {
      detectOperator(phoneNumberController.text.substring(0, 4));
    }
  }

  /// Show confirm dialog before pay amount of mobile charge
  /// Get selected items from UI and set value of them to [ChargeSimData] instance
  void validatePayment() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.confirm_sim_charge_payment,
        description: locale.sim_charge_description,
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

  void _validateAmount() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (useDiscount) {
      if (customerClubDiscountEffectResponse!.data!.newAmount! < 1000 && currentPaymentType != PaymentType.wallet) {
        Timer(Constants.duration100, () {
          SnackBarUtil.showInfoSnackBar(
            locale.payment_must_be_wallet_for_small_amounts,
          );
        });
        return;
      }
      if (customerClubDiscountEffectResponse!.data!.newAmount! > walletAmount &&
          currentPaymentType == PaymentType.wallet) {
        Timer(Constants.duration100, () {
          SnackBarUtil.showNotEnoughWalletMoneySnackBar();
        });
        return;
      } else {
        returnData();
      }
    } else {
      if (currentPaymentType == PaymentType.wallet) {
        if (walletAmount >= selectedChargeAmountData!.amount) {
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
  }

  void returnData() {
    final String refId = AppUtil.getClientRef(mainController.authInfoData!.token!);
    final ChargeSimData chargeSimData = ChargeSimData();
    chargeSimData.paymentType = currentPaymentType;
    chargeSimData.discount = useDiscount ? 1 : 0;
    chargeSimData.clientRef = refId;
    chargeSimData.phoneNumber = phoneNumberController.text;
    chargeSimData.operatorName = _operatorsNames[selectedOperatorData!.id!];
    chargeSimData.amount = selectedChargeAmountData!.amount;
    chargeSimData.chargeType = chargeTypeDataSelected!.value;
    chargeSimData.chargeTypeString = chargeTypeDataSelected!.title;
    _validatePaymentMethod(chargeSimData);
  }

  void setCurrentPaymentType(PaymentType value) {
    currentPaymentType = value;
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

  void setMinePhoneNumber() {
    AppUtil.hideKeyboard(Get.context!);
    phoneNumberController.text = mainController.authInfoData!.mobile!;
    detectOperator(phoneNumberController.text.substring(0, 4));
  }

  Future<void> _getStoredContactDataList() async {
    final String? storedContactsString = await StorageUtil.getStoredContactsSecureStorage();
    if (storedContactsString != null) {
      final ListStoredContactData listStoredContactData =
          ListStoredContactData.fromJson(jsonDecode(storedContactsString));
      storedContactDataList = listStoredContactData.storedContactDataList!;
      update();
    }
  }

  void addContactLocalStorage() {
    final storedList =
        storedContactDataList.where((element) => element.phoneNumber == phoneNumberController.text).toList();
    if (storedList.isEmpty) {
      final StoredContactData storedContactData = StoredContactData();
      storedContactData.phoneNumber = phoneNumberController.text;
      storedContactDataList.add(storedContactData);
      _storeContactDataList();
    }
  }

  void removeContactLocalStorage(StoredContactData storedContactData) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    final storedList =
        storedContactDataList.where((element) => element.phoneNumber == storedContactData.phoneNumber).toList();
    if (storedList.length == 1) {
      storedContactDataList.removeWhere((element) => element.phoneNumber == storedContactData.phoneNumber);
      _storeContactDataList();
      SnackBarUtil.showInfoSnackBar(
        locale.contact_removed_from_favorites,
      );
    }
  }

  Future<void> _storeContactDataList() async {
    final ListStoredContactData listStoredContactData = ListStoredContactData();
    listStoredContactData.storedContactDataList = storedContactDataList;
    await StorageUtil.setStoredContactsSecureStorage(jsonEncode(listStoredContactData.toJson()));
    update();
  }

  /// Checks if the entered phone number is a favorite contact.
  bool isPhoneNumberFav() {
    if (phoneNumberController.text.length == Constants.mobileNumberLength &&
        phoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
      final storedList =
          storedContactDataList.where((element) => element.phoneNumber == phoneNumberController.text).toList();
      if (storedList.length == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void setSelectedPhoneNumberFav(StoredContactData storedContactData) {
    AppUtil.hideKeyboard(Get.context!);
    phoneNumberController.text = storedContactData.phoneNumber!;
    detectOperator(phoneNumberController.text.substring(0, 4));
  }

  void setUseDiscount(bool value) {
    useDiscount = value;
    update();
    setValidPaymentType();
  }

  int? getCorrectAmount() {
    if (useDiscount) {
      if (customerClubDiscountEffectResponse != null) {
        return customerClubDiscountEffectResponse!.data!.newAmount;
      } else {
        return 0;
      }
    } else {
      if (selectedChargeAmountData != null) {
        return selectedChargeAmountData!.amount;
      } else {
        return 0;
      }
    }
  }

  void setChargeAmountData(ChargeAmountData chargeAmountData) {
    selectedChargeAmountData = chargeAmountData;
    update();
  }

  void setChargeTypeData(PlanDatum chargeTypeData) {
    chargeTypeDataSelected = chargeTypeData;
    update();
  }

  void setSelectOperator(OperatorData operatorData) {
    selectedOperatorData = operatorData;
    _selectedOperatorName = _operatorsNames[selectedOperatorData!.id!];
    _initVariables();
    update();
  }

  void setIsStorePhone(bool? value) {
    isStorePhone = value!;
    update();
  }

  /// Handles the back press action, navigating back if the app is not loading.
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
    final int? correctAmount = getCorrectAmount();
    if (walletAmount < correctAmount!) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  Future<void> validateSelectOperator() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedOperatorData == null) {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_operator,
      );
      return;
    }
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
        child: const SelectAmountBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validatePhoneSelectorPage() {
    AppUtil.hideKeyboard(Get.context!);
    if (phoneNumberController.text.length == Constants.mobileNumberLength &&
        phoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
      isPhoneNumberValid = true;
      if (isStorePhone) {
        addContactLocalStorage();
      }
      showSelectOperatorBottomSheet();
    } else {
      isPhoneNumberValid = false;
    }
    update();
  }

  Future<void> showSelectOperatorBottomSheet() async {
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
        child: const SelectOperatorBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validateSelectAmount() {
    _getDiscountEffectRequest(selectedChargeAmountData!.amount);
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  bool showFavList() {
    if (phoneNumberController.text.isEmpty && storedContactDataList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isDiscountEnabled() {
    return mainController.walletDetailData!.data!.havadary == true &&
        customerClubDiscountEffectResponse!.data!.pointsLost != '0';
  }
}
