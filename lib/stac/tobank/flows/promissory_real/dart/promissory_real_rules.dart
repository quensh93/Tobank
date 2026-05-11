import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

/// Promissory Flow - Rules Page
///
/// This screen displays the rules and terms for promissory note issuance.
/// Users must read the rules content (loaded from API), check the acceptance
/// checkbox, and press Continue to proceed.
///
/// Reference: docs/promissory_docs/request_promissory_rule_page.dart
@StacScreen(screenName: 'promissory_real_rules')
StacWidget promissoryRealRules() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: [
        {'key': 'isRulesAccepted', 'value': false},
        {'key': 'isSanaLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: false,
        // صدور سفته
        title: '{{appStrings.promissory.requestPromissory}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 16),
          _buildRulesCard(),
          StacSizedBox(height: 20),
          _buildCheckboxRow(),
          StacSizedBox(height: 24),
          _buildContinueButton(),
          StacSizedBox(height: 16),
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
          borderRadius: StacBorderRadius.all(12),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            // Title
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacText(
                // قوانین و مقررات صدور سفته آنلاین
                data: '{{appStrings.promissory.rulesCardTitle}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            // Divider
            StacContainer(
              height: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            // Scrollable Content
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.all(16),
                child: StacText(
                  // قوانین و مقررات صدور سفته آنلاین
                  data: '{{appStrings.promissory.rulesContentPromissory}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    height: 1.8,
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

StacWidget _buildCheckboxRow() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      padding: StacEdgeInsets.symmetric(vertical: 16),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          // Custom Checkbox
          StacSizedBox(width: 8),
          StacGestureDetector(
            onTap: const StacCustomSetValueAction(
              key: 'isRulesAccepted',
              value: '{{isRulesAccepted ? false : true}}',
            ),
            child: StacContainer(
              width: 21,
              height: 21,
              decoration: StacBoxDecoration(
                color:
                    '{{isRulesAccepted ? appColors.current.secondary.color : "transparent"}}',
                borderRadius: StacBorderRadius.all(3),
                border: StacBorder.all(
                  color:
                      '{{isRulesAccepted ? appColors.current.secondary.color : appColors.current.text.subtitle}}',
                  width: 2,
                ),
              ),
              child: StacCenter(
                child: StacCustomOpacity(
                  opacity: '{{isRulesAccepted ? 1.0 : 0.0}}',
                  child: StacImage(
                    src: 'assets/icons/ic_check.svg',
                    color: '#FFFFFF',
                    width: 19,
                    height: 19,
                  ).toJson(),
                ),
              ),
            ),
          ),
          StacSizedBox(width: 12),
          // Label
          StacExpanded(
            child: StacGestureDetector(
              onTap: const StacCustomSetValueAction(
                key: 'isRulesAccepted',
                value: '{{isRulesAccepted ? false : true}}',
              ),
              child: StacText(
                // قوانین و مقررات صدور سفته آنلاین را قبول دارم
                data: '{{appStrings.promissory.acceptRulesLabel}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w500,
                  height: 1.4,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildContinueButton() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    child: StacCustomReactiveElevatedButton(
      enabledKey: 'isRulesAccepted',
      loadingKey: 'isSanaLoading',
      onPressed: {
        'actionType': 'sequence',
        'actions': [
          {'actionType': 'setValue', 'key': 'isSanaLoading', 'value': true},
          {
            'actionType': 'networkRequest',
            'url':
                'http://192.168.107.22:8280/api/digitalbanking/governance/v1.0/sana/{{userData.nationalCode}}/1',
            'method': 'get',
            'headers': {
              'accept': 'application/json',
              'authorization': '{{auth.accessToken}}',
            },
            'results': [
              {
                'statusCode': 200,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    StacNavigateAction(
                      routeName: 'promissory_real_issuer',
                      navigationStyle: NavigationStyle.push,
                    ).toJson(),
                  ],
                },
              },
              {
                'statusCode': 500,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    const StacCustomSnackBarAction(
                      title: 'خطا',
                      detail: '{{appStrings.promissory.serverConnectionError}}',
                      duration: 4000,
                    ).toJson(),
                  ],
                },
              },
              {
                'statusCode': -1,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    const StacCustomSnackBarAction(
                      title: 'خطا',
                      detail: '{{data.status.message.0}}',
                      duration: 4000,
                    ).toJson(),
                  ],
                },
              },
            ],
          },
        ],
      },
      style: StacButtonStyle(
        backgroundColor: '{{appColors.current.primary.color}}',
        elevation: 0,
        fixedSize: StacSize(999999, 56),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(12),
        ),
      ).toJson(),
      child: StacText(
        // ادامه
        data: '{{appStrings.common.continue}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.primary.onPrimary}}',
        ),
      ).toJson(),
    ),
  );
}
