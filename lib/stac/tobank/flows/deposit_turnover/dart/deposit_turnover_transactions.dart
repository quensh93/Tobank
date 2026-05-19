import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_turnover_transactions')
StacWidget depositTurnoverTransactions() {
  return StacCustomVisibility(
    visible: '[[dtFilterLatestSelected]]',
    child: _transactionsScaffold(
      title: '۱۰ گردش آخر',
      transactions: _latestTenTransactions(),
    ).toJson(),
    replacement: _transactionsScaffold(
      title: 'گردش سپرده',
      transactions: _timeRangeTransactions(),
    ).toJson(),
  );
}

StacWidget _transactionsScaffold({
  required String title,
  required List<StacWidget> transactions,
}) {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: title, showSupport: true),
    body: StacSafeArea(
      child: StacListView(
        padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
        children: [
          _depositNumberCard(),
          StacSizedBox(height: 14),
          ...transactions,
        ],
      ),
    ),
  );
}

StacWidget _depositNumberCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      textDirection: StacTextDirection.rtl,
      children: [
        StacText(
          data: 'شماره سپرده',
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacText(
          data: '۱۴۴.۹۹۶۶.۷۶۳۰۲۰.۱',
          textDirection: StacTextDirection.ltr,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _transactionCard({
  required String title,
  required String amount,
  required String dateTime,
  required bool isDeposit,
}) {
  return StacContainer(
    margin: StacEdgeInsets.only(top: 12),
    padding: StacEdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surfaceContainer}}',
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      crossAxisAlignment: StacCrossAxisAlignment.center,
      children: [
        StacImage(
          src: isDeposit
              ? '{{appAssets.icons.transactionItemSuccessCurrent}}'
              : '{{appAssets.icons.transactionItemFailedCurrent}}',
          imageType: StacImageType.asset,
          width: 32,
          height: 32,
        ),
        StacSizedBox(width: 14),
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
                        fontSize: 18,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                  StacText(
                    data: amount,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.left,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 10),
              StacText(
                data: dateTime,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 15,
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

List<StacWidget> _latestTenTransactions() {
  return [
    _transactionCard(
      title: 'واریز وجه',
      amount: '۱۰,۰۰۰ ریال',
      dateTime: '۱۴۰۵/۰۲/۱۶ - ۱۰:۳۶',
      isDeposit: true,
    ),
    _transactionCard(
      title: 'برداشت وجه',
      amount: '۱۰,۰۰۰ ریال',
      dateTime: '۱۴۰۵/۰۲/۱۲ - ۰۴:۳۶',
      isDeposit: false,
    ),
    _transactionCard(
      title: 'واریز وجه',
      amount: '۱۰,۰۰۰ ریال',
      dateTime: '۱۴۰۵/۰۲/۰۲ - ۰۹:۱۳',
      isDeposit: true,
    ),
    _transactionCard(
      title: 'برداشت وجه',
      amount: '۲,۲۰۹,۳۵۳ ریال',
      dateTime: '۱۴۰۴/۱۲/۱۲ - ۰۵:۱۶',
      isDeposit: false,
    ),
    _transactionCard(
      title: 'برداشت وجه',
      amount: '۱۳۳,۹۶۲,۵۰۰ ریال',
      dateTime: '۱۴۰۴/۱۲/۰۶ - ۱۷:۰۶',
      isDeposit: false,
    ),
    _transactionCard(
      title: 'واریز وجه',
      amount: '۸۴,۷۰۰,۰۰۰ ریال',
      dateTime: '۱۴۰۴/۱۲/۰۶ - ۱۶:۵۹',
      isDeposit: true,
    ),
    _transactionCard(
      title: 'واریز وجه',
      amount: '۴۰,۰۰۰,۰۰۰ ریال',
      dateTime: '۱۴۰۴/۱۲/۰۵ - ۱۱:۲۲',
      isDeposit: true,
    ),
    _transactionCard(
      title: 'برداشت وجه',
      amount: '۷۵,۰۰۰,۰۰۰ ریال',
      dateTime: '۱۴۰۴/۱۲/۰۴ - ۱۴:۰۷',
      isDeposit: false,
    ),
    _transactionCard(
      title: 'واریز وجه',
      amount: '۴,۵۰۰,۰۰۰ ریال',
      dateTime: '۱۴۰۴/۱۲/۰۳ - ۰۸:۲۸',
      isDeposit: true,
    ),
    _transactionCard(
      title: 'برداشت وجه',
      amount: '۹,۹۰۰,۰۰۰ ریال',
      dateTime: '۱۴۰۴/۱۲/۰۱ - ۱۹:۴۳',
      isDeposit: false,
    ),
  ];
}

List<StacWidget> _timeRangeTransactions() {
  return [
    _transactionCard(
      title: 'واریز وجه',
      amount: '۱۰,۰۰۰ ریال',
      dateTime: '۱۴۰۵/۰۲/۱۶ - ۱۰:۳۶',
      isDeposit: true,
    ),
    _transactionCard(
      title: 'برداشت وجه',
      amount: '۱۰,۰۰۰ ریال',
      dateTime: '۱۴۰۵/۰۲/۱۲ - ۰۴:۳۶',
      isDeposit: false,
    ),
    _transactionCard(
      title: 'واریز وجه',
      amount: '۱۰,۰۰۰ ریال',
      dateTime: '۱۴۰۵/۰۲/۰۲ - ۰۹:۱۳',
      isDeposit: true,
    ),
  ];
}
