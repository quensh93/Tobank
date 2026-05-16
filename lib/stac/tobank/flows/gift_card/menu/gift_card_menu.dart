import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

/// Gift Card Real Flow - Debug Menu
@StacScreen(screenName: 'gift_card_menu')
StacWidget giftCardRealMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'منوی دیباگ کارت هدیه',
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
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 32),
          StacFilledButton(
            onPressed: StacNavigateAction.fromJson({
              'actionType': 'navigate',
              'navigationStyle': 'push',
              'request': {
                'url':
                    'http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.gift_card_intro/1',
                'method': 'post',
                'headers': {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                },
                'body': {
                  'operator': 'is',
                  'dimension': {'app': 'mobile'},
                },
              },
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'لود جیسون از API',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/gift_card/json/gift_card_intro.json',
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
              routeName: 'gift_card_intro',
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
        ],
      ),
    ),
  );
}
