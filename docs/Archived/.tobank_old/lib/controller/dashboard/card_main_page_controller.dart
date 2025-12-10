import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/card/add_card_screen.dart';
import '../../ui/card_management/card_management_screen.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class CardMainPageController extends GetxController {
  MainController mainController = Get.find();
  CustomerCardResponseData? customerCardResponseData;
  List<CustomerCard> customerCardList = [];
  List<BankInfo> bankInfo = [];
  bool isLoading = false;

  String? errorTitle = '';

  bool hasError = false;

  final scrollController = ScrollController();
  double itemHeight = 180.0;
  bool isStartScrolling = false;

  bool showAddButton = true;

  void onListenToScroll() {
    if (scrollController.offset > 50) {
      isStartScrolling = true;
    } else if (scrollController.offset < 50) {
      isStartScrolling = false;
    }
    update();
  }

  @override
  void onInit() {
    scrollController.addListener(onListenToScroll);
    mainController.isCardMainPageControllerInit = true;
    getCustomerCardRequest();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    mainController.isCardMainPageControllerInit = false;
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the customer's card data from the server.
  void getCustomerCardRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    hasError = false;
    update();

    CardServices.getCustomerCardsRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerCardResponseData response, int _)):
          hasError = false;
          customerCardResponseData = response;
          _handleCustomerCardList();
          update();
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

  /// Processes and organizes the customer's card list.
  ///
  /// This function takes the customer's card data retrieved from the server and organizes it into
  /// three categories: enabled Gardeshgari cards, disabled Gardeshgari cards, and other cards.
  void _handleCustomerCardList() {
    final List<CustomerCard> enableGardeshgari = [];
    final List<CustomerCard> disableGardeshgari = [];
    final List<CustomerCard> other = [];
    customerCardList = customerCardResponseData!.data!.cards ?? [];
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
    bankInfo = customerCardResponseData!.data!.bankInfo ?? [];
    customerCardList.insert(0, CustomerCard());
    update();
  }

  void showCardManagementScreen({CustomerCard? customerCard}) {
    Get.to(() => CardManagementScreen(
          customerCardList: customerCardList,
          bankInfoList: bankInfo,
          customerCard: customerCard,
        ));
  }

  Future<void> showAddCardScreen() async {
    await Get.to(() => const AddCardScreen());
    getCustomerCardRequest();
  }

  void setAddButtonVisible(bool value) {
    showAddButton = value;
    update();
  }
}
