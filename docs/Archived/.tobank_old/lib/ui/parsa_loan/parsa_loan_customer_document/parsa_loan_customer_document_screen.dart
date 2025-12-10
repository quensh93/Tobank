import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/parsa_loan/parsa_loan_customer_document_controller.dart';
import '../../common/custom_app_bar.dart';
import 'view/parsa_loan_required_document_list_page.dart';
import 'view/parsa_loan_upload_document_page.dart';

class ParsaLoanCustomerDocumentScreen extends StatelessWidget {
  final String trackingNumber;

  const ParsaLoanCustomerDocumentScreen({
    required this.trackingNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanCustomerDocumentController>(
      init: ParsaLoanCustomerDocumentController(trackingNumber: trackingNumber),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: CustomAppBar(
              titleString: locale.parsa_facilities,
              context: context,
            ),
            body: SafeArea(
              child: Container(
                color: context.theme.colorScheme.surface,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          ParsaLoanRequiredDocumentListPage(),
                          ParsaLoanUploadDocumentPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
