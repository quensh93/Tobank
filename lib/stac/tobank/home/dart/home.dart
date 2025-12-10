import 'package:stac_core/stac_core.dart';
import 'package:stac_core/actions/network_request/stac_network_request.dart';

/// Tobank Home Screen - Main dashboard after login
/// 
/// This screen displays:
/// - Account balance card (from API)
/// - Quick action buttons (Transfer, Pay Bills, etc.) - labels from API
/// - Recent transactions list (from API)
/// 
/// Uses data binding to load all data from mock API.
/// Uses STAC theme colors which automatically adapt to light/dark mode.
@StacScreen(screenName: 'tobank_home')
StacWidget tobankHome() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacDynamicView(
        request: StacNetworkRequest(
          url: 'https://api.tobank.com/home-data',
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
          data: '{{appStrings.home.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: 'onSurface',
          ),
        ),
        errorWidget: StacText(
          data: '{{appStrings.home.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: 'onSurface',
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        StacIconButton(
          icon: StacIcon(
            icon: 'notifications',
            color: 'onSurface',
            size: 24,
          ),
          onPressed: StacNavigateAction(
            assetPath: 'stac/.build/tobank_notifications.json',
            navigationStyle: NavigationStyle.push,
          ),
        ),
      ],
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/home-data',
        method: Method.get,
      ),
      targetPath: 'data',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.home.errorLoading}}',
          style: StacCustomTextStyle(
            color: 'error',
          ),
        ),
      ),
      template: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          mainAxisAlignment: StacMainAxisAlignment.start,
          children: [
            // Balance Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{accountBalanceLabel}}',
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
                        fontSize: 32,
                        fontWeight: StacFontWeight.bold,
                        color: 'onSurface',
                      ),
                    ),
                    StacSizedBox(height: 16),
                    StacText(
                      data: '{{accountNumber}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: 'onSurfaceVariant',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 24),
            
            // Quick Actions Section
            StacText(
              data: '{{quickActionsTitle}}',
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.bold,
                color: 'onSurface',
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Quick Actions Row
            StacRow(
              mainAxisAlignment: StacMainAxisAlignment.spaceEvenly,
              children: [
                // Transfer Money
                StacExpanded(
                  child: StacColumn(
                    children: [
                      StacIconButton(
                        icon: StacIcon(
                          icon: 'send',
                          color: 'primary',
                          size: 32,
                        ),
                        onPressed: StacNavigateAction(
                          assetPath: 'stac/.build/tobank_transfer_form.json',
                          navigationStyle: NavigationStyle.push,
                        ),
                      ),
                      StacSizedBox(height: 8),
                      StacText(
                        data: '{{transferLabel}}',
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: 'onSurface',
                        ),
                        textAlign: StacTextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Pay Bills
                StacExpanded(
                  child: StacColumn(
                    children: [
                      StacIconButton(
                        icon: StacIcon(
                          icon: 'receipt',
                          color: 'primary',
                          size: 32,
                        ),
                        onPressed: StacNavigateAction(
                          assetPath: 'stac/.build/tobank_pay_bills.json',
                          navigationStyle: NavigationStyle.push,
                        ),
                      ),
                      StacSizedBox(height: 8),
                      StacText(
                        data: '{{payBillsLabel}}',
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: 'onSurface',
                        ),
                        textAlign: StacTextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Account Overview
                StacExpanded(
                  child: StacColumn(
                    children: [
                      StacIconButton(
                        icon: StacIcon(
                          icon: 'account_balance',
                          color: 'primary',
                          size: 32,
                        ),
                        onPressed: StacNavigateAction(
                          assetPath: 'stac/.build/tobank_account_overview.json',
                          navigationStyle: NavigationStyle.push,
                        ),
                      ),
                      StacSizedBox(height: 8),
                      StacText(
                        data: '{{accountLabel}}',
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: 'onSurface',
                        ),
                        textAlign: StacTextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Transaction History
                StacExpanded(
                  child: StacColumn(
                    children: [
                      StacIconButton(
                        icon: StacIcon(
                          icon: 'history',
                          color: 'primary',
                          size: 32,
                        ),
                        onPressed: StacNavigateAction(
                          assetPath: 'stac/.build/tobank_transaction_history.json',
                          navigationStyle: NavigationStyle.push,
                        ),
                      ),
                      StacSizedBox(height: 8),
                      StacText(
                        data: '{{historyLabel}}',
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: 'onSurface',
                        ),
                        textAlign: StacTextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            StacSizedBox(height: 32),
            
            // Recent Transactions Section
            StacRow(
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacText(
                  data: '{{recentTransactionsTitle}}',
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: 'onSurface',
                  ),
                ),
                StacTextButton(
                  onPressed: StacNavigateAction(
                    assetPath: 'stac/.build/tobank_transaction_history.json',
                    navigationStyle: NavigationStyle.push,
                  ),
                  child: StacText(
                    data: '{{viewAllText}}',
                    style: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w600,
                      color: 'primary',
                    ),
                  ),
                ),
              ],
            ),
            
            StacSizedBox(height: 16),
            
            // Recent Transactions List - Using StacDynamicView with itemTemplate
            // Note: itemTemplate will be added to JSON after build
            StacDynamicView(
              request: StacNetworkRequest(
                url: 'https://api.tobank.com/home-data',
                method: Method.get,
              ),
              targetPath: 'data.transactions',
              loaderWidget: StacSizedBox(height: 100),
              errorWidget: StacText(
                data: '{{appStrings.home.errorLoadingTransactions}}',
                style: StacCustomTextStyle(color: 'error'),
              ),
              emptyTemplate: StacText(
                data: '{{appStrings.home.noTransactionsFound}}',
                style: StacCustomTextStyle(color: 'onSurfaceVariant'),
              ),
              // Use StacListView - itemTemplate will be added to JSON after build
              template: StacListView(
                shrinkWrap: true,
                physics: StacScrollPhysics.never,
                children: [], // Empty - will be replaced by itemTemplate in JSON
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
