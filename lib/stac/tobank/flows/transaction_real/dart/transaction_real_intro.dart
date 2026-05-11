import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'transaction_real_intro')
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
    margin: StacEdgeInsets.symmetric(horizontal: 20 , vertical: 10),

    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.circular(12)
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
            StacTab(text: 'سپرده‌ها', height: 54),
            StacTab(text: 'توبانک', height: 54),
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
                      amount: '۱,۰۰۶,۰۰۰ ریال',
                      title: 'پرداخت اقساط',
                      subtitle: '۰۱ فروردین ۱۴۰۵ - ۱۱:۴۳',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۳۸,۰۰۰ ریال',
                      title: 'سرویس کارمزد سفته',
                      subtitle: '۰۲ اسفند ۱۴۰۴ - ۱۵:۲۷',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۱۰,۰۰۰ ریال',
                      title: 'کارت به کارت',
                      subtitle: '۰۶ دی ۱۴۰۴ - ۱۱:۰۲',
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
                      amount: '۳۱۳,۰۰۰ ریال',
                      title: 'سرویس کارمزد سفته',
                      subtitle: '۵۸ بهمن ۱۴۰۴ - ۱۰:۰۵',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۵۰,۰۰۰ ریال',
                      title: 'شارژ کیف پول توبانک',
                      subtitle: '۵۸ دی ۱۴۰۴ - ۱۴:۰۳',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۱۰,۰۰۰ ریال',
                      title: 'کارت به کارت',
                      subtitle: '۰۶ دی ۱۴۰۴ - ۱۵:۰۸',
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
                      amount: '۱۰,۰۰۰ ریال',
                      title: 'تراکنش کیف پول',
                      subtitle: '۰۳ دی ۱۴۰۴ - ۱۳:۳۰',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۸,۰۰۰ ریال',
                      title: 'سرویس اعتبارسنجی',
                      subtitle: '۰۱ دی ۱۴۰۴ - ۱۲:۰۱',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۸۰,۰۰۰ ریال',
                      title: 'سرویس اعتبارسنجی',
                      subtitle: '۲۶ آذر ۱۴۰۴ - ۱۱:۱۶',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۱,۳۶۸,۵۰۰ ریال',
                      title: 'سفارش کارت هدیه',
                      subtitle: '۲۶ آذر ۱۴۰۴ - ۱۱:۵۰',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۱,۴۰۰,۰۰۰ ریال',
                      title: 'تراکنش کیف پول',
                      subtitle: '۲۶ آذر ۱۴۰۴ - ۱۱:۴۰',
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
                      amount: '۵۰,۰۰۰ ریال',
                      title: 'شارژ کیف پول توبانک',
                      subtitle: '۰۸ دی ۱۴۰۴ - ۱۴:۰۳',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: '۲۵,۰۰۰ ریال',
                      title: 'انتقال کیف پول',
                      subtitle: '۰۸ دی ۱۴۰۴ - ۱۰:۱۶',
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
        onTap: const StacNavigateAction(
          routeName: 'transaction_real_filter',
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
                data: 'فیلترها',
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
        title: 'همه',
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
        title: 'تراکنش های کیف پول',
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
          amount: '۲۹۹,۹۰۰,۰۰۰ ریال',
          title: 'پل',
          subtitle: 'انتقال به مهدی جمشیدپور',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: '۵۰۰,۰۰۰,۰۰۰ ریال',
          title: 'پل',
          subtitle: 'انتقال به مهدی جمشیدپور',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: '۵۰۰,۰۰۰,۰۰۰ ریال',
          title: 'پل',
          subtitle: 'انتقال به مهدی جمشیدپور',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: '۱۰,۵۰۰,۰۰۰ ریال',
          title: 'پل',
          subtitle: 'انتقال به مهدی جمشیدپور',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: '۵۴۳,۸۰۰,۰۰۰ ریال',
          title: 'پایا',
          subtitle: 'انتقال به مهدی جمشیدپور',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: '۵۴۳,۹۰۰,۰۰۰ ریال',
          title: 'پایا',
          subtitle: 'انتقال به مهدی جمشیدپور',
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
