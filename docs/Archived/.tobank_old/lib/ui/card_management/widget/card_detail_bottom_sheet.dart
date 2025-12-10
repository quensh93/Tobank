import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class CardDetailBottomSheet extends StatelessWidget {
  const CardDetailBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
        builder: (controller) {
          final customerCard = controller.selectedCustomerCard;

          if (customerCard == null) {
            return  Center(child: Text(locale.no_card_selected));
          }

          print('📌 Rebuilding CardDetailBottomSheet for card: ${customerCard.cardNumber}, isDefault: ${customerCard.isDefault}');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: context.theme.dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(locale.detail, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Card(
                          elevation: Get.isDarkMode ? 1 : 0,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              Get.isDarkMode ? SvgIcons.cardDefaultDark : SvgIcons.cardDefault,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                         Expanded(
                          child: Text(locale.select_default_card,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        controller.isDefaultLoading
                            ? SpinKitFadingCircle(
                                itemBuilder: (_, int index) => DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.theme.colorScheme.secondary,
                                  ),
                                ),
                                size: 24.0,
                              )
                            : Container(
                                color: Colors.transparent,
                                width: 32.0,
                                height: 20.0,
                                child: Transform.scale(
                                  scale: 0.7,
                                  transformHitTests: false,
                                  child: CupertinoSwitch(
                                    activeColor: context.theme.colorScheme.secondary,
                                    value: customerCard.isDefault ?? false,
                                    onChanged: (bool value) {
                                      print('📌 Switch toggled to: $value for card: ${customerCard.cardNumber}');
                                      controller.setDefaultCard(value, customerCard);
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: InkWell(
                    onTap: () => controller.showEditCardScreen(customerCard),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Card(
                            elevation: Get.isDarkMode ? 1 : 0,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.cardEditDark : SvgIcons.cardEdit,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                           Text(locale.edit_card,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!controller.isGardeshgary)
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: context.theme.dividerColor),
                        ),
                        child: InkWell(
                          onTap: () => controller.confirmDeleteCard(customerCard),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Card(
                                  elevation: Get.isDarkMode ? 1 : 0,
                                  margin: EdgeInsets.zero,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgIcon(
                                      Get.isDarkMode ? SvgIcons.cardDeleteDark : SvgIcons.cardDelete,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                 Text(locale.delete_card,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
