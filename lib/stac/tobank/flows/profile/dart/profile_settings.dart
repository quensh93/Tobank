import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_settings')
StacWidget profileRealSettings() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'تنظیمات',
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: _itemDecoration(),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.fingerprint}}',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                ),
                StacSizedBox(width: 8),
                StacExpanded(
                  child: StacText(
                    data: 'فعال سازی تشخیص چهره',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
                StacContainer(
                  width: 22,
                  height: 14,
                  child: StacCustomReactiveSwitch(
                    valueKey: 'profileRealFaceIdEnabled',
                    initialValue: false,
                    activeColor: '{{appColors.current.primary.color}}',
                    inactiveTrackColor: '#E5E7EB',
                    inactiveThumbColor: '#FFFFFF',
                    scale: 0.63,
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'ظاهر برنامه',
            trailingInfo: '{{appTheme.currentLabel}}',
            iconAsset: '{{appAssets.current.icons.theme}}',
            onTapAction: const StacShowThemeSelectorBottomSheetAction(),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'تغییر رمز عبور',
            iconAsset: '{{appAssets.current.icons.cardServicePasswordChange}}',
            onTapAction: NavigationAction(fileName: 'profile_change_password', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'حذف اطلاعات حساب کاربری',
            iconAsset: '{{appAssets.current.icons.deleteAccount}}',
            onTapAction: const StacShowDeleteAccountConfirmBottomSheetAction(),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'خروج از حساب کاربری',
            iconAsset: '{{appAssets.current.icons.logout}}',
            onTapAction: StacShowDialogAction(
              dialog: _buildLogoutConfirmDialog().toJson(),
              barrierDismissible: true,
              barrierColor: '#8B63708C',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildLogoutConfirmDialog() {
  return StacContainer(
    padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCenter(
          child: StacImage(
            src: 'assets/icons/ic_warning_red.svg',
            imageType: StacImageType.asset,
            width: 56,
            height: 56,
            fit: StacBoxFit.contain,
          ),
        ),
        StacSizedBox(height: 12),
        StacText(
          data: 'مطمئن به خروج از حساب‌کاربری هستید؟',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 17,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 12),
        StacText(
          data:
              'در صورت خروج از حساب‌کاربری، برای ورود مجدد نیاز به احراز هویت خواهد داشت. احراز هویت مجدد، به منظور افزایش امنیت حساب‌کاربری و جلوگیری از دسترسی غیرمجاز افراد ناشناس به حساب شما می‌باشد.',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 18),
        StacRow(
          textDirection: StacTextDirection.ltr,
          children: [
            StacExpanded(
              child: StacFilledButton(
                onPressed: const StacCloseDialogAction(),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 50),
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                  elevation: 0,
                ),
                child: StacText(
                  data: 'بله',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: StacOutlinedButton(
                onPressed: const StacCloseDialogAction(),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 50),
                  side: StacBorderSide(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1.2,
                  ),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                ),
                child: StacText(
                  data: 'خیر',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _settingsItem({
  required String title,
  String? trailingInfo,
  required String iconAsset,
  dynamic onTapAction,
}) {
  return StacGestureDetector(
    onTap:
        onTapAction ??
        StacShowResultAction(
          title: title,
          content: 'این بخش به زودی فعال می‌شود.',
        ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: _itemDecoration(),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
          StacSizedBox(width: 8),

          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          if (trailingInfo != null) ...[
            StacText(
              data: trailingInfo,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacSizedBox(width: 8),
          ],
          StacImage(
            src: '{{appAssets.icons.arrowLeft}}',
            imageType: StacImageType.asset,
            width: 29,
            height: 29,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ),
    ),
  );
}

StacBoxDecoration _itemDecoration() {
  return StacBoxDecoration(
    color: '{{appColors.current.background.surface}}',
    borderRadius: StacBorderRadius.all(8),
    border: StacBorder.all(
      color: '{{appColors.current.input.borderEnabled}}',
      width: 1,
    ),
  );
}

