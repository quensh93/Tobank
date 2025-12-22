import 'package:stac_core/stac_core.dart';

/// Linear Login Flow - Splash Screen
///
/// Cloned from tobank_splash.dart
/// Automatically navigates to onboarding after 2 seconds using onMountAction.
/// This allows the backend to control the navigation timing and target via JSON.
@StacScreen(screenName: 'tobank_login_flow_linear_splash')
StacWidget tobankLoginFlowLinearSplash() {
  // Build the splash content
  final splashContent = StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    body: StacStack(
      children: [
        // Centered Group: Logo + Slogan
        StacAlign(
          alignment: StacAlignmentDirectional.center,
          child: StacColumn(
            mainAxisSize: StacMainAxisSize.min,
            crossAxisAlignment: StacCrossAxisAlignment.center,
            children: [
              const StacImage(
                src: '{{appAssets.icons.logoRed}}',
                imageType: StacImageType.asset,
                width: 229,
                height: 36,
                fit: StacBoxFit.contain,
              ),

              const StacSizedBox(height: 27),

              StacText(
                data: '{{appStrings.splash.slogan}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 20,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.text.title}}',
                  fontFamily: 'IranYekan',
                ),
              ),
            ],
          ),
        ),

        // Bottom Group: Version
        StacAlign(
          alignment: StacAlignmentDirectional.bottomCenter,
          child: StacPadding(
            padding: const StacEdgeInsets.only(bottom: 49),
            child: StacText(
              data: '{{appStrings.splash.version}} {{appData.version}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.subtitle}}',
                fontFamily: 'IranYekan',
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Wrap with onMountAction to auto-navigate after 2 seconds
  // This uses the new onMountAction widget which is backend-controllable
  return StacWidget(
    jsonData: {
      'type': 'onMountAction',
      'delay': 2000,
      'action': {
        'actionType': 'navigate',
        'widgetType': 'tobank_login_flow_linear_onboarding',
        'navigationStyle': 'pushReplacement',
      },
      'child': splashContent.toJson(),
    },
  );
}
