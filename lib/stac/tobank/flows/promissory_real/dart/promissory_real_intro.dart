import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';

/// Promissory Real Flow - Intro Screen
///
/// This is the main visual intro screen for the Real Promissory flow.
/// It contains the Tabs (Services/My Notes) and the Service Cards.
@StacScreen(screenName: 'promissory_real_intro')
StacWidget promissoryRealIntro() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.title}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
      leading: StacIconButton(
        onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
        icon: StacImage(
          src: 'assets/icons/ic_right_arrow.svg',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
    body: StacColumn(
      children: [
        StacSizedBox(height: 16),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: StacColumn(
                  children: [
                    StacText(
                      data: '{{appStrings.promissory.servicesTab}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacContainer(
                      width: 40,
                      height: 3,
                      decoration: StacBoxDecoration(
                        color: '#D32F2F',
                        borderRadius: StacBorderRadius.all(2),
                      ),
                    ),
                  ],
                ),
              ),
              StacContainer(
                width: 1,
                height: 24,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacExpanded(
                child: StacGestureDetector(
                  onTap: StacRawJsonAction({
                    'actionType': 'showResult',
                    'title': '{{appStrings.common.comingSoon}}',
                    'content': '{{appStrings.promissory.myNotesComingSoon}}',
                  }),
                  child: StacCenter(
                    child: StacText(
                      data: '{{appStrings.promissory.myNotesTab}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w500,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        StacSizedBox(height: 16),
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
        StacExpanded(
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_request.svg',
                  title: '{{appStrings.promissory.requestPromissory}}',
                  description:
                      '{{appStrings.promissory.requestPromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'navigate',
                    'widgetType': 'promissory_real_rules',
                    'navigationStyle': 'push',
                  }),
                ),
                StacSizedBox(height: 12),
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
          StacContainer(
            width: 48,
            height: 48,
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.all(8),
            ),
            child: StacCenter(
              child: StacImage(
                src: icon,
                imageType: StacImageType.asset,
                width: 30,
                height: 30,
              ),
            ),
          ),
          StacSizedBox(width: 12),
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

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
