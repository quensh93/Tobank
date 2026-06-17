import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const authenticationRealRulesSheetTitle =
    '{{appStrings.authentication.serviceRulesTitle}}';

class AuthenticationRealRuleSectionData {
  final String title;
  final List<String> paragraphs;

  const AuthenticationRealRuleSectionData({
    required this.title,
    required this.paragraphs,
  });
}

const authenticationRealRulesSections = <AuthenticationRealRuleSectionData>[
  AuthenticationRealRuleSectionData(
    title: '{{appStrings.generated.authentication.authentication_rules.title}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.deposit_security}}',
      '{{appStrings.generated.authentication.authentication_rules.deposit_guarantee_description}}',
      '{{appStrings.generated.authentication.authentication_rules.privacy_confidentiality_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title:
        '{{appStrings.generated.authentication.authentication_rules.hours_support}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.time_bank_day_year_day_description}}',
      '{{appStrings.generated.authentication.authentication_rules.customer_support_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: '{{appStrings.generated.authentication.authentication_rules.fees}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.card_bank_request_customers_description}}',
      '{{appStrings.generated.authentication.authentication_rules.open_account_fee_process_customer_description}}',
      '{{appStrings.generated.authentication.authentication_rules.open_account_save_account_amount_description}}',
      '{{appStrings.generated.authentication.authentication_rules.invite_reward_fee_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title:
        '{{appStrings.generated.authentication.authentication_rules.information_security_privacy_personal}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.bank_responsibility_description}}',
      '{{appStrings.generated.authentication.authentication_rules.app_permission_privacy_description}}',
      '{{appStrings.generated.authentication.authentication_rules.document_security_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title:
        '{{appStrings.generated.authentication.authentication_rules.features}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.card_bank_payment_internet_description}}',
      '{{appStrings.generated.authentication.authentication_rules.services_bank_customers_description}}',
      '{{appStrings.generated.authentication.authentication_rules.fees_operation_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title:
        '{{appStrings.generated.authentication.authentication_rules.open_account_terms_limits_responsibility}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.open_account_bank_description}}',
      '{{appStrings.generated.authentication.authentication_rules.deposit_account_amount_year_open_description}}',
      '{{appStrings.generated.authentication.authentication_rules.account_balance_usage_description}}',
      '{{appStrings.generated.authentication.authentication_rules.account_customer_bank_description}}',
      '{{appStrings.generated.authentication.authentication_rules.account_restriction_description}}',
      '{{appStrings.generated.authentication.authentication_rules.address_card_bank_customers_send_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title:
        '{{appStrings.generated.authentication.authentication_rules.authentication_customer}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.customer_auth_acknowledgement}}',
      '{{appStrings.generated.authentication.authentication_rules.authentication_rejection_right}}',
      '{{appStrings.generated.authentication.authentication_rules.repeat_authentication_right}}',
      '{{appStrings.generated.authentication.authentication_rules.identity_inquiry_permission}}',
      '{{appStrings.generated.authentication.authentication_rules.account_opening_inquiries}}',
      '{{appStrings.generated.authentication.authentication_rules.service_security_standards}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: '{{appStrings.generated.authentication.authentication_rules.terms}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.operation_bank_customers_description}}',
      '{{appStrings.generated.authentication.authentication_rules.internet_bank_services_bank_description}}',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title:
        '{{appStrings.generated.authentication.authentication_rules.bank_authorities}}',
    paragraphs: [
      '{{appStrings.generated.authentication.authentication_rules.refund_loan_date_account_error_description}}',
    ],
  ),
];

@StacScreen(screenName: 'authentication_rules')
StacWidget authenticationRealRules() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.authentication.rulesTitle}}',
      showSupport: false,
      showBack: false,
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: StacPadding(
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
                      data: authenticationRealRulesSheetTitle,
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 17,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 12),
                    ...authenticationRealRulesSections.map(
                      (section) =>
                          _buildRuleSection(section.title, section.paragraphs),
                    ),
                    StacSizedBox(height: 20),
                    StacPadding(
                      padding: StacEdgeInsets.only(bottom: 12),
                      child: StacElevatedButton(
                        onPressed: const StacNavigateAction(
                          navigationStyle: NavigationStyle.pop,
                        ),
                        style: StacButtonStyle(
                          backgroundColor: '#FFFFFF',
                          foregroundColor: '#D61F2C',
                          elevation: 0,
                          fixedSize: StacSize(999999, 67),
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(13),
                            side: const StacBorderSide(
                              color: '#D61F2C',
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: StacText(
                          data:
                              '{{appStrings.generated.authentication.authentication_rules.understood}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 17,
                            fontWeight: StacFontWeight.w700,
                            color: '#D61F2C',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildRuleSection(String title, List<String> paragraphs) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 4),
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
            color: '{{appColors.current.text.title}}',
            height: 1.8,
          ),
        ),
        ...paragraphs.map(_buildRuleParagraph),
      ],
    ),
  );
}

StacWidget _buildRuleParagraph(String description) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 12),
    child: StacText(
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
  );
}
