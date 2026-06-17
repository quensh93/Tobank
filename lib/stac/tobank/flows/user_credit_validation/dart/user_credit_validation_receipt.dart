import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'user_credit_validation_receipt')
StacWidget userCreditValidationReceipt() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: '{{appStrings.authentication.stepValidation}}',
    ),
    body: StacCustomWidget.fromJson({
      'type': 'receiptRepaintBoundary',
      'boundaryKey': 'userCreditValidationReceiptContent',
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
              data: '{{appStrings.promissory.paymentSuccessful}}',
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
              data: '{{appStrings.promissory.successfulMessage}}',
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
    'title':
        '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.report_credit_validation}}',
    'pixelRatio': 3.0,
    'boundaryKey': 'userCreditValidationReceiptContent',
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
        _receiptRow(
          '{{appStrings.generated.user_credit_validation.user_credit_validation_receipt.amount_payment}}',
          '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.rial}}',
        ),
        _line(),
        _receiptRow(
          '{{appStrings.promissory.payDate}}',
          '{{appStrings.generated.user_credit_validation.user_credit_validation_receipt.amount_value}}',
        ),
        _line(),
        _receiptRow(
          '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.code}}',
          '{{appStrings.generated.user_credit_validation.user_credit_validation_receipt.card_number}}',
        ),
        _line(),
        _receiptRow(
          '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.applicant_role}}',
          '{{appStrings.profile.real.destinations.depositItem2Title}}',
        ),
        _line(),
        _receiptRow(
          '{{appStrings.promissory.paymentMethod}}',
          '{{appStrings.profile.real.destinations.tabDeposit}}',
        ),
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
                data:
                    '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.report_credit_validation}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacGestureDetector(
              onTap: NavigationAction(
                fileName: 'user_credit_validation_preview',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
              ),
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
          data:
              '{{appStrings.generated.user_credit_validation.user_credit_validation_receipt.user}}',
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
