import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Rules Page
///
/// This screen displays the rules and terms for promissory note issuance.
/// Users must read the rules content (loaded from API), check the acceptance
/// checkbox, and press Continue to proceed.
///
/// Reference: docs/promissory_docs/request_promissory_rule_page.dart
@StacScreen(screenName: 'promissory_rules')
StacWidget promissoryRules() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isRulesAccepted', value: false),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: false,
        title: '{{appStrings.promissory.rulesTitle}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 16),
          // Rules Card with Scrollable Content
          StacExpanded(
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
                          data: '{{appStrings.promissory.rulesContent}}',
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
          ),
          StacSizedBox(height: 24),
          // Checkbox Row
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacContainer(
              color: 'transparent',
              padding: StacEdgeInsets.symmetric(vertical: 8),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  // Custom Checkbox
                  StacGestureDetector(
                    onTap: StacRawJsonAction({
                      'actionType': 'setValue',
                      'key': 'isRulesAccepted',
                      'value': '{{isRulesAccepted ? false : true}}',
                    }),
                    child: StacContainer(
                      width: 24,
                      height: 24,
                      decoration: StacBoxDecoration(
                        color:
                            '{{isRulesAccepted ? appColors.current.primary.color : "transparent"}}',
                        borderRadius: StacBorderRadius.all(6),
                        border: StacBorder.all(
                          color:
                              '{{isRulesAccepted ? appColors.current.primary.color : appColors.current.text.subtitle}}',
                          width: 2,
                        ),
                      ),
                      child: StacCenter(
                        child: StacRawJsonWidget({
                          'type': 'opacity',
                          'opacity': '{{isRulesAccepted ? 1.0 : 0.0}}',
                          'child': StacImage(
                            src: 'assets/icons/ic_check.svg',
                            color: '#FFFFFF',
                            width: 16,
                            height: 16,
                          ).toJson(),
                        }),
                      ),
                    ),
                  ),
                  StacSizedBox(width: 12),
                  // Label
                  StacExpanded(
                    child: StacGestureDetector(
                      onTap: StacRawJsonAction({
                        'actionType': 'setValue',
                        'key': 'isRulesAccepted',
                        'value': '{{isRulesAccepted ? false : true}}',
                      }),
                      child: StacText(
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
          ),
          StacSizedBox(height: 24),
          // Continue Button
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabledKey': 'isRulesAccepted',
              // 'enabled': false, // Removed hardcoded false
              'onPressed': {
                'actionType': 'navigate',
                'widgetType': 'request_promissory_deposit',
                'navigationStyle': 'push',
              },
              'style': StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                elevation: 0,
                fixedSize: StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ).toJson(),
              'child': StacText(
                data: '{{appStrings.common.continue}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ).toJson(),
            }),
          ),
          StacSizedBox(height: 16),
        ],
      ),
    ),
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
