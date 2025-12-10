import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/storage_util.dart';
import '../../model/card/request/edit_card_data_request.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/card/add_card_screen.dart';
import '../../ui/shaparak_hub/shaparak_hub_submit_screen.dart';
import '../../ui/source_card_selector/view/confirm_shaparak_submit_bottom_sheet_widget.dart';
import '../../ui/source_card_selector/view/source_card_default_card_bottom_sheet_widget.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../dashboard/card_main_page_controller.dart';
import '../main/main_controller.dart';

class SourceCardSelectorController extends GetxController {
  int defaultCardRequest = 0;

  TextEditingController cardSearchController = TextEditingController();

  List<CustomerCard> sourceCustomerCardList = [];
  List<CustomerCard> allSourceCustomerCardList = [];
  MainController mainController = Get.find();
  bool hasError = false;
  String errorTitle = '';
  bool isLoading = false;

  PageController pageController = PageController();
  Function(CustomerCard customerCard, BankInfo bankInfo) returnDataFunction;
  String? description;
  bool? checkIsTransfer;
  bool isPichak;

  List<BankInfo> bankInfoList = [];

  SourceCardSelectorController({
    required this.returnDataFunction,
    required this.isPichak,
    this.description,
    this.checkIsTransfer,
  });

  @override
  Future<void> onInit() async {
    getCustomerCardRequest();
    super.onInit();
  }

  /// Get data of [ListCardData] from server request
  Future getCustomerCardRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CardServices.getCustomerCardsRequest().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerCardResponseData response, int _)):
            hasError = false;
            _handleListOfCards(response.data!.cards ?? []);
            bankInfoList = response.data!.bankInfo ?? [];
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

  Future<void> _handleListOfCards(List<CustomerCard> customerCardList) async {
    sourceCustomerCardList = [];

    for (final CustomerCard customerCard in customerCardList) {
      if (customerCard.isMine == true) {
        if (customerCard.gardeshgaryCardData != null) {
          if (customerCard.gardeshgaryCardData!.status == 1) {
            sourceCustomerCardList.add(customerCard);
          }
        } else {
          sourceCustomerCardList.add(customerCard);
        }
      }
    }
    allSourceCustomerCardList = sourceCustomerCardList;
    update();
  }

  void showAddCardScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(() => const AddCardScreen())!.then((onValue) {
      AppUtil.previousPageController(pageController, isClosed);
      getCustomerCardRequest();
    });
  }

  void setSelectedCardData(CustomerCard customerCard) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    if (bankInfo!.inShaparakHub! || bankInfo.isTransfer! || !checkIsTransfer!) {
      if (mainController.walletDetailData != null && mainController.walletDetailData!.data!.cardDefault == null) {
        defaultCardRequest = StorageUtil.box.read(Constants.defaultCardRequest) ?? 0;
        if (defaultCardRequest < 3 && !isPichak) {
          _setDefaultCard(customerCard);
        } else {
          _checkSelectedCard(customerCard, bankInfo);
        }
      } else {
        _checkSelectedCard(customerCard, bankInfo);
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.card_transfer_unavailable,
      );
    }
  }

  void _checkSelectedCard(CustomerCard customerCard, BankInfo bankInfo) {
    if (isPichak && customerCard.hubCardData == null) {
      _showShaparakHubBottomSheet(customerCard);
    } else {
      returnDataFunction(customerCard, bankInfo);
      Get.back();
    }
  }

  void _setDefaultCard(CustomerCard customerCard) {
    if (isClosed) {
      return;
    }
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    defaultCardRequest++;
    StorageUtil.box.write(Constants.defaultCardRequest, defaultCardRequest);
    showModalBottomSheet(
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
        child: SourceCardDefaultCardBottomSheetWidget(
          customerCard: customerCard,
          bankInfo: bankInfo!,
        ),
      ),
    );
  }

  /// Sends a request to edit a customer card and handles the response.
  void editCardRequest(CustomerCard customerCard, BankInfo bankInfo) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final EditUserCardDataRequest editCardDataRequest = EditUserCardDataRequest();
    editCardDataRequest.id = customerCard.id;
    editCardDataRequest.title = customerCard.title;
    editCardDataRequest.cardExpMonth = customerCard.cardExpMonth;
    editCardDataRequest.cardExpYear = customerCard.cardExpYear;
    editCardDataRequest.isDefault = true;

    isLoading = true;
    update();
    CardServices.updateUserCardRequest(
      editCardDataRequest: editCardDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          if (mainController.walletDetailData != null) {
            mainController.walletDetailData!.data!.customerCardDefault = customerCard;
          }
          returnSelectedCard(customerCard, bankInfo);
          SnackBarUtil.showSuccessSnackBar(locale.card_set_as_default);
          try {
            if (mainController.isCardMainPageControllerInit) {
              final CardMainPageController cardMainPageController = Get.find();
              cardMainPageController.getCustomerCardRequest();
            }
          } on Exception catch (_) {}
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void returnSelectedCard(CustomerCard customerCard, BankInfo bankInfo) {
    _checkSelectedCard(customerCard, bankInfo);
    Get.back();
  }

  /// Filters the customer card list based on the search query.
  void searchCards() {
    sourceCustomerCardList = allSourceCustomerCardList
        .where((customerCard) => (customerCard
            .toSearchJson()
            .toString()
            .toLowerCase()
            .contains(AppUtil.getEnglishNumbers(cardSearchController.text.toLowerCase()))))
        .toList();
    update();
  }

  void _showShaparakHubBottomSheet(CustomerCard customerCard) {
    if (isClosed) {
      return;
    }
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    showModalBottomSheet(
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
        child: ConfirmShaparakSubmitBottomSheetWidget(
          customerCard: customerCard,
          bankInfo: bankInfo!,
        ),
      ),
    );
  }

  void submitShaparakCard(CustomerCard customerCard) {
    Get.back();
    Get.to(
      () => ShaparakHubSubmitScreen(
        cardNumber: customerCard.cardNumber,
        hasPublicKey: true,
        isReactivation: false,
      ),
    )!
        .then((value) {
      AppUtil.previousPageController(pageController, isClosed);
      getCustomerCardRequest();
    });
  }

  void clearSourceCardTextField() {
    cardSearchController.clear();
    searchCards();
  }
}
