import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_endorsement_controller.dart';
import '../../../../model/promissory/promissory_list_info.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/promissory_endorsement_confirm_page.dart';
import 'page/promissory_endorsement_final_page.dart';
import 'page/promissory_endorsement_issuer_page.dart';
import 'page/promissory_endorsement_receiver_page.dart';
import 'page/promissory_endorsement_rule_page.dart';
import 'page/promissory_endorsement_sign_page.dart';

class PromissoryEndorsementScreen extends StatelessWidget {
  const PromissoryEndorsementScreen({required this.promissoryInfo, super.key});

  final PromissoryListInfo promissoryInfo;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<PromissoryEndorsementController>(
          init: PromissoryEndorsementController(promissoryInfo: promissoryInfo),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.promissory_endorsement_title,
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
                                controller.getRulesRequest();
                              },
                            ),
                            const PromissoryEndorsementRulePage(),
                            const PromissoryEndorsementIssuerPage(),
                            const PromissoryEndorsementReceiverPage(),
                            const PromissoryEndorsementConfirmPage(),
                            const PromissoryEndorsementSignPage(),
                            const PromissoryEndorsementFinalPage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
