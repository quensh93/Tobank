import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_guarantee_controller.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';

class PromissoryGuaranteeSignPage extends StatelessWidget {
  const PromissoryGuaranteeSignPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryGuaranteeController>(
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
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  fontFamily: 'IranYekan',
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
