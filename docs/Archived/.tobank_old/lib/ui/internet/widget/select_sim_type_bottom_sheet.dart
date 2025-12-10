import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/internet_plan/internet_plan_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import 'sim_type_item_widget.dart';

class SelectSimTypeBottomSheet extends StatelessWidget {
  const SelectSimTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<InternetPlanController>(
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
                Text(locale.sim_card_type, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.selectedSimTypeList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SimTypeItemWidget(
                        simType: controller.selectedSimTypeList![index],
                        selectedSimType: controller.selectedSimType,
                        returnDataFunction: (simType) {
                          controller.selectSimCardType(simType);
                        });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 12.0,
                    );
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateSimType();
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
