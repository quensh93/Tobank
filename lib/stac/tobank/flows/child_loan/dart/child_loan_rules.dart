import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'child_loan_rules')
StacWidget childLoanRulesScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'isChildLoanRulesAccepted', 'value': false},
        {'key': 'isChildLoanRulesLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.child_loan.child_loan_customer_check.title}}',
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
                    '{{appStrings.generated.child_loan.child_loan_rules.title}}',
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
                      '{{appStrings.generated.child_loan.child_loan_rules.n}}'
                      '{{appStrings.generated.child_loan.child_loan_rules.loan_registration_steps}}'
                      '{{appStrings.generated.child_loan.child_loan_rules.loan_fee_money_description}}',
                  textDirection: StacTextDirection.rtl,
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
        key: 'isChildLoanRulesAccepted',
        value: '{{isChildLoanRulesAccepted ? false : true}}',
      ),
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color:
                '{{isChildLoanRulesAccepted ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
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
                    '{{isChildLoanRulesAccepted ? appColors.current.secondary.color : "transparent"}}',
                borderRadius: StacBorderRadius.all(4),
                border: StacBorder.all(
                  color:
                      '{{isChildLoanRulesAccepted ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                  width: 2,
                ),
              ),
              child: StacCenter(
                child: StacCustomOpacity(
                  opacity: '{{isChildLoanRulesAccepted ? 1.0 : 0.0}}',
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
                    '{{appStrings.generated.child_loan.child_loan_rules.loan_rules_child}}',
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
      enabledKey: 'isChildLoanRulesAccepted',
      loadingKey: 'isChildLoanRulesLoading',
      onPressed: const StacSequenceAction(
        actions: [
          StacCustomSetValueAction(
            values: [
              {'key': 'crDetailVariantMarriageLoan', 'value': false},
              {'key': 'crDetailVariantChildLoan', 'value': true},
              {'key': 'crDetailVariantCompleteDocsDone', 'value': false},
              {'key': 'crDetailVariantCompleteDocsEmpty', 'value': false},
            ],
          ),
          NavigationAction(
            fileName: 'child_loan_customer_check',
            navMode: NavModes.dart,
            navigationStyle: NavigationStyle.push,
          ),
        ],
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
