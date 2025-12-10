import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/open_long_term_deposit_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class OpenLongTermDepositDescriptionPage extends StatelessWidget {
  const OpenLongTermDepositDescriptionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenLongTermDepositController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.term_deposit_instructions,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              Text(
                locale.initial_deposit_requirement,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.validateFirstPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.start_deposit_process_button,
              ),
            ],
          ),
        );
      },
    );
  }
}
