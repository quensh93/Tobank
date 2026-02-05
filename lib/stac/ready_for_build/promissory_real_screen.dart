import 'package:stac_core/stac_core.dart' hide StacTheme;

/// Promissory Real Screen - SDUI screen loaded from real API
///
/// This screen fetches the UI configuration from the real configuration API
/// and renders it using the STAC framework.
///
/// Key features:
/// - Fetches SDUI JSON from real API endpoint
/// - Handles loading, error, and success states
/// - Uses ConfigApiService for network layer

/// Entry point function for StacWidgetLoader registration
/// Note: This returns a "loader" widget that shows loading state
/// The actual SDUI will be fetched and rendered by PromissoryRealScreen
@StacScreen(screenName: 'promissory_real_intro')
StacWidget promissoryRealIntro() {
  // Return a wrapper scaffold that tells the app to use our StatefulWidget
  // We use a special pattern: return a scaffold with a "flutterWidget" type
  // that the navigation system will recognize
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.introTitle}}',
        style: StacTextStyle(
          color: '{{appColors.current.text.title}}',
          fontSize: 18,
          fontWeight: StacFontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: '{{appColors.current.background.surface}}',
      leading: StacIconButton(
        icon: StacImage(
          src: 'assets/icons/ic_right_arrow.svg',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
        onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
      ),
    ),
    body: StacCenter(
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacText(
            data: '{{appStrings.promissory.connectingServer}}',
            style: StacTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              fontSize: 16,
            ),
          ),
          const StacSizedBox(height: 16),
          StacText(
            data: '{{appStrings.promissory.loadFromApiDesc}}',
            style: StacTextStyle(
              color: '{{appColors.current.text.hint}}',
              fontSize: 14,
            ),
            textAlign: StacTextAlign.center,
          ),
          const StacSizedBox(height: 24),
          // Button to load from local JSON files
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'assetPath':
                  'lib/stac/tobank/flows/promissory_real/json/promissory_intro.json',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: StacText(
              data: 'Load from local json',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          const StacSizedBox(height: 16),
          // Show a button to manually trigger the load in the real implementation
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_loader',
              'navigationStyle': 'pushReplacement',
            }),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: StacText(
              data: '{{appStrings.promissory.loadFromApi}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          const StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'promissory_real_login',
            }),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: StacText(
              data: 'Static Login (Nooshin)',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          const StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_login_form',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
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

// ==========================================
// Local Helper Classes (Inlined to avoid import issues)
// ==========================================

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
