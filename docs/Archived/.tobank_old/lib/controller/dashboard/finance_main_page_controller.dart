import 'dart:async';

import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/menu_data_model.dart';
import '../../ui/daran_screen/daran_screen.dart';
import '../../ui/shahkar_check/shahkar_check_screen.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class FinanceMainPageController extends GetxController {
  MainController mainController = Get.find();
  static const String eventName = 'Dashboard_Click_Event';

  void handleDaranButtonClick(MenuItemData menuItemData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (menuItemData.isDisable!) {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: menuItemData.message ?? locale.selected_service_unavailable,
      );
      return;
    }
    if (menuItemData.requireNationalCode!) {
      print("🔴 Checking national code requirement");
      if (mainController.authInfoData!.nationalCode == null ||
          mainController.authInfoData!.nationalCode!.isEmpty) {
        print("🔴 National code is missing or empty");
        DialogUtil.submitShahkarDialog(
            buildContext: Get.context!,
            showShahkarScreenFunction: () {
              print("🔴 User clicked to proceed to Shahkar verification");
              Get.back();
              Timer(Constants.duration200, () {
                print("🔴 Navigating to ShahkarCheckScreen after delay");
                Get.to(() => const ShahkarCheckScreen());
              });
            });
        print("🔴 Showing Shahkar dialog and stopping execution");
        return;
      }
      print("🔴 National code validation passed");
    }
    if (menuItemData.uuid == DataConstants.daranService) {
      mainController.analyticsService
          .logEvent(name: eventName, parameters: {'value': 'DaranScreen'});
      Get.to(() => DaranScreen(menuItemData: menuItemData));
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: locale.service_unavailable_,
      );
    }
  }
}
