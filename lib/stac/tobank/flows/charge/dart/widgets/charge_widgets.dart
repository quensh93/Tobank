import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

StacWidget buildChargeRealAddButton({required String routeName}) {
  return StacFilledButton(
    onPressed: NavigationAction(
      fileName: routeName,
      navMode: NavModes.dart,
      navigationStyle: NavigationStyle.push,
    ),
    style: StacButtonStyle(
      fixedSize: StacSize(148, 56),
      backgroundColor: '{{appColors.current.primary.color}}',
      foregroundColor: '{{appColors.current.primary.onPrimary}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      elevation: 0,
    ),
    child: StacRow(
      mainAxisSize: StacMainAxisSize.min,
      textDirection: StacTextDirection.rtl,
      children: [
        StacIcon(
          icon: 'add',
          size: 20,
          color: '{{appColors.current.primary.onPrimary}}',
        ),
        StacSizedBox(width: 7),
        StacText(
          data: '{{appStrings.generated.charge.charge_intro.new_topup}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.primary.onPrimary}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget buildChargeRealSimCardItem({
  required String operatorName,
  required String number,
  required String logo,
  required String useFilledCardVisible,
  StacAction? onTap,
  StacAction? onLongPress,
}) {
  final item = StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      crossAxisAlignment: StacCrossAxisAlignment.center,
      children: [
        StacImage(
          src: logo,
          imageType: StacImageType.asset,
          width: 28,
          height: 18,
          fit: StacBoxFit.contain,
        ),
        StacSizedBox(width: 8),
        StacText(
          data: operatorName,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 17,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacText(
          data: number,
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 13,
            fontWeight: StacFontWeight.w400,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(width: 10),
        StacIcon(
          icon: 'chevron_left',
          size: 28,
          color: '{{appColors.current.text.title}}',
        ),
      ],
    ),
  );

  final decorated = StacCustomVisibility(
    visible: useFilledCardVisible,
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(8),
      ),
      child: item,
    ).toJson(),
    replacement: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(8),
      ),
      child: item,
    ).toJson(),
  );

  if (onTap == null && onLongPress == null) {
    return decorated;
  }

  return StacGestureDetector(
    onTap: onTap,
    onLongPress: onLongPress,
    child: decorated,
  );
}

StacWidget buildChargeRealDuplicateBanner() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 11),
    decoration: StacBoxDecoration(
      color: '#FBE4E6',
      borderRadius: StacBorderRadius.all(6),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        StacIcon(
          icon: 'error_outline',
          size: 19,
          color: '{{appColors.current.feedback.error}}',
        ),
        StacSizedBox(width: 8),
        StacText(
          data:
              '{{appStrings.generated.charge.charge_intro.is_duplicate_sim_card}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.feedback.error}}',
          ),
        ),
      ],
    ),
  );
}
