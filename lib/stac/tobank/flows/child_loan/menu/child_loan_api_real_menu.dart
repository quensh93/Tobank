import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'child_loan_api_real_menu')
StacWidget childLoanApiRealMenu() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title: 'تسهیلات فرزندآوری api واقعی',
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
            onPressed: const StacNavigateAction(
              routeName: 'child_loan_rules',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'بارگذاری از DART',
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
