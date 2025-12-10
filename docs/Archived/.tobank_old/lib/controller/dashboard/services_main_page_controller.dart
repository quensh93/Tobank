import 'dart:async';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../model/common/menu_data_model.dart';
import '../../new_structure/core/entities/enums.dart';
import '../../new_structure/features/charge_and_package/presentation/pages/sim_list_main_page.dart';
import '../../ui/acceptor/acceptor_screen.dart';
import '../../ui/card_balance/card_balance_screen.dart';
import '../../ui/card_to_card/card_to_card_screen.dart';
import '../../ui/charity/charity_screen.dart';
import '../../ui/customer_club/customer_club_screen.dart';
import '../../ui/gift_card/list_gift_card/gift_card_main_screen.dart';
import '../../ui/honar_ticket/honar_ticket_screen.dart';
import '../../ui/invoice/invoice_screen.dart';
import '../../ui/iran_tic/iran_tic_screen.dart';
import '../../ui/mega_gasht/mega_gasht_screen.dart';
import '../../ui/pichak/pichak_screen.dart';
import '../../ui/shahkar_check/shahkar_check_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ServicesMainPageController extends GetxController {
  MainController mainController = Get.find();
  static const String eventName = 'Dashboard_Click_Event';

  Future<void> handleMenuItemClick(MenuItemData menuItemData) async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (menuItemData.isDisable!) {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: menuItemData.message ?? locale.selected_service_unavailable,
      );
      return;
    }
    // if (menuItemData.requireCard!) {
    //   if (mainController.walletDetailData!.data!.hasAnyCards == false) {
    //     _showSubmitCardDialog();
    //     return;
    //   }
    // }

    if (menuItemData.requireNationalCode!) {
      if (mainController.authInfoData!.nationalCode == null ||
          mainController.authInfoData!.nationalCode!.isEmpty) {
        DialogUtil.submitShahkarDialog(
            buildContext: Get.context!,
            showShahkarScreenFunction: () {
              Get.back();
              Timer(Constants.duration200, () {
                Get.to(() => const ShahkarCheckScreen());
              });
            });
        return;
      }
    }
    if (menuItemData.uuid == DataConstants.cardToCardService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'CardToCardScreen'});
      await Get.to(() => CardToCardScreen(
            menuItemData: menuItemData,
          ));
    } else if (menuItemData.uuid == DataConstants.cardBalanceService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'CardBalanceScreen'});
      Get.to(() => CardBalanceScreen(
            menuItemData: menuItemData,
          ));
    } else if (menuItemData.uuid == DataConstants.simChargeService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'ChargeSimScreen'});

      ///todo: goto new charge page
      // await Get.to(() => SimChargeScreen(
      //       menuItemData: menuItemData,
      //     ));
      await Get.to(() => const SimListMainPage(
            chargeAndPackageType: ChargeAndPackageType.CHARGE,
          ));
    } else if (menuItemData.uuid == DataConstants.internetService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'InternetScreen'});
      // await Get.to(() => InternetScreen(
      //       menuItemData: menuItemData,
      //     ));
      await Get.to(() => const SimListMainPage(
            chargeAndPackageType: ChargeAndPackageType.INTERNET,
          ));
    } else if (menuItemData.uuid == DataConstants.giftCardService) {
      mainController.analyticsService
          .logEvent(name: eventName, parameters: {'value': 'PhysicalGiftCardScreen'});
      await Get.to(() => GiftCardMainScreen(
            menuItemData: menuItemData,
          ));
    } else if (menuItemData.uuid == DataConstants.charityService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'CharityScreen'});
      await Get.to(() => CharityScreen(
            menuItemData: menuItemData,
          ));
    } else if (menuItemData.uuid == DataConstants.invoiceService) {
      mainController.analyticsService
          .logEvent(name: eventName, parameters: {'value': 'InvoiceListBillScreen'});
      await Get.to(() => InvoiceScreen(
            menuItemData: menuItemData,
          ));
    } else if (menuItemData.uuid == DataConstants.paymentAcceptorService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'AcceptorScreen'});
      await Get.to(() => AcceptorScreen(
            menuItemData: menuItemData,
          ));
    } else if (menuItemData.uuid == DataConstants.pichakService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'PichakScreen'});
      await Get.to(() => PichakScreen(menuItemData: menuItemData));
    } else if (menuItemData.uuid == DataConstants.megagashtService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'MegaGashtScreen'});
      Get.to(() => MegaGashtScreen(menuItemData: menuItemData));
    } else if (menuItemData.uuid == DataConstants.customerClubService) {
      mainController.analyticsService
          .logEvent(name: eventName, parameters: {'value': 'CustomerClubMenuScreen'});
      await Get.to(() => CustomerClubScreen(menuItemData: menuItemData));
    } else if (menuItemData.uuid == DataConstants.iranTicService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'IranTicScreen'});
      await Get.to(() => IranTicScreen(menuItemData: menuItemData));
    } else if (menuItemData.uuid == DataConstants.iranConcertService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'IranConcertScreen'});
      AppUtil.launchInBrowser(url: Constants.iranConcertUrl);
    } else if (menuItemData.uuid == DataConstants.honarTicketService) {
      mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'HonarTicketScreen'});
      await Get.to(() => HonarTicketScreen(menuItemData: menuItemData));
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: locale.service_unavailable_,
      );
    }
  }

  // void _showSubmitCardDialog() {
  //   DialogUtil.showSubmitCardDialog(Get.context!, () async {
  //     Get.back();
  //     await Get.to(() => const AddCardScreen());
  //   });
  // }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
