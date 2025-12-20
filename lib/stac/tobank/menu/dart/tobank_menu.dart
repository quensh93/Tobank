import 'package:stac_core/stac_core.dart';

/// Tobank Menu Screen - Menu with Flows, Completed Items, and Incomplete Items sections
///
/// This screen displays:
/// 1. Flows Section (روند ها) - Complete user flows that connect multiple screens
/// 2. Completed Items Section - Individual screens that are done
/// 3. Incomplete Items Section (سایر موارد) - Individual screens still in progress
///
/// Menu items are loaded from mock API to separate data layer from code.
/// Uses STAC Dart syntax with StacDynamicView for data binding.
@StacScreen(screenName: 'tobank_menu_dart')
StacWidget tobankMenuDart() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.menu.title}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 20,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      centerTitle: true,
      actions: [
        StacIconButton(
          onPressed: StacAction(jsonData: {'actionType': 'toggleTheme'}),
          tooltip: '{{appStrings.menu.themeToggle.tooltip}}',
          icon: StacImage(
            src: '{{appAssets.icons.theme}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
    body: StacListView(
      padding: StacEdgeInsets.all(16),
      children: [
        // ============================================
        // FLOWS SECTION (روند ها)
        // ============================================

        // Flows Section Divider with Text
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacContainer(
                height: 1,
                color: '{{appColors.current.primary.color}}',
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 12),
              child: StacText(
                data: "روند ها",
                style: StacCustomTextStyle(
                  color: '{{appColors.current.primary.color}}',
                  fontSize: 14,
                  fontWeight: StacFontWeight.bold,
                ),
              ),
            ),
            StacExpanded(
              child: StacContainer(
                height: 1,
                color: '{{appColors.current.primary.color}}',
              ),
            ),
          ],
        ),

        StacSizedBox(height: 16),

        // Flows Items - Load from API
        StacDynamicView(
          request: StacNetworkRequest(
            url: 'https://api.tobank.com/menu-items',
            method: Method.get,
          ),
          targetPath: 'data.flows',
          loaderWidget: StacCenter(child: StacCircularProgressIndicator()),
          errorWidget: StacSizedBox(),
          emptyTemplate: StacSizedBox(),
          template: StacListView(padding: StacEdgeInsets.all(0), children: []),
        ),

        StacSizedBox(height: 24),

        // ============================================
        // COMPLETED ITEMS SECTION (صفحات تمام شده)
        // ============================================

        // Completed Items Section Divider
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacContainer(
                height: 1,
                color: '{{appColors.current.success.color}}',
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 12),
              child: StacText(
                data: "صفحات تمام شده",
                style: StacCustomTextStyle(
                  color: '{{appColors.current.success.color}}',
                  fontSize: 12,
                  fontWeight: StacFontWeight.w500,
                ),
              ),
            ),
            StacExpanded(
              child: StacContainer(
                height: 1,
                color: '{{appColors.current.success.color}}',
              ),
            ),
          ],
        ),

        StacSizedBox(height: 16),

        // Completed Items
        StacDynamicView(
          request: StacNetworkRequest(
            url: 'https://api.tobank.com/menu-items',
            method: Method.get,
          ),
          targetPath: 'data.completedItems',
          loaderWidget: StacCenter(child: StacCircularProgressIndicator()),
          errorWidget: StacCenter(
            child: StacText(
              data: '{{appStrings.menu.errorLoading}}',
              style: StacCustomTextStyle(
                color: '{{appColors.current.error.color}}',
              ),
            ),
          ),
          emptyTemplate: StacSizedBox(),
          template: StacListView(padding: StacEdgeInsets.all(0), children: []),
        ),

        StacSizedBox(height: 24),

        // ============================================
        // INCOMPLETE ITEMS SECTION (سایر موارد)
        // ============================================

        // Incomplete Items Separator
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacContainer(
                height: 1,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 12),
              child: StacText(
                data: "سایر موارد",
                style: StacCustomTextStyle(
                  color: '{{appColors.current.text.subtitle}}',
                  fontSize: 12,
                  fontWeight: StacFontWeight.w500,
                ),
              ),
            ),
            StacExpanded(
              child: StacContainer(
                height: 1,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ],
        ),

        StacSizedBox(height: 16),

        // Incomplete Items Section
        StacDynamicView(
          request: StacNetworkRequest(
            url: 'https://api.tobank.com/menu-items',
            method: Method.get,
          ),
          targetPath: 'data.incompleteItems',
          loaderWidget: StacCenter(child: StacCircularProgressIndicator()),
          errorWidget: StacCenter(
            child: StacText(
              data: '{{appStrings.menu.errorLoading}}',
              style: StacCustomTextStyle(
                color: '{{appColors.current.error.color}}',
              ),
            ),
          ),
          emptyTemplate: StacSizedBox(),
          template: StacListView(padding: StacEdgeInsets.all(0), children: []),
        ),
      ],
    ),
  );
}
