import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_contact')
StacWidget profileRealContact() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'ØªÙ…Ø§Ø³ Ø¨Ø§ Ù…Ø§'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _addressCard(
            label: 'Ø¢Ø¯Ø±Ø³',
            value:
                'ØªÙ‡Ø±Ø§Ù†ØŒ Ø³Ø¹Ø§Ø¯Øªâ€ŒØ¢Ø¨Ø§Ø¯ØŒ Ø¨Ù„ÙˆØ§Ø± ÙØ±Ù‡Ù†Ú¯ØŒ Ù†Ø¨Ø´ Ú©ÙˆÚ†Ù‡ Ù†ÙˆØ±ØŒ Ù¾Ù„Ø§Ú© Û¶',
          ),
          StacSizedBox(height: 16),
          _infoRowCard(label: 'Ú©Ø¯ Ù¾Ø³ØªÛŒ', value: 'Û±Û¹Û¹Û·Û·Û´Û´ÛµÛ³Û·'),
          StacSizedBox(height: 16),
          _infoRowCard(
            label: 'Ù¾Ø´ØªÛŒØ¨Ø§Ù†ÛŒ Ø´Ø¹Ø¨Ù‡',
            value: 'Ø¯Ø§Ø®Ù„ÛŒ Û³ - Û°Û²Û±Û²Û³Û¹ÛµÛ°',
          ),
          StacSizedBox(height: 16),
          _infoRowCard(
            label: 'Ø§ÛŒÙ†Ø³ØªØ§Ú¯Ø±Ø§Ù… Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ',
            value: '@tourism.bank',
            isUnderlinedValue: true,
            valueTextDirection: StacTextDirection.ltr,
          ),
          StacSizedBox(height: 32),
          StacCenter(
            child: StacText(
              data: 'Ø§Ø±ØªØ¨Ø§Ø· Ø¨Ø§ ØªÙˆØ¨Ø§Ù†Ú©',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 16),
          _socialRow(
            iconAssets: [
              'assets/icons/ic_website.svg',
              'assets/icons/ic_email.svg',
              'assets/icons/ic_call.svg',
            ],
          ),
          StacSizedBox(height: 16),
          _socialRow(
            iconAssets: [
              'assets/icons/ic_aparat.svg',
              'assets/icons/ic_linkedin.svg',
              'assets/icons/ic_instagram.svg',
            ],
          ),
        ],
      ),
    ),
  );
}

StacWidget _addressCard({required String label, required String value}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
            height: 1.8,
          ),
        ),
      ],
    ),
  );
}

StacWidget _infoRowCard({
  required String label,
  required String value,
  bool isUnderlinedValue = false,
  StacTextDirection valueTextDirection = StacTextDirection.rtl,
}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: [
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w400,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        _rowValue(
          value: value,
          valueTextDirection: valueTextDirection,
          isUnderlinedValue: isUnderlinedValue,
        ),
      ],
    ),
  );
}

StacWidget _rowValue({
  required String value,
  required StacTextDirection valueTextDirection,
  required bool isUnderlinedValue,
}) {
  if (!isUnderlinedValue) {
    return StacText(
      data: value,
      textDirection: valueTextDirection,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.title}}',
      ),
    );
  }

  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.end,
    children: [
      StacText(
        data: value,
        textDirection: valueTextDirection,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 2),
      StacContainer(
        width: 98,
        height: 1,
        color: '{{appColors.current.text.title}}',
      ),
    ],
  );
}

StacWidget _socialRow({required List<String> iconAssets}) {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.center,
    children: iconAssets
        .map(
          (iconAsset) => StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 8),
            child: StacGestureDetector(
              onTap: const StacShowResultAction(
                title: 'Ø§Ø±ØªØ¨Ø§Ø· Ø¨Ø§ ØªÙˆØ¨Ø§Ù†Ú©',
                content: 'Ø§ÛŒÙ† Ø¨Ø®Ø´ Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ ÙØ¹Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯.',
              ),
              child: StacContainer(
                width: 48,
                height: 48,
                decoration: StacBoxDecoration(
                  color: '#FDF3F4',
                  shape: StacBoxShape.circle,
                ),
                child: StacCenter(
                  child: StacImage(
                    src: iconAsset,
                    imageType: StacImageType.asset,
                    width: 24,
                    height: 24,
                    color: '{{appColors.current.primary.color}}',
                  ),
                ),
              ),
            ),
          ),
        )
        .toList(),
  );
}
