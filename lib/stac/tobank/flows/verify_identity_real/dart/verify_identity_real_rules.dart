import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_rules')
StacWidget verifyIdentityRealRules() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildPromissoryAppBar(
      title: '{{appStrings.authentication.rulesTitle}}',
    ),
    body: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            height: 1,
            color: '{{appColors.current.input.borderEnabled}}',
          ),
          StacSizedBox(height: 24),
          StacExpanded(
            child: StacSingleChildScrollView(
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacText(
                    data: '{{appStrings.authentication.serviceRulesTitle}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 20),
                  _buildRuleItem(
                    '{{appStrings.authentication.rule1Title}}',
                    '{{appStrings.authentication.rule1Description}}',
                  ),
                  _buildRuleItem(
                    '{{appStrings.authentication.rule2Title}}',
                    '{{appStrings.authentication.rule2Description}}',
                  ),
                  _buildRuleItem(
                    '{{appStrings.authentication.rule3Title}}',
                    '{{appStrings.authentication.rule3Description}}',
                  ),
                  _buildRuleItem(
                    '{{appStrings.authentication.rule4Title}}',
                    '{{appStrings.authentication.rule4Description}}',
                  ),
                  _buildRuleItem(
                    '{{appStrings.authentication.rule5Title}}',
                    '{{appStrings.authentication.rule5Description}}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildRuleItem(String title, String description) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 18),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.subtitle}}',
            height: 1.8,
          ),
        ),
        StacText(
          data: description,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
            height: 1.9,
          ),
        ),
      ],
    ),
  );
}
