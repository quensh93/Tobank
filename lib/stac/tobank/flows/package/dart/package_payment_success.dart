import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'package_payment_success')
StacWidget packageRealPaymentSuccess() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'اینترنت',
    ),
    body: StacSafeArea(
      top: false,
      child: StacPadding(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacCustomWidget.fromJson({
                'type': 'receiptRepaintBoundary',
                'boundaryKey': 'packageRealReceiptContent',
                'child': StacSingleChildScrollView(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacSizedBox(height: 20),
                      _buildSuccessHeader(),
                      StacSizedBox(height: 18),
                      _buildReceiptCard(),
                      StacSizedBox(height: 24),
                      _buildSloganSection(),
                    ],
                  ),
                ).toJson(),
              }),
            ),
            StacRow(
              children: [
                StacExpanded(
                  child: _actionButton(
                    title: 'اشتراک‌گذاری',
                    iconAsset: 'assets/icons/ic_share.svg',
                    mode: 'shareText',
                  ),
                ),
                StacSizedBox(width: 10),
                StacExpanded(
                  child: _actionButton(
                    title: 'ذخیره در گالری',
                    iconAsset: 'assets/icons/ic_download.svg',
                    mode: 'shareImage',
                  ),
                ),
              ],
            ),
            StacSizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildSuccessHeader() {
  return StacColumn(
    children: [
      StacCenter(
        child: StacContainer(
          width: 84,
          height: 84,
          decoration: StacBoxDecoration(
            color: '#E7F7ED',
            shape: StacBoxShape.circle,
          ),
          child: StacCenter(
            child: StacContainer(
              width: 58,
              height: 58,
              decoration: StacBoxDecoration(
                color: '#BFEFD0',
                shape: StacBoxShape.circle,
              ),
              child: StacCenter(
                child: StacContainer(
                  width: 40,
                  height: 40,
                  decoration: StacBoxDecoration(
                    color: '#24B76A',
                    shape: StacBoxShape.circle,
                  ),
                  child: StacCenter(
                    child: StacIcon(icon: 'check', size: 22, color: '#FFFFFF'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      StacSizedBox(height: 14),
      StacText(
        data: 'پرداخت موفق',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 22,
          fontWeight: StacFontWeight.w700,
          color: '#17945A',
        ),
      ),
    ],
  );
}

StacWidget _buildReceiptCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _detailRow('مبلغ', '{{crPayReceiptAmount}} ریال'),
        _dottedDivider(),
        _detailRow('زمان تراکنش', '{{crPayReceiptTime}}'),
        _dottedDivider(),
        _detailRow('خدمت', '{{crPayReceiptPackage}}'),
        _dottedDivider(),
        _detailRow('پرداخت از طریق', '{{crPayReceiptVia}}'),
        _dottedDivider(),
        _detailRow('مبدا', '{{crPayReceiptFrom}}'),
        _dottedDivider(),
        _detailRow('شماره پیگیری', '{{crPayReceiptTracking}}'),
      ],
    ),
  );
}

StacWidget _detailRow(String title, String value) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 8),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _dottedDivider() {
  return StacContainer(height: 1, color: '#E5E7EB');
}

StacWidget _buildSloganSection() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacImage(
        src: 'assets/icons/ic_tobank_red.svg',
        imageType: StacImageType.asset,
        width: 40,
        height: 18,
        fit: StacBoxFit.contain,
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacText(
              data: 'یک شعبه مجازی همراه شماست!',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 2),
            StacText(
              data: 'www.tobank.ir',
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _actionButton({
  required String title,
  required String iconAsset,
  required String mode,
}) {
  return StacOutlinedButton(
    onPressed: StacCustomAction.fromJson({
      'actionType': 'transferReceipt',
      'mode': mode,
      'title': 'رسید خرید بسته',
      'pixelRatio': 3.0,
      'boundaryKey': 'packageRealReceiptContent',
    }),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 52),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: iconAsset,
          imageType: StacImageType.asset,
          width: 20,
          height: 20,
          color: '{{appColors.current.text.title}}',
        ),
        StacSizedBox(width: 6),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}
