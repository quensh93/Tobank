import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_settlement_gradual_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';

class PromissorySettlementGradualSignPage extends StatelessWidget {
  const PromissorySettlementGradualSignPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissorySettlementGradualController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Expanded(child: Container()),
              const SvgIcon(
                SvgIcons.signPdf,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.instruction_text_promissory_signature,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  height: 1.6,
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.showConfirmDialog();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.promissory_signature,
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
