import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_invite_friends')
StacWidget profileRealInviteFriends() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'دعوت از دوستان'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            padding: StacEdgeInsets.all(16),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surface}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacCenter(
                  child: StacIcon(
                    icon: 'mail_outline',
                    size: 104,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacSizedBox(height: 10),
                StacDivider(),
                StacSizedBox(height: 14),
                StacText(
                  data: 'دعوت از دوستان',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 22,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data:
                      'کد دعوت را کپی کنید و یا با دوستانتان به اشتراک بگذارید',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 15,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacSizedBox(height: 14),
                StacContainer(
                  padding: StacEdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surfaceContainer}}',
                    borderRadius: StacBorderRadius.all(12),
                  ),
                  child: StacRow(
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacContainer(
                        width: 46,
                        height: 46,
                        decoration: StacBoxDecoration(
                          color: '#FADFE2',
                          borderRadius: StacBorderRadius.all(10),
                        ),
                        child: StacIconButton(
                          onPressed: const StacShowResultAction(
                            title: 'کپی',
                            content: 'کد دعوت کپی شد.',
                          ),
                          icon: StacIcon(
                            icon: 'content_copy',
                            size: 21,
                            color: '#D32F2F',
                          ),
                        ),
                      ),
                      StacSizedBox(width: 12),
                      StacExpanded(
                        child: StacText(
                          data: '۴۵۳۲۵۰۹۱',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.center,
                          style: StacCustomTextStyle(
                            fontSize: 28,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StacSizedBox(height: 14),
                StacFilledButton(
                  onPressed: const StacShowResultAction(
                    title: 'اشتراک‌گذاری کد دعوت',
                    content: 'امکان اشتراک‌گذاری به زودی فعال می‌شود.',
                  ),
                  style: StacButtonStyle(
                    padding: StacEdgeInsets.symmetric(vertical: 16),
                    backgroundColor:
                        '{{appColors.current.button.primary.backgroundColor}}',
                  ),
                  child: StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.center,
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacIcon(
                        icon: 'share',
                        size: 20,
                        color:
                            '{{appColors.current.button.primary.foregroundColor}}',
                      ),
                      StacSizedBox(width: 8),
                      StacText(
                        data: 'اشتراک‌گذاری کد دعوت',
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color:
                              '{{appColors.current.button.primary.foregroundColor}}',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 14),
          StacGestureDetector(
            onTap: const StacShowResultAction(
              title: 'لیست دعوت‌شدگان',
              content: 'این بخش به زودی فعال می‌شود.',
            ),
            child: StacContainer(
              padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surface}}',
                borderRadius: StacBorderRadius.all(12),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacIcon(
                    icon: 'group_add',
                    size: 24,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  StacSizedBox(width: 10),
                  StacExpanded(
                    child: StacText(
                      data: 'لیست دعوت‌شدگان',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
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
          ),
        ],
      ),
    ),
  );
}
