import 'package:stac_core/stac_core.dart';
import 'package:stac_core/actions/network_request/stac_network_request.dart';

/// Tobank Account Overview Screen - Account details and information
/// 
/// This screen displays account information including:
/// - Account number
/// - Account type
/// - Balance
/// - Account holder name
/// 
/// Uses data binding to load all data from mock API.
/// Uses Persian text from app_fa.arb.
/// Uses STAC theme colors which automatically adapt to light/dark mode.
/// 
/// Reference: `.tobank_old/lib/ui/dashboard_screen/page/account_page.dart`
@StacScreen(screenName: 'tobank_account_overview')
StacWidget tobankAccountOverview() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacDynamicView(
        request: StacNetworkRequest(
          url: 'https://api.tobank.com/account-overview-data',
          method: Method.get,
        ),
        targetPath: 'data',
        template: StacText(
          data: '{{appBarTitle}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: 'onSurface',
          ),
        ),
        loaderWidget: StacText(
          data: '{{appStrings.account.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: 'onSurface',
          ),
        ),
        errorWidget: StacText(
          data: '{{appStrings.account.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: 'onSurface',
          ),
        ),
      ),
      centerTitle: true,
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/account-overview-data',
        method: Method.get,
      ),
      targetPath: 'data',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.account.errorLoading}}',
          style: StacCustomTextStyle(
            color: 'error',
          ),
        ),
      ),
      template: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            // Account Number Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{accountNumberLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: 'onSurfaceVariant',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{accountNumber}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: 'onSurface',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Account Type Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{accountTypeLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: 'onSurfaceVariant',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{accountType}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: 'onSurface',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Balance Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{balanceLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: 'onSurfaceVariant',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{balance}}',
                      style: StacCustomTextStyle(
                        fontSize: 24,
                        fontWeight: StacFontWeight.bold,
                        color: 'onSurface',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Account Holder Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{holderLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: 'onSurfaceVariant',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{accountHolder}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: 'onSurface',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
