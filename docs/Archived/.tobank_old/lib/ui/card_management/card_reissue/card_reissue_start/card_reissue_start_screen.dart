import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/card_management/card_reissue_start_controller.dart';
import '../../../../model/address/response/address_inquiry_response_data.dart';
import '../../../../model/card/response/customer_card_response_data.dart';
import '../../../common/custom_app_bar.dart';
import 'view/card_reissue_start_card_template_page.dart';
import 'view/card_reissue_start_confirm_page.dart';
import 'view/card_reissue_start_result_page.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class CardReissueStartScreen extends StatelessWidget {
  const CardReissueStartScreen({
    required this.customerCard,
    required this.postalCode,
    required this.customerAddressInquiry,
    super.key,
  });

  final CustomerCard customerCard;
  final AddressInquiryResponseData customerAddressInquiry;
  final String postalCode;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return GetBuilder<CardReissueStartController>(
      init: CardReissueStartController(
        customerCard: customerCard,
        postalCode: postalCode,
        customerAddressInquiryResponseData: customerAddressInquiry,
      ),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.issuing_duplicate_card,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          CardReissueStartConfirmPage(),
                          CardReissueStartCardTemplatePage(),
                          CardReissueStartResultPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
