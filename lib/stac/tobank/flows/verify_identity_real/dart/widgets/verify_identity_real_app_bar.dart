import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

StacAppBar buildVerifyIdentityRealAppBar({
  required String title,
  bool showSupport = true,
  bool showBack = true,
}) {
  return StacAppBar(
    title: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
    ),
    centerTitle: true,
    leading: showSupport
        ? _buildSupportButton()
        : (showBack ? _buildBackButton() : null),
    actions: showSupport && showBack ? [_buildBackAction()] : [],
  );
}

StacWidget _buildBackButton() {
  return StacIconButton(
    onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
    icon: StacImage(
      src: 'assets/icons/ic_arrow_back.svg',
      imageType: StacImageType.asset,
      width: 30,
      height: 30,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildBackAction() {
  return StacPadding(
    padding: StacEdgeInsets.only(right: 15),
    child: _buildBackButton(),
  );
}

StacWidget _buildSupportButton() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 12),
    child: StacCenter(
      child: StacContainer(
        width: 42,
        height: 42,
        child: StacCenter(
          child: StacImage(
            src: 'assets/icons/ic_support.svg',
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
