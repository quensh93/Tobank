import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_collateral_type_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../military_guarantee_deposit_item_widget.dart';

class MilitaryGuaranteeCollateralTypeCollateralDepositPage extends StatelessWidget {
  const MilitaryGuaranteeCollateralTypeCollateralDepositPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeCollateralTypeController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    locale.select_collateral_deposit_account,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.select_collateral_deposit_explanation,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: controller.collateralDepositList.isEmpty
                    ? Column(
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
                            locale.no_collateral_deposit_found,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        itemBuilder: (context, index) {
                          return MilitaryGuaranteeDepositItemWidget(
                            deposit: controller.collateralDepositList[index],
                            selectedDeposit: controller.selectedCollateralDeposit,
                            setSelectedDepositFunction: (deposit) {
                              controller.setSelectedCollateralDeposit(deposit);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: controller.collateralDepositList.length),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateCollateralDepositPage();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.submit_collateral_button,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
