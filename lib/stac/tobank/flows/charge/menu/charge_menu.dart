import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'charge_menu')
StacWidget chargeRealMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'منوی دیباگ شارژ',
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
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
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
            onPressed: const StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  key: 'crChargeFlowInitialized',
                  value: false,
                ),
                NavigationAction(fileName: 'charge_intro', navMode: NavModes.localJson, navigationStyle: NavigationStyle.push),
              ],
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
            onPressed: const StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  key: 'crChargeFlowInitialized',
                  value: false,
                ),
                NavigationAction(fileName: 'charge_intro', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
              ],
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

