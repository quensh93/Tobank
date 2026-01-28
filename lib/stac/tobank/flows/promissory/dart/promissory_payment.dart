import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Payment Method Page
///
/// This screen allows users to select payment method:
/// 1. Wallet payment
/// 2. Deposit payment
/// 3. Internet Gateway payment
///
/// Reference: docs/promissory_docs/request_promissory_select_payment_bottom_sheet.dart
@StacScreen(screenName: 'promissory_payment')
StacWidget promissoryPayment() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      key: 'selectedPaymentMethod',
      value: 'wallet',
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.paymentTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  // Issuance summary and payable amount
                  StacColumn(
                    children: [
                      StacContainer(
                        decoration: StacBoxDecoration(
                          color: '{{appColors.current.background.surfaceContainer}}',
                          borderRadius: StacBorderRadius.all(40),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 0.5,
                          ),
                        ),
                        padding: StacEdgeInsets.all(12),
                        child: StacImage(
                          src: 'assets/icons/ic_promissory_request.svg',
                          imageType: StacImageType.asset,
                          width: 40,
                          height: 40,
                          color: '{{appColors.current.primary.color}}',
                        ),
                      ),
                      StacSizedBox(height: 16),
                      StacText(
                        data: '{{appStrings.promissory.issuanceTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 16),
                      StacRow(
                        textDirection: StacTextDirection.rtl,
                        mainAxisAlignment: StacMainAxisAlignment.spaceAround,
                        children: [
                          StacText(
                            data: '{{appStrings.promissory.payableAmount}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w500,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacRow(
                            textDirection: StacTextDirection.ltr,
                            children: [
                              StacText(
                                data: '{{appData.totalAmount}}',
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w900,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(width: 4),
                              StacText(
                                data: '{{appStrings.common.rial}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  StacSizedBox(height: 16),
                  // Fee breakdown card
                  StacContainer(
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 0.5,
                      ),
                    ),
                    child: StacColumn(
                      children: [
                        _buildKVRow('{{appStrings.promissory.stampDuty}}', '{{appData.taxAmount}} {{appStrings.common.rial}}'),
                        StacSizedBox(height: 16),
                        _buildKVRow('{{appStrings.promissory.issuanceFee}}', '{{appData.feeAmount}} {{appStrings.common.rial}}'),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Payment Methods Title
                  StacText(
                    data: '{{appStrings.promissory.paymentMethod}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Wallet Payment Option
                  _buildPaymentOption(
                    id: 'wallet',
                    icon: 'assets/icons/ic_wallet.svg',
                    title: '{{appStrings.promissory.walletPayment}}',
                    subtitle:
                        '{{appStrings.promissory.walletBalance}}: {{wallet.balance}} {{appStrings.common.rial}}',
                  ),
                  StacSizedBox(height: 12),

                  // Deposit Payment Option
                  _buildPaymentOption(
                    id: 'deposit',
                    icon: 'assets/icons/ic_branch.svg',
                    title: '{{appStrings.promissory.depositPayment}}',
                    subtitle: '{{appStrings.promissory.fromLinkedDeposit}}',
                  ),
                  StacSizedBox(height: 12),

                  // Navigate to deposit selection when tapping deposit option
                ],
              ),
            ),
          ),
          // Pay Button
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacFilledButton(
              style: StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                elevation: 0,
                fixedSize: StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              onPressed: StacRawJsonAction({
                'actionType': 'dialog',
                'widget': {
                  'type': 'alertDialog',
                  'title': {
                    'type': 'text',
                    'data': '{{appStrings.promissory.payConfirmTitle}}',
                    'textDirection': 'rtl'
                  },
                  'content': {
                    'type': 'text',
                    'data': '{{appStrings.promissory.payConfirmMessage}}',
                    'textDirection': 'rtl'
                  },
                  'actions': [
                    {
                      'type': 'textButton',
                      'onPressed': {'actionType': 'closeDialog'},
                      'child': {'type': 'text', 'data': '{{appStrings.common.cancel}}', 'textDirection': 'rtl'}
                    },
                    {
                      'type': 'textButton',
                      'onPressed': {
                        'actionType': 'sequence',
                        'actions': [
                          {'actionType': 'closeDialog'},
                          {
                            'actionType': 'navigate',
                            'widgetType': 'promissory_success',
                            'navigationStyle': 'pushReplacement'
                          }
                        ]
                      },
                      'child': {'type': 'text', 'data': '{{appStrings.common.confirm}}', 'textDirection': 'rtl'}
                    }
                  ]
                }
              }),
              child: StacText(
                data: '{{appStrings.promissory.payAndSign}}',
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Helper: KV row (rtl label, ltr value)
StacWidget _buildKVRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacText(
        data: value,
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

/// Helper: Payment option card
StacWidget _buildPaymentOption({
  required String id,
  required String icon,
  required String title,
  required String subtitle,
}) {
  return StacGestureDetector(
    onTap: id == 'deposit'
        ? StacSequenceAction(actions: [
            StacCustomSetValueAction(key: 'selectedPaymentMethod', value: id),
            {
              'actionType': 'navigate',
              'widgetType': 'promissory_deposit_select',
              'navigationStyle': 'push'
            }
          ])
        : StacCustomSetValueAction(key: 'selectedPaymentMethod', value: id),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Icon
          StacImage(
            src: icon,
            imageType: StacImageType.asset,
            width: 32,
            height: 32,
            color: '{{appColors.current.primary.color}}',
          ),
          StacSizedBox(width: 12),
          // Text
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.start,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 4),
                StacText(
                  data: subtitle,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 12,
                    color: '{{appColors.current.text.subtitle}}',
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

/// Helper: Deposit item styled like screenshot
StacWidget _buildDepositItem({
  required String title,
  required String depositNumber,
  required String iban,
  required String balance,
  required String cardNumber,
  required bool selected,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacContainer(
            width: 18,
            height: 18,
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.all(18),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
              color: selected ? '{{appColors.current.primary.color}}' : 'transparent',
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacContainer(
        height: 1,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.input.borderEnabled}}',
        ),
      ),
      StacSizedBox(height: 12),
      _buildKVRow('شماره سپرده', depositNumber),
      StacSizedBox(height: 12),
      _buildKVRow('شماره شبا', iban),
      StacSizedBox(height: 12),
      _buildKVRow('موجودی', balance),
      StacSizedBox(height: 12),
      _buildKVRow('شماره کارت', cardNumber),
    ],
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON action helper for simple actions
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
