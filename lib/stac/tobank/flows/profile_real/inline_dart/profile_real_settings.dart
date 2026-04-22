import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_settings')
StacWidget profileRealSettings() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'ØªÙ†Ø¸ÛŒÙ…Ø§Øª'),
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
                    data: 'ÙØ¹Ø§Ù„ Ø³Ø§Ø²ÛŒ ØªØ´Ø®ÛŒØµ Ú†Ù‡Ø±Ù‡',
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
            title: 'Ø¸Ø§Ù‡Ø± Ø¨Ø±Ù†Ø§Ù…Ù‡',
            trailingInfo: 'Ø­Ø§Ù„Øª Ø±ÙˆØ²',
            iconAsset: '{{appAssets.current.icons.theme}}',
            onTapAction: const StacShowThemeSelectorBottomSheetAction(),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'ØªØºÛŒÛŒØ± Ø±Ù…Ø² Ø¹Ø¨ÙˆØ±',
            iconAsset: '{{appAssets.current.icons.cardServicePasswordChange}}',
            onTapAction: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/profile_real/json/profile_real_change_password.json',
              navigationStyle: NavigationStyle.push,
            ),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'Ø­Ø°Ù Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø­Ø³Ø§Ø¨ Ú©Ø§Ø±Ø¨Ø±ÛŒ',
            iconAsset: '{{appAssets.current.icons.deleteAccount}}',
            onTapAction: const StacShowDeleteAccountConfirmBottomSheetAction(),
          ),
          StacSizedBox(height: 16),
          _settingsItem(
            title: 'Ø®Ø±ÙˆØ¬ Ø§Ø² Ø­Ø³Ø§Ø¨ Ú©Ø§Ø±Ø¨Ø±ÛŒ',
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
          content: 'Ø§ÛŒÙ† Ø¨Ø®Ø´ Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ ÙØ¹Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯.',
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
