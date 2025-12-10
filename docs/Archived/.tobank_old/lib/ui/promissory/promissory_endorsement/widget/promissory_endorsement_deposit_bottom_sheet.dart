import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_endorsement_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/promissory_deposit_item_widget.dart';

class PromissoryEndorsementDepositBottomSheet extends StatelessWidget {
  const PromissoryEndorsementDepositBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PromissoryEndorsementController>(
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
                  const SizedBox(height: 24.0),
                  Text(
                    locale.select_deposit_for_promissory,
                    style: ThemeUtil.titleStyle,
                  ),
                  if (controller.depositList.isEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                          height: 100,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.no_deposit_found_personal_branch,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                      ],
                    )
                  else
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        itemBuilder: (context, index) {
                          return PromissoryDepositItemWidget(
                            deposit: controller.depositList[index],
                            selectedDeposit: controller.selectedDeposit,
                            setSelectedDepositFunction: (deposit) {
                              controller.setSelectedDeposit(deposit);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: controller.depositList.length),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateDepositPage();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.continue_label,
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
