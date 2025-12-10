import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../controller/card_management/card_reissue_start_controller.dart';
import '../../../../bpms/card_physical_issue/card_physical_issue_start/widget/card_color_item_widget.dart';
import '../../../../common/card_template_item.dart';

class CardReissueStartCardTemplatePage extends StatelessWidget {
  const CardReissueStartCardTemplatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardReissueStartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: controller.cardTemplates.isEmpty
                      ? Column(
                          children: [
                            Center(
                              child: Text(
                                locale.default_card_message,
                                style: ThemeUtil.titleStyle,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                             locale.select_card_color,
                              style: ThemeUtil.titleStyle,
                            ),
                            const SizedBox(height: 24.0),
                            ExpandablePageView(
                              controller: controller.expandablePageViewController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                controller.cardTemplates.length,
                                (index) => CardTemplateItem(
                                  index: index,
                                  cardTemplate: controller.cardTemplates[index],
                                  onToggle: controller.update,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 56.0,
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return CardColorItemWidget(
                                          cardColorData: controller.cardColorDataList[index],
                                          index: index,
                                          selectedCardColorData: controller.selectedCardColorData,
                                          returnDataFunction: (index, selectedCardColorData) {
                                            controller.setSelectedCardColorData(index, selectedCardColorData);
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(width: 24.0);
                                      },
                                      itemCount: controller.cardColorDataList.length),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40.0),
                          ],
                        ),
                ),
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateSelectedCardTemplate();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.confirm_continue,
              ),
            ],
          ),
        );
      },
    );
  }
}
