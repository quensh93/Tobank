import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'marriage_loan_rules')
StacWidget marriageLoanRulesScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'isMarriageLoanRulesAccepted', 'value': false},
        {'key': 'isMarriageLoanRulesLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.marriage_loan.marriage_loan_menu.title}}',
        showBack: true,
        showSupport: true,
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 16),
          _buildRulesCard(),
          StacSizedBox(height: 12),
          _buildRulesCheckbox(),
          StacSizedBox(height: 12),
          _buildNextButton(),
          StacSizedBox(height: 18),
        ],
      ),
    ),
  );
}

StacWidget _buildRulesCard() {
  return StacExpanded(
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16),
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacText(
                data:
                    '{{appStrings.generated.marriage_loan.marriage_loan_rules.title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacContainer(
              height: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: StacText(
                  data:
                      '{{appStrings.generated.marriage_loan.marriage_loan_rules.fullContent}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    height: 1.9,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildRulesCheckbox() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    child: StacGestureDetector(
      onTap: const StacCustomSetValueAction(
        key: 'isMarriageLoanRulesAccepted',
        value: '{{isMarriageLoanRulesAccepted ? false : true}}',
      ),
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color:
                '{{isMarriageLoanRulesAccepted ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacContainer(
              width: 28,
              height: 28,
              decoration: StacBoxDecoration(
                color:
                    '{{isMarriageLoanRulesAccepted ? appColors.current.secondary.color : "transparent"}}',
                borderRadius: StacBorderRadius.all(4),
                border: StacBorder.all(
                  color:
                      '{{isMarriageLoanRulesAccepted ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                  width: 2,
                ),
              ),
              child: StacCenter(
                child: StacCustomOpacity(
                  opacity: '{{isMarriageLoanRulesAccepted ? 1.0 : 0.0}}',
                  child: StacImage(
                    src: 'assets/icons/ic_check.svg',
                    color: '{{appColors.current.text.buttonPrimary}}',
                    width: 20,
                    height: 20,
                  ).toJson(),
                ),
              ),
            ),
            StacSizedBox(width: 12),
            StacExpanded(
              child: StacText(
                data:
                    '{{appStrings.generated.marriage_loan.marriage_loan_rules.acceptTitle}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 15,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildNextButton() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    child: StacCustomReactiveElevatedButton(
      enabledKey: 'isMarriageLoanRulesAccepted',
      loadingKey: 'isMarriageLoanRulesLoading',
      onPressed: const StacAction(
        jsonData: {
          'actionType': 'navigate',
          'fileName': 'marriage_loan_customer_check',
          'navMode': '{{marriageLoanFlowNavMode}}',
          'navigationStyle': 'push',
        },
      ).toJson(),
      style: StacButtonStyle(
        fixedSize: StacSize(999999, 56),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(10),
        ),
        backgroundColor: '{{appColors.current.primary.color}}',
        foregroundColor: '#FFFFFF',
        disabledBackgroundColor: '{{appColors.current.input.borderEnabled}}',
        disabledForegroundColor: '{{appColors.current.text.subtitle}}',
      ).toJson(),
      child: StacText(
        data: '{{appStrings.generated.cartable.cartable_intro.next_step}}',
        style: StacTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '#FFFFFF',
        ),
      ).toJson(),
    ),
  );
}
