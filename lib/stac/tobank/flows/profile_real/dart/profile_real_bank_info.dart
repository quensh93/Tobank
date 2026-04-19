import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
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
          StacSizedBox(height: 16),
          StacGestureDetector(
            onTap: const StacShowBankAddressBottomSheetAction(
              address:
                  'مرکزی - تهران منطقه جغرافیایی - شهر: نام منطقه جغرافیایی - تهران - کد نقطه جغرافیایی: ۱۷۷۱۲ - نام محله: اختیاری - نوع و نام ساختمان: برگزیده',
              postalCode: '۱۹۵۱۳۴۷۱۳',
            ),
            child: StacContainer(
              padding: StacEdgeInsets.all(16),
              decoration: _itemDecoration(),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacImage(
                    src: 'assets/icons/ic_location.svg',
                    imageType: StacImageType.asset,
                    width: 22,
                    height: 22,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  StacSizedBox(width: 8),
                  StacExpanded(
                    child: StacText(
                      data: 'آدرس ثبت‌شده در بانک',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                  StacImage(
                    src: '{{appAssets.icons.arrowLeft}}',
                    imageType: StacImageType.asset,
                    width: 35,
                    height: 35,
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

StacWidget _infoCard({required String label, required String value}) {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: _itemDecoration(),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: [
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w400,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacText(
          data: value,
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
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
