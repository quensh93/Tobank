import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_invite_friends')
StacWidget profileRealInviteFriends() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'Ø¯Ø¹ÙˆØª Ø§Ø² Ø¯ÙˆØ³ØªØ§Ù†'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            padding: StacEdgeInsets.all(16),
            decoration: _itemDecoration(),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacCenter(
                  child: StacImage(
                    src: 'assets/icons/ic_invite_header.svg',
                    imageType: StacImageType.asset,
                    width: 205,
                    height: 189,
                  ),
                ),
                StacSizedBox(height: 16),
                StacText(
                  data: 'Ø¯Ø¹ÙˆØª Ø§Ø² Ø¯ÙˆØ³ØªØ§Ù†',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data:
                      'Ú©Ø¯ Ø¯Ø¹ÙˆØª Ø±Ø§ Ú©Ù¾ÛŒ Ú©Ù†ÛŒØ¯ Ùˆ ÛŒØ§ Ø¨Ø§ Ø¯ÙˆØ³ØªØ§Ù†ØªØ§Ù† Ø¨Ù‡ Ø§Ø´ØªØ±Ø§Ú© Ø¨Ú¯Ø°Ø§Ø±ÛŒØ¯',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacSizedBox(height: 16),
                _inviteCodeCard(),
                StacSizedBox(height: 16),
                StacFilledButton(
                  onPressed: const StacShowResultAction(
                    title: 'Ø§Ø´ØªØ±Ø§Ú©â€ŒÚ¯Ø°Ø§Ø±ÛŒ Ú©Ø¯ Ø¯Ø¹ÙˆØª',
                    content:
                        'Ø§Ù…Ú©Ø§Ù† Ø§Ø´ØªØ±Ø§Ú©â€ŒÚ¯Ø°Ø§Ø±ÛŒ Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ ÙØ¹Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯.',
                  ),
                  style: StacButtonStyle(
                    elevation: 0,
                    fixedSize: const StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(10),
                    ),
                    backgroundColor:
                        '{{appColors.current.button.primary.backgroundColor}}',
                  ),
                  child: StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.center,
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacImage(
                        src: 'assets/icons/ic_share.svg',
                        imageType: StacImageType.asset,
                        width: 20,
                        height: 20,
                        color:
                            '{{appColors.current.button.primary.foregroundColor}}',
                      ),
                      StacSizedBox(width: 8),
                      StacText(
                        data: 'Ø§Ø´ØªØ±Ø§Ú©â€ŒÚ¯Ø°Ø§Ø±ÛŒ Ú©Ø¯ Ø¯Ø¹ÙˆØª',
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w500,
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
          StacSizedBox(height: 16),
          StacGestureDetector(
            onTap: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/profile_real/json/profile_real_customer_referrals.json',
              navigationStyle: NavigationStyle.push,
            ),
            child: StacContainer(
              padding: StacEdgeInsets.all(16),
              decoration: _itemDecoration(),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacImage(
                    src: 'assets/icons/ic_person.svg',
                    imageType: StacImageType.asset,
                    width: 24,
                    height: 24,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  StacSizedBox(width: 8),
                  StacExpanded(
                    child: StacText(
                      data: 'Ù„ÛŒØ³Øª Ø¯Ø¹ÙˆØªâ€ŒØ´Ø¯Ú¯Ø§Ù†',
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
                    width: 2,
                    height: 16,
                    color: '{{appColors.current.input.borderEnabled}}',
                  ),
                  StacSizedBox(width: 8),
                  StacImage(
                    src: '{{appAssets.icons.arrowLeft}}',
                    imageType: StacImageType.asset,
                    width: 31,
                    height: 31,
                    color: '{{appColors.current.text.title}}',
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

StacWidget _inviteCodeCard() {
  return StacContainer(
    height: 61,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
    ),
    child: StacRow(
      textDirection: StacTextDirection.ltr,
      children: [
        StacExpanded(
          child: StacContainer(
            height: 64,
            child: StacStack(
              children: [
                StacAlign(
                  alignment: StacAlignmentDirectional.topEnd,
                  child: StacPadding(
                    padding: StacEdgeInsets.only(top: 2, right: 24),
                    child: StacImage(
                      src: 'assets/icons/ic_invite_code.svg',
                      imageType: StacImageType.asset,
                      width: 99,
                      height: 61,
                    ),
                  ),
                ),
                StacCenter(
                  child: StacText(
                    data: 'Û´ÛµÛ³Û²ÛµÛ°Û¹Û±',
                    textDirection: StacTextDirection.ltr,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 20,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        StacContainer(
          width: 64,
          height: 64,
          child: StacCenter(
            child: StacContainer(
              width: 48,
              height: 48,
              decoration: StacBoxDecoration(
                color: '#33D61F2C',
                borderRadius: StacBorderRadius.all(8),
              ),
              child: StacIconButton(
                onPressed: const StacShowResultAction(
                  title: 'Ú©Ù¾ÛŒ',
                  content: 'Ú©Ø¯ Ø¯Ø¹ÙˆØª Ú©Ù¾ÛŒ Ø´Ø¯.',
                ),
                icon: StacImage(
                  src: 'assets/icons/ic_copy.svg',
                  imageType: StacImageType.asset,
                  width: 35,
                  height: 35,
                  color: '{{appColors.current.primary.color}}',
                ),
              ),
            ),
          ),
        ),
      ],
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
