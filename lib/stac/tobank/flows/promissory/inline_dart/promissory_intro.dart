import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

/// Promissory Flow - Intro Screen
///
/// This is the main entry point for the promissory (سفته) feature.
/// It shows two tabs:
/// 1. Promissory Services (خدمات سفته) - Actions like issuing promissory
/// 2. My Promissory Notes (سفته‌های من) - List of user's promissory notes
///
/// Reference: docs/promissory_docs/promissory_screen.dart
@StacScreen(screenName: 'promissory_intro')
StacWidget promissoryIntro() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      showSupport: false,
      backIconSrc: 'assets/icons/ic_right_arrow.svg',
      title: '{{appStrings.promissory.title}}',
    ),
    body: StacColumn(
      children: [
        // Tab Selector Row
        StacSizedBox(height: 16),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacDefaultTabController(
            length: 2,
            initialIndex: 1,
            child: StacContainer(
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(8),
              ),
              child: StacStack(
                children: [
                  StacTabBar(
                    enableFeedback: false,
                    dividerColor: '#00000000',
                    indicator: StacBoxDecoration(
                      color: '{{appColors.current.primary.color}}',
                      borderRadius: StacBorderRadius.all(8),
                    ),
                    indicatorSize: StacTabBarIndicatorSize.tab,
                    labelStyle: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w600,
                    ),
                    unselectedLabelStyle: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                    ),
                    labelColor: '{{appColors.current.primary.onPrimary}}',
                    unselectedLabelColor: '{{appColors.current.text.subtitle}}',
                    tabs: const [
                      StacTab(text: '{{appStrings.promissory.myNotesTab}}', height: 44),
                      StacTab(text: '{{appStrings.promissory.servicesTab}}', height: 44),
                    ],
                  ),
                  StacPositioned(
                    top: 6,
                    bottom: 6,
                    left: 0,
                    right: 0,
                    child: StacCenter(
                      child: StacContainer(
                        width: 1,
                        color: '{{appColors.current.input.borderEnabled}}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        StacSizedBox(height: 16),

        StacSizedBox(height: 16),

        // Section Header Box (Electronic Promissory)
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacContainer(
            padding: StacEdgeInsets.all(16),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data: '{{appStrings.promissory.title}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
        ),
        StacSizedBox(height: 12),

        // Services Content Area
        StacExpanded(
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                // Request Promissory Card
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_request.svg',
                  title: '{{appStrings.promissory.requestPromissory}}',
                  description:
                      '{{appStrings.promissory.requestPromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'navigate',
                    'widgetType': 'promissory_rules',
                    'navigationStyle': 'push',
                  }),
                ),
                StacSizedBox(height: 12),

                // Guarantee Promissory Card
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_guarantee.svg',
                  title: '{{appStrings.promissory.guaranteePromissory}}',
                  description:
                      '{{appStrings.promissory.guaranteePromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'showResult',
                    'title': '{{appStrings.common.comingSoon}}',
                    'content': '{{appStrings.promissory.comingSoonMessage}}',
                  }),
                ),
                StacSizedBox(height: 12),

                // View Promissory Card (Inquiry)
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_inquiry.svg',
                  title: '{{appStrings.promissory.viewPromissory}}',
                  description: '{{appStrings.promissory.viewPromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'showResult',
                    'title': '{{appStrings.common.comingSoon}}',
                    'content': '{{appStrings.promissory.comingSoonMessage}}',
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Helper to build a service card
StacWidget _buildServiceCard({
  required String icon,
  required String title,
  required String description,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Icon Container (Start/Right)
          StacContainer(
            width: 48,
            height: 48,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.primary.color}}20',
              borderRadius: StacBorderRadius.all(8),
            ),
            child: StacCenter(
              child: StacImage(
                src: icon,
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.primary.color}}',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          // Text Content (End/Left)
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.end,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 4),
                StacText(
                  data: description,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 12,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Custom class to support alias text styles (same pattern as in login_flow_linear_login.dart)
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON action helper for simple actions
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
