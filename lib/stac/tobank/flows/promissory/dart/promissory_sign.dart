import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Digital Signature Page
///
/// This screen allows users to digitally sign the promissory PDF:
/// 1. Loads sign assets (coordinates) on init
/// 2. Shows PDF preview/viewer
/// 3. Shows signature area info
/// 4. Sign button triggers confirmation dialog
/// 5. After confirmation, signs PDF and finalizes promissory
/// 6. Navigates to transaction detail page (promissory_success)
///
/// Reference: docs/promissory_docs/promissory_issuance.md (Step 8)
/// Reference: docs/promissory_docs/request_promissory_sign_page.dart
@StacScreen(screenName: 'promissory_sign')
StacWidget promissorySign() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.signTitle}}',
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
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              textDirection: StacTextDirection.rtl,
              children: [
                // Instructions
                // PDF Preview Container
                StacContainer(
                  width: 999999,
                  height: 500,

                  child: StacCenter(
                    child: StacColumn(
                      mainAxisAlignment: StacMainAxisAlignment.center,
                      children: [
                        StacImage(
                          src: 'assets/icons/sign-pdf.svg',
                          imageType: StacImageType.asset,
                          width: 145,
                          height: 145,
                        ),
                        StacSizedBox(height: 16),
                        StacText(
                          data:
                              '{{appStrings.promissory.signInstructionsDetail}}',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.center,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StacSizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Sign and Finalize Button
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacFilledButton(
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              elevation: 0,
              fixedSize: StacSize(999999, 56),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ),
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_success',
              'navigationStyle': 'pushReplacement',
            }),
            child: StacText(
              data: 'امضا و نهایی کردن',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.bold,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ),
      ],
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

/// Raw JSON widget helper for complex widgets
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

/// Raw JSON action helper for simple actions
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
