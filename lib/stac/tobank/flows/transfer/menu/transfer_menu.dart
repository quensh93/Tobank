import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

/// Transfer API Real Flow - Debug Menu
@StacScreen(screenName: 'transfer_menu')
StacWidget transferRealMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'منوی دیباگ انتقال وجه',
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
            data: 'مسیرهای ورود جریان',
            textAlign: StacTextAlign.center,
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 32),
          StacFilledButton(
            onPressed: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/transfer/json/transfer_amount.json',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'بارگذاری از JSON محلی',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: const StacNavigateAction(
              routeName: 'transfer_amount',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'بارگذاری از DART',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacOutlinedButton(
            onPressed: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/transfer/api/GET_transfer_amount.json',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: StacText(
              data: 'بارگذاری از JSON API',
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
