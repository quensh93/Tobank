import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/tracking_credit_controller.dart';
import '../../common/custom_app_bar.dart';
import 'view/tracking_credit_inquiry_cheque_info_page.dart';
import 'view/tracking_credit_inquiry_result_page.dart';

class TrackingInquiryScreen extends StatelessWidget {
  const TrackingInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<TrackingCreditController>(
        init: TrackingCreditController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.issued_cheques_inquiry,
              context: context,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: const [
                        TrackingInquiryChequeInfoPage(),
                        TrackingInquiryResultPage(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
