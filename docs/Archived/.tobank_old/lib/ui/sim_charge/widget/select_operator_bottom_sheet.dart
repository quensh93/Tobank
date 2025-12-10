import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/sim_charge/sim_charge_controller.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/operator_item_widget.dart';

class SelectOperatorBottomSheet extends StatelessWidget {
  const SelectOperatorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SimChargeController>(
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
                  Text(locale.select_operator, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(locale.porting_operator_instruction,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: DataConstants.getOperatorDataList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return OperatorItemWidget(
                        operatorData: DataConstants.getOperatorDataList()[index],
                        selectedOperatorData: controller.selectedOperatorData,
                        returnDataFunction: (operatorData) {
                          controller.setSelectOperator(operatorData);
                        },
                      );
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
                      controller.validateSelectOperator();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.confirm_continue,
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
