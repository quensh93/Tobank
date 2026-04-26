import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

StacAppBar buildVerifyIdentityRealAppBar({
  required String title,
  bool showSupport = true,
  bool showBack = true,
  StacAction? backAction,
}) {
  return StacAppBar(
    title: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
    ),
    centerTitle: true,
    leading: showSupport
        ? _buildSupportButton(backAction: backAction)
        : (showBack ? _buildBackButton(backAction: backAction) : null),
    actions: showSupport && showBack
        ? [_buildBackAction(backAction: backAction)]
        : [],
  );
}

StacWidget _buildBackButton({StacAction? backAction}) {
  return StacIconButton(
    onPressed:
        backAction ?? StacNavigateAction(navigationStyle: NavigationStyle.pop),
    icon: StacImage(
      src: '{{appAssets.icons.arrowBack}}',
      imageType: StacImageType.asset,
      width: 30,
      height: 30,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildBackAction({StacAction? backAction}) {
  return StacPadding(
    padding: StacEdgeInsets.only(right: 15),
    child: _buildBackButton(backAction: backAction),
  );
}

StacWidget _buildSupportButton({StacAction? backAction}) {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 12),
    child: StacCenter(
      child: StacContainer(
        width: 42,
        height: 42,
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
    ),
  );
}
