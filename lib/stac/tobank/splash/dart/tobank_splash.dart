import 'package:stac_core/stac_core.dart';
import '../../../../core/stac/builders/stac_stateful_widget.dart';

/// Tobank Splash Screen
///
/// Displays the Tobank logo and app version.
/// Matches Figma design: https://www.figma.com/design/G0vx068PwQB3ZOMm8jFdlR/TOBANK---Application-Develop-?node-id=9665-1807&m=dev
@StacScreen(screenName: 'tobank_splash_dart')
StacWidget tobankSplashDart() {
  return StacStatefulWidget(
    child: StacScaffold(
      // Use theme-aware background color
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
                  width: 229, // Exact width from Figma
                  height: 36, // Exact height from Figma
                  fit: StacBoxFit.contain,
                ),

                const StacSizedBox(height: 27), // Exact gap (427 - 400 = 27px)

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
              padding: const StacEdgeInsets.only(
                bottom: 49,
              ), // Exact bottom gap
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
    ),
  );
}
