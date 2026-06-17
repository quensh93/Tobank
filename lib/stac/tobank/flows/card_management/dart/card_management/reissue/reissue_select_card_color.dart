import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'card_management_reissue_color')
StacWidget dashboardCardReissueSelectCardColor() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'cardsManagement.reissue.selectedTemplate', 'value': '#ED1B2F'},
        {'key': 'cardsManagement.reissue.templateIsFront', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.card_management.card_management_reissue_color.card_reissue}}',
        showBack: true,
        backOnRight: true,
      ),
      body: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacText(
              data:
                  '{{appStrings.generated.deposit_more_options.deposit_card_issue_template.title}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 20,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 20),
            const StacCustomWidget.fromJson({
              'type': 'depositCardTemplatePicker',
              'selectedColorKey': 'cardsManagement.reissue.selectedTemplate',
              'selectedFaceKey': 'cardsManagement.reissue.templateIsFront',
            }),
            StacExpanded(child: StacSizedBox(height: 0)),
            StacFilledButton(
              onPressed: StacShowDialogAction(
                dialogActionType: 'showLogoutConfirmDialog',
                title:
                    '{{appStrings.generated.card_management.card_management_reissue_color.select_confirm}}',
                description:
                    '{{appStrings.generated.card_management.card_management_reissue_color.card_reissue_select_color}}',
                positiveText: '{{appStrings.common.confirm}}',
                negativeText: '{{appStrings.common.cancel}}',
                positiveAction: StacSequenceAction(
                  actions: [
                    const StacCloseDialogAction(),
                    NavigationAction(
                      fileName: 'card_management_reissue_receipt',
                      navMode: NavModes.dart,
                      navigationStyle: NavigationStyle.push,
                    ),
                  ],
                ),
                negativeAction: const StacCloseDialogAction(),
              ),
              style: StacButtonStyle(
                fixedSize: StacSize(999999, 56),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                elevation: 0,
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(16),
                ),
              ),
              child: StacText(
                data: '{{appStrings.authentication.confirmAndContinue}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.button.primary.foregroundColor}}',
                ),
              ),
            ),
            StacSizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
