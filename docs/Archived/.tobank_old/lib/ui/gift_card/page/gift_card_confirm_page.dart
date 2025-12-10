import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/key_value_widget.dart';

class GiftCardConfirmPage extends StatelessWidget {
  const GiftCardConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: context.theme.dividerColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locale.gift_card,
                                    style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    locale.amount_format(AppUtil.formatMoney(controller.physicalGiftCardDataRequest.cards![index].balance)),
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${controller.physicalGiftCardDataRequest.cards![index].quantity} ${locale.digit}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(thickness: 1);
                        },
                        itemCount: controller.physicalGiftCardDataRequest.cards!.length,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Card(
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KeyValueWidget(
                            keyString: locale.gift_card_amount,
                            valueString: locale.amount_format(AppUtil.formatMoney(controller.getCardCost())),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          KeyValueWidget(
                            keyString: locale.card_issuance_fee,
                            valueString: locale.amount_format(AppUtil.formatMoney(controller.costsData!.data!.chargeAmount)),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          KeyValueWidget(
                            keyString: locale.delivery_cost,
                            valueString: locale.amount_format(AppUtil.formatMoney(controller.costsData!.data!.deliveryCost)),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          KeyValueWidget(
                            keyString: locale.gift_card_type,
                            valueString: controller.giftCardSelectedDesignData!.selectedEvent!.title ?? '',
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          KeyValueWidget(
                            keyString: locale.recipient_name,
                            valueString: controller.physicalGiftCardDataRequest.receiverFullname!,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          KeyValueWidget(
                            keyString: locale.recipient_mobile,
                            valueString: controller.physicalGiftCardDataRequest.receiverMobile,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          if (controller.hasDeliveryTime)
                            KeyValueWidget(
                              keyString: locale.delivery_date,
                              valueString: controller.physicalGiftCardDataRequest.date,
                            )
                          else
                            Container(),
                          if (controller.hasDeliveryTime)
                            const SizedBox(
                              height: 16.0,
                            )
                          else
                            Container(),
                          if (controller.hasDeliveryTime)
                            KeyValueWidget(
                              keyString: locale.delivery_time,
                              valueString: controller.physicalGiftCardDataRequest.time,
                            )
                          else
                            Container(),
                          if (controller.hasDeliveryTime)
                            const SizedBox(
                              height: 16.0,
                            )
                          else
                            Container(),
                          KeyValueWidget(
                            keyString: locale.recipient_city,
                            valueString: controller.selectedCity!.name,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
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
                            height: 8.0,
                          ),
                          Text(
                            controller.physicalGiftCardDataRequest.receiverAddress!,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style:
                                TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.getWalletDetailRequest();
                },
                isLoading: controller.isLoading,
                buttonTitle: '${locale.payment_button} ${AppUtil.formatMoney(controller.getAllCost())} ${locale.rial}',
              ),
            ],
          ),
        ),
      );
    });
  }
}
