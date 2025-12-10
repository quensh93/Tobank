import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';

class TransferAmountController extends GetxController {
  PageController pageController = PageController();
  final Deposit? deposit;

  TransferTypeEnum currentTransferType = TransferTypeEnum.iban;

  bool isHideTabView = false;

  TransferAmountController({this.deposit});

  void setCurrentTransferType(TransferTypeEnum transferType) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (transferType == TransferTypeEnum.card) {
      if (isAvailableCard()) {
        currentTransferType = transferType;
        AppUtil.gotoPageController(pageController: pageController, page: 1, isClosed: isClosed);
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.only_for_deposits_with_active_bank_cards,
        );
      }
    } else {
      currentTransferType = transferType;
      AppUtil.gotoPageController(pageController: pageController, page: 0, isClosed: isClosed);
    }
    update();
  }

  bool isAvailableCard() {
    return deposit!.cardInfo != null && deposit!.cardInfo!.status == 1;
  }

  void setIsHideTabView(bool hideTabView) {
    isHideTabView = hideTabView;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
