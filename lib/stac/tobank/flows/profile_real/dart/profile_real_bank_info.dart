import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_bank_info')
StacWidget profileRealBankInfo() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'اطلاعات بانکی'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _infoCard(label: 'شماره مشتری', value: '۱۷۵۵۸۰۹'),
          StacSizedBox(height: 14),
          StacGestureDetector(
            onTap: const StacShowResultAction(
              title: 'آدرس ثبت‌شده در بانک',
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
                    icon: 'location_on_outlined',
                    size: 22,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  StacSizedBox(width: 10),
                  StacExpanded(
                    child: StacText(
                      data: 'آدرس ثبت‌شده در بانک',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 20,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                  StacSizedBox(width: 8),
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

StacWidget _infoCard({required String label, required String value}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 10),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 26,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}
