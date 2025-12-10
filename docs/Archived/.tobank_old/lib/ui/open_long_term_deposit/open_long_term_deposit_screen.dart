import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/deposit/open_long_term_deposit_controller.dart';
import '../../../model/deposit/response/deposit_type_response_data.dart';
import '../common/custom_app_bar.dart';
import 'view/open_long_term_deposit_description_page.dart';
import 'view/open_long_term_deposit_result_page.dart';
import 'view/open_long_term_deposit_rule_page.dart';
import 'view/open_long_term_deposit_source_selector_page.dart';

class OpenLongTermDepositScreen extends StatelessWidget {
  const OpenLongTermDepositScreen({
    required this.selectedDepositType,
    this.branchCode,
    super.key,
  });

  final DepositType selectedDepositType;
  final int? branchCode;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenLongTermDepositController>(
      init: OpenLongTermDepositController(selectedDepositType: selectedDepositType, branchCode: branchCode),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.open_term_deposit,
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
                            OpenLongTermDepositDescriptionPage(),
                            OpenLongTermDepositRulePage(),
                            OpenLongTermDepositSourceSelectorPage(),
                            OpenLongTermDepositResultPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
