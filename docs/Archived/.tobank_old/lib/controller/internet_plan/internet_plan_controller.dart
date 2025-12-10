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
import '../../model/internet/internet_plan_filter_data.dart';
import '../../model/internet/request/internet_plan_request_data.dart';
import '../../model/internet/response/internet_plan_data.dart';
import '../../model/internet/response/internet_plan_pay_internet_data.dart';
import '../../model/internet/response/internet_static_data_model.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../service/core/api_core.dart';
import '../../service/customer_club_services.dart';
import '../../service/internet_plan_services.dart';
import '../../service/transaction_services.dart';
import '../../ui/contact/contact_screen.dart';
import '../../ui/internet/widget/internet_select_payment_bottom_sheet.dart';
import '../../ui/internet/widget/select_operator_bottom_sheet.dart';
import '../../ui/internet/widget/select_sim_type_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class InternetPlanController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  late InternetPlanData internetPlanResponseData;
  TransactionData? transactionData;
  InternetPlanPayInternetData? internetPlanPayInternetResponseData;
  bool isLoading = false;
  int? selectedId;
  int walletAmount = 0;
  List<InternetPlanFilterData> selectedInternetPlanFilterDataList = [];
  List<DataPlanList> dataPlanLists = [];
  late InternetStaticDataModel _internetStaticDataResponse;
  List<SimType>? selectedSimTypeList = [];
  SimType? selectedSimType;
  bool isSimTypeValid = true;
  CustomerClubDiscountEffectResponse? customerClubDiscountEffectResponse;

  bool useDiscount = false;

  String errorTitle = '';

  bool hasError = false;

  OperatorData? selectedOperatorData;

  List<StoredContactData> storedContactDataList = [];

  bool isStorePhone = false;

  TextEditingController phoneNumberController = TextEditingController();

  int openBottomSheets = 0;

  final _operatorsNames = [
    'Mtn',
    'Mci',
    'Rightel',
    'Shatel',
  ];

  bool isPhoneNumberValid = true;

  PaymentType currentPaymentType = PaymentType.wallet;

  DataPlanList? selectedDataPlanList;

  @override
  void onInit() {
    getInternetStaticDataRequest();
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

  Future<void> _getStoredContactDataList() async {
    final storedContactsString = await StorageUtil.getStoredContactsSecureStorage();
    if (storedContactsString != null) {
      final ListStoredContactData listStoredContactData =
          ListStoredContactData.fromJson(jsonDecode(storedContactsString));
      storedContactDataList = listStoredContactData.storedContactDataList!;
      update();
    }
  }

  void setSelectedPhoneNumberFav(StoredContactData storedContactData) {
    AppUtil.hideKeyboard(Get.context!);
    phoneNumberController.text = storedContactData.phoneNumber ?? '';
    detectOperator(phoneNumberController.text.substring(0, 4));
  }

  void removeContactLocalStorage(StoredContactData storedContactData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    final storedList =
        storedContactDataList.where((element) => element.phoneNumber == storedContactData.phoneNumber).toList();
    if (storedList.length == 1) {
      storedContactDataList.removeWhere((element) => element.phoneNumber == storedContactData.phoneNumber);
      _storeContactDataList();
      SnackBarUtil.showInfoSnackBar(locale.contact_removed_from_favorites);
    }
  }

  void _storeContactDataList() {
    final ListStoredContactData listStoredContactData = ListStoredContactData();
    listStoredContactData.storedContactDataList = storedContactDataList;
    StorageUtil.setStoredContactsSecureStorage(jsonEncode(listStoredContactData.toJson()));
    update();
  }

  /// Retrieves static data for internet services and initializes variables.
  void getInternetStaticDataRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    InternetPlanServices.getInternetStaticData().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final InternetStaticDataModel response, int _)):
          _internetStaticDataResponse = response;
          hasError = false;
          update();
          _initVariables();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = false;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _initVariables() {
    selectedSimTypeList = _internetStaticDataResponse.data!.dataPlanType!.mtn;
  }

  /// Check payment type
  /// if payment type == [PaymentType.wallet] run [_payPlanWallet] function
  /// else run [_payPlanInternet] function
  void _checkPaymentType(InternetPlanRequestData internetData) {
    if (currentPaymentType == PaymentType.wallet) {
      _payPlanWalletRequest(internetData);
    } else {
      _payPlanInternetRequest(internetData);
    }
  }

  /// Processes an internet plan payment request using the user's wallet.
  /// Get data of [InternetWalletPayData] from server request
  void _payPlanWalletRequest(InternetPlanRequestData internetData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    InternetPlanServices.payInternetPlanWalletRequest(
      internetData: internetData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          Get.back();
          transactionData = response.data;
          if (useDiscount) {
            mainController.updateWallet();
          }
          update();
          AppUtil.changePageController(
            pageController: pageController,
            page: 4,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.connectionTimeout) {
            _checkClientRefTransaction(internetData.clientRef);
          } else {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
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
            page: 4,
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

  /// Processes an internet plan payment request using internet payment methods.
  /// Get data of [InternetPlanPayInternetData] from server request
  void _payPlanInternetRequest(InternetPlanRequestData internetData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    InternetPlanServices.payInternetPlanInternetRequest(
      internetData: internetData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final InternetPlanPayInternetData response, int _)):
          Get.back();
          internetPlanPayInternetResponseData = response;
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

  /// Retrieves available internet plans based on the selected operator and sim type.
  /// Get data of [InternetPlanData] from server request
  Future _getInternetPlansRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    InternetPlanServices.getInternetPlanRequest(
      operatorName: _operatorsNames[selectedOperatorData!.id!],
      planType: selectedSimType!.value!.toString(),
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final InternetPlanData response, int _)):
          internetPlanResponseData = response;
          dataPlanLists = internetPlanResponseData.data!.dataPlanLists!;
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

  /// Retrieves transaction details by its ID (obtained from internet payment response).
  ///
  /// This function retrieves detailed information about a transaction using its ID,
  /// specifically obtained from the [internetPlanPayInternetResponseData].
  void _transactionDetailByIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: internetPlanPayInternetResponseData!.data!.transactionId!,
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
  Future<void> _getDiscountEffectRequest(int amount) async {
//locale
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

  /// Use 4 first digits of phone number for detect operator type
  void detectOperator(String phoneNumber) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String? operatorName = DataConstants.simCardData[phoneNumber];
    if (operatorName == locale.mtn) {
      selectedOperatorData = DataConstants.getOperatorDataList()[0];
      selectMTN();
    } else if (operatorName == locale.mci) {
      selectedOperatorData = DataConstants.getOperatorDataList()[1];
      selectMCI();
    } else if (operatorName == locale.rightel) {
      selectedOperatorData = DataConstants.getOperatorDataList()[2];
      selectRightel();
    } else if (operatorName == locale.shatel) {
      selectedOperatorData = DataConstants.getOperatorDataList()[3];
      selectShatel();
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

  /// Validate values of form before request
  void validatePhoneNumber() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (phoneNumberController.text.length == Constants.mobileNumberLength &&
        phoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
      isPhoneNumberValid = true;
    } else {
      isValid = false;
      isPhoneNumberValid = false;
    }
    update();
    if (isValid) {
      if (isStorePhone) {
        addContactLocalStorage();
      }
      showSelectOperatorBottomSheet();
      //_getInternetPlan();
    }
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

  void selectMTN() {
    selectedSimTypeList = _internetStaticDataResponse.data!.dataPlanType!.mtn;
    selectedSimType = null;
    update();
  }

  void selectMCI() {
    selectedSimTypeList = _internetStaticDataResponse.data!.dataPlanType!.mci;
    selectedSimType = null;
    update();
  }

  void selectRightel() {
    selectedSimTypeList = _internetStaticDataResponse.data!.dataPlanType!.rightel;
    selectedSimType = null;
    update();
  }

  void selectShatel() {
    selectedSimTypeList = _internetStaticDataResponse.data!.dataPlanType!.shatel;
    selectedSimType = null;
    update();
  }

  void selectSimCardType(SimType value) {
    selectedSimType = value;
    update();
  }

  /// Confirm payment before request to server
  void validatePayment() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: currentPaymentType == PaymentType.wallet
            ? locale.wallet_payment_confirmation
            : locale.internet_payment_confirmation,
        description: currentPaymentType == PaymentType.wallet
            ? locale.wallet_payment_description
            : locale.internet_payment_description,
        positiveMessage: locale.yes,
        negativeMessage: locale.no,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _validateAmount();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void _validateAmount() {
//locale
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
        if (walletAmount >= selectedDataPlanList!.priceWithTax!) {
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

  /// This function checks if the payment amount is valid for internet payment
  /// and prepares the data required for the purchase.
  void returnData() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (currentPaymentType == PaymentType.gateway && selectedDataPlanList!.priceWithTax! < 10000) {
      SnackBarUtil.showInfoSnackBar(
        locale.payment_amount_too_low,
      );
    } else {
      final String refId = AppUtil.getClientRef(mainController.authInfoData!.token!);
      final InternetPlanRequestData internetData = InternetPlanRequestData(
        phoneNumber: phoneNumberController.text,
        operatorName: _operatorsNames[selectedOperatorData!.id!],
        wallet: currentPaymentType == PaymentType.wallet ? 1 : 0,
        clientRef: refId,
        discount: useDiscount ? 1 : 0,
        priceWithTax: selectedDataPlanList!.priceWithTax!,
        chargeType: selectedDataPlanList!.id!,
      );
      _checkPaymentType(internetData);
    }
  }

  void setCurrentPaymentType(PaymentType value) {
    currentPaymentType = value;
    update();
  }

  void setMinePhoneNumber() {
    AppUtil.hideKeyboard(Get.context!);
    phoneNumberController.text = mainController.authInfoData!.mobile ?? '';
    detectOperator(phoneNumberController.text.substring(0, 4));
  }

  void showSelectContactScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(
      () => ContactScreen(
        returnDataFunction: (contact) {
          setSelectedPhoneNumber(contact);
        },
      ),
    );
  }

  void setInternetPlanFilterData(InternetPlanFilterData internetPlanFilterData) {
    if (selectedInternetPlanFilterDataList.contains(internetPlanFilterData)) {
      selectedInternetPlanFilterDataList.remove(internetPlanFilterData);
    } else {
      selectedInternetPlanFilterDataList.add(internetPlanFilterData);
    }

    _updateListOfPlans();
    update();
  }

  void _updateListOfPlans() {
    final List<DataPlanList> filteredDataPlanLists = [];
    selectedInternetPlanFilterDataList.sort((a, b) => a.index!.compareTo(b.index!));
    if (selectedInternetPlanFilterDataList.isEmpty) {
      dataPlanLists = internetPlanResponseData.data!.dataPlanLists!;
    } else {
      for (final InternetPlanFilterData item in selectedInternetPlanFilterDataList) {
        for (final int duration in item.durationInHours!) {
          final filtered = internetPlanResponseData.data!.dataPlanLists!
              .where((element) => element.durationInHours == duration)
              .toList();
          filteredDataPlanLists.addAll(filtered);
        }
      }
      dataPlanLists = filteredDataPlanLists;
    }
    update();
  }

  void setSelectedDataPlanList(DataPlanList dataPlanList) {
    selectedDataPlanList = dataPlanList;
    selectedId = dataPlanList.id;
    update();
    _getDiscountEffectRequest(selectedDataPlanList!.priceWithTax!);
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
      if (selectedDataPlanList != null) {
        return selectedDataPlanList!.priceWithTax;
      } else {
        return 0;
      }
    }
  }

  void setSelectOperator(OperatorData operatorData) {
    if (selectedOperatorData != null && selectedOperatorData!.id == operatorData.id) {
      return;
    } else {
      selectedOperatorData = operatorData;
      if (selectedOperatorData!.id == 0) {
        selectMTN();
      } else if (selectedOperatorData!.id == 1) {
        selectMCI();
      } else if (selectedOperatorData!.id == 2) {
        selectRightel();
      } else if (selectedOperatorData!.id == 3) {
        selectShatel();
      }
      update();
    }
  }

  void setIsStorePhone(bool? value) {
    isStorePhone = value!;
    update();
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
    final int? correctAmount = getCorrectAmount();
    if (walletAmount < correctAmount!) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  bool showFavList() {
    if (phoneNumberController.text.isEmpty && storedContactDataList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> validateSelectOperator() async {
//locale
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
        child: const SelectSimTypeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validateSimType() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedSimType != null) {
      _getInternetPlansRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_sim_type,
      );
    }
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
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
        child: const InternetSelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
    useDiscount = false;
    update();
  }

  bool isDiscountEnabled() {
    return mainController.walletDetailData!.data!.havadary == true &&
        customerClubDiscountEffectResponse!.data!.pointsLost != '0';
  }
}
