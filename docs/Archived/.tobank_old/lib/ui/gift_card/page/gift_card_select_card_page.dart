import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../widget/gift_card_item_select.dart';

class GiftCardSelectCardPage extends StatelessWidget {
  const GiftCardSelectCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Text(locale.select_gift_card_amount, style: ThemeUtil.titleStyle),
                        const SizedBox(width: 4.0),
                        InkWell(
                          onTap: () {
                            controller.showHelpBottomSheet();
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgIcon(
                              SvgIcons.info,
                              colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.physicalGiftCardDataRequest.cards!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GiftCardItemSelectWidget(
                          cardInfo: controller.physicalGiftCardDataRequest.cards![index],
                          mainIndex: index,
                          gitCardItemDataList: controller.giftCardAmountItemList,
                          returnDataFunction: (cardInfo, int mainIndex) {
                            controller.showAmountBottomSheet(cardInfo, mainIndex);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        controller.addDefaultCardToList();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgIcon(
                              SvgIcons.addGiftCard,
                              colorFilter: ColorFilter.mode(Get.context!.theme.colorScheme.primary, BlendMode.srcIn),
                              size: 24.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              locale.add_card_with_new_amount,
                              style: ThemeUtil.titleStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ContinueButtonWidget(
              callback: () {
                controller.validateSecondPage();
              },
              isEnabled: controller.physicalGiftCardDataRequest.cards!.isNotEmpty,
              isLoading: controller.isLoading,
              buttonTitle: locale.continue_label,
            ),
          ),
        ],
      );
    });
  }
}
