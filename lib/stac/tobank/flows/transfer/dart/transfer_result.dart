import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'transfer_result')
StacWidget transferRealResult() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      title: '{{appStrings.menu.items.transfer}}',
    ),
    body: StacCustomVisibility(
      visible: '[[transferApiIsCardToCardFlow]]',
      child: _cardResultContent().toJson(),
      replacement: _defaultResultContent().toJson(),
    ),
  );
}

StacWidget _cardResultContent() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, top: 14, right: 16, bottom: 24),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _cardSuccessHeader(),
                StacSizedBox(height: 16),
                _cardResultCard(),
                StacSizedBox(height: 18),
                _brandSection(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _defaultResultContent() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, top: 14, right: 16, bottom: 35),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacCustomWidget.fromJson({
            'type': 'receiptRepaintBoundary',
            'boundaryKey': 'transferReceiptContentV2',
            'child': StacSingleChildScrollView(
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  _successHeader(),
                  StacSizedBox(height: 14),
                  _resultCard(),
                  StacSizedBox(height: 20),
                  _brandSection(),
                ],
              ),
            ).toJson(),
          }),
        ),
        StacSizedBox(height: 12),
        StacRow(
          children: [
            StacExpanded(
              child: _bottomActionButton(
                title:
                    '{{appStrings.generated.transfer.transfer_card_result.title}}',
                iconAsset: 'assets/icons/ic_download.svg',
                mode: 'shareText',
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _bottomActionButton(
                title:
                    '{{appStrings.generated.transfer.transfer_card_result.image_receipt}}',
                iconAsset: 'assets/icons/ic_share.svg',
                mode: 'shareImage',
              ),
            ),
          ],
        ),
      ],
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
      StacSizedBox(height: 18),
      StacText(
        data: '{{appStrings.generated.transfer.transfer_in_bank_result.title}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _cardSuccessHeader() {
  return StacColumn(
    children: [
      StacSizedBox(height: 6),
      StacImage(
        src: 'assets/icons/ic_transaction_success.svg',
        imageType: StacImageType.asset,
        width: 96,
        height: 96,
      ),
      StacSizedBox(height: 12),
      StacText(
        data: '{{appStrings.promissory.paymentSuccessful}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 40 / 2,
          fontWeight: StacFontWeight.w700,
          color: '#12B76A',
        ),
      ),
      StacSizedBox(height: 10),
      StacText(
        data:
            '{{appStrings.generated.transfer.transfer_card_result.money_transfer_successfully_operation_card}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 34 / 2,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _cardResultCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(16),
      color: '{{appColors.current.background.surfaceContainer}}',
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      children: [
        _resultRow(
          title: '{{appStrings.promissory.paidAmount}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiCardAmountRaw',
            child: StacRow(
              mainAxisSize: StacMainAxisSize.min,
              textDirection: StacTextDirection.ltr,
              children: [
                StacRawJsonWidget({
                  'type': 'text',
                  'data': '{{transferApiCardAmountRaw}}',
                  'textDirection': 'ltr',
                  'style': {
                    'type': 'custom',
                    'fontSize': 17,
                    'fontWeight': 'w700',
                    'color': '{{appColors.current.text.title}}',
                  },
                }),
                StacSizedBox(width: 4),
                StacText(
                  data: '{{appStrings.common.rial}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 17,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ).toJson(),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: '{{appStrings.promissory.transactionType}}',
          valueWidget: StacText(
            data: '{{appStrings.homePage.cards.cardToCard}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: '{{appStrings.promissory.transactionTime}}',
          valueWidget: StacText(
            data:
                '{{appStrings.generated.transfer.transfer_card_result.amount_value}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: '{{appStrings.promissory.paidVia}}',
          valueWidget: StacText(
            data: '{{appStrings.generated.transfer.transfer_card_result.bank}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.installment_payment.installment_payment_others_receipt.source_label}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiCardSourceNumber',
            child: {
              'type': 'text',
              'data': '{{transferApiCardSourceNumber}}',
              'textDirection': 'ltr',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_card_result.destination_label}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiCardDestinationNumber',
            child: {
              'type': 'text',
              'data': '{{transferApiCardDestinationNumber}}',
              'textDirection': 'ltr',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_card_result.name_card}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiCardDestinationName',
            child: {
              'type': 'text',
              'data': '{{transferApiCardDestinationName}}',
              'textDirection': 'rtl',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: '{{appStrings.promissory.trackingNumber}}',
          valueWidget: StacText(
            data:
                '{{appStrings.generated.transfer.transfer_result.amount_value}}',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: '{{appStrings.promissory.descriptionLabel}}',
          valueWidget: StacText(
            data: '-',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _resultCard() {
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
      children: [
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_in_bank_result.transfer}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiTransferTypeTitle',
            child: {
              'type': 'text',
              'data': '{{transferApiTransferTypeTitle}}',
              'textDirection': 'rtl',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.card_management.card_management_root.amount_transfer}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiAmountRaw',
            child: StacRow(
              mainAxisSize: StacMainAxisSize.min,
              textDirection: StacTextDirection.ltr,
              children: [
                StacRawJsonWidget({
                  'type': 'text',
                  'data': '{{transferApiAmountRaw}}',
                  'textDirection': 'ltr',
                  'style': {
                    'type': 'custom',
                    'fontSize': 17,
                    'fontWeight': 'w700',
                    'color': '{{appColors.current.text.title}}',
                  },
                }),
                StacSizedBox(width: 4),
                StacText(
                  data: '{{appStrings.common.rial}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 17,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ).toJson(),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_in_bank_result.money_transfer}}',
          valueWidget: StacText(
            data:
                '{{appStrings.generated.transfer.transfer_result.date_value}}',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_in_bank_result.deposit_number}}',
          valueWidget: StacText(
            data:
                '{{appStrings.generated.transfer.transfer_in_bank_confirm.title}}',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: '{{appStrings.generated.transfer.transfer_result.title}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiDestinationIban',
            child: {
              'type': 'text',
              'data': 'IR{{transferApiDestinationIban}}',
              'textDirection': 'ltr',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_in_bank_result.deposit}}',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiDestinationName',
            child: {
              'type': 'text',
              'data': '{{transferApiDestinationName}}',
              'textDirection': 'rtl',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title:
              '{{appStrings.generated.transfer.transfer_in_bank_result.number_bank}}',
          valueWidget: StacText(
            data:
                '{{appStrings.generated.transfer.transfer_result.card_number}}',
            textDirection: StacTextDirection.ltr,
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

StacWidget _resultRow({
  required String title,
  required StacWidget valueWidget,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacExpanded(
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
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
          child: valueWidget,
        ),
      ),
    ],
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

StacWidget _brandSection() {
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
      StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.end,
        children: [
          StacText(
            data: '{{appStrings.profile.real.about.slogan}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: 'www.tobank.ir',
            textDirection: StacTextDirection.ltr,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ),
    ],
  );
}

StacWidget _bottomActionButton({
  required String title,
  required String iconAsset,
  required String mode,
}) {
  return StacOutlinedButton(
    onPressed: StacCustomAction.fromJson({
      'actionType': 'transferReceipt',
      'mode': mode,
      'title':
          '{{appStrings.generated.transfer.transfer_card_result.transaction_receipt}}',
      'pixelRatio': 3.0,
      'boundaryKey': 'transferReceiptContentV2',
    }),
    style: StacButtonStyle(
      fixedSize: const StacSize(999999, 57),
      side: StacBorderSide(color: '{{appColors.current.input.borderEnabled}}'),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      foregroundColor: '{{appColors.current.text.title}}',
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(width: 8),

        StacImage(
          src: iconAsset,
          imageType: StacImageType.asset,
          width: 26,
          height: 26,
          color: '{{appColors.current.text.title}}',
        ),
      ],
    ),
  );
}
