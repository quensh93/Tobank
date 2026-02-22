import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

StacAppBar buildPromissoryAppBar({required String title}) {
  return StacAppBar(
    title: StacText(
      data: title,
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
  );
}
