import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

StacAppBar buildCartableRealAppBar({required String title}) {
  return StacAppBar(
    title: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
    ),
    centerTitle: true,
    leading: StacPadding(
      padding: StacEdgeInsets.only(left: 12),
      child: StacCenter(
        child: StacImage(
          src: '{{appAssets.icons.support}}',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
    actions: [
      StacPadding(
        padding: StacEdgeInsets.only(right: 12),
        child: StacIconButton(
          onPressed: const StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: '{{appAssets.icons.arrowBack}}',
            imageType: StacImageType.asset,
            width: 31,
            height: 31,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}
