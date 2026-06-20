import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'transaction_intro')
StacWidget transactionRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'trIntroChipAllSelected', 'value': true},
        {'key': 'trIntroChipWalletSelected', 'value': false},
        {'key': 'trIntroShowSuccessTx', 'value': true},
        {'key': 'trIntroShowFailedTx', 'value': true},
        {'key': 'trFilterDirectionReceive', 'value': false},
        {'key': 'trFilterDirectionSend', 'value': false},
        {'key': 'trFilterWalletTypeSelected', 'value': false},
        {'key': 'trFilterTypeGiftCard', 'value': false},
        {'key': 'trFilterTypeTransferWallet', 'value': false},
        {'key': 'trFilterTypeCardToCard', 'value': false},
        {'key': 'trFilterTypeBuyInternet', 'value': false},
        {'key': 'trFilterTypeBuyRecharge', 'value': false},
        {'key': 'trFilterTypeCharity', 'value': false},
        {'key': 'trFilterTypeWalletCharge', 'value': false},
        {'key': 'trFilterTypeBillPayment', 'value': false},
        {'key': 'trFilterTypeGroupBill', 'value': false},
        {'key': 'trFilterTypeRefund', 'value': false},
        {'key': 'trFilterTypeSafeBox', 'value': false},
        {'key': 'trFilterStatusSuccessSelected', 'value': false},
        {'key': 'trFilterStatusFailedSelected', 'value': false},
        {'key': 'trFilterStatusNoLimit', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacDefaultTabController(
        length: 2,
        initialIndex: 1,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 65),
            _buildTopTabs(),
            StacExpanded(
              child: StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 14),
                child: StacTabBarView(
                  children: [_buildDepositsContent(), _buildToBankContent()],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildTopTabs() {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 20, vertical: 10),

    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.circular(12),
    ),
    child: StacStack(
      children: [
        StacTabBar(
          enableFeedback: false,
          dividerColor: '#00000000',
          indicatorColor: '{{appColors.current.primary.color}}',
          indicatorWeight: 3,
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.only(left: 62, top: 50, right: 62),
          labelStyle: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w800,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.hint}}',
          tabs: const [
            StacTab(text: '{{appStrings.homePage.tabs.deposits}}', height: 54),
            StacTab(text: '{{appStrings.splash.title}}', height: 54),
          ],
        ),
        StacPositioned(
          top: 12,
          bottom: 12,
          left: 0,
          right: 0,
          child: StacCenter(
            child: StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildToBankContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 14),
        _buildToBankHeaderFilters(),
        StacSizedBox(height: 16),
        StacCustomVisibility(
          visible: '[[trIntroChipAllSelected]]',
          child: StacColumn(
            children: [
              StacCustomVisibility(
                visible: '[[trIntroShowSuccessTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial}}',
                      title:
                          '{{appStrings.generated.installment_payment.installment_payment_receipt.title}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.title}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_message}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.promissory_fee}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.amount_value}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_label}}',
                      title: '{{appStrings.homePage.cards.cardToCard}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.amount_value_text}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
              StacCustomVisibility(
                visible: '[[trIntroShowFailedTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_description}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.promissory_fee}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.amount_value_label}}',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.charge.charge_intro.rial}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.topup_wallet_money}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.amount_value_message}}',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_label}}',
                      title: '{{appStrings.homePage.cards.cardToCard}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.amount_value_item}}',
                      isSuccess: false,
                    ),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
        StacCustomVisibility(
          visible: '[[trIntroChipWalletSelected]]',
          child: StacColumn(
            children: [
              StacCustomVisibility(
                visible: '[[trIntroShowSuccessTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_label}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.transaction_wallet_money}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.amount_value_alt}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_hint}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.credit_validation_service}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.sample_number}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.rial}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.credit_validation_service}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.sample_number_option}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.rial_value}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.gift_card}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.sample_number_message}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.transaction_wallet_money}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.sample_number_label}}',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
              StacCustomVisibility(
                visible: '[[trIntroShowFailedTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.charge.charge_intro.rial}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_intro.topup_wallet_money}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.sample_number_theme}}',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount:
                          '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_option}}',
                      title:
                          '{{appStrings.generated.transaction.transaction_filter.wallet_transfer}}',
                      subtitle:
                          '{{appStrings.generated.transaction.transaction_intro.sample_number_sample}}',
                      isSuccess: false,
                    ),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
        StacSizedBox(height: 10),
      ],
    ),
  );
}

StacWidget _buildToBankHeaderFilters() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacGestureDetector(
        onTap: NavigationAction(
          fileName: 'transaction_filter',
          navMode: NavModes.dart,
          navigationStyle: NavigationStyle.push,
        ),

        child: StacContainer(
          height: 36,
          padding: StacEdgeInsets.symmetric(horizontal: 12),
          decoration: StacBoxDecoration(
            color: 'transparent',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            mainAxisAlignment: StacMainAxisAlignment.center,
            textDirection: StacTextDirection.rtl,
            children: [
              StacIcon(
                icon: 'tune',
                size: 16,
                color: '{{appColors.current.text.subtitle}}',
              ),
              StacSizedBox(width: 6),
              StacText(
                data:
                    '{{appStrings.generated.transaction.transaction_intro.filter}}',
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
      ),
      StacSizedBox(width: 6),
      StacContainer(
        width: 1,
        height: 25,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      StacSizedBox(width: 6),
      _buildToggleChip(
        title: '{{appStrings.generated.cartable.cartable_intro.all_filter}}',
        selectedVisible: '[[trIntroChipAllSelected]]',
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'trIntroChipAllSelected', 'value': true},
            {'key': 'trIntroChipWalletSelected', 'value': false},
            {'key': 'trIntroShowSuccessTx', 'value': true},
            {'key': 'trIntroShowFailedTx', 'value': true},
          ],
        ),
      ),
      StacSizedBox(width: 8),
      _buildToggleChip(
        title:
            '{{appStrings.generated.transaction.transaction_intro.transaction_wallet_money_text}}',
        selectedVisible: '[[trIntroChipWalletSelected]]',
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'trIntroChipAllSelected', 'value': false},
            {'key': 'trIntroChipWalletSelected', 'value': true},
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildToggleChip({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        height: 36,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.secondary.secondaryContainer}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.secondary.color}}',
            width: 1,
          ),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.secondary.color}}',
            ),
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 36,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        decoration: StacBoxDecoration(
          color: 'transparent',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildDepositsContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      children: [
        StacSizedBox(height: 14),
        _buildTransactionCard(
          amount:
              '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_message}}',
          title:
              '{{appStrings.generated.transaction.transaction_intro.bridge_service}}',
          subtitle:
              '{{appStrings.generated.transaction.transaction_intro.transfer}}',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount:
              '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_label}}',
          title:
              '{{appStrings.generated.transaction.transaction_intro.bridge_service}}',
          subtitle:
              '{{appStrings.generated.transaction.transaction_intro.transfer}}',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount:
              '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_label}}',
          title:
              '{{appStrings.generated.transaction.transaction_intro.bridge_service}}',
          subtitle:
              '{{appStrings.generated.transaction.transaction_intro.transfer}}',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount:
              '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_theme}}',
          title:
              '{{appStrings.generated.transaction.transaction_intro.bridge_service}}',
          subtitle:
              '{{appStrings.generated.transaction.transaction_intro.transfer}}',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount:
              '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_sample}}',
          title:
              '{{appStrings.generated.transaction.transaction_intro.sample_label}}',
          subtitle:
              '{{appStrings.generated.transaction.transaction_intro.transfer}}',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount:
              '{{appStrings.generated.transaction.transaction_intro.sample_amount_rial_secondary}}',
          title:
              '{{appStrings.generated.transaction.transaction_intro.sample_label}}',
          subtitle:
              '{{appStrings.generated.transaction.transaction_intro.transfer}}',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
      ],
    ),
  );
}

StacWidget _buildTransactionCard({
  required String amount,
  required String title,
  required String subtitle,
  required bool isSuccess,
}) {
  return StacContainer(
    padding: StacEdgeInsets.only(top: 14, bottom: 14, right: 14, left: 14),
    decoration: StacBoxDecoration(
      color: 'transparent',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacSizedBox(
          width: 28,
          height: 28,
          child: StacImage(
            src: isSuccess
                ? '{{appAssets.icons.transactionItemSuccessCurrent}}'
                : '{{appAssets.icons.transactionItemFailedCurrent}}',
            imageType: StacImageType.asset,
            width: 28,
            height: 28,
          ),
        ),
        StacSizedBox(width: 12),
        StacExpanded(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacExpanded(
                    child: StacText(
                      data: title,
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                  StacSizedBox(width: 12),
                  StacText(
                    data: amount,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.left,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 8),
              StacText(
                data: subtitle,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 13,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
