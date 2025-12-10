import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_contract_controller.dart';
import '../../../common/contract/contract_widget.dart';

class ParsaLoanSignContractPage extends StatelessWidget {
  const ParsaLoanSignContractPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanContractController>(
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
                  rejectReason: null,
                  pdfData: base64Decode(controller.loanDetail!.unsignedContract!),
                  previewFunction: () => controller.showPreviewScreen(),
                  shareFunction: () => controller.sharePdf(),
                  showShare: false,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.showConfirmationBottomSheet();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
