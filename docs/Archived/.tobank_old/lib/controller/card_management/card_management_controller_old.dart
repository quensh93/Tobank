/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../model/address/request/address_inquiry_request_data.dart';
import '../../model/address/response/address_inquiry_response_data.dart';
import '../../model/card/card_block_reason_data.dart';
import '../../model/card/pin_type_data.dart';
import '../../model/card/request/card_block_request_data.dart';
import '../../model/card/request/edit_card_data_request.dart';
import '../../model/card/response/card_block_response_data.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/config_by_title_response_data.dart';
import '../../model/contact_match/custom_match_contact.dart';
import '../../model/deposit/request/customer_deposits_request_data.dart';
import '../../model/deposit/request/deposit_balance_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/deposit/response/deposit_balance_response_data.dart';
import '../../model/service_item_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/request/charge_wallet_request_data.dart';
import '../../model/wallet/request/transfer_wallet_data.dart';
import '../../model/wallet/response/charge_wallet_response_data.dart';
import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../service/card_services.dart';
import '../../service/config_by_title_services.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/transaction_services.dart';
import '../../service/update_address_services.dart';
import '../../service/wallet_services.dart';
import '../../ui/card_balance/card_balance_screen.dart';
import '../../ui/card_management/card_primary_password/card_primary_password_screen.dart';
import '../../ui/card_management/card_reissue/card_reissue_start/card_reissue_start_screen.dart';
import '../../ui/card_management/card_secondary_password/card_secondary_password_screen.dart';
import '../../ui/card_management/edit_card_screen.dart';
import '../../ui/card_management/wallet_charge/wallet_charge_screen.dart';
import '../../ui/card_management/widget/card_block_bottom_sheet.dart';
import '../../ui/card_management/widget/card_detail_bottom_sheet.dart';
import '../../ui/card_management/widget/card_reissue_postal_code_bottom_sheet.dart';
import '../../ui/card_management/widget/card_widget.dart';
import '../../ui/card_management/widget/confirm_payment_bottom_sheet.dart';
import '../../ui/card_management/widget/primary_password_select_service_bottom_sheet.dart';
import '../../ui/card_management/widget/secondary_password_select_service_bottom_sheet.dart';
import '../../ui/card_management/widget/share_card_bottom_sheet.dart';
import '../../ui/card_management/widget/wallet_charge_bottom_sheet.dart';
import '../../ui/card_management/widget/wallet_charge_select_payment_bottom_sheet.dart';
import '../../ui/card_management/widget/wallet_transfer_bottom_sheet.dart';
import '../../ui/card_to_card/card_to_card_screen.dart';
import '../../ui/common/select_deposit_payment_bottom_sheet.dart';
import '../../ui/common/wallet_widget.dart';
import '../../ui/contact/contact_match_screen.dart';
import '../../ui/transaction_detail/transaction_detail_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/theme/theme_util.dart';
import '../dashboard/card_main_page_controller.dart';
import '../main/main_controller.dart';
import 'card_wallet_controller.dart';

class CardManagementController extends GetxController {
  late PageController cardPageController;

  CustomerCard? selectedCustomerCard;
  List<CustomerCard> customerCardList;
  List<BankInfo> bankInfoList;
  BankInfo? selectedSourceBankInfo;

  PinTypeData? selectedPrimaryService;
  PinTypeData? selectedSecondaryService;

  int currentCardPageIndex = 0;
  bool isWallet = false;
  bool isGardeshgary = false;

  List<Widget> cardWidgets = [];

  MainController mainController = Get.find();
  bool isLoading = false;
  bool isBlockReasonValid = true;
  CardBlockReasonData? selectedCardBlockReasonData;
  CardBlockResponseData? cardBlockResponseData;

  String? cityName;
  AddressInquiryResponseData? customerAddressInquiryResponseData;
  TextEditingController postalCodeController = TextEditingController();
  bool isPostalCodeValid = true;
  bool isPostalCodeLoading = false;
  String postalCodeErrorMessage = '';

  int? amount;
  bool isWalletLoading = false;
  bool hasWalletError = false;

  static const String eventName = 'Card_Click_Event';

  bool isCardBalanceLoading = false;

  int openBottomSheets = 0;

  TransactionData? transactionData;
  TextEditingController destinationPhoneNumberController = TextEditingController();
  bool isPhoneNumberValid = true;
  bool isAmountValid = true;
  int _amount = 0;
  bool amountValid = true;
  bool amountValidOverFlow = true;
  TextEditingController amountController = TextEditingController();
  TransferWalletData? transferWalletData;
  bool isLoadingWallet = false;
  bool hasError = false;
  TextEditingController descriptionController = TextEditingController();

  String errorMessage = '';

  int selectedAmount = 0;

  List<int> amounts = [50000, 200000, 500000, 1000000];

  PaymentType currentPaymentType = PaymentType.gateway;

  Deposit? selectedPaymentDeposit;

  bool isReissueCardFeeLoading = false;

  String? reissueFee;

  ServiceItemData? clickedServiceItemData;

  String? errorTitle = '';

  bool isEditSuccessful = false;

  bool isDefaultLoading = false;

  CardMainPageController cardMainPageController = Get.find();

  CardManagementController(this.customerCardList, this.bankInfoList, this.selectedCustomerCard);

  @override
  void onInit() {
    _initializeCardPage();
    _generateCardListWidget();
    cardPageController = PageController(initialPage: currentCardPageIndex);
    selectedCardBlockReasonData = AppUtil.getCardBlockReasonList()[0];
    update();
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

  void _initializeCardPage() {
    if (selectedCustomerCard == null) {
      currentCardPageIndex = 0;
      isWallet = true;
      isGardeshgary = false;
    } else {
      final int cardPageIndexFind = customerCardList.indexWhere((element) => element == selectedCustomerCard);
      if (cardPageIndexFind == -1) {
        currentCardPageIndex = 0;
        isWallet = true;
        isGardeshgary = false;
      } else {
        currentCardPageIndex = cardPageIndexFind;
        isWallet = false;
        if (customerCardList[currentCardPageIndex].gardeshgaryCardData == null) {
          isGardeshgary = false;
        } else {
          isGardeshgary = true;
        }
      }
    }
    update();
  }

  /// Generates a list of card widgets to be displayed.
  void _generateCardListWidget() {
    cardWidgets = [];
    cardWidgets.add(const WalletWidget());
    for (final CustomerCard customerCard in customerCardList) {
      if (customerCardList.first == customerCard) {
        continue;
      }
      cardWidgets.add(
        CardWidget(
          customerCard: customerCard,
          bankInfoList: bankInfoList,
          showCardDetailBottomSheet: (customerCard) {
            showCardDetailBottomSheet(customerCard);
          },
          isCardBalanceLoading: isCardBalanceLoading,
          shareCardInfo: (customerCard) {
            shareCardInfo(customerCard);
          },
          balanceFunction: (customerCard) {
            getCardBalance(customerCard);
          },
          isLock: isDisabledGardeshgaryCard(customerCard),
        ),
      );
    }
  }

  Future<void> getCardBalance(CustomerCard customerCard) async {
    if (customerCard.gardeshgaryCardData != null && !mainController.isCustomerHasFullAccess()) {
      SnackBarUtil.showInfoSnackBar('لطفا از بخش سپرده‌ها، احراز هویت خود را کامل کنید');
      return;
    }
    if (customerCard.status == '1') {
      _getDepositBalanceRequest(customerCard);
    } else {
      SnackBarUtil.showInfoSnackBar('این سرویس برای کارت انتخاب شده غیرفعال است');
    }
  }

  /// Sends a request to get the deposit balance for a specific card and updates the UI.
  void _getDepositBalanceRequest(CustomerCard cardData) {
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = cardData.gardeshgaryCardData!.depositNumber;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    isCardBalanceLoading = true;
    update();
    _generateCardListWidget();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      isCardBalanceLoading = false;
      _generateCardListWidget();
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          cardData.gardeshgaryCardData!.balance = response.data?.balance;
          update();
          _generateCardListWidget();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: 'خطا - ${apiException.displayCode}',
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Displays a bottom sheet for sharing card information.
  Future<void> shareCardInfo(CustomerCard cardData) async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ShareCardBottomSheet(cardData: cardData),
      ),
    );
    openBottomSheets--;
  }

  /// Sets the default card for the user and updates the UI.
  Future<void> setDefaultCard(bool statusValue, CustomerCard customerCard) async {
    isDefaultLoading = true;
    update();
    final EditUserCardDataRequest editCardDataRequest = EditUserCardDataRequest();
    editCardDataRequest.title = customerCard.title;
    editCardDataRequest.cardExpMonth = customerCard.cardExpMonth;
    editCardDataRequest.cardExpYear = customerCard.cardExpYear;
    editCardDataRequest.id = customerCard.id;
    editCardDataRequest.isDefault = statusValue;
    await _editCardRequest(editCardDataRequest).then((value) async {
      if (isEditSuccessful) {
        await _updateCustomerCardListRequest();
        _generateCardListWidget();
        selectedCustomerCard = customerCardList[currentCardPageIndex];
        cardMainPageController.getCustomerCardRequest();
        isDefaultLoading = false;
        update();
        _closeBottomSheet();
        if (statusValue == true) {
          SnackBarUtil.showSuccessSnackBar('کارت پیش فرض با موفقیت ثبت شد');
        } else {
          SnackBarUtil.showSuccessSnackBar('کارت پیش فرض حذف شد');
        }
      } else {
        isDefaultLoading = false;
        update();
      }
    });
    update();
  }

  Future<void> showCardDetailBottomSheet(CustomerCard customerCard) async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CardDetailBottomSheet(customerCard: customerCard),
      ),
    );
    openBottomSheets--;
  }

  void handleExtraCardServicesClick(ServiceItemData serviceItemData) {
    if (selectedCustomerCard != null &&
        selectedCustomerCard!.gardeshgaryCardData != null &&
        !mainController.isCustomerHasFullAccess()) {
      SnackBarUtil.showInfoSnackBar('لطفا از بخش سپرده‌ها، احراز هویت خود را کامل کنید');
      return;
    }
    if (selectedCustomerCard != null && (selectedCustomerCard!.status == '1' || selectedCustomerCard!.status == null)) {
      final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == selectedCustomerCard!.bankId);
      if (serviceItemData.eventCode == 1) {
        if (bankInfo!.isTransfer == true) {
          Get.to(() => CardToCardScreen(customerCard: selectedCustomerCard));
        } else {
          SnackBarUtil.showInfoSnackBar('امکان کارت به کارت برای این کارت وجود ندارد');
        }
      } else if (serviceItemData.eventCode == 2) {
        Get.to(() => CardBalanceScreen(customerCard: selectedCustomerCard, bankInfo: bankInfo));
      }
    } else {
      SnackBarUtil.showInfoSnackBar('این سرویس برای کارت انتخاب شده غیرفعال است');
    }
  }

  void handleCardServiceItemClick(ServiceItemData serviceItemData) {
    clickedServiceItemData = serviceItemData;
    if (isWallet) {
      if (serviceItemData.eventCode == 7) {
        _showWalletChargeBottomSheet();
      } else if (serviceItemData.eventCode == 8) {
        _showWalletTransferBottomSheet();
      }
    } else {
      if (!mainController.isCustomerHasFullAccess()) {
        SnackBarUtil.showInfoSnackBar('لطفا از بخش سپرده‌ها، احراز هویت خود را کامل کنید');
        return;
      }
      if (selectedCustomerCard != null && selectedCustomerCard!.status == '1') {
        if (serviceItemData.eventCode == 1) {
          showPrimaryPasswordSelectServiceBottomSheet();
        } else if (serviceItemData.eventCode == 2) {
          showSecondaryPasswordSelectServiceBottomSheet();
        } else if (serviceItemData.eventCode == 3) {
          _getReIssuanceFeeRequest();
        } else if (serviceItemData.eventCode == 4) {
          showCardBlockBottomSheet();
        }
      } else {
        // Enable card reissuance even the card is disabled
        if (serviceItemData.eventCode == 3) {
          _getReIssuanceFeeRequest();
        } else {
          SnackBarUtil.showInfoSnackBar('این سرویس برای کارت انتخاب شده غیرفعال است');
        }
      }
    }
  }

  Future<void> showPrimaryPasswordSelectServiceBottomSheet() async {
    selectedPrimaryService = null;
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const PrimaryPasswordSelectServiceBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> showSecondaryPasswordSelectServiceBottomSheet() async {
    selectedSecondaryService = null;
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const SecondaryPasswordSelectServiceBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> showCardBlockBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    selectedCardBlockReasonData = AppUtil.getCardBlockReasonList()[0];
    update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const CardBlockBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> showCardReissueBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    postalCodeController.text = '';
    update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const CardReissuePostalCodeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void setPrimarySelectService(PinTypeData serviceType) {
    selectedPrimaryService = serviceType;
    update();
  }

  void setSecondarySelectService(PinTypeData serviceType) {
    selectedSecondaryService = serviceType;
    update();
  }

  void goToPrimaryPasswordScreen() {
    if (selectedPrimaryService != null) {
      Get.back();
      Get.to(() => CardPrimaryPasswordScreen(
        customerCard: selectedCustomerCard!,
        pinTypeData: selectedPrimaryService!,
      ));
    }
  }

  void goToSecondaryPasswordScreen() {
    if (selectedSecondaryService != null) {
      Get.back();
      Get.to(() => CardSecondaryPasswordScreen(
        customerCard: selectedCustomerCard!,
        pinTypeData: selectedSecondaryService!,
      ));
    }
  }

  void goToCardReissueScreen() {
    Get.to(() => CardReissueStartScreen(
      customerCard: selectedCustomerCard!,
      postalCode: postalCodeController.text.trim(),
      customerAddressInquiry: customerAddressInquiryResponseData!,
    ));
  }

  void validateGoToCardReissueScreen() {
    cityName = customerAddressInquiryResponseData!.data!.detail?.townShip ??
        customerAddressInquiryResponseData!.data!.detail?.localityName;
    update();
    if (cityName != null && customerAddressInquiryResponseData!.data!.detail!.province != null) {
      Get.back();
      goToCardReissueScreen();
    } else {
      SnackBarUtil.showInfoSnackBar(
        'آدرسی برای این کد پستی یافت نشد',
      );
    }
  }

  void validateCardBlock() {
    if (selectedCardBlockReasonData != null) {
      final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == selectedCustomerCard!.bankId);
      DialogUtil.showCardConfirmDialogMessage(
        buildContext: Get.context!,
        title: 'مسدودسازی',
        titleDescription: 'آیا از مسدودی کارت خود به شماره زیر اطمینان دارید؟',
        confirmMessage: 'مسدودسازی',
        cancelMessage: 'انصراف',
        pan: selectedCustomerCard!.cardNumber!,
        symbol: bankInfo!.symbol!,
        positiveFunction: () {
          Get.back();
          _cardBlockRequest();
        },
        negativeFunction: () {
          Get.back();
        },
        buttonColor: ThemeUtil.primaryColor,
      );
      isBlockReasonValid = true;
    } else {
      isBlockReasonValid = false;
    }
    update();
  }

  /// Sends a request to block a card and handles the response.
  void _cardBlockRequest() {
    final CardBlockRequestData cardBlockRequestData = CardBlockRequestData();
    cardBlockRequestData.trackingNumber = const Uuid().v4();
    cardBlockRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    cardBlockRequestData.pan = selectedCustomerCard!.cardNumber;
    cardBlockRequestData.blockingReason = selectedCardBlockReasonData!.id;
    isLoading = true;
    update();
    CardServices.cardBlockRequest(
      cardBlockRequestData: cardBlockRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CardBlockResponseData response, int _)):
          cardBlockResponseData = response;
          update();
          await _updateCustomerCardListRequest();
          _generateCardListWidget();
          cardMainPageController.getCustomerCardRequest();
          onCardChange(cardPageController.page!.toInt());
          Get.back();
          Timer(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar('مسدودسازی کارت با موفقیت ثبت شد');
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: 'خطا - ${apiException.displayCode}',
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedCardBlockReasonData(CardBlockReasonData cardBlockReasonData) {
    selectedCardBlockReasonData = cardBlockReasonData;
    update();
  }

  /// Validates the postal code and proceeds with the customer address inquiry if valid.
  void validateCustomerAddressInquiry() {
    AppUtil.hideKeyboard(Get.context!);
    if (postalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _customerAddressInquiryRequest();
    } else {
      isPostalCodeValid = false;
      postalCodeErrorMessage = 'مقدار معتبری برای کد پستی وارد کنید';
    }
    update();
  }

  /// Performs a customer address inquiry request based on the provided postal code.
  void _customerAddressInquiryRequest() {
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = postalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isPostalCodeLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          customerAddressInquiryResponseData = response;
          update();
          validateGoToCardReissueScreen();
        case Failure(exception: final ApiException apiException):
          customerAddressInquiryResponseData = null;
          update();
          SnackBarUtil.showSnackBar(
            title: 'خطا - ${apiException.displayCode}',
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Handles card changes and updates the UI accordingly.
  void onCardChange(int page) {
    if (page == 0) {
      isWallet = true;
      selectedCustomerCard = null;
      isGardeshgary = false;
    } else {
      isWallet = false;
      selectedCustomerCard = customerCardList[page];
      if (customerCardList[page].gardeshgaryCardData == null) {
        isGardeshgary = false;
      } else {
        isGardeshgary = true;
      }
    }
    currentCardPageIndex = page;
    Timer(Constants.duration500, () {
      update();
    });
  }

  Future<void> _showWalletTransferBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    destinationPhoneNumberController.text = '';
    amountController.text = '';
    descriptionController.text = '';
    isAmountValid = true;
    isPhoneNumberValid = true;
    _amount = 0;
    update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 9 / 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const WalletTransferBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  /// Sends a request to update the wallet balance and handles the response.
  void updateWalletRequest() {
    hasWalletError = false;
    isWalletLoading = true;
    update();
    WalletServices.getWalletBalance().then(
          (result) {
        isWalletLoading = false;
        update();

        switch (result) {
          case Success(value: (final WalletBalanceResponseData response, int _)):
            amount = response.data!.amount;
            update();
          case Failure(exception: final ApiException apiException):
            hasWalletError = true;
            update();
            SnackBarUtil.showSnackBar(
              title: 'خطا - ${apiException.displayCode}',
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void confirmDeleteCard(CustomerCard customerCard) {
    _closeBottomSheet();
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    DialogUtil.showCardConfirmDialogMessage(
      buildContext: Get.context!,
      title: 'حذف کارت',
      titleDescription: 'آیا از حذف کارت زیر اطمینان دارید؟',
      confirmMessage: 'حذف',
      cancelMessage: 'انصراف',
      pan: customerCard.cardNumber!,
      symbol: bankInfo!.symbol!,
      positiveFunction: () {
        _deleteUserCardRequest(customerCard);
        Get.back(closeOverlays: true);
      },
      negativeFunction: () {
        Get.back(closeOverlays: true);
      },
      buttonColor: ThemeUtil.primaryColor,
    );
  }

  /// Sends a request to delete a user card and handles the response.
  void _deleteUserCardRequest(CustomerCard customerCard) {
    CardServices.deleteUserCardRequest(
      customerCard.id!,
    ).then((result) {
      switch (result) {
        case Success(value: _):
          customerCardList.removeWhere((element) => element.id == customerCard.id);
          _generateCardListWidget();
          cardMainPageController.getCustomerCardRequest();
          update();
          SnackBarUtil.showSuccessSnackBar('کارت با موفقیت حذف شد');
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: 'خطا - ${apiException.displayCode}',
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> showEditCardScreen(CustomerCard customerCard) async {
    _closeBottomSheet();
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    final result = await Get.to(() => EditCardScreen(
      customerCard: customerCard,
      bankInfo: bankInfo!,
    ));
    if (result == true) {
      await _updateCustomerCardListRequest();
      _generateCardListWidget();
      selectedCustomerCard = customerCardList[currentCardPageIndex];
      cardMainPageController.getCustomerCardRequest();
      update();
    }
  }

  Future<void> openContactScreen() async {
    await Get.to(() => ContactMatchScreen(returnDataFunction: (contact) {
      setSelectedPhoneNumber(contact);
    }));
    AppUtil.hideKeyboard(Get.context!);
  }

  /// Show selected phone number in TextField
  /// remove space and replace +98 & 0098 with 0
  void setSelectedPhoneNumber(CustomMatchContact contact) {
    destinationPhoneNumberController.text =
        contact.phone!.replaceAll(' ', '').replaceAll(Constants.iranCountryCode, '0');
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = _amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
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
      _amount = int.parse(value.replaceAll(',', ''));
    } else {
      _amount = 0;
    }
    update();
  }

  /// Validate values of form before request
  void validateTransfer() {
    AppUtil.hideKeyboard(Get.context!);
    bool valid = true;
    if (destinationPhoneNumberController.text.length == Constants.mobileNumberLength &&
        destinationPhoneNumberController.text.startsWith(Constants.mobileStartingDigits)) {
      isPhoneNumberValid = true;
    } else {
      valid = false;
      isPhoneNumberValid = false;
    }
    if (_amount >= Constants.minValidAmount) {
      isAmountValid = true;
    } else {
      valid = false;
      isAmountValid = false;
    }
    update();
    if (valid) {
      transferWalletData = TransferWalletData();
      transferWalletData!.amount = _amount;
      transferWalletData!.destinationNumber = destinationPhoneNumberController.text;
      transferWalletData!.description = descriptionController.text;
      update();
      _showConfirmBottomSheet();
    }
  }

  Future<void> _showConfirmBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 9 / 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const ConfirmPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  /// Show confirm message before transfer money wallet to wallet
  void validatePayment() {
    _closeBottomSheet();
    DialogUtil.showDialogMessage(
      buildContext: Get.context!,
      message: 'آيا از پرداخت وجه مطمئن هستید؟',
      description: 'بعد از پرداخت، بازگشت وجه امکان پذیر نیست. لذا از دستور پرداخت اطمینان حاصل فرمایید',
      positiveMessage: 'تایید',
      negativeMessage: 'انصراف',
      positiveFunction: () {
        Get.back(closeOverlays: true);
        final CardWalletController cardWalletController = Get.find();
        if (cardWalletController.currentAmount >= transferWalletData!.amount!) {
          _walletToWalletRequest();
        } else {
          Timer(Constants.duration100, () {
            SnackBarUtil.showNotEnoughWalletMoneySnackBar();
          });
        }
      },
      negativeFunction: () {
        Get.back(closeOverlays: true);
      },
    );
  }

  /// Sends a request for a wallet-to-wallet transfer and handles the response.
  /// Get data of [TransactionData] from server request
  void _walletToWalletRequest() {
    final String refId = AppUtil.getClientRef(mainController.authInfoData!.token!);
    transferWalletData!.clientRef = refId;
    transferWalletData!.isProfile = 0;
    isLoading = true;
    update();
    WalletServices.transferWalletToWalletRequest(
      transferWalletData: transferWalletData!,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          update();

          await Get.to(() => TransactionDetailScreen(transactionData: transactionData!));
          final CardWalletController cardWalletController = Get.find();
          cardWalletController.getWalletDetailRequest();
        case Failure(exception: final ApiException apiException):
          if (apiException.type == ApiExceptionType.connectionTimeout) {
            _checkClientRefTransaction(transferWalletData!.clientRef!);
          } else {
            SnackBarUtil.showSnackBar(
              title: 'خطا - ${apiException.displayCode}',
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  void _closeBottomSheet() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  void _checkClientRefTransaction(String refId) {
    TransactionServices.getTransactionByRefId(
      refId: refId,
    ).then((result) {
      switch (result) {
        case Success(value: (final TransactionDataResponse response, int _)):
          transactionData = response.data;
          update();
          _closeBottomSheet();
          Get.to(() => TransactionDetailScreen(transactionData: transactionData!));
        case Failure(exception: final ApiException apiException):
          if (apiException.statusCode == 404) {
            AppUtil.showOverlaySnackbar(
              message: 'وضعیت تراکنش نامعلوم است',
              buttonText: 'بررسی مجدد',
              callback: () {
                _checkClientRefTransaction(refId);
              },
            );
          } else {
            SnackBarUtil.showSnackBar(
              title: 'خطا - ${apiException.displayCode}',
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  Future<void> _showWalletChargeBottomSheet() async {
    if (isClosed) {
      return;
    }
    amountController.text = '';
    isAmountValid = true;
    _amount = 0;
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 9 / 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const WalletChargeBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void setCurrentPaymentType(PaymentType value) {
    currentPaymentType = value;
    update();
  }

  void validateCharge() {
    isAmountValid = true;
    AppUtil.hideKeyboard(Get.context!);
    update();
    final int remainAmount =
        mainController.walletDetailData!.data!.maxAmount! - mainController.walletDetailData!.data!.amount!;
    if (_amount < 10000) {
      isAmountValid = false;
      errorMessage = 'مقدار معتبری وارد نمایید';
      update();
    } else if (_amount > remainAmount) {
      isAmountValid = false;
      errorMessage = 'سقف کیف پول بیشتر از حد مجاز است';
      update();
    } else {
      showPaymentBottomSheet();
    }
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
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const WalletChargeSelectPaymentBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validateWalletChargePayment() {
    switch (currentPaymentType) {
      case PaymentType.wallet:
        break; // Will not happend
      case PaymentType.gateway:
        _confirmPayment();
      case PaymentType.deposit:
        _getPaymentDepositsRequest();
    }
  }

  /// Sends a request to get payment deposits and displays a bottom sheet for selection.
  void _getPaymentDepositsRequest() {
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
            title: 'خطا - ${apiException.displayCode}',
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
      isDismissible: true,
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
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: 'از افزایش موجودی کیف پول مطمئن هستید؟',
        description: '',
        positiveMessage: 'تایید',
        negativeMessage: 'لغو',
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
        _chargeWalletInternetRequest();
      case PaymentType.wallet: // Will not happend
      case PaymentType.deposit:
        _chargeWalletPaymentRequest();
    }
  }

  /// Sends a request to charge the wallet via internet payment and handles the response.
  /// Get data of [ChargeWalletInternetResponseData] from server request
  void _chargeWalletInternetRequest() {
    final ChargeWalletRequestData chargeWalletData = ChargeWalletRequestData(
      amount: _amount,
      transactionType: currentPaymentType,
      depositNumber: null,
    );

    isLoading = true;
    update();
    WalletServices.chargeWalletInternetRequest(
      chargeWalletData: chargeWalletData,
    ).then(
          (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final ChargeWalletInternetResponseData response, int _)):
            _showChargeWalletScreen(chargeWalletResponseData: response, transactionDataResponse: null);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: 'خطا - ${apiException.displayCode}',
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  /// Sends a request to charge the wallet via a payment method and handles the response.
  /// Get data of [TransactionDataResponse] from server request
  void _chargeWalletPaymentRequest() {
    final ChargeWalletRequestData chargeWalletData = ChargeWalletRequestData(
      amount: _amount,
      transactionType: currentPaymentType,
      depositNumber: currentPaymentType == PaymentType.deposit ? selectedPaymentDeposit!.depositNumber! : null,
    );

    isLoading = true;
    update();
    WalletServices.chargeWalletRequest(
      chargeWalletData: chargeWalletData,
    ).then(
          (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            _showChargeWalletScreen(chargeWalletResponseData: null, transactionDataResponse: response);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: 'خطا - ${apiException.displayCode}',
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  Future<void> _showChargeWalletScreen({
    required ChargeWalletInternetResponseData? chargeWalletResponseData,
    required TransactionDataResponse? transactionDataResponse,
  }) async {
    _closeBottomSheet();
    await Get.to(() => WalletChargeScreen(
      chargeWalletResponseData: chargeWalletResponseData,
      transactionDataResponse: transactionDataResponse,
      chargeAmount: _amount,
    ));
    final CardWalletController cardWalletController = Get.find();
    cardWalletController.getWalletDetailRequest();
  }

  void setSelectedAmount(int selectedAmount) {
    validateAmountValue(selectedAmount.toString());
    this.selectedAmount = selectedAmount;
    update();
  }

  void shareText(String text) {
    Share.share(text, subject: '');
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtil.showInfoSnackBar('مقدار در حافظه کپی شد');
  }

  /// Sends a request to get the card re-issuance fee and displays a bottom sheet.
  Future<void> _getReIssuanceFeeRequest() async {
    isReissueCardFeeLoading = true;
    update();
    ConfigByTitleServices.getReIssuanceFee().then((result) async {
      isReissueCardFeeLoading = false;
      update();

      switch (result) {
        case Success(value: (final ConfigByTitleResponse response, int _)):
          reissueFee = response.data!.data;
          update();
          showCardReissueBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: 'خطا - ${apiException.displayCode}',
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a request to update the customer card list and handles the response.
  Future<void> _updateCustomerCardListRequest() async {
    isLoading = true;
    hasError = false;
    update();

    final result = await CardServices.getCustomerCardsRequest();
    isLoading = false;
    update();

    switch (result) {
      case Success(value: (final CustomerCardResponseData response, int _)):
        hasError = false;
        _handleCustomerCardListResponse(response);
        update();
      case Failure(exception: final ApiException apiException):
        hasError = true;
        errorTitle = apiException.displayMessage;
        update();
        SnackBarUtil.showSnackBar(
          title: 'خطا - ${apiException.displayCode}',
          message: apiException.displayMessage,
        );
    }
  }

  /// Sends a request to edit a user card and handles the response.
  Future<void> _editCardRequest(EditUserCardDataRequest editCardDataRequest) async {
    isLoading = true;
    isEditSuccessful = false;
    update();
    await CardServices.updateUserCardRequest(
      editCardDataRequest: editCardDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          isEditSuccessful = true;
          update();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: 'خطا - ${apiException.displayCode}',
            message: apiException.displayMessage,
          );
      }
    });
  }

  void clearAmountTextField() {
    amountController.clear();
    _amount = 0;
    update();
  }

  bool isDisabledGardeshgaryCard(CustomerCard? customerCard) {
    return customerCard != null &&
        customerCard.gardeshgaryCardData != null &&
        customerCard.gardeshgaryCardData!.status != 1;
  }

  /// Handles the customer card list response and updates the UI.
  void _handleCustomerCardListResponse(CustomerCardResponseData customerCardResponseData) {
    final List<CustomerCard> enableGardeshgari = [];
    final List<CustomerCard> disableGardeshgari = [];
    final List<CustomerCard> other = [];
    customerCardList = customerCardResponseData.data!.cards ?? [];
    customerCardList = customerCardList.where((element) => element.isMine == true).toList();
    for (final customerCard in customerCardList) {
      if (customerCard.gardeshgaryCardData != null) {
        if (customerCard.gardeshgaryCardData!.status == 1) {
          enableGardeshgari.add(customerCard);
        } else {
          disableGardeshgari.add(customerCard);
        }
      } else {
        other.add(customerCard);
      }
    }
    customerCardList = List.from(enableGardeshgari)
      ..addAll(other)
      ..addAll(disableGardeshgari);
    bankInfoList = customerCardResponseData.data!.bankInfo ?? [];
    customerCardList.insert(0, CustomerCard());
    update();
  }
}
 */