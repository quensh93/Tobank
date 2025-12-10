import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/azki_loan/azki_loan_controller.dart';
import '../../../../util/app_theme.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/contract/signed_contract_widget.dart';

class AzkiLoanResultPage extends StatelessWidget {
  const AzkiLoanResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AzkiLoanController>(
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
                      const SvgIcon(
                        SvgIcons.transactionSuccess,
                      ),
                      const SizedBox(height: 16.0),
                       Text(
                        locale.successful_request,
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
                          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                          child: Text(
                            controller.submitAzkiLoanContractResponseModel!.message!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      if (controller.submitAzkiLoanContractResponseModel!.data!.loan!.contract != null) ...[
                        const SizedBox(height: 24.0),
                        SignedContractWidget(
                          pdfTitle: locale.contract_loan_pdf_azki,
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
                buttonTitle: locale.return_to_other_services,
              ),
            ],
          ),
        );
      },
    );
  }
}
