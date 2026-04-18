import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

@StacScreen(screenName: 'profile_real_intro')
StacWidget profileRealIntro() {
  return StacScaffold(
    backgroundColor: '#F4F5F8',
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, top: 20, right: 16, bottom: 12),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 20),
          StacCenter(
            child: StacText(
              data: 'حساب کاربری',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 20,
                fontWeight: StacFontWeight.w700,
                color: '#252B37',
              ),
            ),
          ),
          StacSizedBox(height: 20),
          StacCenter(
            child: StacColumn(
              mainAxisSize: StacMainAxisSize.min,
              children: [
                StacContainer(
                  width: 90,
                  height: 90,
                  child: StacStack(
                    children: [
                      StacAlign(
                        alignment: StacAlignmentDirectional.center,
                        child: StacContainer(
                          width: 84,
                          height: 84,
                          decoration: StacBoxDecoration(
                            color: '#FFFFFF',
                            shape: StacBoxShape.circle,
                            border: StacBorder.all(
                              color: '#D6DAE1',
                              width: 1,
                            ),
                          ),
                          child: StacClipRRect(
                            borderRadius: StacBorderRadius.all(42),
                            child: StacImage(
                              src: 'assets/images/profile.png',
                              imageType: StacImageType.asset,
                              fit: StacBoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      StacAlign(
                        alignment: StacAlignmentDirectional.bottomStart,
                        child: StacGestureDetector(
                          onTap: const StacShowResultAction(
                            title: 'ویرایش تصویر',
                            content: 'این بخش به زودی فعال می‌شود.',
                          ),
                          child: StacContainer(
                            width: 26,
                            height: 26,
                            decoration: StacBoxDecoration(
                              color: '#FFFFFF',
                              shape: StacBoxShape.circle,
                              border: StacBorder.all(
                                color: '#D6DAE1',
                                width: 1,
                              ),
                            ),
                            child: StacCenter(
                              child: StacIcon(
                                icon: 'edit',
                                size: 14,
                                color: '#7C8796',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StacSizedBox(height: 12),
                StacText(
                  data: 'مهدی جمشیدپور',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '#252B37',
                  ),
                ),
                StacSizedBox(height: 6),
                StacText(
                  data: '09142767469',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '#7C8796',
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 24),
          _buildMenuItem(
            title: 'اطلاعات بانکی',
            icon: 'account_balance',
            routeName: 'profile_real_bank_info',
          ),
          StacSizedBox(height: 12),
          _buildMenuItem(
            title: 'دعوت از دوستان',
            icon: 'group_add',
            routeName: 'profile_real_invite_friends',
          ),
          StacSizedBox(height: 12),
          _buildMenuItem(
            title: 'مدیریت مقصدها',
            icon: 'work_outline',
            routeName: 'profile_real_destinations',
          ),
          StacSizedBox(height: 12),
          _buildMenuItem(
            title: 'تنظیمات',
            icon: 'settings',
            routeName: 'profile_real_settings',
          ),
          StacSizedBox(height: 12),
          _buildMenuItem(
            title: 'قوانین و مقررات',
            icon: 'gavel',
            routeName: 'profile_real_rules',
          ),
          StacSizedBox(height: 12),
          _buildMenuItem(
            title: 'درباره ما',
            icon: 'info_outline',
            routeName: 'profile_real_about',
          ),
          StacSizedBox(height: 12),
          _buildMenuItem(
            title: 'تماس با ما',
            icon: 'support_agent',
            routeName: 'profile_real_contact',
          ),
          StacSizedBox(height: 24),
          StacCenter(
            child: StacText(
              data: 'نسخه برنامه ۳.۲.۶',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 13,
                fontWeight: StacFontWeight.w500,
                color: '#9AA3AF',
              ),
            ),
          ),
          StacSizedBox(height: 8),
        ],
      ),
    ),
  );
}

StacWidget _buildMenuItem({
  required String title,
  required String icon,
  required String routeName,
}) {
  return StacGestureDetector(
    onTap: StacNavigateAction(
      routeName: routeName,
      navigationStyle: NavigationStyle.push,
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: StacBoxDecoration(
        color: '#FFFFFF',
        borderRadius: StacBorderRadius.all(14),
        border: StacBorder.all(
          color: '#D6DAE1',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacIcon(
            icon: icon,
            size: 24,
            color: '#6F7A89',
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '#252B37',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacImage(
            src: '{{appAssets.icons.arrowLeft}}',
            imageType: StacImageType.asset,
            width: 16,
            height: 16,
            color: '#6F7A89',
          ),
        ],
      ),
    ),
  );
}
