import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/report_main_controller.dart';
import '../../../util/enums_constants.dart';
import '../../common/selector_item_widget.dart';
import '../card_board/card_board_page.dart';
import '../process/process_page.dart';

class ReportMainPage extends StatelessWidget {
  const ReportMainPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ReportMainController>(
        init: ReportMainController(),
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 16.0),
              Card(
                elevation: Get.isDarkMode ? 1 : 0,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                shadowColor: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SelectorItemWidget(
                        title: locale.cartable,
                        isSelected: controller.currentHistoryCardScreen == ReportPageType.cardBoard,
                        callBack: () {
                          controller.selectCardBoard();
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
                        title: locale.activity_history,
                        isSelected: controller.currentHistoryCardScreen == ReportPageType.process,
                        callBack: () {
                          controller.selectProcess();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    CardboardPage(),
                    ProcessPage(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
