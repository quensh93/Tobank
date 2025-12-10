import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../ui/customer_referrals/customer_referrals_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class InviteCustomerController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;
  PageController pageController = PageController();

  String errorTitle = '';
  bool hasError = false;

  @override
  void onInit() {
    isLoading = true;
    update();
    Timer(Constants.duration500, () {
      isLoading = false;
      update();
      AppUtil.nextPageController(pageController, isClosed);
    });
    super.onInit();
  }

  String? getLoyaltyCode() {
    return mainController.authInfoData!.loyaltyCode;
  }

  void showCustomerReferralsScreen() {
    Get.to(() => const CustomerReferralsScreen());
  }

  void shareLoyaltyCode() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.loyaltyCode != null) {
      final String text =
          mainController.advertisementText!.replaceAll('\$\$', mainController.authInfoData!.loyaltyCode!);
      Share.share(text, subject: locale.invite_code_shared);
    }
  }

  void copyToClipboard() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.loyaltyCode != null) {
      final String textForShare =
          mainController.advertisementText!.replaceAll('\$\$', mainController.authInfoData!.loyaltyCode!);
      Clipboard.setData(ClipboardData(text: textForShare));
      SnackBarUtil.showInfoSnackBar(locale.invite_code_copied);
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
