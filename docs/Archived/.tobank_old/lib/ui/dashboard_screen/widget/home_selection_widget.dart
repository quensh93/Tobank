import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/home_controller.dart';
import '../../../widget/svg/svg_icon.dart';
import 'selection_item_widget.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class HomeSelectionWidget extends StatelessWidget {
  const HomeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<HomeController>(builder: (controller) {
      return Row(
        children: [
          SelectionItemWidget(
            title: locale.deposits,
            icon: SvgIcons.deposit,
            iconSelected: SvgIcons.depositSelected,
            index: 0,
            selectedTab: controller.selectedTab,
            returnDataFunction: (int index) {
              controller.showPage(index: index);
            },
          ),
          Container(
            height: 24.0,
            width: 2,
            decoration: BoxDecoration(color: context.theme.dividerColor),
          ),
          SelectionItemWidget(
            title: locale.cards,
            icon: SvgIcons.card,
            iconSelected: SvgIcons.cardSelected,
            index: 1,
            selectedTab: controller.selectedTab,
            returnDataFunction: (int index) {
              controller.showPage(index: index);
            },
          ),
          Container(
            height: 24.0,
            width: 2,
            decoration: BoxDecoration(color: context.theme.dividerColor),
          ),
          SelectionItemWidget(
            title: locale.investment_title,
            icon: SvgIcons.finance,
            iconSelected: SvgIcons.financeSelected,
            index: 2,
            selectedTab: controller.selectedTab,
            returnDataFunction: (int index) {
              controller.showPage(index: index);
            },
          ),
          Container(
            height: 24.0,
            width: 2,
            decoration: BoxDecoration(color: context.theme.dividerColor),
          ),
          SelectionItemWidget(
            title: locale.services_title,
            icon: SvgIcons.other,
            iconSelected: SvgIcons.otherSelected,
            index: 3,
            selectedTab: controller.selectedTab,
            returnDataFunction: (int index) {
              controller.showPage(index: index);
            },
          ),
        ],
      );
    });
  }
}
