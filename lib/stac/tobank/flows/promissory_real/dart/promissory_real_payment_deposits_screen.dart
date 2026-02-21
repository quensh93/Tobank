import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

@StacScreen(screenName: 'promissory_real_payment_deposits')
StacWidget promissoryRealPaymentDeposits() {
  final fetchDepositsAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'deposits.isLoaded', 'value': false},
          {'key': 'deposits.rawData', 'value': null},
          {'key': 'deposits.error', 'value': null},
          {'key': 'selectedDepositId', 'value': null},
          {'key': 'hasSelection', 'value': false},
          {'key': 'isDraftLoading', 'value': false},
          // Clear stale deposit selection from previous screen
          {'key': 'selectedDeposit.depositNumber', 'value': null},
          {'key': 'selectedDeposit.depositIban', 'value': null},
          {'key': 'form.selected_deposit_id', 'value': null},
          {'key': 'form.selected_deposit_title', 'value': null},
          {'key': 'form.selected_deposit_number', 'value': null},
          {'key': 'form.selected_shaba_number', 'value': null},
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
            'action': StacSequenceAction(
              actions: [
                StacLogAction(
                  message:
                      'DEBUG: payment deposits fetch success. payload={{data_payload}}',
                ).toJson(),
                StacCustomSetValueAction(
                  values: const [
                    {'key': 'deposits.rawData', 'value': '{{data_payload}}'},
                    {'key': 'deposits.isLoaded', 'value': true},
                    {'key': 'deposits.error', 'value': null},
                  ],
                ).toJson(),
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
                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                },
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  // --- onContinue: Draft API call (PRESERVED from original) ---
  final onContinueAction = StacRawJsonAction({
    'actionType': 'sequence',
    'actions': [
      {'actionType': 'setValue', 'key': 'isDraftLoading', 'value': true},
      {'actionType': 'setValue', 'key': 'hasSelection', 'value': true},
      {
        'actionType': 'networkRequest',
        'url':
            'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/draft',
        'method': 'post',
        'headers': {
          'accept': 'application/json',
          'authorization': '{{auth.accessToken}}',
          'content-type': 'application/json',
        },
        'data': {
          'issuerType': 'I',
          'sourceAccount': '{{selectedDeposit.depositNumber}}',
          'issuerBirthDate': "{{replace(userData.birthDate, '/', '')}}",
          'issuerNN': '{{userData.nationalCode}}',
          'issuerSanaCheck': true,
          'issuerCellphone': '{{removeLeadingZero(userData.mobile)}}',
          'issuerFullName': '{{userData.fullName}}',
          'issuerAccountNumber': '{{selectedDeposit.depositIban}}',
          'issuerAddress': '{{userData.address}}',
          'issuerPostalCode': '{{userData.postalCode}}',
          'recipientType': 'I',
          'recipientBirthDate': "{{replace(receiver.birthDate, '/', '')}}",
          'recipientNationalId': '{{receiver.nationalCode}}',
          'recipientCellphone': '{{removeLeadingZero(receiver.mobile)}}',
          'recipientFullName': '{{receiverIdentity.fullName}}',
          'paymentPlace': 'تهران، آرشام',
          'amount': '{{toInt(form.promissory_amount)}}',
          'dueDate': "{{replace(form.promissory_due_date, '/', '')}}",
          'description': '{{form.description}}',
          'transferable': true,
        },
        'results': [
          {
            'statusCode': 200,
            'action': {
              'actionType': 'sequence',
              'actions': [
                {
                  'actionType': 'setValue',
                  'values': [
                    {'key': 'isDraftLoading', 'value': false},
                    {'key': 'hasSelection', 'value': true},
                    {
                      'key': 'form.unsigned_pdf_id',
                      'value': '{{data_payload.unSignedPdfId}}',
                    },
                    {
                      'key': 'form.promissory_id',
                      'value': '{{data_payload.id}}',
                    },
                  ],
                },
                {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_real_sign',
                  'navigationStyle': 'push',
                },
              ],
            },
          },
          {
            'statusCode': 422,
            'action': {
              'actionType': 'sequence',
              'actions': [
                {
                  'actionType': 'setValue',
                  'values': [
                    {'key': 'isDraftLoading', 'value': false},
                    {'key': 'hasSelection', 'value': true},
                  ],
                },
                {
                  'actionType': 'showSnackBar',
                  'backgroundColor': '#D32F2F',
                  'content': {
                    'type': 'text',
                    'data': '{{data.status.message.0}}',
                    'style': {
                      'type': 'custom',
                      'color': '#FFFFFF',
                      'fontSize': 14,
                    },
                  },
                },
              ],
            },
          },
          {
            'statusCode': -1,
            'action': {
              'actionType': 'sequence',
              'actions': [
                {
                  'actionType': 'setValue',
                  'values': [
                    {'key': 'isDraftLoading', 'value': false},
                    {'key': 'hasSelection', 'value': true},
                  ],
                },
                {
                  'actionType': 'showSnackBar',
                  'backgroundColor': '#D32F2F',
                  'content': {
                    'type': 'text',
                    'data': '{{data.status.message.0}}',
                    'style': {
                      'type': 'custom',
                      'color': '#FFFFFF',
                      'fontSize': 14,
                    },
                  },
                },
              ],
            },
          },
        ],
      },
    ],
  });

  return StacStatefulWidget(
    onInit: fetchDepositsAction,
    child: StacScaffold(
      appBar: _buildAppBar(),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 24.0),
          StacPadding(
            padding: const StacEdgeInsets.symmetric(horizontal: 16.0),
            child: StacText(
              data: 'سپرده خود را جهت پرداخت انتخاب کنید',
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
            child: StacRawJsonWidget({
              'type': 'reactiveListView',
              'dataKey': 'deposits.rawData',
              'dataPath': 'data',
              'isLoadedKey': 'deposits.isLoaded',
              'errorKey': 'deposits.error',
              'itemIdField': 'depositNumber',
              'selectedIdKey': 'selectedDepositId',
              'padding': {
                'left': 16.0,
                'right': 16.0,
                'top': 8.0,
                'bottom': 8.0,
              },
              'separator': StacSizedBox(height: 16.0).toJson(),
              'loadingWidget': StacCenter(
                child: StacColumn(
                  mainAxisSize: StacMainAxisSize.min,
                  children: [
                    StacCircularProgressIndicator(),
                    StacSizedBox(height: 16.0),
                    StacText(
                      data: 'در حال دریافت لیست سپرده‌ها...',
                      textDirection: StacTextDirection.rtl,
                      style: StacTextStyle(
                        fontSize: 16.0,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                  ],
                ),
              ).toJson(),
              'errorWidget': _buildErrorContent(fetchDepositsAction).toJson(),
              'emptyWidget': StacCenter(
                child: StacText(
                  data: 'سپرده‌ای یافت نشد',
                  textDirection: StacTextDirection.rtl,
                  style: StacTextStyle(
                    fontSize: 14.0,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ).toJson(),
              'onItemTap': StacSequenceAction(
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
              ).toJson(),
              'itemTemplate': _buildDepositCardTemplate().toJson(),
            }),
          ),
          // ----- CONTINUE BUTTON (with draft API call + loading state) -----
          StacPadding(
            padding: const StacEdgeInsets.all(16.0),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabledKey': 'hasSelection',
              'loadingKey': 'isDraftLoading',
              'onPressed': onContinueAction.toJson(),
              'style': {
                'type': 'buttonStyle',
                'backgroundColor': '{{appColors.current.primary.color}}',
                'elevation': 0.0,
                'fixedSize': StacSize(999999.0, 56.0).toJson(),
                'shape': {
                  'type': 'roundedRectangleBorder',
                  'borderRadius': {'type': 'all', 'value': 12.0},
                },
              },
              'child': StacText(
                data: '{{appStrings.common.continue}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 18.0,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ).toJson(),
            }),
          ),
        ],
      ),
    ),
  );
}

StacAppBar _buildAppBar() {
  return StacAppBar(
    centerTitle: true,
    title: StacText(
      data: 'انتخاب سپرده پرداخت',
      textDirection: StacTextDirection.rtl,
      style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
    ),
    leading: StacIconButton(
      onPressed: StacRawJsonAction({
        'actionType': 'navigate',
        'navigationStyle': 'pop',
      }),
      icon: StacImage(
        src: 'assets/icons/ic_right_arrow.svg',
        imageType: StacImageType.asset,
        width: 24.0,
        height: 24.0,
        color: '{{appColors.current.text.title}}',
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
            data: 'تلاش مجدد',
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
                child: StacRawJsonWidget({
                  'type': 'opacity',
                  'opacity': '{{isSelected ? 1.0 : 0.0}}',
                  'child': StacContainer(
                    width: 12.0,
                    height: 12.0,
                    decoration: StacBoxDecoration(
                      shape: StacBoxShape.circle,
                      color: '{{appColors.current.secondary.color}}',
                    ),
                  ).toJson(),
                }),
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
              data: 'شماره سپرده: ',
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
              data: 'شماره شبا: ',
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
              data: 'موجودی: ',
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
