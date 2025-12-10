import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_select_design_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../common/gift_card_plan_item.dart';

class GiftCardPlanSelectorBottomSheet extends StatelessWidget {
  const GiftCardPlanSelectorBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardSelectDesignController>(
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
                Text(locale.choose_gift_card_design, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      children: List<Widget>.generate(controller.selectedEvent!.plans!.length, (index) {
                        return GiftCardPlanItem(
                          selectedPlan: controller.selectedPlan,
                          plan: controller.selectedEvent!.plans![index],
                          reloadFunction: () {
                            controller.update();
                          },
                          returnSelectedFunction: (plan) {
                            controller.selectPlan(plan);
                          },
                          isLoading: controller.isLoadingMessages,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
