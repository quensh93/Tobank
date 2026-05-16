import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_contact')
StacWidget profileRealContact() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'تماس با ما',
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _addressCard(
            label: 'آدرس',
            value: 'تهران، سعادت‌آباد، بلوار فرهنگ، نبش کوچه نور، پلاک ۶',
          ),
          StacSizedBox(height: 16),
          _infoRowCard(label: 'کد پستی', value: '۱۹۹۷۷۴۴۵۳۷'),
          StacSizedBox(height: 16),
          _infoRowCard(label: 'پشتیبانی شعبه', value: 'داخلی ۳ - ۰۲۱۲۳۹۵۰'),
          StacSizedBox(height: 16),
          _infoRowCard(
            label: 'اینستاگرام بانک گردشگری',
            value: '@tourism.bank',
            isUnderlinedValue: true,
            valueTextDirection: StacTextDirection.ltr,
          ),
          StacSizedBox(height: 32),
          StacCenter(
            child: StacText(
              data: 'ارتباط با توبانک',
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
                title: 'ارتباط با توبانک',
                content: 'این بخش به زودی فعال می‌شود.',
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
