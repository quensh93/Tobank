import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controller/bpms/military_guarantee/military_guarantee_start_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../common/key_value_widget.dart';

class MilitaryGuaranteePersonInfoConfirmPage extends StatelessWidget {
  const MilitaryGuaranteePersonInfoConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeStartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      Text(
                        locale.mashmol_information,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.full_name,
                        valueString: controller.personName(),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8.0),
                      KeyValueWidget(
                        keyString: locale.national_code_title,
                        valueString: controller.personNationalCodeController.text,
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8.0),
                      KeyValueWidget(
                        keyString: locale.birthdate_label,
                        valueString: controller.personBirthDateController.text,
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8.0),
                      KeyValueWidget(
                        keyString: locale.mobile_number,
                        valueString: controller.personMobileController.text,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.validatePersonInfoConfirmPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.confirm_continue,
              ),
            ],
          ),
        );
      },
    );
  }
}
