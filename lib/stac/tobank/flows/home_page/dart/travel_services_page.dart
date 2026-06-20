import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'tobank_travel_services_page')
StacWidget tobankTravelServicesPage() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    body: StacSafeArea(
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _buildMegaGashtHeader(),
          StacExpanded(child: StacTobankMegaGashtWebView()),
        ],
      ),
    ),
  );
}

StacWidget _buildMegaGashtHeader() {
  return StacColumn(
    children: [
      StacSizedBox(height: 8),
      StacSizedBox(
        height: 48,
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacGestureDetector(
              onTap: const StacTobankMegaGashtBackAction(),
              child: StacContainer(
                alignment: StacAlignment.centerRight,
                child: StacPadding(
                  padding: StacEdgeInsets.all(8),
                  child: StacImage(
                    src: '{{appAssets.current.icons.arrowBack}}',
                    imageType: StacImageType.asset,
                    width: 24,
                    height: 24,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ),
            StacSizedBox(width: 40),
            StacExpanded(
              child: StacText(
                data: '{{appStrings.homePage.services.travelServices}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 8),
              child: StacElevatedButton(
                onPressed: const StacNavigateAction(
                  navigationStyle: NavigationStyle.pop,
                ),
                style: StacButtonStyle(
                  elevation: 1,
                  padding: StacEdgeInsets.symmetric(horizontal: 16),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                ),
                child: StacText(
                  data: '{{appStrings.common.close}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      StacSizedBox(height: 8),
    ],
  );
}
