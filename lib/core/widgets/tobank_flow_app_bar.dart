import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

StacAppBar buildTobankFlowAppBar({
  required String title,
  bool showSupport = false,
  bool showBack = true,
  StacAction? backAction,
  String backIconSrc = '{{appAssets.icons.arrowBack}}',
}) {
  final resolvedBackAction =
      backAction ??
      const StacNavigateAction(navigationStyle: NavigationStyle.pop);

  StacWidget buildBackButton() {
    return StacIconButton(
      onPressed: resolvedBackAction,
      icon: StacImage(
        src: backIconSrc,
        imageType: StacImageType.asset,
        width: 31,
        height: 31,
        color: '{{appColors.current.text.title}}',
      ),
    );
  }

  return StacAppBar(
    title: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
    ),
    centerTitle: true,
    automaticallyImplyLeading: showBack || showSupport,
    leading: showSupport
        ? StacPadding(
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
          )
        : (showBack ? buildBackButton() : null),
    actions: showSupport && showBack
        ? [
            StacPadding(
              padding: StacEdgeInsets.only(right: 12),
              child: buildBackButton(),
            ),
          ]
        : [],
  );
}
