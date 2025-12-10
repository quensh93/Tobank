import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/promissory/promissory_item_data.dart';
import '../../model/promissory/response/promissory_asset_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_finalized_history/promissory_finalized_history_screen.dart';
import '../../ui/promissory/promissory_guarantee/promissory_guarantee_screen.dart';
import '../../ui/promissory/promissory_inquiry/promissory_inquiry_screen.dart';
import '../../ui/promissory/promissory_requests_history/promissory_requests_history_screen.dart';
import '../../ui/promissory/request_promissory/request_promissory_screen.dart';
import '../../util/app_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = true;

  PromissoryMenuType promissoryMenuType = PromissoryMenuType.promissoryServices;

  @override
  void onInit() {
    getPromissoryAssetRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> handleItemClick(PromissoryItemData promissoryItemData) async {
    if (promissoryItemData.eventId == 1) {
      await Get.to(() => const RequestPromissoryScreen());
    } else if (promissoryItemData.eventId == 2) {
      Get.to(() => const PromissoryRequestsHistoryScreen());
    } else if (promissoryItemData.eventId == 3) {
      Get.to(() => const PromissoryFinalizedHistoryScreen());
    } else if (promissoryItemData.eventId == 4) {
      // Get.to(() => const PromissoryEndorsementScreen());
    } else if (promissoryItemData.eventId == 5) {
      Get.to(() => const PromissoryGuaranteeScreen());
    } else if (promissoryItemData.eventId == 6) {
      Get.to(() => const PromissoryInquiryScreen());
    } else if (promissoryItemData.eventId == 7) {
    } else if (promissoryItemData.eventId == 8) {
      // Get.to(() => const PromissorySettlementScreen());
    } else {
      comingSoon();
    }
  }

  void comingSoon() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    SnackBarUtil.showInfoSnackBar(locale.coming_soon);
  }

  void showPromissoryServices() {
    promissoryMenuType = PromissoryMenuType.promissoryServices;
    update();
    AppUtil.previousPageController(pageController, isClosed);
  }

  void showMyPromissory() {
    promissoryMenuType = PromissoryMenuType.myPromissory;
    update();
    AppUtil.nextPageController(pageController, isClosed);
  }

  /// Retrieves the promissory assets and updates the [promissoryAssetResponseData] main controller.
  void getPromissoryAssetRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    PromissoryServices.getPromissoryAssets().then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryAssetResponseData response, int _)):
          mainController.promissoryAssetResponseData = response;
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
    });
  }
}
