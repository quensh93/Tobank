import 'dart:async';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_io/io.dart';

import '../../model/gift_card/city_province_data_model.dart';
import '../../model/gift_card/gift_card_selected_design_data.dart';
import '../../model/gift_card/request/gift_card_data_request.dart';
import '../../model/gift_card/response/costs_data.dart';
import '../../model/gift_card/response/gift_card_internet_pay_data.dart';
import '../../model/gift_card/response/gift_card_wallet_pay_data.dart';
import '../../model/gift_card/response/list_delivery_date_data.dart';
import '../../model/gift_card/response/list_gift_card_amount_data.dart';
import '../../model/gift_card/response/list_message_gift_card_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/gift_card_services.dart';
import '../../service/transaction_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/common/help_bottom_sheet.dart';
import '../../ui/common/location_picker_screen.dart';
import '../../ui/gift_card/gift_card_select_custom_design/gift_card_select_custom_design_screen.dart';
import '../../ui/gift_card/gift_card_select_design/gift_card_select_design_screen.dart';
import '../../ui/gift_card/widget/gift_card_select_amount_bottom_sheet.dart';
import '../../ui/gift_card/widget/gift_card_select_date_bottom_sheet.dart';
import '../../ui/gift_card/widget/gift_card_select_payment_bottom_sheet.dart';
import '../../ui/gift_card/widget/select_design_type_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/web_only_utils/token_util.dart';
import '../main/main_controller.dart';

class GiftCardController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  List<PhysicalGiftCardAmount> giftCardAmountItemList = [];
  TransactionData? transactionData;
  PhysicalGiftCardInternetPayData? physicalGiftCardInternetPayData;
  GiftCardWalletPayData? giftCardWalletPayData;
  CostsData? costsData;
  PhysicalGiftCardDataRequest physicalGiftCardDataRequest =
      PhysicalGiftCardDataRequest();
  bool isLoading = false;
  List<MessageData>? messageGiftCardList = [];
  List<DeliveryDate>? deliveryDateList = [];
  int walletAmount = 0;

  bool isValidateData = true;
  bool? confirmRules = false;

  File? selectedImage;
  int selectedGiftCardCount = 0;

  String errorTitle = '';

  bool hasError = false;

  CityProvinceDataModel? selectedProvince;
  bool isProvinceValid = true;

  City? selectedCity;
  bool isCityValid = true;

  List<CityProvinceDataModel> cityProvinceDataModelList = [];
  List<City>? cityDataModelList = [];

  bool isShowCityList = false;
  bool isShowProvinceList = false;

  bool hasDeliveryTime = false;

  int openBottomSheets = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isNameValid = true;
  bool isMobileValid = true;
  bool isPostalCodeValid = true;
  bool isAddressValid = true;
  bool isLocationValid = true;

  LatLng? selectedLocation;

  int? selectedTime;
  int? selectedDate;
  List<DeliveryTime>? deliveryTimeList = [];

  PaymentType currentPaymentType = PaymentType.wallet;

  GiftCardSelectedDesignData? giftCardSelectedDesignData;

  bool isOwner = false;

  GiftCardController({this.costsData});

  bool isCustom = false;

  @override
  void onInit() {
    physicalGiftCardDataRequest.cards = [];
    listOfGiftCardAmountRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  bool? isCustomDesignEnable() {
    return costsData!.data!.enableOrderCustomDesign;
  }
  //locale
  final locale = AppLocalizations.of(Get.context!)!;

  void addDefaultCardToList() {

    if (selectedGiftCardCount <= 4) {
      final CardInfo cardInfo = CardInfo(
        balance: giftCardAmountItemList[0].balance,
        quantity: 1,
      );
      physicalGiftCardDataRequest.cards!.add(cardInfo);
      selectedGiftCardCount++;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.max_daily_cards_purchase,
      );
    }
  }

  /// Adds a default gift card to the purchase list,
  /// up to a maximum of 5 cards.
  void _addFirstSelectedCard() {
    if (physicalGiftCardDataRequest.cards!.isEmpty) {
      final CardInfo cardInfo = CardInfo(
        balance: giftCardAmountItemList[0].balance,
        quantity: 1,
      );
      physicalGiftCardDataRequest.cards!.add(cardInfo);
      selectedGiftCardCount++;
      update();
    }
  }

  /// Retrieves a list of available gift card amounts and initializes the selection.
  ///
  /// If successful, it updates the [giftCardAmountItemList] with the retrieved data,
  /// adds the first card to the selection using [_addFirstSelectedCard()],
  /// and navigates to the next page.
  void listOfGiftCardAmountRequest() {

    hasError = false;
    isLoading = true;
    update();

    GiftCardServices.getPhysicalGiftCardsAmountRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(
            value: (final ListPhysicalGiftCardAmountData response, int _)
          ):
          giftCardAmountItemList = response.data!;
          _addFirstSelectedCard();
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
    });
  }

  Future<void> validateInternetPayment() async {
    if (GetPlatform.isWeb) {
      // Check if we're returning from a payment gateway
      final Uri currentUri = Uri.parse(html.window.location.href);

      // Check for transaction information in URL parameters
      if (currentUri.queryParameters.containsKey('transaction_id')) {
        // Get the transaction ID and convert to int if needed
        final transactionIdStr = currentUri.queryParameters['transaction_id']!;
        final int? transactionId = int.tryParse(transactionIdStr);

        // Create a data object with the transaction ID if we don't have it already
        physicalGiftCardInternetPayData ??= PhysicalGiftCardInternetPayData(
          transactionId: transactionId,
        );

        _transactionDetailByIdRequest();
      } else if (physicalGiftCardInternetPayData != null) {
        _transactionDetailByIdRequest();
      } else {
        // No transaction information found
        SnackBarUtil.showSnackBar(
          title: locale.error,
          message: locale.transaction_info_not_found,
        );
      }
    } else {
      // Mobile flow remains unchanged
      _transactionDetailByIdRequest();
    }
  }

  /// Retrieves detailed information about a transaction using its ID,
  /// which is obtained from the [physicalGiftCardInternetPayData].
  void _transactionDetailByIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: physicalGiftCardInternetPayData!.transactionId!,
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

  Future<void> getListDeliveryDate() async {
    if (selectedCity!.id == 87 && selectedProvince!.id == 8) {
      _getListDeliveryDateRequest();
    } else {
      hasDeliveryTime = false;
      update();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  /// Retrieves a list of available delivery dates for gift cards and displays a selection bottom sheet.
  void _getListDeliveryDateRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    GiftCardServices.getListDeliveryDateData().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ListDeliveryDateData response, int _)):
          deliveryDateList = response.data!.results;
          hasDeliveryTime = true;
          update();
          _showSelectDateBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _payGiftCard() async {
    if (currentPaymentType == PaymentType.gateway) {
      physicalGiftCardDataRequest.wallet = 0;
      _payGiftCardInternetRequest();
    } else {
      physicalGiftCardDataRequest.wallet = 1;
      _payGiftCardWalletRequest();
    }
  }

  /// Processes an internet payment request for a physical gift card purchase.
  void _payGiftCardInternetRequest() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;

    try {
      isLoading = true;
      update();

      // Generate a new short-lived token for web platform
      String? token;
      if (GetPlatform.isWeb) {
        // Generate token similar to card management controller
        final tokenData = await _generateToken();
        token = tokenData['token'];
        print('🔑 Generated token for gift card payment: $token');

        // Add the token to the request data if needed
        // If your API expects the token in the request body:
        physicalGiftCardDataRequest.token = token;
      }

      // Send the payment request
      GiftCardServices.payPhysicalGiftCardInternet(
        physicalGiftCardDataRequest: physicalGiftCardDataRequest,
      ).then((result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(
          value: (final PhysicalGiftCardInternetPayData response, int _)
          ):
            physicalGiftCardInternetPayData = response;
            update();
            Get.back();

            if (GetPlatform.isWeb) {
              // For web, redirect directly to the payment gateway
              if (response.url != null && response.url!.isNotEmpty) {
                // Open the payment gateway URL in the current browser window
                print('🔗 Redirecting to payment URL: ${response.url}');
                html.window.location.href = response.url!;
              } else {
                SnackBarUtil.showSnackBar(
                  title: locale.error,
                  message: locale.payment_gateway_address_not_found,
                );
              }
            } else {
              // For mobile, continue with the normal flow
              AppUtil.nextPageController(pageController, isClosed);
            }

          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      });
    } catch (e) {
      isLoading = false;
      update();
      print('Error in _payGiftCardInternetRequest: $e');
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.error_in_pay_request,
      );
    }
  }

// Private function to generate a short-lived token, similar to the one in card management controller
  Future<Map<String, dynamic>> _generateToken() async {
    try {
      // Clear the previously stored token (if any)
      await TokenUtil.clearStoredToken();

      // Generate a new token using TokenUtil
      final tokenData = await TokenUtil.generateShortLivedToken();
      print('🔑 Generated token: ${tokenData['token']}');
      return tokenData;
    } catch (e) {
      print('Error generating token: $e');
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.problem_in_generating_token,
      );
      rethrow;
    }
  }

  /// Processes a wallet payment request for a physical gift card purchase.
  void _payGiftCardWalletRequest() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    GiftCardServices.payPhysicalGiftCardWallet(
      physicalGiftCardDataRequest: physicalGiftCardDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          update();
          Get.back();
          AppUtil.changePageController(
            pageController: pageController,
            page: 6,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Retrieves the user's wallet balance and determines valid payment types.
  Future<void> getWalletDetailRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    WalletServices.getWalletBalance().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(
              value: (final WalletBalanceResponseData response, int _)
            ):
            walletAmount = response.data!.amount!;
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

  void setConfirmRules(bool? value) {
    confirmRules = value;
    update();
  }

  /// Validate values of form before request
  void validateSecondPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;
    if (physicalGiftCardDataRequest.cards!.isNotEmpty) {
      for (final CardInfo cardInfo in physicalGiftCardDataRequest.cards!) {
        if (cardInfo.balance! < costsData!.data!.minPayableAmount! ||
            cardInfo.balance! > costsData!.data!.maxPayableAmount!) {
          isValid = false;
        }
      }
      if (isValid) {
        _showSelectDesignTypeBottomSheet();
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.invalid_amount,
        );
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.add_at_least_one_card,
      );
    }
  }

  bool validateSecondPageBool(String textAmount) {
    if (textAmount == '') {
      return true;
    }
    if (physicalGiftCardDataRequest.cards?.isEmpty ?? true) {
      return false;
    }
    for (final CardInfo cardInfo in physicalGiftCardDataRequest.cards!) {
      final balance = cardInfo.balance ?? 0;
      final min = costsData?.data?.minPayableAmount ?? 0;
      final max = costsData?.data?.maxPayableAmount ?? double.infinity;

      if (balance < min || balance > max) {
        return false;
      }
    }
    return true;
  }

  /// Validate values of form before request
  void validateSixthPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (nameController.text.trim().isNotEmpty) {
      isNameValid = true;
    } else {
      isNameValid = false;
      isValid = false;
    }
    if (mobileController.text.trim().length == Constants.mobileNumberLength) {
      isMobileValid = true;
    } else {
      isMobileValid = false;
      isValid = false;
    }
    if (postalCodeController.text.trim().length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
    } else {
      isPostalCodeValid = false;
      isValid = false;
    }
    if (addressController.text.trim().length > 3) {
      isAddressValid = true;
    } else {
      isAddressValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      physicalGiftCardDataRequest.receiverFullname = nameController.text;
      physicalGiftCardDataRequest.receiverMobile = mobileController.text;
      physicalGiftCardDataRequest.receiverAddress = addressController.text;
      physicalGiftCardDataRequest.receiverPostcode = postalCodeController.text;
      if (selectedLocation != null) {
        physicalGiftCardDataRequest.receiverLatitude =
            double.parse(selectedLocation!.latitude.toStringAsFixed(5));
        physicalGiftCardDataRequest.receiverLongitude =
            double.parse(selectedLocation!.longitude.toStringAsFixed(5));
      } else {
        physicalGiftCardDataRequest.receiverLatitude = 0.0;
        physicalGiftCardDataRequest.receiverLongitude = 0.0;
      }
      physicalGiftCardDataRequest.selectedLocation = selectedLocation;
      physicalGiftCardDataRequest.city = selectedCity!.id;
      physicalGiftCardDataRequest.province = selectedProvince!.id;
      getListDeliveryDate();
    }
  }

  void showSelectLocationScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(
      () => LocationPickerScreen(
        returnDataFunction: (latLng) {
          selectedLocation = latLng;
          update();
        },
      ),
    );
  }

  /// Validate values of form before request
  void validateSeventhPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (hasDeliveryTime) {
      if (selectedDate != null && selectedTime != null) {
        physicalGiftCardDataRequest.deliveryTime =
            deliveryTimeList![selectedTime!].id;
        physicalGiftCardDataRequest.deliveryDate =
            deliveryDateList![selectedDate!].id;
        physicalGiftCardDataRequest.date =
            DateConverterUtil.getDateJalaliWithDayName(
                gregorianDate: deliveryDateList![selectedDate!].deliveryDate!);
        physicalGiftCardDataRequest.time =
            '${deliveryTimeList![selectedTime!].fromHour} - ${deliveryTimeList![selectedTime!].toHour}';
        Get.back();
        AppUtil.nextPageController(pageController, isClosed);
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.select_delivery_time,
        );
      }
    } else {
      physicalGiftCardDataRequest.deliveryTime = 0;
      physicalGiftCardDataRequest.deliveryDate = 0;
      Get.back();
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void selectDate(int index) {
    selectedDate = index;
    deliveryTimeList = deliveryDateList![index].times;
    update();
  }

  void selectTIme(int index) {
    selectedTime = index;
    update();
  }

  void showConfirmMessage() {

    DialogUtil.showDialogMessage(
      buildContext: Get.context!,
      message: locale.confirm_payment,
      description: locale.payment_irreversible,
      positiveMessage: locale.yes,
      negativeMessage: locale.no,
      positiveFunction: () {
        Get.back(closeOverlays: true);
        if (currentPaymentType == PaymentType.wallet) {
          if (walletAmount >= getAllCost()) {
            _payGiftCard();
          } else {
            Timer(Constants.duration100, () {
              SnackBarUtil.showNotEnoughWalletMoneySnackBar();
            });
          }
        } else {
          _payGiftCard();
        }
      },
      negativeFunction: () {
        Get.back(closeOverlays: true);
      },
    );
  }

  void setCurrentPaymentType(PaymentType value) {
    currentPaymentType = value;
    update();
  }

  /// Formatting value of amount with each three number one separation
  ///  1000 => 1,000
  void validateAmountValue(String value, int? index) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      physicalGiftCardDataRequest.cards![index!].amountController.text =
          AppUtil.formatMoney(value);
      physicalGiftCardDataRequest.cards![index].amountController.selection =
          TextSelection.fromPosition(TextPosition(
              offset: physicalGiftCardDataRequest
                  .cards![index].amountController.text.length));
    }
    if (value != '') {
      physicalGiftCardDataRequest.cards![index!].balance =
          int.parse(value.replaceAll(',', ''));
    }
    update();
  }

  void addQuantityOfGiftCard(int? index) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedGiftCardCount <= 4) {
      physicalGiftCardDataRequest.cards![index!].quantity =
          physicalGiftCardDataRequest.cards![index].quantity! + 1;
      selectedGiftCardCount++;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.max_daily_cards_purchase,
      );
    }
  }

  void setSelectedAmount(int index, int? balance) {
    physicalGiftCardDataRequest.cards![index].balance = balance;
    physicalGiftCardDataRequest.cards![index].isShow = false;
    update();
  }

  /// Decreases the quantity of a gift card in the purchase list or removes it entirely.
  void removeQuantity(int index) {
    if (physicalGiftCardDataRequest.cards![index].quantity! > 1) {
      physicalGiftCardDataRequest.cards![index].quantity =
          physicalGiftCardDataRequest.cards![index].quantity! - 1;
    } else {
      physicalGiftCardDataRequest.cards!.removeAt(index);
    }
    selectedGiftCardCount--;
    update();
  }

  void toggleShowListAmount(int index) {
    physicalGiftCardDataRequest.cards![index].isShow =
        !physicalGiftCardDataRequest.cards![index].isShow;
    update();
  }

  void toggleProvinceListShowing() {
    isShowProvinceList = !isShowProvinceList;
    update();
  }

  void toggleCityListShowing() {
    isShowCityList = !isShowCityList;
    update();
  }

  /// Loads city and province data from a local JSON asset file./// This function loads city and province data from a JSON file located in the "assets/json" folder.
  Future<void> loadCityProvinceData() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (giftCardSelectedDesignData != null) {
      isLoading = true;
      update();
      final String data = await DefaultAssetBundle.of(Get.context!)
          .loadString('assets/json/city_province.json');
      cityProvinceDataModelList = cityProvinceDataModelFromJson(data);
      isLoading = false;
      selectedProvince =
          cityProvinceDataModelList.where((element) => element.id == 8).first;
      selectedCity =
          selectedProvince!.city!.where((element) => element.id == 87).first;
      cityDataModelList = selectedProvince!.city;
      AppUtil.nextPageController(pageController, isClosed);
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_text_and_design,
      );
    }
  }

  void setSelectedCity(City city) {
    selectedCity = city;
    isShowCityList = false;
    update();
  }

  void setSelectedProvince(CityProvinceDataModel cityProvinceDataModel) {
    selectedProvince = cityProvinceDataModel;
    cityDataModelList = cityProvinceDataModel.city;
    selectedCity = cityDataModelList![0];
    isShowProvinceList = false;
    update();
  }

  void returnFirstPage() {
    AppUtil.previousPageController(pageController, isClosed);
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 5 ||
          pageController.page == 6) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void setValidPaymentType() {
    final int correctAmount = getAllCost();
    if (walletAmount < correctAmount) {
      setCurrentPaymentType(PaymentType.gateway);
    } else {
      setCurrentPaymentType(PaymentType.wallet);
    }
  }

  Future<void> showAmountBottomSheet(CardInfo cardInfo, int mainIndex) async {
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
        child: GiftCardSelectAmountBottomSheet(
          cardInfo: cardInfo,
          mainIndex: mainIndex,
        ),
      ),
    );
    openBottomSheets--;
  }

  Future<void> _showSelectDesignTypeBottomSheet() async {
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
        child: const SelectDesignTypeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> showGiftCardSelectScreen() async {
    if (isCustom) {
      final GiftCardSelectedDesignData? result =
          await Get.to(() => const GiftCardSelectCustomDesignScreen());
      if (result != null) {
        giftCardSelectedDesignData = result;
        physicalGiftCardDataRequest.event =
            giftCardSelectedDesignData!.selectedEvent!.id;
        physicalGiftCardDataRequest.design =
            giftCardSelectedDesignData!.selectedPlan!.id;
        physicalGiftCardDataRequest.title =
            giftCardSelectedDesignData!.cardTitle;
        physicalGiftCardDataRequest.alternativeTitle =
            giftCardSelectedDesignData!.selectedMessageData!.description;
        physicalGiftCardDataRequest.customImage =
            giftCardSelectedDesignData!.customImageBase64;
        update();
      }
    } else {
      final GiftCardSelectedDesignData? result =
          await Get.to(() => const GiftCardSelectDesignScreen());
      if (result != null) {
        giftCardSelectedDesignData = result;
        physicalGiftCardDataRequest.event =
            giftCardSelectedDesignData!.selectedEvent!.id;
        physicalGiftCardDataRequest.design =
            giftCardSelectedDesignData!.selectedPlan!.id;
        physicalGiftCardDataRequest.title =
            giftCardSelectedDesignData!.cardTitle;
        physicalGiftCardDataRequest.alternativeTitle =
            giftCardSelectedDesignData!.selectedMessageData!.description;
        update();
      }
    }
  }

  void setDesignType({required bool isCustomValue}) {
    isCustom = isCustomValue;
    giftCardSelectedDesignData = null;
    update();
    AppUtil.nextPageController(pageController, isClosed);
    Get.back();
  }

  String getCardTitle() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (giftCardSelectedDesignData == null) {
      return locale.default_text;
    } else {
      if (giftCardSelectedDesignData!.cardTitle != null) {
        return giftCardSelectedDesignData!.cardTitle!;
      } else {
        return giftCardSelectedDesignData!.selectedMessageData!.description!;
      }
    }
  }

  String getAlternativeCardTitle() {
    return giftCardSelectedDesignData!.selectedMessageData!.description!;
  }

  void setOwner(bool? value) {
    if (value == true) {
      nameController.text =
          '${mainController.authInfoData!.firstName} ${mainController.authInfoData!.lastName}';
      mobileController.text = '${mainController.authInfoData!.mobile}';
    } else {
      nameController.text = '';
      mobileController.text = '';
    }
    isOwner = value!;
    update();
  }

  Future<void> _showSelectDateBottomSheet() async {
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
        child: const GiftCardSelectDateBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  /// Calculates the total cost of the gift card purchase, including delivery and charges.
  int getAllCost() {
    int sumCost = 0;
    if (costsData != null) {
      sumCost += costsData!.data!.deliveryCost!;
      for (final CardInfo cardInfo in physicalGiftCardDataRequest.cards!) {
        sumCost += cardInfo.balance! * cardInfo.quantity!;
        sumCost += costsData!.data!.chargeAmount! * cardInfo.quantity!;
      }
    }
    return sumCost;
  }

  /// Calculates the total cost of the gift cards in the purchase list, excluding delivery and charges.
  int getCardCost() {
    int sumCost = 0;
    for (final CardInfo cardInfo in physicalGiftCardDataRequest.cards!) {
      sumCost += cardInfo.balance! * cardInfo.quantity!;
    }
    return sumCost;
  }

  /// Calculates the total number of gift cards in the purchase list.
  int cardCount() {
    int count = 0;
    for (final CardInfo cardInfo in physicalGiftCardDataRequest.cards!) {
      count += cardInfo.quantity!;
    }
    return count;
  }

  Future<void> _showPaymentBottomSheet() async {
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
        child: const GiftCardSelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  String getCustomTitle() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (giftCardSelectedDesignData == null) {
      return locale.default_text;
    } else {
      return giftCardSelectedDesignData!.cardTitle!;
    }
  }

  Future<void> showHelpBottomSheet() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
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
        child: HelpBottomSheet(
          title: locale.guide,
          description: locale.min_max_desired_amount(
              AppUtil.formatMoney(costsData!.data!.maxPayableAmount),
              AppUtil.formatMoney(costsData!.data!.minPayableAmount)),
        ),
      ),
    );
    openBottomSheets--;
  }

  void removeSelectedMapLocation() {
    selectedLocation = null;
    update();
  }
}
