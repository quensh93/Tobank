import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';

// Menu item visibility flags
const bool _showAuthentication = true;
const bool _showPromissoryApiReal = true;
const bool _showGuaranteePromissoryApiReal = true;
const bool _showAuthenticationApiReal = true;
const bool _showCreditScoringApiReal = false;
const bool _showProfileApiReal = true;
const bool _showCartableApiReal = true;
const bool _showTransactionApiReal = true;

const bool _showInstallmentPaymentApiReal = true;
const bool _showChildLoanApiReal = false;
const bool _showDepositTurnoverApiReal = false;
const bool _showDepositMoreOptions = true;

const bool _showNotificationApiReal = true;
const bool _showDashboardRealNavigation = true;
const bool _showGiftCardApiReal = true;
const bool _showTransferReal = true;
const bool _showChargeApiReal = true;
const bool _showInternetPakageApiReal = true;
const bool _showBiometricModuleTest = true;

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

        if (_showAuthentication)
          _buildMenuItemCard(
            title: 'لاگین',
            dartPath: 'lib/stac/tobank/flows/login/dart/login_splash.dart',
            jsonPath: 'lib/stac/tobank/flows/login/json/login_splash.json',
            apiPath: null,
            widgetType: 'login_splash',
          ),
        if (_showPromissoryApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'سفته',
            widgetType: 'promissory_menu',
          ),
        if (_showGuaranteePromissoryApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'ضمانت سفته (API واقعی)',
            widgetType: 'guarantee_promissory_api_real_menu',
          ),
        if (_showAuthenticationApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'احراز هویت',
            widgetType: 'authentication_menu',
          ),
        if (_showCreditScoringApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'اعتبارسنجی',
            widgetType: 'tobank_user_credit_validation',
          ),
        if (_showProfileApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'پروفایل',
            widgetType: 'profile_menu',
          ),
        if (_showCartableApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'کارتابل',
            widgetType: 'cartable_menu',
          ),
        if (_showTransactionApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'تراکنش‌ها',
            widgetType: 'transaction_menu',
          ),
        if (_showInstallmentPaymentApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'پرداخت اقساط',
            widgetType: 'installment_payment_api_real_menu',
          ),
        if (_showChildLoanApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'تسهیلات فرزندآوری',
            widgetType: 'child_loan_api_real_menu',
          ),
        if (_showNotificationApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'اعلانات',
            widgetType: 'notification_menu',
          ),
        if (_showDepositTurnoverApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'گردش سپرده',
            widgetType: 'deposit_turnover_menu',
          ),
        if (_showDepositMoreOptions)
          _buildSingleButtonMenuItemCard(
            title: 'بیشتر(سپرده)',
            widgetType: 'deposit_more_options_menu',
          ),
        if (_showDashboardRealNavigation)
          _buildSingleButtonMenuItemCard(
            title: 'داشبورد',
            widgetType: 'dashboard_menu',
          ),
        if (_showGiftCardApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'کارت هدیه',
            widgetType: 'gift_card_menu',
          ),
        if (_showTransferReal)
          _buildSingleButtonMenuItemCard(
            title: 'انتقال وجه',
            widgetType: 'transfer_menu',
          ),
        if (_showChargeApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'شارژ',
            widgetType: 'charge_menu',
          ),
        if (_showInternetPakageApiReal)
          _buildSingleButtonMenuItemCard(
            title: 'پکیج اینترنت',
            widgetType: 'internet_pakage_menu',
          ),
        StacSizedBox(height: 20),
        _buildSectionHeader('ماژول ها'),
        StacSizedBox(height: 8),
        if (_showBiometricModuleTest)
          _buildSingleButtonMenuItemCard(
            title: 'بیومتریک (تست ماژول)',
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
              maxLines: 1,
              overflow: StacTextOverflow.ellipsis,
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
              maxLines: 1,
              overflow: StacTextOverflow.ellipsis,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 8),
          StacRow(
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
      onPressed = NavigationAction(fileName: widgetType, navMode: NavModes.dart, navigationStyle: NavigationStyle.push);
    } else if (hasValidPath) {
      onPressed = NavigationAction(navMode: NavModes.localJson, pathOverride: path, navigationStyle: NavigationStyle.push);
    }
  } else if (hasValidPath) {
    onPressed = NavigationAction(navMode: NavModes.localJson, pathOverride: path, navigationStyle: NavigationStyle.push);
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
