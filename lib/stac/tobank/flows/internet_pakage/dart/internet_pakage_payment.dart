import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'internet_pakage_payment')
StacWidget packageRealPayment() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'crPayAcc1Sel', 'value': true},
        {'key': 'crPayAcc2Sel', 'value': false},
        {'key': 'crPayAcc3Sel', 'value': false},
        {'key': 'crPayCanSubmit', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title:
            '{{appStrings.generated.internet_pakage.internet_pakage_add_sim.title}}',
      ),
      body: StacSafeArea(
        top: false,
        child: StacPadding(
          padding: StacEdgeInsets.all(14),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCenter(
                child: StacContainer(
                  width: 50,
                  height: 50,
                  padding: StacEdgeInsets.all(10),
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    shape: StacBoxShape.circle,
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacImage(
                    src: '{{crActiveSimLogo}}',
                    imageType: StacImageType.asset,
                    fit: StacBoxFit.contain,
                  ),
                ),
              ),
              StacSizedBox(height: 8),
              StacText(
                data: '{{crActiveSimNumber}}',
                textDirection: StacTextDirection.ltr,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 10),
              StacRow(
                mainAxisAlignment: StacMainAxisAlignment.center,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacText(
                    data:
                        '{{appStrings.generated.internet_pakage.internet_pakage_payment.title}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacSizedBox(width: 8),
                  StacText(
                    data: '{{appStrings.generated.charge.charge_payment.rial}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 20,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 14),
              _walletCard(),
              StacSizedBox(height: 18),
              StacContainer(
                padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.background.surface}}',
                  borderRadius: StacBorderRadius.all(10),
                  border: StacBorder.all(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1,
                  ),
                ),
                child: StacText(
                  data:
                      '{{appStrings.generated.charge.charge_payment.account}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
              StacSizedBox(height: 16),
              StacExpanded(
                child: StacSingleChildScrollView(
                  padding: StacEdgeInsets.only(top: 4, bottom: 2),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      _accountCard(
                        selectedKey: 'crPayAcc1Sel',
                        onTap: _selectAccount(1),
                        title:
                            '{{appStrings.generated.charge.charge_payment.deposit}}',
                        depositNo:
                            '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number}}',
                        cardNo:
                            '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number_text}}',
                        withdrawable:
                            '{{appStrings.generated.charge.charge_payment.rial_message}}',
                      ),
                      StacSizedBox(height: 10),
                      _accountCard(
                        selectedKey: 'crPayAcc2Sel',
                        onTap: _selectAccount(2),
                        title:
                            '{{appStrings.generated.charge.charge_payment.deposit_text}}',
                        depositNo:
                            '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number}}',
                        cardNo:
                            '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number_text}}',
                        withdrawable:
                            '{{appStrings.generated.charge.charge_payment.rial_label}}',
                        warningBadge:
                            '{{appStrings.generated.installment_payment.installment_payment_detail_main.balance}}',
                        warningRed: true,
                      ),
                      StacSizedBox(height: 10),
                      _accountCard(
                        selectedKey: 'crPayAcc3Sel',
                        onTap: _selectAccount(3),
                        title:
                            '{{appStrings.generated.charge.charge_payment.deposit_label}}',
                        depositNo:
                            '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number}}',
                        cardNo:
                            '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number_text}}',
                        withdrawable:
                            '{{appStrings.generated.charge.charge_payment.rial_description}}',
                      ),
                    ],
                  ),
                ),
              ),
              StacSizedBox(height: 10),
              StacCustomVisibility(
                visible: '[[crPayCanSubmit]]',
                child: _buildPayButton(enabled: true).toJson(),
                replacement: _buildPayButton(enabled: false).toJson(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _walletCard() {
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
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacContainer(
          width: 34,
          height: 34,
          decoration: StacBoxDecoration(
            color: '#F2F4F7',
            shape: StacBoxShape.circle,
          ),
          child: StacCenter(
            child: StacIcon(
              icon: 'account_balance_wallet_outlined',
              size: 20,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ),
        StacSizedBox(width: 8),
        StacText(
          data: '{{appStrings.promissory.walletPayment}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacText(
          data: '{{appStrings.generated.charge.charge_payment.rial_text}}',
          textDirection: StacTextDirection.ltr,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacAction _selectAccount(int index) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'crPayAcc1Sel', 'value': index == 1},
      {'key': 'crPayAcc2Sel', 'value': index == 2},
      {'key': 'crPayAcc3Sel', 'value': index == 3},
      {'key': 'crPayCanSubmit', 'value': index != 2},
    ],
  );
}

StacWidget _buildPayButton({required bool enabled}) {
  return StacFilledButton(
    onPressed: enabled
        ? const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                values: [
                  {
                    'key': 'crPayReceiptAmount',
                    'value': '{{crPkgSelectedAmount}}',
                  },
                  {
                    'key': 'crPayReceiptTime',
                    'value':
                        '{{appStrings.generated.charge.charge_payment.amount_value}}',
                  },
                  {
                    'key': 'crPayReceiptInternetPakage',
                    'value':
                        '{{appStrings.generated.internet_pakage.internet_pakage_payment.buy_package}}',
                  },
                  {
                    'key': 'crPayReceiptVia',
                    'value':
                        '{{appStrings.profile.real.destinations.tabDeposit}}',
                  },
                  {
                    'key': 'crPayReceiptFrom',
                    'value':
                        '{{appStrings.generated.installment_payment.installment_payment_others_detail_main.card_number}}',
                  },
                  {
                    'key': 'crPayReceiptTracking',
                    'value':
                        '{{appStrings.generated.internet_pakage.internet_pakage_payment.amount_value}}',
                  },
                ],
              ),
              NavigationAction(
                fileName: 'internet_pakage_payment_success',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
              ),
            ],
          )
        : null,
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      backgroundColor: enabled
          ? '{{appColors.current.primary.color}}'
          : '#D0D5DD',
      foregroundColor: enabled
          ? '{{appColors.current.primary.onPrimary}}'
          : '#98A2B3',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
      elevation: 0,
    ),
    child: StacText(
      data:
          '{{appStrings.generated.card_management.card_management_root.payment}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: enabled ? '{{appColors.current.primary.onPrimary}}' : '#98A2B3',
      ),
    ),
  );
}

StacWidget _accountCard({
  required String selectedKey,
  required StacAction onTap,
  required String title,
  required String depositNo,
  required String cardNo,
  required String withdrawable,
  String? warningBadge,
  bool warningRed = false,
}) {
  final warningColor = warningRed ? '#E31D35' : '#13A780';
  final card = StacContainer(
    padding: StacEdgeInsets.all(12),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          crossAxisAlignment: StacCrossAxisAlignment.start,
          textDirection: StacTextDirection.rtl,
          children: [
            StacContainer(
              width: 18,
              height: 18,
              decoration: StacBoxDecoration(
                shape: StacBoxShape.circle,
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCustomVisibility(
                visible: '[[$selectedKey]]',
                child: StacCenter(
                  child: StacContainer(
                    width: 8,
                    height: 8,
                    decoration: StacBoxDecoration(
                      shape: StacBoxShape.circle,
                      color: '#20C4D8',
                    ),
                  ),
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 10),
        _metaRow(
          label:
              '{{appStrings.generated.card_management.card_management_root.deposit_number}}',
          value: depositNo,
        ),
        StacSizedBox(height: 8),
        _metaRow(
          label: '{{appStrings.profile.real.destinations.cardNumberLabel}}',
          value: cardNo,
        ),
        StacContainer(
          margin: StacEdgeInsets.only(top: 10, bottom: 10),
          height: 1,
          color: '#E5E7EB',
        ),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data:
                  '{{appStrings.generated.charge.charge_payment.withdrawable_label}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w500,
                color: warningColor,
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: withdrawable,
              textDirection: StacTextDirection.ltr,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: warningColor,
              ),
            ),
            StacExpanded(child: StacSizedBox()),
            if (warningBadge != null)
              StacContainer(
                padding: StacEdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: StacBoxDecoration(
                  color: '#E31D35',
                  borderRadius: StacBorderRadius.all(99),
                ),
                child: StacText(
                  data: warningBadge,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 11,
                    fontWeight: StacFontWeight.w500,
                    color: '#FFFFFF',
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '#F4FDFF',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: card,
      ).toJson(),
      replacement: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: card,
      ).toJson(),
    ),
  );
}

StacWidget _metaRow({required String label, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacText(
        data: value,
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}
