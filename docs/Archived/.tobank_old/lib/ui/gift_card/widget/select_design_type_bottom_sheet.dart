import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class SelectDesignTypeBottomSheet extends StatelessWidget {
  const SelectDesignTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardController>(
        builder: (controller) {
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
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(locale.choose_card_design, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.theme.dividerColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      controller.setDesignType(isCustomValue: false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.giftCardPreparedDark : SvgIcons.giftCardPrepared,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            locale.ready_design,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if(!kIsWeb)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: context.theme.dividerColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          if (controller.isCustomDesignEnable() == true) {
                            controller.setDesignType(isCustomValue: true);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Card(
                                elevation: 1,
                                margin: EdgeInsets.zero,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: controller.isCustomDesignEnable() == true
                                      ? SvgIcon(
                                          Get.isDarkMode ? SvgIcons.giftCardCustomDark : SvgIcons.giftCardCustom,
                                        )
                                      : SvgIcon(
                                          Get.isDarkMode ? SvgIcons.giftCardCustomDark : SvgIcons.giftCardCustom,
                                          colorFilter: ColorFilter.mode(
                                              context.theme.iconTheme.color!.withOpacity(0.4), BlendMode.srcIn),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Text(
                                locale.custom_design,
                                style: TextStyle(
                                  color: controller.isCustomDesignEnable() == true
                                      ? ThemeUtil.textTitleColor
                                      : ThemeUtil.textTitleColor.withOpacity(0.4),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
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
