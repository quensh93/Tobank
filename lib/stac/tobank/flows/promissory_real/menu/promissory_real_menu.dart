import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';

/// Promissory Real Flow - Debug Menu
///
/// This screen provides entry points for testing various parts of the promissory flow.
@StacScreen(screenName: 'promissory_real_debug')
StacWidget promissoryRealDebugMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'Promissory Debug Menu',
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
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacText(
            data: 'Flows Entry Points',
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 32),

          // 1. Load from Local JSON
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'assetPath':
                  'lib/stac/tobank/flows/promissory_real/json/promissory_intro.json',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'Load from local json',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),

          // 2. Load from DART (Now Main Intro)
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_intro',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'Load from DART',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
           StacSizedBox(height: 16),
          // 3. Load from API
          StacOutlinedButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_loader',
              'navigationStyle': 'pushReplacement',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
            ),
            child: StacText(
              data: '{{appStrings.promissory.loadFromJsonApi}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 32),
          StacDivider(),
          StacSizedBox(height: 16),
          StacText(
            data: 'Login Methods',
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              fontWeight: StacFontWeight.w500,
            ),
          ),
          StacSizedBox(height: 16),

        

          // 4. Static Login
          StacOutlinedButton(
            onPressed: StacRawJsonAction({
              'actionType': 'promissory_real_login',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
            ),
            child: StacText(
              data: 'Static Login (Nooshin)',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),

          // 5. Dynamic Login
          StacOutlinedButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_login_form',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
            ),
            child: StacText(
              data: 'Dynamic Login',
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
