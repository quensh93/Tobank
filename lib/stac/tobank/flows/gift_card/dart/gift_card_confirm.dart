import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_confirm')
StacWidget giftCardRealConfirm() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: '???? ????',
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.only(left: 16, right: 16, top: 14),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildCardsSummarySection(),
                StacSizedBox(height: 18),
                _buildDetailsSection(),
                StacSizedBox(height: 20),
              ],
            ),
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: StacFilledButton(
            onPressed: _paymentAccountsBottomSheetAction(),
            style: StacButtonStyle(
              fixedSize: StacSize(999999, 62),
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(14),
              ),
              elevation: 0,
            ),
            child: StacText(
              data: '?????? {{giftCardRealSummaryPaymentLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 19,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

StacAction _paymentAccountsBottomSheetAction() {
  return _proxyLegacyBottomSheetAction(const {
    'actionType': 'showGiftCardPaymentAccountsBottomSheet',
    'title': '???? ????',
    'paymentAmountKey': 'giftCardRealSummaryPaymentAmount',
    'walletLabel': '??? ???',
    'walletBalance': 226600,
    'accountsTitle': '???????',
    'insufficientText': '?????? ??????',
    'sufficientText': '?????? ????',
    'chargeButtonText': '???? ????',
    'continueButtonText': '?????',
    'accounts': [
      {
        'id': 'acc_1',
        'title': '????? ????? ???? ??? ?????? ???? ?????- ?????',
        'ownerName': '??? ????? ??? ???',
        'depositNumber': '???.??.??/????.?',
        'availableAmount': 66770,
      },
      {
        'id': 'acc_2',
        'title': '????? ????? ????? ?????? ????? ????? ???',
        'ownerName': '??????- ????? ????? ??? ????? ??? ???',
        'depositNumber': '???.????.??/????.?',
        'availableAmount': 39148,
      },
      {
        'id': 'acc_3',
        'title': '????? ????? ????? ?????? ????? ????',
        'ownerName': '??????- ????? ????? ??? ????? ??? ???',
        'depositNumber': '???.????.??/????.?',
        'availableAmount': 9200000,
      },
    ],
    'continueAction': {
      'actionType': 'showResult',
      'title': '??????',
      'content': '?????? ?? ?????? ????? ??.',
    },
    'chargeAction': {
      'actionType': 'showResult',
      'title': '???? ????',
      'content': '???? ?????? ???? ??? ?? ???? ????.',
    },
  });
}

StacAction _proxyLegacyBottomSheetAction(Map<String, dynamic> legacyAction) {
  return StacShowBottomSheetAction(
    title: 'gift_card_confirm',
    backgroundColor: '#00000000',
    sheet: StacStatefulWidget(
      onInit: StacSequenceAction(
        actions: [
          StacCustomAction.fromJson(legacyAction),
          const StacNavigateAction(navigationStyle: NavigationStyle.pop),
        ],
      ),
      child: StacSizedBox(width: 0, height: 0),
    ).toJson(),
  );
}

StacWidget _buildCardsSummarySection() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
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
        _buildCardLine(
          amountLabelKey: 'giftCardRealAmountLabel1',
          countKey: 'giftCardRealCardCount1',
        ),
        StacCustomVisibility(
          visible: '[[giftCardRealShowSecondAmountCard]]',
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacSizedBox(height: 12),
              StacContainer(
                height: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacSizedBox(height: 12),
              _buildCardLine(
                amountLabelKey: 'giftCardRealAmountLabel2',
                countKey: 'giftCardRealCardCount2',
              ),
            ],
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[giftCardRealShowThirdAmountCard]]',
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacSizedBox(height: 12),
              StacContainer(
                height: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacSizedBox(height: 12),
              _buildCardLine(
                amountLabelKey: 'giftCardRealAmountLabel3',
                countKey: 'giftCardRealCardCount3',
              ),
            ],
          ).toJson(),
        ),
      ],
    ),
  );
}

StacWidget _buildCardLine({
  required String amountLabelKey,
  required String countKey,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.end,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.end,
        children: [
          StacText(
            data: '???? ????',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 7),
          StacText(
            data: '{{$amountLabelKey}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
      StacText(
        data: '{{$countKey}} ???',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 17,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _buildDetailsSection() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
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
        _buildDetailRow(
          '???? ????(???) ????',
          '{{giftCardRealSummaryCardsAmountLabel}}',
        ),
        _buildGap(),
        _buildDetailRow(
          '????? ???? ?? ????',
          '{{giftCardRealSummaryIssuanceFeeLabel}}',
        ),
        _buildGap(),
        _buildDetailRow(
          '????? ?????',
          '{{giftCardRealSummaryDeliveryFeeLabel}}',
        ),
        _buildGap(),
        _buildDetailRow('??? ???? ????', '{{giftCardRealSummaryType}}'),
        _buildGap(),
        _buildDetailRow(
          '??? ????? ??????',
          '{{giftCardRealSummaryReceiverName}}',
        ),
        _buildGap(),
        _buildDetailRow(
          '?????? ????? ??????',
          '{{giftCardRealSummaryReceiverMobile}}',
        ),
        _buildGap(),
        _buildDetailRow('????? ?????', '{{giftCardRealSummaryDeliveryDate}}'),
        _buildGap(),
        _buildDetailRow('???? ?????', '{{giftCardRealSummaryDeliveryTime}}'),
        _buildGap(),
        _buildDetailRow(
          '??? ????? ??????',
          '{{giftCardRealSummaryReceiverCity}}',
        ),
        _buildGap(),
        StacText(
          data: '???? ????? ??????',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: '{{giftCardRealSummaryReceiverAddress}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildDetailRow(String keyText, String valueText) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacText(
        data: keyText,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 12),
      StacExpanded(
        child: StacText(
          data: valueText,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildGap() => StacSizedBox(height: 16);

