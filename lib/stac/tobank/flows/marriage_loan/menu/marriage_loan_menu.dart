import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'marriage_loan_menu')
StacWidget marriageLoanMenu() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.generated.marriage_loan.marriage_loan_menu.title}}',
      showBack: true,
      showSupport: true,
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacFilledButton(
            onPressed: const StacAction(
              jsonData: {
                'actionType': 'sequence',
                'actions': [
                  {
                    'actionType': 'setValue',
                    'key': 'marriageLoanFlowNavMode',
                    'value': 'dart',
                  },
                  {
                    'actionType': 'navigate',
                    'fileName': 'marriage_loan_rules',
                    'navMode': 'dart',
                    'navigationStyle': 'push',
                  },
                ],
              },
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: '{{appStrings.promissory.debug.loadDart}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: const StacAction(
              jsonData: {
                'actionType': 'sequence',
                'actions': [
                  {
                    'actionType': 'setValue',
                    'key': 'marriageLoanFlowNavMode',
                    'value': 'localJson',
                  },
                  {
                    'actionType': 'navigate',
                    'fileName': 'marriage_loan_rules',
                    'navMode': 'localJson',
                    'navigationStyle': 'push',
                  },
                ],
              },
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data:
                  '{{appStrings.generated.marriage_loan.marriage_loan_menu.upload_json}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacOutlinedButton(
            onPressed: const StacAction(
              jsonData: {
                'actionType': 'sequence',
                'actions': [
                  {
                    'actionType': 'setValue',
                    'key': 'marriageLoanFlowNavMode',
                    'value': 'apiJson',
                  },
                  {
                    'actionType': 'navigate',
                    'fileName': 'marriage_loan_rules',
                    'navMode': 'apiJson',
                    'navigationStyle': 'push',
                  },
                ],
              },
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data:
                  '{{appStrings.generated.marriage_loan.marriage_loan_menu.upload_json_api}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
