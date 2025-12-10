import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/cbs/cbs_services/cbs_services_controller.dart';
import '../../common/virtual_branch_pay_in_browser.dart';
import 'view/cbs_services_phone_page.dart';
import 'view/cbs_services_verify_code_page.dart';

class CBSServiceScreen extends StatelessWidget {
  const CBSServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CBSServicesController>(
        init: CBSServicesController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const CbsServicesPhonePage(),
                    const CBSServicesVerifyCodePage(),
                    VirtualBranchPayInBrowserWidget(
                      isLoading: controller.isLoading,
                      returnDataFunction: () {
                        controller.validateInternetPayment();
                      },
                      amount: controller.mainController.creditInquiryPrice!,
                      url: controller.creditInquiryInternetResponseData != null
                          ? controller.creditInquiryInternetResponseData!.data!.url
                          : '',
                      titleText: locale.pay_inquiry_fee,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
