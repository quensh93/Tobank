import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import 'gift_card_item_date.dart';
import 'gift_card_item_hour.dart';

class GiftCardSelectDateBottomSheet extends StatelessWidget {
  const GiftCardSelectDateBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
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
                  Text(locale.select_gift_delivery_date, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                   locale.delivery_date,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 3.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(controller.deliveryDateList!.length, (index) {
                      return GiftCardItemDateWidget(
                        deliveryDate: controller.deliveryDateList![index],
                        selectedDate: controller.selectedDate,
                        index: index,
                        returnSelectedFunction: (index) {
                          controller.selectDate(index);
                        },
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                   locale.delivery_time_range,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (controller.selectedDate == null && controller.deliveryTimeList!.isEmpty)
                    Center(
                      child: Text(
                        locale.no_date_selected,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    controller.selectedDate != null && controller.deliveryTimeList!.isEmpty
                        ? Center(
                            child: Text(
                              locale.no_time_available_for_date,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Wrap(
                            spacing: 8,
                            children: List.generate(controller.deliveryTimeList!.length, (index) {
                              return GiftCardItemHourWidget(
                                deliveryTime: controller.deliveryTimeList![index],
                                value: index,
                                groupValue: controller.selectedTime,
                                onChanged: (int? newValue) {
                                  controller.selectTIme(newValue!);
                                },
                              );
                            }),
                          ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateSeventhPage();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.confirmation,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
