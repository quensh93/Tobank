import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_guarantee_controller.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/promissory_guarantee_confirm_page.dart';
import 'page/promissory_guarantee_final_page.dart';
import 'page/promissory_guarantee_info_page.dart';
import 'page/promissory_guarantee_sign_page.dart';

class PromissoryGuaranteeScreen extends StatelessWidget {
  const PromissoryGuaranteeScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PromissoryGuaranteeController>(
        init: PromissoryGuaranteeController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString:locale.guarantee_promissory_note,
              context: context,
            ),
            body: SafeArea(
              child: PopScope(
                canPop: false,
                onPopInvoked: controller.onBackPress,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          VirtualBranchLoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getCustomerInfoRequest();
                            },
                          ),
                          const PromissoryGuaranteeInfoPage(),
                          const PromissoryGuaranteeConfirmPage(),
                          const PromissoryGuaranteeSignPage(),
                          const PromissoryGuaranteeFinalPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
