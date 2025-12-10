import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/retail_loan/retail_loan_sign_contract_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/contract/contract_widget.dart';

class RetailLoanSignContractPage extends StatelessWidget {
  const RetailLoanSignContractPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RetailLoanSignContractController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(locale.contract_acceptance, style: ThemeUtil.titleStyle),
                const SizedBox(height: 16.0),
                ContractWidget(
                  rejectReason: controller.rejectReason,
                  pdfData: base64Decode(controller.getTaskContractDocumentResponse!.data!.base64Data!),
                  previewFunction: () => controller.showPreviewScreen(),
                  shareFunction: () => controller.sharePdf(),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.signDocument();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.digital_signature,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
