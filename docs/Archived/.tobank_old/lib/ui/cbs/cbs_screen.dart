import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/cbs/cbs_controller.dart';
import '../../../util/enums_constants.dart';
import '../common/custom_app_bar.dart';
import '../common/selector_item_widget.dart';
import 'cbs_reports/cbs_reports_screen.dart';
import 'cbs_services/cbs_service_screen.dart';

class CBSScreen extends StatelessWidget {
  const CBSScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CBSController>(
          init: CBSController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.credit_check,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Card(
                            elevation: Get.isDarkMode ? 1 : 0,
                            margin: const EdgeInsets.symmetric(horizontal: 16.0),
                            shadowColor: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SelectorItemWidget(
                                    title: locale.credit_check,
                                    isSelected: controller.cbsMenuType == CBSMenuType.cbsServices,
                                    callBack: () {
                                      controller.showCBSServices();
                                    },
                                  ),
                                ),
                                Container(
                                  height: 24.0,
                                  width: 1.0,
                                  color: context.theme.dividerColor,
                                ),
                                Expanded(
                                  child: SelectorItemWidget(
                                    title: locale.reports,
                                    isSelected: controller.cbsMenuType == CBSMenuType.cbsReports,
                                    callBack: () {
                                      controller.showCBSReports();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            child: Container(
                              color: context.theme.colorScheme.surface,
                              child: PageView(
                                controller: controller.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: const [
                                  CBSServiceScreen(),
                                  CBSReportsScreen(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
