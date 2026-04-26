import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

@StacScreen(screenName: 'tobank_special_services_page')
StacWidget tobankSpecialServicesPage() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      title: StacText(
        data: 'خدمات ویژه توبانک',
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
          _buildServicesRow(
            first: _buildServiceTile(
              title: 'خدمات موبایل بانک',
              subtitle: 'فعال سازی خدمات و صدور رمز',
              iconPath: 'assets/icons/ic_menu_mobile.svg',
            ),
            second: _buildServiceTile(
              title: 'خدمات اینترنت بانک',
              subtitle: 'فعال سازی خدمات و صدور رمز',
              iconPath: 'assets/icons/ic_menu_internet.svg',
            ),
          ),
          StacSizedBox(height: 16),
          _buildServicesRow(
            first: _buildServiceTile(
              title: 'صندوق امانات',
              subtitle: 'اجاره صندوق، رزرو زمان بازدید',
              iconPath: 'assets/icons/ic_safe_box.svg',
            ),
            second: _buildServiceTile(
              title: 'ضمانت نامه نظام وظیفه',
              subtitle: 'ثبت ضمانتنامه',
              iconPath: 'assets/icons/ic_military_guarantee.svg',
            ),
          ),
          StacSizedBox(height: 16),
          _buildServicesRow(
            first: _buildServiceTile(
              title: 'سفته آنلاین',
              subtitle: 'صدور و خدمات',
              iconPath: 'assets/icons/ic_promissory.svg',
              onTap: const StacNavigateAction(
                routeName: 'promissory_real_intro',
                navigationStyle: NavigationStyle.push,
              ),
            ),
            second: _buildServiceTile(
              title: 'اعتبارسنجی',
              subtitle: 'اعتبارسنجی خود و سایرین',
              iconPath: 'assets/icons/ic_cbs_search.svg',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildServicesRow({
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

StacWidget _buildServiceTile({
  required String title,
  required String subtitle,
  required String iconPath,
  double height = 176,
  StacAction? onTap,
}) {
  final tile = StacContainer(
    height: height,
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
