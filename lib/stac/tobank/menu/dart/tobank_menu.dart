import 'package:stac_core/stac_core.dart';

/// Tobank Menu Screen built entirely from Dart (no menu-items JSON dependency).
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
        _buildMenuItemCard(
          title: 'لاگین (خطی)',
          dartPath:
              'lib/stac/tobank/flows/login_flow_linear/dart/login_flow_linear_splash.dart',
          jsonPath:
              'lib/stac/tobank/flows/login_flow_linear/json/login_flow_linear_splash.json',
          apiPath:
              'lib/stac/tobank/flows/login_flow_linear/api/GET_login_flow_linear_splash.json',
          widgetType: 'tobank_login_flow_linear_splash',
        ),
        _buildMenuItemCard(
          title: 'سفته',
          dartPath:
              'lib/stac/tobank/flows/promissory/dart/promissory_intro.dart',
          jsonPath:
              'lib/stac/tobank/flows/promissory/json/promissory_intro.json',
          apiPath:
              'lib/stac/tobank/flows/promissory/api/GET_promissory_intro.json',
          widgetType: 'promissory_intro',
        ),
        _buildMenuItemCard(
          title: 'احراز هویت',
          dartPath: 'lib/stac/tobank/login/dart/tobank_login.dart',
          jsonPath: null,
          apiPath: null,
          widgetType: 'tobank_login_dart',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'خانه',
          widgetType: 'tobank_home_page_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'سفته (API واقعی)',
          widgetType: 'promissory_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'احراز هویت (API واقعی)',
          widgetType: 'verify_identity_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'اعتبارسنجی (API واقعی)',
          widgetType: 'tobank_user_validation',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'پروفایل (API واقعی)',
          widgetType: 'profile_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'کارتابل (API واقعی)',
          widgetType: 'cartable_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'تراکنش‌ها (API واقعی)',
          widgetType: 'transaction_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'پرداخت اقساط (API واقعی)',
          widgetType: 'installment_payment_api_real_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'تسهیلات فرزندآوری ( API واقعی)',
          widgetType: 'child_loan_api_real_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'اعلانات (API واقعی)',
          widgetType: 'notification_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'گردش سپرده (API واقعی)',
          widgetType: 'deposit_turnover_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'بیشتر(سپرده)',
          widgetType: 'deposit_more_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'داشبورد (ناوبری واقعی)',
          widgetType: 'dashboard_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'کارت هدیه (API واقعی)',
          widgetType: 'gift_card_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'انتقال وجه (واقعی)',
          widgetType: 'transfer_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'شارژ (API واقعی)',
          widgetType: 'charge_menu',
        ),
        _buildSingleButtonMenuItemCard(
          title: 'پکیج اینترنت (API واقعی)',
          widgetType: 'package_menu',
        ),
        StacSizedBox(height: 20),
        _buildSectionHeader('ماژول ها'),
        StacSizedBox(height: 8),
        _buildSingleButtonMenuItemCard(
          title: 'بیومتریک ( تست ماژول)',
          widgetType: 'biometric_test_menu',
        ),
      ],
    ),
  );
}

StacWidget _buildSectionHeader(String title) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 8),
    child: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      textAlign: StacTextAlign.right,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.text.title}}',
      ),
    ),
  );
}

StacWidget _buildSingleButtonMenuItemCard({
  required String title,
  required String widgetType,
}) {
  return StacContainer(
    margin: StacEdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      border: StacBorder(
        width: 1.5,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 8),
          _buildButtonWidget(
            label: 'Run',
            path: null,
            widgetType: widgetType,
            buttonType: 'dart',
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildMenuItemCard({
  required String title,
  String? dartPath,
  String? jsonPath,
  String? apiPath,
  String? widgetType,
}) {
  return StacContainer(
    margin: StacEdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      border: StacBorder(
        width: 1.5,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 8),
          StacFlexible(
            flex: 0,
            fit: StacFlexFit.loose,
            child: StacRow(
              mainAxisSize: StacMainAxisSize.min,
              children: [
                _buildButtonWidget(
                  label: 'Dart',
                  path: dartPath,
                  widgetType: widgetType,
                  buttonType: 'dart',
                ),
                StacSizedBox(width: 4),
                _buildButtonWidget(
                  label: 'JSON',
                  path: jsonPath,
                  buttonType: 'json',
                ),
                StacSizedBox(width: 4),
                _buildButtonWidget(
                  label: 'API',
                  path: apiPath,
                  buttonType: 'api',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildButtonWidget({
  required String label,
  String? path,
  String? widgetType,
  required String buttonType,
}) {
  final hasValidPath =
      path != null &&
      path.isNotEmpty &&
      path != 'null' &&
      path.trim().isNotEmpty;

  StacAction? onPressed;
  if (buttonType == 'dart') {
    if (widgetType != null && widgetType.isNotEmpty && widgetType != 'null') {
      onPressed = StacAction.fromJson({
        'actionType': 'navigate',
        'widgetType': widgetType,
        'navigationStyle': 'push',
      });
    } else if (hasValidPath) {
      onPressed = StacNavigateAction(
        assetPath: path,
        navigationStyle: NavigationStyle.push,
      );
    }
  } else if (hasValidPath) {
    onPressed = StacNavigateAction(
      assetPath: path,
      navigationStyle: NavigationStyle.push,
    );
  }

  final isEnabled =
      hasValidPath ||
      (buttonType == 'dart' &&
          widgetType != null &&
          widgetType.isNotEmpty &&
          widgetType != 'null');

  final buttonColor = '{{appColors.current.secondary.secondaryContainer}}';
  final textColor = '{{appColors.current.secondary.color}}';
  final disabledButtonColor =
      '{{appColors.current.background.surfaceContainerHigh}}';
  final disabledTextColor = '{{appColors.current.text.hint}}';

  return StacFilledButton(
    onPressed: onPressed,
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(horizontal: 8, vertical: 6),
      minimumSize: const StacSize(0, 0),
      backgroundColor: isEnabled ? buttonColor : disabledButtonColor,
      foregroundColor: isEnabled ? textColor : disabledTextColor,
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(6)),
      tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
    ),
    child: StacText(
      data: label,
      style: StacCustomTextStyle(
        fontSize: 11,
        fontWeight: StacFontWeight.w600,
        color: isEnabled ? textColor : disabledTextColor,
      ),
    ),
  );
}
