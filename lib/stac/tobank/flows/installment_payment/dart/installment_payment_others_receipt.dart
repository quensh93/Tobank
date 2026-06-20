import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'installment_payment_others_receipt')
StacWidget installmentPaymentOthersReceipt() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title:
          '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.title}}',
      showSupport: true,
      showBack: true,
    ),
    body: StacSafeArea(
      top: false,
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 14, right: 16, bottom: 24),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacCustomWidget.fromJson({
                'type': 'receiptRepaintBoundary',
                'boundaryKey': 'installmentPaymentOthersReceiptContent',
                'child': StacSingleChildScrollView(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      _successHeader(),
                      StacSizedBox(height: 14),
                      _receiptCard(),
                      StacSizedBox(height: 20),
                      _tobankSlogan(),
                      StacSizedBox(height: 10),
                    ],
                  ),
                ).toJson(),
              }),
            ),
            StacSizedBox(height: 12),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacExpanded(
                  child: _receiptActionButton(
                    title:
                        '{{appStrings.generated.card_management.card_management_root.share}}',
                    iconAsset: 'assets/icons/ic_share.svg',
                    mode: 'shareText',
                  ),
                ),
                StacSizedBox(width: 12),
                StacExpanded(
                  child: _receiptActionButton(
                    title:
                        '{{appStrings.generated.charge.charge_payment_success.title}}',
                    iconAsset: 'assets/icons/ic_download.svg',
                    mode: 'shareImage',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _successHeader() {
  return StacColumn(
    children: [
      StacSizedBox(height: 8),
      StacImage(
        src: 'assets/icons/ic_transaction_success.svg',
        imageType: StacImageType.asset,
        width: 88,
        height: 88,
      ),
      StacSizedBox(height: 14),
      StacText(
        data: '{{appStrings.promissory.paymentSuccessful}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '#17945A',
        ),
      ),
      StacSizedBox(height: 8),
      StacText(
        data:
            '{{appStrings.generated.installment_payment.installment_payment_others_receipt.installment_payment_successfully}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _receiptCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(11),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _receiptDetailRow(
          label:
              '{{appStrings.generated.installment_payment.installment_payment_detail_main.amount_text}}',
          value:
              '{{appStrings.generated.installment_payment.installment_payment_others_receipt.rial}}',
        ),
        _dashedLikeDivider(),
        _receiptDetailRow(
          label:
              '{{appStrings.generated.installment_payment.installment_payment_others_main.title}}',
          value: '{{othersPayment.loanNumber}}',
        ),
        _dashedLikeDivider(),
        _receiptDetailRow(
          label: '{{appStrings.promissory.transactionTime}}',
          value:
              '{{appStrings.generated.installment_payment.installment_payment_others_receipt.amount_value}}',
        ),
        _dashedLikeDivider(),
        _receiptDetailRow(
          label: '{{appStrings.promissory.paidVia}}',
          value:
              '{{appStrings.generated.installment_payment.installment_payment_others_receipt.account}}',
        ),
        _dashedLikeDivider(),
        _receiptDetailRow(
          label:
              '{{appStrings.generated.installment_payment.installment_payment_others_receipt.source_label}}',
          value:
              '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number}}',
        ),
        _dashedLikeDivider(),
        _receiptDetailRow(
          label: '{{appStrings.promissory.trackingNumber}}',
          value:
              '{{appStrings.generated.installment_payment.installment_payment_others_receipt.amount_value_text}}',
        ),
      ],
    ),
  );
}

StacWidget _receiptDetailRow({required String label, required String value}) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 2),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      crossAxisAlignment: StacCrossAxisAlignment.center,
      children: [
        StacExpanded(
          child: StacText(
            data: label,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ),
        StacSizedBox(width: 8),
        StacExpanded(
          child: StacAlign(
            alignment: StacAlignmentDirectional.centerStart,
            child: StacText(
              data: value,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.left,
              style: StacTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _dashedLikeDivider() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 11),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: List.generate(
        44,
        (_) => StacContainer(
          width: 3,
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
      ),
    ),
  );
}

StacWidget _tobankSlogan() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.center,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacImage(
        src: 'assets/icons/ic_tobank.svg',
        imageType: StacImageType.asset,
        width: 56,
        height: 56,
      ),
      StacSizedBox(width: 16),
      StacContainer(
        height: 45,
        width: 0.7,
        color: '{{appColors.current.text.subtitle}}',
      ),
      StacSizedBox(width: 16),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.end,
          children: [
            StacText(
              data: '{{appStrings.profile.real.about.slogan}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacText(
              data: 'www.tobank.ir',
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.right,
              style: StacTextStyle(
                fontSize: 18,
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

StacWidget _receiptActionButton({
  required String title,
  required String iconAsset,
  required String mode,
}) {
  return StacOutlinedButton(
    onPressed: StacCustomAction.fromJson({
      'actionType': 'transferReceipt',
      'mode': mode,
      'title':
          '{{appStrings.generated.installment_payment.installment_payment_others_receipt.installment_payment_receipt}}',
      'pixelRatio': 3.0,
      'boundaryKey': 'installmentPaymentOthersReceiptContent',
    }),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
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
        StacSizedBox(width: 8),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}
