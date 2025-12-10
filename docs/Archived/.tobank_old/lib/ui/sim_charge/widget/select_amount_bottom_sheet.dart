import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/sim_charge/sim_charge_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import 'sim_charge_amount_item.dart';
import 'sim_charge_type_item.dart';

class SelectAmountBottomSheet extends StatelessWidget {
  const SelectAmountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SimChargeController>(
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
                Text(locale.select_charge_type_and_amount, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                if (controller.chargeTypeList.length > 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locale.choose_charge_type_and_amount,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 1,
                        shadowColor: Colors.transparent,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<Widget>.generate(controller.chargeTypeList.length, (index) {
                              return SimChargeTypeItemWidget(
                                chargeTypeDataSelected: controller.chargeTypeDataSelected,
                                chargeTypeData: controller.chargeTypeList[index],
                                returnDataFunction: (chargeTypeData) {
                                  controller.setChargeTypeData(chargeTypeData);
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Text(locale.select_charge_amount,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                const SizedBox(
                  height: 24.0,
                ),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                  ),
                  children: List<Widget>.generate(controller.chargeAmountList.length, (index) {
                    return SimChargeAmountItemWidget(
                      selectedChargeAmountData: controller.selectedChargeAmountData,
                      chargeAmountData: controller.chargeAmountList[index],
                      returnDataFunction: (chargeAmountData) {
                        controller.setChargeAmountData(chargeAmountData);
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateSelectAmount();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_continue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
