import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../model/gift_card/request/gift_card_data_request.dart';
import '../../../model/gift_card/response/list_gift_card_amount_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class GiftCardItemSelectWidget extends StatelessWidget {
  const GiftCardItemSelectWidget({
    required this.gitCardItemDataList,
    required this.cardInfo,
    required this.mainIndex,
    required this.returnDataFunction,
    super.key,
  });

  final List<PhysicalGiftCardAmount> gitCardItemDataList;
  final CardInfo cardInfo;
  final int mainIndex;
  final Function(CardInfo cardInfo, int mainIndex) returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: context.theme.dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.theme.dividerColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    returnDataFunction(cardInfo, mainIndex);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            locale.amount_format(AppUtil.formatMoney(cardInfo.balance)),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Text(locale.card_count, style: ThemeUtil.titleStyle),
                  ),
                  InkWell(
                    onTap: () {
                      controller.addQuantityOfGiftCard(mainIndex);
                    },
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgIcon(
                      Get.isDarkMode ? SvgIcons.addSquareDark : SvgIcons.addSquare,
                      size: 30.0,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    width: 24.0,
                    child: Text(
                      cardInfo.quantity.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () {
                      controller.removeQuantity(mainIndex);
                    },
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgIcon(
                      Get.isDarkMode ? SvgIcons.minusSquareDark : SvgIcons.minusSquare,
                      size: 30.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
