import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'promissory_real_deposits')
StacWidget promissoryRealDeposits() {
  final fetchDepositsAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'deposits.isLoaded', 'value': false},
          {'key': 'deposits.rawData', 'value': null},
          {'key': 'deposits.error', 'value': null},
          {'key': 'selectedDepositId', 'value': null},
          {'key': 'hasSelection', 'value': false},
        ],
      ),
      StacNetworkRequestAction(
        url:
            'http://192.168.107.22:8280/api/digitalbanking/deposits/v1.0/customer/{{userData.nationalCode}}',
        method: 'get',
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'app-platform': 'android',
          'app-store': 'application/json',
          'app-version': '456',
          'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
          'serviceauthorization':
              'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
          'authorization': '{{auth.accessToken}}',
        },
        results: [
          {
            'statusCode': 200,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.rawData', 'value': '{{data_payload}}'},
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.error', 'value': null},
              ],
            ).toJson(),
          },
          {
            'statusCode': 403,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': 'Access forbidden. Please check your permissions.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': 401,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': 'Authentication failed. Please login again.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': 520,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value':
                      'Server Error (520): Unknown Response from Gateway. Please try again later.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': 500,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': 'Internal Server Error. Please try again later.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': -1,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value':
                      // خطا در برقراری ارتباط با سرور. لطفا مجددا تلاش کنید.
                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                },
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  final onContinueAction = const StacNavigateAction(
    routeName: 'promissory_real_issuer',
    navigationStyle: NavigationStyle.push,
  );

  return StacStatefulWidget(
    onInit: fetchDepositsAction,
    child: StacScaffold(
      appBar: buildPromissoryAppBar(
        // انتخاب سپرده
        title: '{{appStrings.promissory.selectDepositTitle}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 24.0),
          StacPadding(
            padding: const StacEdgeInsets.symmetric(horizontal: 16.0),
            child: StacText(
              // سپرده مورد نظر برای صدور سفته را انتخاب نمایید:
              data: '{{appStrings.promissory.selectDepositForPromissory}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16.0,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 16.0),
          // ----- REACTIVE LIST VIEW -----
          StacExpanded(
            child: StacCustomReactiveListView(
              dataKey: 'deposits.rawData',
              dataPath: 'data',
              isLoadedKey: 'deposits.isLoaded',
              errorKey: 'deposits.error',
              itemIdField: 'depositNumber',
              selectedIdKey: 'selectedDepositId',
              padding: const {
                'left': 16.0,
                'right': 16.0,
                'top': 8.0,
                'bottom': 8.0,
              },
              separator: StacSizedBox(height: 16.0).toJson(),
              loadingWidget: _buildDepositsLoadingWidget().toJson(),
              errorWidget: _buildErrorContent(fetchDepositsAction).toJson(),
              emptyWidget: _buildDepositsEmptyWidget().toJson(),
              onItemTap: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'selectedDepositId',
                        'value': '{{item.depositNumber}}',
                      },
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {'key': 'hasSelection', 'value': true},
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'form.selected_deposit_id',
                        'value': '{{item.depositNumber}}',
                      },
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'form.selected_deposit_title',
                        'value': '{{item.depositTitle}}',
                      },
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'form.selected_deposit_number',
                        'value': '{{item.depositNumber}}',
                      },
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'form.selected_shaba_number',
                        'value': '{{item.depositIban}}',
                      },
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'selectedDeposit.depositNumber',
                        'value': '{{item.depositNumber}}',
                      },
                    ],
                  ),
                  StacCustomSetValueAction(
                    values: const [
                      {
                        'key': 'selectedDeposit.depositIban',
                        'value': '{{item.depositIban}}',
                      },
                    ],
                  ),
                ],
              ),
              itemTemplate: _buildDepositCardTemplate().toJson(),
            ),
          ),
          // ----- CONTINUE BUTTON -----
          StacPadding(
            padding: const StacEdgeInsets.all(16.0),
            child: StacCustomReactiveElevatedButton(
              enabledKey: 'hasSelection',
              onPressed: onContinueAction,
              style: {
                'type': 'buttonStyle',
                'backgroundColor': '{{appColors.current.primary.color}}',
                'elevation': 0.0,
                'fixedSize': StacSize(
                  999999.0,
                  56.0,
                ).toJson(), // generic infinite logic
                'shape': {
                  'type': 'roundedRectangleBorder',
                  'borderRadius': {'type': 'all', 'value': 12.0},
                },
              },
              child: StacText(
                // ادامه
                data: '{{appStrings.common.continue}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 18.0,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ).toJson(),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildErrorContent(StacSequenceAction onRetryAction) {
  return StacCenter(
    child: StacColumn(
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        StacPadding(
          padding: const StacEdgeInsets.all(16.0),
          child: StacText(
            data: '{{error}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 14.0,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ),
        StacSizedBox(height: 16.0),
        StacElevatedButton(
          onPressed: onRetryAction,
          style: StacButtonStyle(
            backgroundColor: '{{appColors.current.primary.color}}',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(12.0),
            ),
          ),
          child: StacText(
            // تلاش مجدد
            data: '{{appStrings.common.tryAgain}}',
            style: StacTextStyle(
              color: 'white',
              fontWeight: StacFontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildDepositsLoadingWidget() {
  return StacCenter(
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacCircularProgressIndicator(),
        StacSizedBox(height: 16.0),
        StacText(
          // در حال دریافت لیست سپرده‌ها...
          data: '{{appStrings.promissory.loadingDeposits}}',
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16.0,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildDepositsEmptyWidget() {
  return StacCenter(
    child: StacText(
      // سپرده‌ای یافت نشد. لطفا از طریق شعبه اقدام نمایید.
      data: '{{appStrings.promissory.noDepositFound}}',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 14.0,
        color: '{{appColors.current.text.subtitle}}',
      ),
    ),
  );
}

StacWidget _buildDepositCardTemplate() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8.0),
      border: StacBorder.all(
        color:
            '{{isSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
        width: 1.0,
      ),
    ),
    padding: const StacEdgeInsets.all(16.0),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        // Title row with radio indicator
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacExpanded(
              child: StacText(
                data: '{{item.depositTitle}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 16.0,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            // Radio indicator
            StacContainer(
              width: 24.0,
              height: 24.0,
              decoration: StacBoxDecoration(
                shape: StacBoxShape.circle,
                border: StacBorder.all(
                  color:
                      '{{isSelected ? appColors.current.secondary.color : appColors.current.text.subtitle}}',
                  width: 2.0,
                ),
              ),
              child: StacCenter(
                child: StacCustomOpacity(
                  opacity: '{{isSelected ? 1.0 : 0.0}}',
                  child: StacContainer(
                    width: 12.0,
                    height: 12.0,
                    decoration: StacBoxDecoration(
                      shape: StacBoxShape.circle,
                      color: '{{appColors.current.secondary.color}}',
                    ),
                  ).toJson(),
                ),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 12.0),
        // Divider
        StacContainer(
          height: 1.0,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacSizedBox(height: 12.0),
        // Deposit number
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              // شماره سپرده: 
              data: '{{appStrings.promissory.depositNumberLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14.0,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacText(
              data: '{{item.depositNumber}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14.0,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 8.0),
        // Shaba number
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              // شماره شبا: 
              data: '{{appStrings.promissory.ibanLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14.0,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacExpanded(
              child: StacText(
                data: '{{item.depositIban}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 14.0,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 8.0),
        // Available amount
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              // موجودی: 
              data: '{{appStrings.promissory.balanceLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14.0,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacText(
              data: '{{item.availableAmount}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14.0,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(width: 4.0),
            StacText(
              // ریال
              data: '{{appStrings.common.rial}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14.0,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

