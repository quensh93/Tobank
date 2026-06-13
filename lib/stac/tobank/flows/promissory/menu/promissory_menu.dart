import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';

/// Promissory Real Flow - Debug Menu
///
/// This screen provides entry points for testing various parts of the promissory flow.
@StacScreen(screenName: 'promissory_debug')
StacWidget promissoryRealDebugMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        // منوی دیباگ سفته
        data: '{{appStrings.promissory.debug.menuTitle}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
      leading: StacIconButton(
        onPressed: const StacNavigateAction(
          navigationStyle: NavigationStyle.pop,
        ),
        icon: StacImage(
          src: 'assets/icons/ic_right_arrow.svg',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacText(
            // مسیرهای ورود جریان
            data: '{{appStrings.promissory.debug.flowEntryPoints}}',
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 32),
          StacFilledButton(
            onPressed: NavigationAction(fileName: 'promissory_intro', navMode: NavModes.localJson, navigationStyle: NavigationStyle.push),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              // بارگذاری از JSON محلی
              data: '{{appStrings.promissory.debug.loadLocalJson}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: NavigationAction(fileName: 'promissory_intro', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              // بارگذاری از DART
              data: '{{appStrings.promissory.debug.loadDart}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacOutlinedButton(
            onPressed: NavigationAction(fileName: 'promissory_loader', navMode: NavModes.dart, navigationStyle: NavigationStyle.pushReplacement),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: StacText(
              // بارگذاری از API جریان
              data: '{{appStrings.promissory.loadFromJsonApi}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 32),
          StacDivider(),
          StacSizedBox(height: 16),
          StacText(
            // روش‌های ورود
            data: '{{appStrings.promissory.debug.loginMethods}}',
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              fontWeight: StacFontWeight.w500,
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: const StacPromissoryRealLoginAction(),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
            ),
            child: StacText(
              // ورود استاتیک
              data: '{{appStrings.promissory.debug.staticLogin}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacOutlinedButton(
            onPressed: NavigationAction(fileName: 'login_form_dart', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
            ),
            child: StacText(
              // ورود داینامیک
              data: '{{appStrings.promissory.debug.dynamicLogin}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class StacPromissoryRealLoginAction extends StacAction {
  const StacPromissoryRealLoginAction();

  @override
  String get actionType => 'promissory_login';

  @override
  Map<String, dynamic> toJson() => {'actionType': 'promissory_login'};
}
