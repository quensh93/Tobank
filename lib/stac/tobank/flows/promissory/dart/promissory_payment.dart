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
                  // Amount to pay card
                  StacContainer(
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.primary.color}}10',
                      borderRadius: StacBorderRadius.all(12),
                    ),
                    child: StacColumn(
                      children: [
                        StacText(
                          data: '{{appStrings.promissory.payableAmount}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                        StacSizedBox(height: 8),
                        StacText(
                          data:
                              '{{form.promissory_amount}} {{appStrings.common.rial}}',
                          textDirection: StacTextDirection.ltr,
                          style: StacCustomTextStyle(
                            fontSize: 24,
                            fontWeight: StacFontWeight.bold,
                            color: '{{appColors.current.primary.color}}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 24),

                  // Payment Methods Title
                  StacText(
                    data: '{{appStrings.promissory.selectPaymentMethod}}',
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

                  // Gateway Payment Option
                  _buildPaymentOption(
                    id: 'gateway',
                    icon: 'assets/icons/ic_card.svg',
                    title: '{{appStrings.promissory.gatewayPayment}}',
                    subtitle: '{{appStrings.promissory.gatewayPaymentDesc}}',
                  ),
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
                'actionType': 'navigate',
                'widgetType': 'promissory_success',
                'navigationStyle': 'pushReplacement',
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

/// Helper: Payment option card
StacWidget _buildPaymentOption({
  required String id,
  required String icon,
  required String title,
  required String subtitle,
}) {
  return StacGestureDetector(
    onTap: StacRawJsonAction({
      'actionType': 'setValue',
      'key': 'selectedPaymentMethod',
      'value': id,
    }),
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
