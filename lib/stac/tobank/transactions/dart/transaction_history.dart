import 'package:stac_core/stac_core.dart';
import 'package:stac_core/actions/network_request/stac_network_request.dart';

/// Tobank Transaction History Screen - List of all transactions
/// 
/// This screen displays a list of all user transactions.
/// 
/// Uses data binding to load all data from mock API.
/// Uses Persian text from app_fa.arb.
/// Uses STAC theme colors which automatically adapt to light/dark mode.
/// 
/// Reference: `.tobank_old/lib/ui/dashboard_screen/page/transaction_list_page.dart`
@StacScreen(screenName: 'tobank_transaction_history')
StacWidget tobankTransactionHistory() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacDynamicView(
        request: StacNetworkRequest(
          url: 'https://api.tobank.com/transaction-history-data',
          method: Method.get,
        ),
        targetPath: 'data',
        template: StacText(
          data: '{{appBarTitle}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        loaderWidget: StacText(
          data: '{{appStrings.transactions.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        errorWidget: StacText(
          data: '{{appStrings.transactions.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      centerTitle: true,
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/transaction-history-data',
        method: Method.get,
      ),
      targetPath: 'data.transactions',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.transactions.errorLoading}}',
          style: StacCustomTextStyle(
            color: '{{appColors.current.error.color}}',
          ),
        ),
      ),
      emptyTemplate: StacCenter(
        child: StacText(
          data: '{{appStrings.transactions.noTransactionsFound}}',
          style: StacCustomTextStyle(
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      template: StacListView(
        padding: StacEdgeInsets.all(8),
        children: [], // Empty - will be replaced by itemTemplate in JSON
      ),
    ),
  );
}
