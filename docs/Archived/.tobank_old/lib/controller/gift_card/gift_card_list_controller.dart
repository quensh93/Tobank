import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/gift_card/response/costs_data.dart';
import '../../model/gift_card/response/list_gift_card_data.dart';
import '../../service/core/api_core.dart';
import '../../service/gift_card_services.dart';
import '../../ui/gift_card/gift_card_screen.dart';
import '../../ui/gift_card/list_gift_card/widget/gift_card_confirm_rule_bottom_sheet.dart';
import '../../ui/gift_card/page/gift_card_preview_bottom_sheet.dart';
import '../../ui/rule/rules_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class GiftCardListController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoad = false;
  bool isLoading = false;
  PhysicalGiftCardData? selectedPhysicalGiftCardData;
  List<PhysicalGiftCardData> physicalGiftCardDataList = [];

  String errorTitle = '';

  bool hasError = false;

  CostsData? costsData;

  bool isValidateData = true;

  bool confirmRules = false;

  int openBottomSheets = 0;

  bool showAddButton = true;

  @override
  void onInit() {
    getGiftCardListRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves a list of available physical gift cards.
  /// If successful, it updates the [physicalGiftCardDataList] with the retrieved data
  void getGiftCardListRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    GiftCardServices.getListPhysicalGiftCardRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ListPhysicalGiftCardData response, int _)):
          physicalGiftCardDataList = response.data!.results ?? [];
          isLoad = true;
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

  void showDetailFunction(PhysicalGiftCardData physicalGiftCardData) {
    selectedPhysicalGiftCardData = physicalGiftCardData;
    update();
    AppUtil.nextPageController(pageController, isClosed);
  }

  /// Calculates the total amount for a selected physical gift card,including charges and delivery.
  int getAllAmount() {
    int sum = selectedPhysicalGiftCardData!.balance! * selectedPhysicalGiftCardData!.quantity!;
    sum += selectedPhysicalGiftCardData!.chargeAmount! * selectedPhysicalGiftCardData!.quantity!;
    sum += selectedPhysicalGiftCardData!.deliveryCost!;
    return sum;
  }

  /// Checks if delivery is available for the selected physical gift card based on city and province.
  bool hasDelivery() {
    if (selectedPhysicalGiftCardData!.city == 87 && selectedPhysicalGiftCardData!.province == 8) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> showCardDetailBottomSheet() async {
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
              child: GiftCardPreviewBottomSheet(selectedPhysicalGiftCardData: selectedPhysicalGiftCardData!),
            ));
    openBottomSheets--;
  }

  /// Retrieves cost information for physical gift card purchases and displays a confirmation bottom sheet.
  void getCostsRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    GiftCardServices.getPhysicalCostsRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CostsData response, int _)):
          costsData = response;
          _showConfirmBottomSheet();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showConfirmBottomSheet() async {
    if (isClosed) {
      return;
    }
    confirmRules = false;
    update();
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
        child: const GiftCardConfirmRuleBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void giftCardConfirmRule() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (confirmRules) {
      isValidateData = true;
      if (costsData!.data!.orderQuantity! <= 4) {
        _showGiftCardScreen();
      } else {
        SnackBarUtil.showInfoSnackBar(locale.daily_gift_card_limit_reached);
      }
    } else {
      isValidateData = false;
    }
    update();
  }

  Future<void> _showGiftCardScreen() async {
    _closeBottomSheets();
    await Get.to(() => GiftCardScreen(
          costsData: costsData!,
        ));
    AppUtil.previousPageController(pageController, isClosed);
    Timer(Constants.duration500, () {
      getGiftCardListRequest();
    });
  }

  void setConfirmRules(bool? value) {
    confirmRules = value!;
    update();
  }

  void showRulesScreen() {
    Get.to(
      () => const RulesScreen(
        isFirst: false,
      ),
    );
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void setAddButtonVisible(bool value) {
    showAddButton = value;
    update();
  }
}
