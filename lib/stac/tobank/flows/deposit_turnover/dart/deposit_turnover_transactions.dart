import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_turnover_transactions')
StacWidget depositTurnoverTransactions() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: List.generate(
        _allTransactions.length,
        (index) => {
          'key': _expandedKey(index),
          'value': false,
        },
      ),
    ),
    child: StacCustomVisibility(
      visible: '[[dtFilterLatestSelected]]',
      child: _transactionsScaffold(
        title: '?? ???? ???',
        transactions: _latestTenTransactions(),
      ).toJson(),
      replacement: _transactionsScaffold(
        title: '???? ?????',
        transactions: _timeRangeTransactions(),
      ).toJson(),
    ),
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
          data: '????? ?????',
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacText(
          data: '???.????.??????.?',
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

StacWidget _transactionCard(_DepositTransaction transaction) {
  return StacGestureDetector(
    onTap: StacCustomSetValueAction(
      key: transaction.expandedKey,
      value: '{{${transaction.expandedKey} ? false : true}}',
    ),
    child: StacContainer(
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
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _transactionHeader(transaction),
          StacCustomVisibility(
            visible: '[[${transaction.expandedKey}]]',
            child: _transactionExpandedContent(transaction).toJson(),
            replacement: StacSizedBox(height: 0).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _transactionHeader(_DepositTransaction transaction) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      _transactionIcon(transaction.isDeposit),
      StacSizedBox(width: 12),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              crossAxisAlignment: StacCrossAxisAlignment.start,
              children: [
                StacExpanded(
                  child: StacText(
                    data: transaction.title,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
                StacSizedBox(width: 12),
                StacText(
                  data: transaction.amount,
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
              data: transaction.dateTime,
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
  );
}

StacWidget _transactionIcon(bool isDeposit) {
  return StacContainer(
    width: 48,
    height: 48,
    decoration: StacBoxDecoration(
      shape: StacBoxShape.circle,
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surfaceContainer}}',
    ),
    child: StacCenter(
      child: StacPadding(
        padding: StacEdgeInsets.all(8),
        child: StacImage(
          src: isDeposit
              ? '{{appAssets.icons.inCurrent}}'
              : '{{appAssets.icons.outCurrent}}',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
        ),
      ),
    ),
  );
}

StacWidget _transactionExpandedContent(_DepositTransaction transaction) {
  return StacPadding(
    padding: StacEdgeInsets.only(top: 16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          thickness: 1,
          height: 1,
        ),
        StacSizedBox(height: 16),
        StacText(
          data: '???????:',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            color: '{{appColors.current.text.title}}',
            fontSize: 14,
            fontWeight: StacFontWeight.w700,
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: transaction.description,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            color: '{{appColors.current.text.subtitle}}',
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            height: 1.75,
          ),
        ),
      ],
    ),
  );
}

List<StacWidget> _latestTenTransactions() {
  return _allTransactions.take(10).map(_transactionCard).toList();
}

List<StacWidget> _timeRangeTransactions() {
  return _allTransactions.take(3).map(_transactionCard).toList();
}

String _expandedKey(int index) => 'depositTurnoverExpanded$index';

final List<_DepositTransaction> _allTransactions = [
  _DepositTransaction(
    title: '????? ???',
    amount: '??,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '????? ??? ?? ????? ?? ???? ?????? ????? ???? ???? ????? ?????? ???? ????? ??? ???.',
    isDeposit: true,
    expandedKey: _expandedKey(0),
  ),
  _DepositTransaction(
    title: '?????? ???',
    amount: '??,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '?????? ???? ?????? ????? ?????? ?? ?? ????? ?????? ?????????????????????? ??? ??? ???.',
    isDeposit: false,
    expandedKey: _expandedKey(1),
  ),
  _DepositTransaction(
    title: '????? ???',
    amount: '??,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '????? ?? ???? ???? ????? ?? ??? ????? ?? ??? ?????? ?????? ?????? ????? ??? ???.',
    isDeposit: true,
    expandedKey: _expandedKey(2),
  ),
  _DepositTransaction(
    title: '?????? ???',
    amount: '?,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '?????? ??? ???? ?????? ?? ???? ???? ???? ???????? ?? ????? ?????? ??????? ??? ??? ???.',
    isDeposit: false,
    expandedKey: _expandedKey(3),
  ),
  _DepositTransaction(
    title: '?????? ???',
    amount: '???,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '???? ???? ????? ??????? ?????? ???? ?? ????? ??? ??? ? ?? ?????? ?????????? ????????? ???.',
    isDeposit: false,
    expandedKey: _expandedKey(4),
  ),
  _DepositTransaction(
    title: '????? ???',
    amount: '??,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '????? ?? ???? ???? ???? ???? ????? ?????? ????? ???????????? ??? ??? ???.',
    isDeposit: true,
    expandedKey: _expandedKey(5),
  ),
  _DepositTransaction(
    title: '????? ???',
    amount: '??,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '????? ??? ?? ???? ???? ????? ??? ????? ?????? ???? ???? ??? ????? ????? ??? ???.',
    isDeposit: true,
    expandedKey: _expandedKey(6),
  ),
  _DepositTransaction(
    title: '?????? ???',
    amount: '??,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '?????? ???? ?????? ??? ????? ?? ???? ????????? ????? ?? ??? ???? ?? ?????? ????? ??? ???.',
    isDeposit: false,
    expandedKey: _expandedKey(7),
  ),
  _DepositTransaction(
    title: '????? ???',
    amount: '?,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '????? ?????? ??? ?? ????? ??? ?? ??? ????? ?? ?????? ??? ??? ??? ???.',
    isDeposit: true,
    expandedKey: _expandedKey(8),
  ),
  _DepositTransaction(
    title: '?????? ???',
    amount: '?,???,??? ????',
    dateTime: '????/??/?? - ??:??',
    description:
        '?????? ??? ???? ?????? ???? ?? ???? ????? ?? ????? ?????? ???????? ????? ??? ???.',
    isDeposit: false,
    expandedKey: _expandedKey(9),
  ),
];

class _DepositTransaction {
  const _DepositTransaction({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.description,
    required this.isDeposit,
    required this.expandedKey,
  });

  final String title;
  final String amount;
  final String dateTime;
  final String description;
  final bool isDeposit;
  final String expandedKey;
}

