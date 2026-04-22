import 'package:stac_core/stac_core.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_about')
StacWidget profileRealAbout() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'Ø¯Ø±Ø¨Ø§Ø±Ù‡ Ù…Ø§'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 32),
          StacCenter(
            child: StacImage(
              src: 'assets/icons/ic_tobank_red.svg',
              imageType: StacImageType.asset,
              width: 164,
              height: 40,
            ),
          ),
          StacSizedBox(height: 16),
          StacCenter(
            child: StacText(
              data: 'ÛŒÚ© Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ Ù‡Ù…Ø±Ø§Ù‡ Ø´Ù…Ø§Ø³Øª!',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 32),
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacText(
              data:
                  'Ø³ÙˆÙ¾Ø± Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù† ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ù‡ Ø¹Ù†ÙˆØ§Ù† Ù…Ø­ØµÙˆÙ„ Ù…Ø´ØªØ±Ú© Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ Ùˆ Ø´Ø±Ú©Øª Ù†ÙˆÛŒÙ† Ø§Ù†Ø¯ÛŒØ´Ù‡ '
                  'Ùˆ Ø¢Ø±Ø§Ù…Ø´ Ø¢ÙØ±ÛŒÙ†Ø§Ù† Ù¾Ø§Ø³Ø§Ø±Ú¯Ø§Ø¯ØŒ Ø¬Ø§Ù…Ø¹ Ø¯Ø± Ø­ÙˆØ²Ù‡ Ù¾Ø±Ø¯Ø§Ø®Øª Ùˆ Ø®Ø¯Ù…Ø§Øª Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ Ø§Ø³Øª. '
                  'Ø§ÛŒÙ† Ø³ÙˆÙ¾Ø± Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù† Ø¹Ù„Ø§ÙˆÙ‡ Ø¨Ø± Ø®Ø¯Ù…Ø§Øª Ù¾Ø±Ø¯Ø§Ø®Øª Ù‡Ù…Ú†ÙˆÙ† Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±ØªØŒ Ø¯Ø± Ø¨Ø³ØªØ± Ø®Ø¯Ù…Ø§Øª Ù…Ø§Ù„ÛŒØŒ '
                  'Ø§Ø³ØªØ¹Ù„Ø§Ù… Ø®Ù„Ø§ÙÛŒ Ø®ÙˆØ¯Ø±Ùˆ Ùˆ Ù‚Ø¨ÙˆØ¶â€ŒÙ‡Ø§ÛŒ Ù…ØªÙ†ÙˆØ¹ Ùˆ Ù¾Ø±Ø¯Ø§Ø®Øª Ø¢Ù†â€ŒÙ‡Ø§ Ùˆ Ø®Ø±ÛŒØ¯ Ø´Ø§Ø±Ú˜ Ùˆ Ø¨Ø³ØªÙ‡â€ŒÛŒ Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ ØªÙ„ÙÙ† Ù‡Ù…Ø±Ø§Ù‡ØŒ '
                  'Ø§Ù…Ú©Ø§Ù† Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ùˆ Ø§ÙØªØªØ§Ø­ Ø³Ù¾Ø±Ø¯Ù‡ Ø¢Ù†Ù„Ø§ÛŒÙ† Ùˆ Ø±Ø§ÛŒÚ¯Ø§Ù† Ø¯Ø± Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ Ø±Ø§ Ù†ÛŒØ² Ø¨Ù‡ Ù…Ø±Ø§Ø¬Ø¹Ù‡ Ø­Ø¶ÙˆØ±ÛŒ Ø¨Ø±Ø§ÛŒ Ø´Ù…Ø§ Ù…ÛŒØ³Ø± Ù…ÛŒâ€ŒÚ©Ù†Ø¯.\n\n'
                  'Ø§Ù…Ù†ÛŒØªØŒ Ø³Ø±Ø¹ØªØŒ Ø³Ø§Ø¯Ú¯ÛŒØŒ ØªØ¬Ø±Ø¨Ù‡ Ú©Ø§Ø±Ø¨Ø±ÛŒ Ù…Ù†Ø­ØµØ±â€ŒØ¨Ù‡â€ŒÙØ±Ø¯ØŒ Ù¾ÙˆØ´Ø´ Ø·ÛŒÙ Ú¯Ø³ØªØ±Ø¯Ù‡â€ŒØ§ÛŒ Ø§Ø² Ø³Ø±ÙˆÛŒØ³â€ŒÙ‡Ø§ÛŒ Ù…ØªÙ†ÙˆØ¹ØŒ '
                  'ÛŒÚ©ÛŒ Ø§Ø² Ø¨Ø³ØªØ±Ù‡Ø§ÛŒ Ù…ØªÙØ§ÙˆØª Ø¯ÛŒÚ¯Ø± Ùˆ Ù‚Ø§Ø¨Ù„ Ø§Ø¹ØªÙ…Ø§Ø¯ Ø¨ÙˆØ¯Ù†ØŒ ØªÙ…Ø§Ù… Ø¢Ù† Ú†ÛŒØ²ÛŒ Ø§Ø³Øª Ú©Ù‡ Ù…ØµØ±Ùâ€ŒÚ©Ù†Ù†Ø¯Ú¯Ø§Ù† ÛŒÚ© Ø¨Ø³ØªØ± Ø®Ø¯Ù…Ø§ØªÛŒ '
                  'Ø¯Ø± Ø­ÙˆØ²Ù‡ Ù…Ø§Ù„ÛŒ Ø¨Ù‡ Ø¢Ù† Ù†ÛŒØ§Ø² Ø¯Ø§Ø±Ù†Ø¯. Ø¨Ø§ ØªÙˆØ¨Ø§Ù†Ú© Ù†ÛŒØ§Ø² Ø¨Ù‡ Ø¬Ø§Ø¨Ù‡â€ŒØ¬Ø§ÛŒÛŒ Ùˆ Ø¨Ú©Ø§Ø±Ú¯ÛŒØ±ÛŒ Ø±ÙˆØ´â€ŒÙ‡Ø§ÛŒ Ù…ØªÙØ§ÙˆØª Ø¨Ø±Ø§ÛŒ '
                  'Ù‡Ø±Ú¯ÙˆÙ†Ù‡ Ù¾Ø±Ø¯Ø§Ø®ØªØŒ Ø§Ø¹Ù… Ø§Ø² Ù†Ù‚Ø¯ Ùˆ Ø§Ù†ØªÙ‚Ø§Ù„ Ù¾ÙˆÙ„ Ùˆ Ø³Ø±Ù…Ø§ÛŒÙ‡â€ŒÚ¯Ø°Ø§Ø±ÛŒ Ø¨Ø±Ø·Ø±Ù Ù…ÛŒâ€ŒØ´ÙˆØ¯.',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
                height: 1.9,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
