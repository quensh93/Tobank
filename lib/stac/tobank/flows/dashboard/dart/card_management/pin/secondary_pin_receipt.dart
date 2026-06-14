import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_secondary_pin_result')
StacWidget dashboardSecondaryPinResult() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'تغییر رمز دوم', showSupport: true, showBack: true),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 64,
              height: 64,
              decoration: StacBoxDecoration(
                color: '#E8F5E9',
                borderRadius: StacBorderRadius.all(32),
              ),
              child: StacCenter(
                child: StacImage(
                  src: '{{appAssets.current.icons.successCheck}}',
                  imageType: StacImageType.asset,
                  width: 36,
                  height: 36,
                  color: '#43A047',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'درخواست موفق',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '#43A047',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: 'رمز دوم کارت تغییر یافت',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w400,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacSizedBox(height: 32),
          _receiptDividerRow(
            label: 'شماره کارت',
            value: '۵۰۵۴ - ۱۶۱۷ - ۰۳۰۲ - ۰۳۹۰',
          ),
          StacSizedBox(height: 16),
          _maskedPinRow(),
          StacSizedBox(height: 48),
          StacFilledButton(
            onPressed: NavigationAction(fileName: 'dashboard_cards_management', navMode: NavModes.dart, navigationStyle: NavigationStyle.pushAndRemoveAll),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'بازگشت به لیست خدمات کارت',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _receiptDividerRow({required String label, required String value}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacText(
            data: label,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w400,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacText(
            data: value,
            textDirection: StacTextDirection.ltr,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacContainer(
        height: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ],
  );
}

StacWidget _maskedPinRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: 'رمز انتخابی',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w400,
          color: '{{appColors.current.text.hint}}',
        ),
      ),
      StacRow(
        children: [
          StacText(
            data: '*****',
            textDirection: StacTextDirection.ltr,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 8),
          StacGestureDetector(
            onTap: const StacCustomSnackBarAction(
              title: 'نمایش رمز (mock)',
              detail: 'این قابلیت در نسخه واقعی فعال می‌شود.',
              duration: 2000,
            ),
            child: StacImage(
              src: 'assets/icons/ic_show_password.svg',
              imageType: StacImageType.asset,
              width: 20,
              height: 20,
              color: '{{appColors.current.icon.main}}',
            ),
          ),
          StacSizedBox(width: 8),
          StacGestureDetector(
            onTap: const StacCustomSnackBarAction(
              title: 'کپی رمز (mock)',
              detail: 'این قابلیت در نسخه واقعی فعال می‌شود.',
              duration: 2000,
            ),
            child: StacImage(
              src: 'assets/icons/ic_copy.svg',
              imageType: StacImageType.asset,
              width: 20,
              height: 20,
              color: '{{appColors.current.icon.main}}',
            ),
          ),
        ],
      ),
    ],
  );
}
