import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_settings')
StacWidget profileRealSettings() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'تنظیمات'),
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
            trailingInfo: 'حالت روز',
            iconAsset: '{{appAssets.current.icons.theme}}',
            onTapAction: const StacShowThemeSelectorBottomSheetAction(),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'تغییر رمز عبور',
            iconAsset: '{{appAssets.current.icons.cardServicePasswordChange}}',
            onTapAction: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'profile_real_change_password',
              'navigationStyle': 'push',
            }),
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
            onTapAction: const StacShowLogoutConfirmDialogAction(),
          ),
        ],
      ),
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
