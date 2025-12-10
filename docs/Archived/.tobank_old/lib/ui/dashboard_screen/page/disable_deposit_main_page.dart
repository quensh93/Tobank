import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/home_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/banner_view.dart';
import '../widget/customer_club_widget.dart';

class DisableDepositMainPage extends StatelessWidget {
  const DisableDepositMainPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<HomeController>(builder: (controller) {
      // ignore: prefer_final_locals
      var authenticationStatusItem = controller.getAuthenticationStatusItem();
      return SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              margin: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  authenticationStatusItem.description,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ContinueButtonWidget(
                                  isLoading: false,
                                  callback: () {
                                    controller.handleAuthenticationStatusButton(
                                        eventCode: authenticationStatusItem.eventCode);
                                  },
                                  buttonTitle: authenticationStatusItem.buttonTitle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    Get.isDarkMode ? SvgIcons.transactionDark : SvgIcons.transaction,
                                    colorFilter:
                                        ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                                    size: 28.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                locale.deposit_turn_over,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: context.theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                          if (controller.mainController.activateIncreaseDepositBalance)
                            Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgIcon(
                                      Get.isDarkMode ? SvgIcons.receiveAmountDark : SvgIcons.receiveAmount,
                                      colorFilter:
                                          ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  locale.deposit_money,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: context.theme.disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          Column(
                            children: [
                              Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    Get.isDarkMode ? SvgIcons.transferAmountDark : SvgIcons.transferAmount,
                                    colorFilter:
                                        ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                                    size: 28.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                locale.transfer_money,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: context.theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.copy,
                                    colorFilter:
                                        ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                                    size: 28.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                locale.more,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: context.theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: Text(
              locale.tobank_special_services,
              style: context.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700, color: context.theme.disabledColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: [
              Expanded(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: context.theme.dividerColor,
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgIcon(
                              Get.isDarkMode ? SvgIcons.creditCardDark : SvgIcons.creditCard,
                              colorFilter: ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                              size: 24.0,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              locale.loan_types,
                              style: TextStyle(
                                color: context.theme.disabledColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          locale.loan_types_description,
                          style: TextStyle(
                            color: context.theme.disabledColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: context.theme.dividerColor,
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgIcon(
                              Get.isDarkMode ? SvgIcons.promissoryDark : SvgIcons.promissory,
                              colorFilter: ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                              size: 24.0,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                             locale.other_services,
                              style: TextStyle(
                                color: context.theme.disabledColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          locale.other_services_description,
                          style: TextStyle(
                            color: context.theme.disabledColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 24.0,
          ),
          BannerView(
            bannerData: controller.mainController.menuDataModel.bannerData,
            handleBannerClick: AppUtil.handleBannerClick,
          ),
          CustomerClub(
            showCustomerClubScreen: controller.showCustomerClubScreen,
          ),
          const SizedBox(height: 8.0),
        ],
      ));
    });
  }
}
