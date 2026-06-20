import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_card_issue_template')
StacWidget depositCardIssueTemplate() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'depositCardIssue.templateColorHex', 'value': '#ED1B2F'},
        {'key': 'depositCardIssue.templateIsFront', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.title}}',
        showSupport: true,
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
              'selectedColorKey': 'depositCardIssue.templateColorHex',
              'selectedFaceKey': 'depositCardIssue.templateIsFront',
            }),
            StacExpanded(child: StacSizedBox(height: 0)),
            StacFilledButton(
              onPressed: StacFingerPrintAction(
                title: '{{appStrings.menu.items.authentication}}',
                description:
                    '{{appStrings.generated.deposit_more_options.deposit_card_issue_template.authentication_continue_card}}',
                onSuccess: {
                  'actionType': 'navigate',
                  'fileName': 'deposit_card_issue_result',
                  'navMode': 'dart',
                  'navigationStyle': 'push',
                },
                onFailure: {
                  'actionType': 'showSnackBar',
                  'title':
                      '{{appStrings.generated.deposit_more_options.deposit_card_issue_template.authentication_failed_title}}',
                  'description':
                      '{{appStrings.generated.deposit_more_options.deposit_card_issue_template.authentication_try_again}}',
                  'type': 'error',
                },
              ),
              style: StacButtonStyle(
                fixedSize: StacSize(999999, 56),
                backgroundColor: '{{appColors.current.primary.color}}',
                foregroundColor: '{{appColors.current.primary.onPrimary}}',
                elevation: 0,
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(16),
                ),
              ),
              child: StacText(
                data:
                    '{{appStrings.generated.deposit_more_options.deposit_card_issue_template.select_continue}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
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
