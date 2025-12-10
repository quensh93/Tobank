import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_collateral_type_controller.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../military_guarantee_deposit_type_item_widget.dart';

class MilitaryGuaranteeCollateralTypeDepositTypePage extends StatelessWidget {
  const MilitaryGuaranteeCollateralTypeDepositTypePage({
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
                    locale.collateral_deposit_type,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.please_select_collateral_deposit_type,
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
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    itemBuilder: (context, index) {
                      return MilitaryGuaranteeDepositTypeItemWidget(
                        militaryGuaranteeDepositTypeData: AppUtil.getMilitaryGuaranteeDepositTypeList()[index],
                        selectedMilitaryGuaranteeDepositTypeData: controller.selectedCollateralDepositType,
                        returnDataFunction: (depositType) {
                          controller.setSelectedCollateralDepositType(depositType);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: AppUtil.getMilitaryGuaranteeDepositTypeList().length),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateCollateralDepositType();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.continue_label,
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
