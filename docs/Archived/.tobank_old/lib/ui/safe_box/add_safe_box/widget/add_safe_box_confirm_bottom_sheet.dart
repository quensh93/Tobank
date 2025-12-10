import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/ui/dotted_separator_widget.dart';
import '../../../common/key_value_widget.dart';

class AddSafeBoxConfirmBottomSheet extends StatelessWidget {
  const AddSafeBoxConfirmBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AddSafeBoxController>(
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
                Text(locale.confirm_selection_message, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Card(
                  elevation: Get.isDarkMode ? 1 : 0,
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
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString:locale.customer_number,
                          valueString: controller.mainController.authInfoData!.customerNumber!,
                        ),
                        const DottedSeparatorWidget(),
                        KeyValueWidget(
                          keyString: locale.selected_branch,
                          valueString:
                              '${controller.selectedBranchResult!.city!.name!} - ${controller.selectedBranchResult!.title!}',
                        ),
                        const DottedSeparatorWidget(),
                        KeyValueWidget(
                          keyString: locale.box_type,
                          valueString: controller.selectedFund!.type!.titleFa!,
                        ),
                        const DottedSeparatorWidget(),
                        KeyValueWidget(
                          keyString: locale.dimensions,
                          valueString: controller.selectedFund!.volume!,
                        ),
                        const DottedSeparatorWidget(),
                        KeyValueWidget(
                          keyString: locale.annual_rent,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedFund!.rent!)),
                        ),
                        const DottedSeparatorWidget(),
                        KeyValueWidget(
                          keyString: locale.trusteeship_deposit,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedFund!.trust!)),
                        ),
                        const DottedSeparatorWidget(),
                        KeyValueWidget(
                          keyString: locale.value_added_services,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedFund!.fee!)),
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
                    controller.getWalletDetailRequest();
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
