import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';

import '../../../../../stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'tobank_facilities_page')
StacWidget tobankFacilitiesPage() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      title: StacText(
        data: 'انواع تسهیلات',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
      leading: StacPadding(
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
      ),
      actions: [
        StacPadding(
          padding: StacEdgeInsets.only(right: 15),
          child: StacIconButton(
            onPressed: const StacNavigateAction(
              navigationStyle: NavigationStyle.pop,
            ),
            icon: StacImage(
              src: '{{appAssets.icons.arrowBack}}',
              imageType: StacImageType.asset,
              width: 30,
              height: 30,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, top: 24, right: 16, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _buildFacilitiesRow(
            first: _buildFacilityTile(
              title: 'تسهیلات فرزندآوری',
              subtitle: 'ثبت و پیگیری درخواست',
              iconPath: 'assets/icons/ic_children_loan.svg',
              onTap: NavigationAction(
                fileName: 'child_loan_rules',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
              ),
            ),
            second: _buildFacilityTile(
              title: 'تسهیلات ازدواج',
              subtitle: 'ثبت و پیگیری درخواست',
              iconPath: 'assets/icons/ic_loan.svg',
            ),
          ),
          StacSizedBox(height: 16),
          _buildFacilitiesRow(
            first: _buildFacilityTile(
              title: 'کارت اعتباری',
              subtitle: 'درخواست کارت اعتباری',
              iconPath: 'assets/icons/ic_credit_card.svg',
            ),
            second: _buildFacilityTile(
              title: 'تسهیلات خرد',
              subtitle: 'درخواست تسهیلات',
              iconPath: 'assets/icons/ic_micro_lending_loan.svg',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildFacilitiesRow({
  required StacWidget first,
  required StacWidget second,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(child: first),
      StacSizedBox(width: 16),
      StacExpanded(child: second),
    ],
  );
}

StacWidget _buildFacilityTile({
  required String title,
  required String subtitle,
  required String iconPath,
  StacAction? onTap,
}) {
  final tile = StacContainer(
    height: 176,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(16),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 32,
            height: 32,
          ),
          StacSizedBox(height: 18),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
              height: 1.5,
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data: subtitle,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 12,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
              height: 1.65,
            ),
          ),
        ],
      ),
    ),
  );

  if (onTap == null) {
    return tile;
  }

  return StacGestureDetector(onTap: onTap, child: tile);
}
