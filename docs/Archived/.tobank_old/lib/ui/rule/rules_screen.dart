import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/rule/rule_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'view/rules_page.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({required this.isFirst, super.key});

  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<RuleController>(
          init: RuleController(isFirst: isFirst),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.rules_and_regulations,
                context: context,
                hideSupport: isFirst,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.initGet();
                            },
                          ),
                          const RulesPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
