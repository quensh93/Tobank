import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_settlement_controller.dart';
import '../../../../model/promissory/promissory_list_info.dart';
import '../../common/custom_app_bar.dart';
import 'page/promissory_settlement_confirm_page.dart';
import 'page/promissory_settlement_final_page.dart';
import 'page/promissory_settlement_sign_page.dart';

class PromissorySettlementScreen extends StatelessWidget {
  const PromissorySettlementScreen({
    required this.promissoryInfo,
    super.key,
  });

  final PromissoryListInfo promissoryInfo;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PromissorySettlementController>(
        init: PromissorySettlementController(promissoryInfo: promissoryInfo),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.full_settlement_of_promissory,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          PromissorySettlementConfirmPage(),
                          PromissorySettlementSignPage(),
                          PromissorySettlementFinalPage(),
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
