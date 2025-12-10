import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_list_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/persian_date.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/button/previous_button_widget.dart';
import '../../../common/key_value_widget.dart';

class GiftCardDetailViewWidget extends StatelessWidget {
  const GiftCardDetailViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardListController>(builder: (controller) {
      String? persianDateString;
      if (controller.selectedPhysicalGiftCardData!.delivery!.date!.deliveryDate != null) {
        final PersianDate persianDate = PersianDate();
        persianDateString = persianDate.parseToFormat(
            controller.selectedPhysicalGiftCardData!.delivery!.date!.deliveryDate!
                .toIso8601String()
                .split('+')[0]
                .split('.')[0],
            'd MM yyyy');
      } else {
        persianDateString = ' ';
      }
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KeyValueWidget(
                      keyString: locale.tracking_number_label,
                      valueString: controller.selectedPhysicalGiftCardData!.id.toString(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.total_amount,
                      valueString: locale.amount_format(AppUtil.formatMoney(controller.getAllAmount())),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.each_card_amount,
                      valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedPhysicalGiftCardData!.balance)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.cards_count,
                      valueString: '${controller.selectedPhysicalGiftCardData!.quantity.toString()} ${locale.digit}',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.card_issuance_fee,
                      valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedPhysicalGiftCardData!.chargeAmount)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.delivery_cost,
                      valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedPhysicalGiftCardData!.deliveryCost)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.gift_card_type,
                      valueString: controller.selectedPhysicalGiftCardData!.eventTitle ?? '',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.recipient_name,
                      valueString: controller.selectedPhysicalGiftCardData!.receiverFullname ?? '',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.recipient_mobile,
                      valueString: controller.selectedPhysicalGiftCardData!.receiverMobile ?? '',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (controller.hasDelivery())
                      KeyValueWidget(
                        keyString: locale.delivery_date,
                        valueString: persianDateString ?? '',
                      )
                    else
                      Container(),
                    if (controller.hasDelivery())
                      const SizedBox(
                        height: 16.0,
                      )
                    else
                      Container(),
                    if (controller.hasDelivery())
                      KeyValueWidget(
                        keyString: locale.delivery_time,
                        valueString:
                            '${controller.selectedPhysicalGiftCardData!.delivery!.time!.fromHour} - ${controller.selectedPhysicalGiftCardData!.delivery!.time!.toHour}',
                      )
                    else
                      Container(),
                    if (controller.hasDelivery())
                      const SizedBox(
                        height: 16.0,
                      )
                    else
                      Container(),
                    Text(
                      locale.recipient_address,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      controller.selectedPhysicalGiftCardData!.receiverAddress!,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ContinueButtonWidget(
              callback: () {
                controller.showCardDetailBottomSheet();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.preview_card,
            ),
            const SizedBox(
              height: 16.0,
            ),
            PreviousButtonWidget(
              callback: () {
                AppUtil.previousPageController(controller.pageController, controller.isClosed);
              },
              buttonTitle: locale.return_,
              isLoading: controller.isLoading,
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      );
    });
  }
}
