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
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isWalletSelected', value: false),
        StacCustomSetValueAction(key: 'isDepositSelected', value: false),
        StacCustomSetValueAction(key: 'selectedPaymentMethod', value: ''),
        StacCustomSetValueAction(key: 'isPayEnabled', value: false),
      ],
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
                          color:
                              '{{appColors.current.background.surfaceContainer}}',
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
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 0.5,
                      ),
                    ),
                    child: StacColumn(
                      children: [
                        _buildKVRow(
                          '{{appStrings.promissory.stampDuty}}',
                          '{{appData.taxAmount}} {{appStrings.common.rial}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildKVRow(
                          '{{appStrings.promissory.issuanceFee}}',
                          '{{appData.feeAmount}} {{appStrings.common.rial}}',
                        ),
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
                    isSelectedVar: 'isWalletSelected',
                    activeColor:
                        'appColors.current.error.color', // Removed braces
                    icon: 'assets/icons/ic_wallet.svg',
                    title: '{{appStrings.promissory.walletPayment}}',
                    subtitle:
                        '{{appStrings.promissory.walletBalance}}: {{wallet.balance}} {{appStrings.common.rial}}',
                  ),
                  StacSizedBox(height: 12),

                  // Deposit Payment Option
                  _buildPaymentOption(
                    id: 'deposit',
                    isSelectedVar: 'isDepositSelected',
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
          // Pay Button (Wallet Action - Default)
          StacRawJsonWidget({
            'type': 'container',
            'height': '{{isDepositSelected ? 0 : 88}}',
            'clipBehavior': 'hardEdge',
            'decoration': StacBoxDecoration(color: 'transparent').toJson(),
            'child': StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isPayEnabled',
                'enabled': false,
                'onPressed': StacDialogAction(
                  widget: StacAlertDialog(
                    title: StacText(
                      data: '{{appStrings.promissory.payConfirmTitle}}',
                      textDirection: StacTextDirection.rtl,
                    ),
                    content: StacText(
                      data: '{{appStrings.promissory.payConfirmMessage}}',
                      textDirection: StacTextDirection.rtl,
                    ),
                    actions: [
                      StacTextButton(
                        onPressed: StacRawJsonAction({
                          'actionType': 'closeDialog',
                        }),
                        child: StacText(
                          data: '{{appStrings.common.cancel}}',
                          textDirection: StacTextDirection.rtl,
                        ),
                      ),
                      StacTextButton(
                        onPressed: StacSequenceAction(
                          actions: [
                            StacRawJsonAction({'actionType': 'closeDialog'}),
                            {
                              'actionType': 'navigate',
                              'widgetType': 'promissory_sign',
                              'navigationStyle': 'pushReplacement',
                            },
                          ],
                        ),
                        child: StacText(
                          data: '{{appStrings.common.confirm}}',
                          textDirection: StacTextDirection.rtl,
                        ),
                      ),
                    ],
                  ).toJson(),
                ).toJson(),
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.promissory.payAndSign}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ).toJson(),
          }),
          // Pay Button (Deposit Action)
          StacRawJsonWidget({
            'type': 'container',
            'height': '{{isDepositSelected ? 88 : 0}}',
            'clipBehavior': 'hardEdge',
            'decoration': StacBoxDecoration(color: 'transparent').toJson(),
            'child': StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isPayEnabled',
                'enabled': false,
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_deposit_select',
                  'navigationStyle': 'push',
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.promissory.payAndSign}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ).toJson(),
          }),
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
      StacExpanded(
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(width: 8),
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
  String? isSelectedVar,
  String activeColor = 'appColors.current.primary.color', // Removed braces
}) {
  return StacGestureDetector(
    onTap: id == 'deposit'
        ? StacSequenceAction(
            actions: [
              StacCustomSetValueAction(key: 'selectedPaymentMethod', value: id),
              StacCustomSetValueAction(key: 'isPayEnabled', value: true),
              StacCustomSetValueAction(key: 'isWalletSelected', value: false),
              if (isSelectedVar != null)
                StacCustomSetValueAction(key: isSelectedVar, value: true),
            ],
          )
        : StacSequenceAction(
            actions: [
              StacCustomSetValueAction(key: 'selectedPaymentMethod', value: id),
              StacCustomSetValueAction(key: 'isPayEnabled', value: true),
              StacCustomSetValueAction(key: 'isDepositSelected', value: false),
              if (isSelectedVar != null)
                StacCustomSetValueAction(key: isSelectedVar, value: true),
            ],
          ),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: isSelectedVar != null
              ? '{{$isSelectedVar ? $activeColor : appColors.current.input.borderEnabled}}'
              : '{{appColors.current.input.borderEnabled}}',
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

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper for complex widgets
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);
  @override
  Map<String, dynamic> get jsonData => json;
  @override
  Map<String, dynamic> toJson() => json;
  @override
  String get type => json['type'] as String;
  String? get id => json['id'] as String?;
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
