import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

@StacScreen(screenName: 'tobank_home_page_menu')
StacWidget tobankHomePageMenu() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.menu.items.home}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
      leading: StacIconButton(
        onPressed: const StacNavigateAction(
          navigationStyle: NavigationStyle.pop,
        ),
        icon: StacImage(
          src: '{{appAssets.icons.arrowRight}}',
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
            data: '{{appStrings.promissory.debug.flowEntryPoints}}',
            textAlign: StacTextAlign.center,
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 32),
          _buildPrimaryButton(
            label: '{{appStrings.promissory.debug.loadDart}}',
            onPressed: const StacNavigateAction(
              routeName: 'tobank_home_page_dart',
              navigationStyle: NavigationStyle.push,
            ),
          ),
          StacSizedBox(height: 16),
          _buildPrimaryButton(
            label: '{{appStrings.promissory.debug.loadLocalJson}}',
            onPressed: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/home_page/json/tobank_home_page_dart.json',
              navigationStyle: NavigationStyle.push,
            ),
          ),
          StacSizedBox(height: 16),
          _buildDisabledButton(
            label: '{{appStrings.promissory.loadFromJsonApi}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildPrimaryButton({
  required String label,
  required StacAction onPressed,
}) {
  return StacFilledButton(
    onPressed: onPressed,
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 16),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
      foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(16)),
    ),
    child: StacText(
      data: label,
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(fontSize: 16, fontWeight: StacFontWeight.w600),
    ),
  );
}

StacWidget _buildDisabledButton({required String label}) {
  return StacOutlinedButton(
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 16),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      foregroundColor: '{{appColors.current.text.hint}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(16)),
    ),
    child: StacText(
      data: label,
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.hint}}',
      ),
    ),
  );
}
