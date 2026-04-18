import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
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
            padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: _itemDecoration(),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacIcon(icon: 'fingerprint', size: 22, color: '#D32F2F'),
                StacSizedBox(width: 10),
                StacExpanded(
                  child: StacText(
                    data: 'فعال سازی تشخیص چهره',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
                StacContainer(
                  width: 48,
                  height: 28,
                  decoration: StacBoxDecoration(
                    color: '#E3E5E8',
                    borderRadius: StacBorderRadius.all(14),
                  ),
                  child: StacAlign(
                    alignment: StacAlignmentDirectional.centerEnd,
                    child: StacContainer(
                      width: 24,
                      height: 24,
                      margin: StacEdgeInsets.only(right: 2),
                      decoration: StacBoxDecoration(
                        color: '#FFFFFF',
                        shape: StacBoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 12),
          _settingsItem(
            title: 'ظاهر برنامه',
            trailingInfo: 'حالت روز',
            icon: 'palette_outlined',
          ),
          StacSizedBox(height: 12),
          _settingsItem(title: 'تغییر رمز عبور', icon: 'password'),
          StacSizedBox(height: 12),
          _settingsItem(
            title: 'حذف اطلاعات حساب کاربری',
            icon: 'delete_outline',
          ),
          StacSizedBox(height: 12),
          _settingsItem(title: 'خروج از حساب کاربری', icon: 'logout'),
        ],
      ),
    ),
  );
}

StacWidget _settingsItem({
  required String title,
  String? trailingInfo,
  required String icon,
}) {
  return StacGestureDetector(
    onTap: StacShowResultAction(
      title: title,
      content: 'این بخش به زودی فعال می‌شود.',
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: _itemDecoration(),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacIcon(
            icon: icon,
            size: 22,
            color: '{{appColors.current.text.subtitle}}',
          ),
          StacSizedBox(width: 10),
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 18,
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
            width: 14,
            height: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ],
      ),
    ),
  );
}

StacBoxDecoration _itemDecoration() {
  return StacBoxDecoration(
    color: '{{appColors.current.background.surface}}',
    borderRadius: StacBorderRadius.all(12),
    border: StacBorder.all(
      color: '{{appColors.current.input.borderEnabled}}',
      width: 1,
    ),
  );
}
