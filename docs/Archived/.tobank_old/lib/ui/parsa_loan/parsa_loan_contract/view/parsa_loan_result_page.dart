import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/parsa_loan/parsa_loan_contract_controller.dart';
import '../../../../../util/app_theme.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/contract/signed_contract_widget.dart';

class ParsaLoanResultPage extends StatelessWidget {
  const ParsaLoanResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanContractController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_transaction_success.svg',
                      ),
                      const SizedBox(height: 16.0),
                       Text(
                        locale.documents_completed_successfully,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppTheme.successColor,
                        ),
                      ),
                      const SizedBox(height: 36.0),
                      Card(
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
                          child: Text(
                            controller.submitParsaLoanContractResponseModel!.message!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ),
                      if (controller.submitParsaLoanContractResponseModel!.data!.loanDetail!.multiSignedContract !=
                          null) ...[
                        const SizedBox(height: 24.0),
                        SignedContractWidget(
                          pdfTitle: locale.parsa_loan_contract_success_message,
                          previewFunction: () => controller.showMultiSignedContractPreviewScreen(),
                          shareFunction: () => controller.shareMultiSignedContractPdf(),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ContinueButtonWidget(
                callback: () {
                  Get.back();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.end,
              ),
            ],
          ),
        );
      },
    );
  }
}
