import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/destination_notebook/destination_notebook_controller.dart';
import '../../util/enums_constants.dart';
import '../common/custom_app_bar.dart';
import '../common/selector_item_widget.dart';
import 'card_notebook/card_notebook_page.dart';
import 'deposit_notebook/page/deposit_notebook_page.dart';
import 'deposit_notebook/page/iban_notebook_page.dart';

class DestinationNotebookScreen extends StatelessWidget {
  const DestinationNotebookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DestinationNotebookController>(
        init: DestinationNotebookController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.contact,
              context: context,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  Card(
                    elevation: Get.isDarkMode ? 1 : 0,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    shadowColor: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SelectorItemWidget(
                            title: locale.card,
                            isSelected: controller.currentDepositScreenType == DestinationType.card,
                            callBack: () {
                              controller.selectCard();
                            },
                          ),
                        ),
                        Container(
                          height: 24.0,
                          width: 2.0,
                          color: context.theme.dividerColor,
                        ),
                        Expanded(
                          child: SelectorItemWidget(
                            title: locale.deposit,
                            isSelected: controller.currentDepositScreenType == DestinationType.deposit,
                            callBack: () {
                              controller.selectDeposit();
                            },
                          ),
                        ),
                        Container(
                          height: 24.0,
                          width: 2.0,
                          color: context.theme.dividerColor,
                        ),
                        Expanded(
                          child: SelectorItemWidget(
                            title: locale.shaba,
                            isSelected: controller.currentDepositScreenType == DestinationType.iban,
                            callBack: () {
                              controller.selectIban();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const <Widget>[
                        CardNotebookPage(),
                        DepositNotebookPage(),
                        IbanNotebookPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
