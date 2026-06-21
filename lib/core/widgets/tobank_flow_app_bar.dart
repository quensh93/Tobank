import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';

StacAppBar buildTobankFlowAppBar({
  required String title,
  bool showSupport = false,
  bool showBack = true,
  bool backOnRight = false,
  StacAction? backAction,
  String backIconSrc = '{{appAssets.icons.arrowBack}}',
  StacTextStyle? titleStyle,
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

  final List<StacWidget> actionsList = [];
  if (backOnRight && showBack) {
    actionsList.add(buildBackButton());
  } else if (showSupport && showBack) {
    actionsList.add(
      StacPadding(
        padding: StacEdgeInsets.only(right: 12),
        child: buildBackButton(),
      ),
    );
  }

  return StacAppBar(
    title: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: titleStyle ?? StacAliasTextStyle('{{appStyles.appbarStyle}}'),
    ),
    centerTitle: true,
    automaticallyImplyLeading: !backOnRight && (showBack || showSupport),
    leading: backOnRight
        ? null
        : showSupport
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
    actions: actionsList,
  );
}
