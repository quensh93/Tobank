import 'package:stac_core/stac_core.dart';

/// Tobank Menu Screen - Simple menu with list of menu items
/// 
/// This screen displays a simple list of menu items that users can navigate to.
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
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/menu-items',
        method: Method.get,
      ),
      targetPath: 'data.menuItems',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.menu.errorLoading}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            color: '{{appColors.current.error.color}}',
          ),
        ),
      ),
      emptyTemplate: StacCenter(
        child: StacText(
          data: '{{appStrings.menu.noItemsFound}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      template: StacListView(
        padding: StacEdgeInsets.all(8),
        // itemTemplate will be added to JSON after build
        children: [],
      ),
      // Note: itemTemplate for StacListTile will be added during JSON generation
      // For now, we define it here but it will be processed by the build system
    ),
  );
}
