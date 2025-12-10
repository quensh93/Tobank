import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../model/bank_list_data.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/card_scanner_data.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/card_scanner/card_scanner_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class DestinationCardSelectorController extends GetxController {
  List<CustomerCard> destinationCustomerCardList = [];
  List<CustomerCard> allDestinationCustomerCardList = [];
  List<BankInfo> bankInfoList = [];
  MainController mainController = Get.find();
  bool hasError = false;
  String errorTitle = '';
  bool isLoading = false;

  PageController pageController = PageController();
  final Function(String cardNumber,String destinationName) returnDataFunction;
  TextEditingController cardDestinationController = TextEditingController();
  bool isDestinationCardNumberValid = true;

  List<BankDataItem> bankDataItemList = [];

  DestinationCardSelectorController({required this.returnDataFunction});

  @override
  Future<void> onInit() async {
    await _getBankListData();
    getCustomerCardRequest();
    super.onInit();
  }

  Future<void> _getBankListData() async {
    final String data = await DefaultAssetBundle.of(Get.context!).loadString('assets/json/bank_list_data.json');
    final BankListData bankListData = bankListDataFromJson(data);
    bankDataItemList = bankListData.data ?? [];
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Get data of [ListCardData] from server request
  Future getCustomerCardRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    hasError = true;
    update();
    CardServices.getCustomerCardsRequest().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerCardResponseData response, int _)):
            hasError = false;
            update();
            _handleListOfCards(response.data!.cards ?? []);
            bankInfoList = response.data!.bankInfo ?? [];
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

  /// It filters the list to include only cards that do not belong to the current user
  /// and updates the local list of destination cards.
  Future<void> _handleListOfCards(List<CustomerCard> customerCardList) async {
    destinationCustomerCardList = [];
    allDestinationCustomerCardList = [];
    for (final CustomerCard customerCard in customerCardList) {
      if (customerCard.isMine == false) {
        destinationCustomerCardList.add(customerCard);
        allDestinationCustomerCardList.add(customerCard);
      }
    }
    update();
  }

  void setSelectedCardData(CustomerCard customerCard) {
    returnDataFunction(customerCard.cardNumber!,(customerCard.title??''));
    Get.back();
  }

  void validate() {
    bool isValid = true;
    if (cardDestinationController.text.isNotEmpty &&
        cardDestinationController.text.length == Constants.cardNumberLength) {
      isDestinationCardNumberValid = true;
    } else {
      isDestinationCardNumberValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      returnDataFunction(cardDestinationController.text.replaceAll('-', ''),'');
      Get.back();
    }
  }

  // Filters the list of destination customer cards based on a search query.
  void search(String value) {
    if (value.isEmpty) {
      destinationCustomerCardList = allDestinationCustomerCardList;
    } else {
      destinationCustomerCardList = allDestinationCustomerCardList
          .where((customerCard) => (customerCard
              .toSearchJson()
              .toString()
              .toLowerCase()
              .contains(AppUtil.getEnglishNumbers(value.toLowerCase()))))
          .toList();
    }
    update();
  }

  void cleanTextField() {
    cardDestinationController.clear();
    search(cardDestinationController.text);
    update();
  }

  void showScannerScreen() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Get.to(() => CardScannerScreen(
          returnDataFunction: (CardScannerData cardScannerData) {
            final BankDataItem? bankDataItem = bankDataItemList
                .firstWhereOrNull((element) => element.preCode == cardScannerData.cardNumber!.substring(0, 6));
            if (cardScannerData.isSuccess == true && cardScannerData.cardNumber != null && bankDataItem != null) {
              cardDestinationController.text = cardScannerData.cardNumber!;
              update();
            } else {
              SnackBarUtil.showSnackBar(
                title: locale.announcement,
                message: locale.card_scan_failed,
              );
            }
          },
        ));
  }
}
