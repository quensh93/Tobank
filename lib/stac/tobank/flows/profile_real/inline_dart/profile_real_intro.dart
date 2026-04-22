import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

@StacScreen(screenName: 'profile_real_intro')
StacWidget profileRealIntro() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    body: StacStack(
      children: [
        StacAlign(
          alignment: StacAlignmentDirectional.topCenter,
          child: StacImage(
            src: '{{appAssets.current.icons.accountHeader}}',
            imageType: StacImageType.asset,
            width: 999999,
            height: 450,
            fit: StacBoxFit.fitHeight,
          ),
        ),
        StacContainer(
          width: 999999,
          height: 999999,
          child: StacColumn(
            children: [
              StacSizedBox(height: 65),
              StacText(
                data: '{{appStrings.profile.real.accountTitle}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 32),
              StacGestureDetector(
                onTap: const StacShowResultAction(
                  title: '{{appStrings.profile.real.editImageTitle}}',
                  content: '{{appStrings.profile.real.comingSoon}}',
                ),
                child: StacContainer(
                  width: 84,
                  height: 84,
                  child: StacStack(
                    children: [
                      StacAlign(
                        alignment: StacAlignmentDirectional.center,
                        child: StacContainer(
                          width: 80,
                          height: 80,
                          decoration: StacBoxDecoration(
                            color: '#F2F4F7',
                            shape: StacBoxShape.circle,
                          ),
                          child: StacPadding(
                            padding: StacEdgeInsets.all(4),
                            child: StacClipRRect(
                              borderRadius: StacBorderRadius.all(36),
                              child: StacImage(
                                src: 'assets/images/profile.png',
                                imageType: StacImageType.asset,
                                fit: StacBoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      StacAlign(
                        alignment: StacAlignmentDirectional.bottomStart,
                        child: StacContainer(
                          width: 24,
                          height: 24,
                          decoration: StacBoxDecoration(
                            color: '#FFFFFF',
                            shape: StacBoxShape.circle,
                            border: StacBorder.all(color: '#D0D5DD', width: 1),
                          ),
                          child: StacPadding(
                            padding: StacEdgeInsets.all(4),
                            child: StacImage(
                              src: '{{appAssets.icons.editAccountImage}}',
                              imageType: StacImageType.asset,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StacSizedBox(height: 16),
              StacText(
                data: '{{appStrings.profile.real.userName}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacText(
                data: '{{appStrings.profile.real.phoneNumber}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacExpanded(
                child: StacSingleChildScrollView(
                  child: StacColumn(
                    children: [
                      StacPadding(
                        padding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: StacColumn(
                          children: [
                            _buildMenuItem(
                              title:
                                  '{{appStrings.profile.real.menu.bankInfo}}',
                              iconAsset: '{{appAssets.icons.bankAccount}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_bank_info.json',
                            ),
                            StacSizedBox(height: 16),
                            _buildMenuItem(
                              title:
                                  '{{appStrings.profile.real.menu.inviteFriends}}',
                              iconAsset: '{{appAssets.icons.inviteMember}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_invite_friends.json',
                            ),
                            StacSizedBox(height: 16),
                            _buildMenuItem(
                              title:
                                  '{{appStrings.profile.real.menu.destinations}}',
                              iconAsset: '{{appAssets.icons.storedDeposit}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_destinations.json',
                            ),
                            StacSizedBox(height: 16),
                            _buildMenuItem(
                              title:
                                  '{{appStrings.profile.real.menu.settings}}',
                              iconAsset: '{{appAssets.icons.settings}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_settings.json',
                            ),
                            StacSizedBox(height: 16),
                            _buildMenuItem(
                              title: '{{appStrings.profile.real.menu.rules}}',
                              iconAsset: '{{appAssets.icons.rules}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_rules.json',
                            ),
                            StacSizedBox(height: 16),
                            _buildMenuItem(
                              title: '{{appStrings.profile.real.menu.aboutUs}}',
                              iconAsset: '{{appAssets.icons.aboutUs}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_about.json',
                            ),
                            StacSizedBox(height: 16),
                            _buildMenuItem(
                              title:
                                  '{{appStrings.profile.real.menu.contactUs}}',
                              iconAsset: '{{appAssets.icons.contact}}',
                              assetPath:
                                  'lib/stac/tobank/flows/profile_real/json/profile_real_contact.json',
                            ),
                          ],
                        ),
                      ),
                      StacText(
                        data: '{{appStrings.profile.real.appVersion}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                      ),
                      StacSizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildMenuItem({
  required String title,
  required String iconAsset,
  required String assetPath,
}) {
  return StacGestureDetector(
    onTap: StacNavigateAction(
      assetPath: assetPath,
      navigationStyle: NavigationStyle.push,
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacImage(
            src: '{{appAssets.icons.arrowLeft}}',
            imageType: StacImageType.asset,
            width: 20,
            height: 20,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ),
    ),
  );
}
