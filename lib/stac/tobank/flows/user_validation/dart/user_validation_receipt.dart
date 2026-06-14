import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'user_validation_receipt')
StacWidget userValidationReceipt() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'اعتبارسنجی',
    ),
    body: StacCustomWidget.fromJson({
      'type': 'receiptRepaintBoundary',
      'boundaryKey': 'userValidationReceiptContent',
      'child': StacSingleChildScrollView(
        padding: StacEdgeInsets.only(left: 16, top: 14, right: 16, bottom: 24),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 8),
            StacCenter(
              child: StacImage(
                src: 'assets/icons/ic_transaction_success.svg',
                imageType: StacImageType.asset,
                width: 45,
                height: 45,
              ),
            ),
            StacSizedBox(height: 12),
            StacText(
              data: 'پرداخت موفق',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 21,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.success.color}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacText(
              data: 'عملیات پرداخت با موفقیت انجام شد',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 20),
            _receiptDetailCard(),
            StacSizedBox(height: 16),
            _reportCard(),
          ],
        ),
      ).toJson(),
    }),
  );
}

StacAction _shareValidationReceiptAction() {
  return StacCustomAction.fromJson({
    'actionType': 'transferReceipt',
    'mode': 'shareImage',
    'title': 'گزارش اعتبارسنجی',
    'pixelRatio': 3.0,
    'boundaryKey': 'userValidationReceiptContent',
  });
}

StacWidget _receiptDetailCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      children: [
        _receiptRow('مبلغ پرداخت', '۸۰,۰۰۰ ریال'),
        _line(),
        _receiptRow('تاریخ پرداخت', '۰۳ خرداد ۱۴۰۵ - ۱۰:۱۳'),
        _line(),
        _receiptRow('کد پیگیری', '۵۰۰۰ ۳۰۷۰ ۹۰۰۰ ۰۷۹۵ ۸۵۰۶'),
        _line(),
        _receiptRow('متقاضی', 'علیرضا حیدریان'),
        _line(),
        _receiptRow('روش پرداخت', 'سپرده'),
      ],
    ),
  );
}

StacWidget _reportCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacImage(
              src: 'assets/icons/ic_pdf_file.svg',
              imageType: StacImageType.asset,
              width: 32,
              height: 32,
            ),
            StacSizedBox(width: 8),
            StacExpanded(
              child: StacText(
                data: 'گزارش اعتبارسنجی',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacGestureDetector(
              onTap: NavigationAction(fileName: 'user_validation_preview', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
              child: StacPadding(
                padding: StacEdgeInsets.all(6),
                child: StacImage(
                  src: 'assets/icons/ic_show.svg',
                  imageType: StacImageType.asset,
                  width: 22,
                  height: 22,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(width: 8),
            StacGestureDetector(
              onTap: _shareValidationReceiptAction(),
              child: StacPadding(
                padding: StacEdgeInsets.all(6),
                child: StacImage(
                  src: 'assets/icons/ic_share.svg',
                  imageType: StacImageType.asset,
                  width: 22,
                  height: 22,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 10),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacSizedBox(height: 10),
        StacText(
          data: 'کاربر گرامی گزارش اعتبارسنجی شما در بخش گزارش‌ها نیز قابل مشاهده است',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _receiptRow(String key, String value) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 10),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacText(
            data: key,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ),
        StacSizedBox(width: 8),
        StacExpanded(
          child: StacText(
            data: value,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _line() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 2),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: List.generate(
        42,
        (_) => StacContainer(
          width: 3,
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
      ),
    ),
  );
}
