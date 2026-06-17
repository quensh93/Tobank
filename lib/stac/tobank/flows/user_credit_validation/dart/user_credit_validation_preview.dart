import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'user_credit_validation_preview')
StacWidget userCreditValidationPreview() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title:
          '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.title}}',
    ),
    body: StacSafeArea(
      top: false,
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(14),
              child: StacCustomWidget.fromJson({
                'type': 'receiptRepaintBoundary',
                'boundaryKey': 'userCreditValidationPreviewContent',
                'child': _reportPage().toJson(),
              }),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.only(left: 14, right: 14, bottom: 12),
            child: StacRow(
              children: [
                StacExpanded(
                  child: _previewActionButton(
                    title:
                        '{{appStrings.generated.card_management.card_management_root.share}}',
                    iconAsset: 'assets/icons/ic_share.svg',
                    mode: 'shareText',
                  ),
                ),
                StacSizedBox(width: 10),
                StacExpanded(
                  child: _previewActionButton(
                    title: '{{appStrings.promissory.saveButton}}',
                    iconAsset: 'assets/icons/ic_download.svg',
                    mode: 'shareImage',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _reportPage() {
  return StacContainer(
    padding: StacEdgeInsets.all(14),
    decoration: StacBoxDecoration(
      color: '#FFFFFF',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(color: '#D9DEE7', width: 1),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacText(
                data:
                    '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.real_credit_report_title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 17,
                  fontWeight: StacFontWeight.w700,
                  color: '#2B3A55',
                ),
              ),
            ),
            StacImage(
              src: 'assets/icons/ic_tobank_red.svg',
              imageType: StacImageType.asset,
              width: 74,
              height: 24,
              fit: StacBoxFit.contain,
            ),
          ],
        ),
        StacSizedBox(height: 8),
        StacText(
          data:
              '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.date_time}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 12,
            fontWeight: StacFontWeight.w500,
            color: '#5B6578',
          ),
        ),
        StacText(
          data:
              '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.tracking_code}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 12,
            fontWeight: StacFontWeight.w500,
            color: '#5B6578',
          ),
        ),
        StacSizedBox(height: 12),
        StacContainer(
          padding: StacEdgeInsets.all(10),
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(color: '#D9DEE7', width: 1),
          ),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacContainer(
                width: 120,
                height: 120,
                decoration: StacBoxDecoration(
                  shape: StacBoxShape.circle,
                  border: StacBorder.all(color: '#CAD2E0', width: 12),
                ),
                child: StacCenter(
                  child: StacText(
                    data:
                        '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.number_value}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 24,
                      fontWeight: StacFontWeight.w700,
                      color: '#2AA66B',
                    ),
                  ),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _previewInfoRow(
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.number_national}}',
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.amount_value}}',
                    ),
                    _previewInfoRow(
                      '{{appStrings.generated.promissory.promissory_confirm.name}}',
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.sample_message}}',
                    ),
                    _previewInfoRow(
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.last_name}}',
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.sample_label}}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        StacSizedBox(height: 12),
        StacContainer(
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(color: '#D9DEE7', width: 1),
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacContainer(
                padding: StacEdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: StacBoxDecoration(
                  color: '#8392AA',
                  borderRadius: StacBorderRadius.only(topLeft: 8, topRight: 8),
                ),
                child: StacText(
                  data:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.score_reasons_title}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '#FFFFFF',
                  ),
                ),
              ),
              StacPadding(
                padding: StacEdgeInsets.all(10),
                child: StacText(
                  data:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_preview.transaction_amount_buy}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w500,
                    color: '#2B3A55',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _previewInfoRow(String key, String value) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 4),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacText(
          data: key,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 13,
            fontWeight: StacFontWeight.w500,
            color: '#6B7280',
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '#1F2937',
          ),
        ),
      ],
    ),
  );
}

StacWidget _previewActionButton({
  required String title,
  required String iconAsset,
  required String mode,
}) {
  return StacOutlinedButton(
    onPressed: StacCustomAction.fromJson({
      'actionType': 'transferReceipt',
      'mode': mode,
      'title':
          '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.report_credit_validation}}',
      'pixelRatio': 3.0,
      'boundaryKey': 'userCreditValidationPreviewContent',
    }),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 52),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
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
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}
