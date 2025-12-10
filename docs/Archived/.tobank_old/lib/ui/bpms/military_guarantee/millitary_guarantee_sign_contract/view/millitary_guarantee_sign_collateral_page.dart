import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_sign_contracts_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/contract/contract_widget.dart';

class MillitaryGuaranteeSignCollateralPage extends StatelessWidget {
  const MillitaryGuaranteeSignCollateralPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MillitaryGuaranteeSignContractsController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.contract_acceptance_tosigh,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ContractWidget(
                  rejectReason: null,
                  pdfData: base64Decode(controller.unsignedCollateralBase64!),
                  previewFunction: () => controller.showCollateralPreviewScreen(),
                  shareFunction: () => controller.shareCollateralPdf(),
                ),
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.signCollateralDocument();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.digital_signature,
              ),
            ],
          ),
        );
      },
    );
  }
}
