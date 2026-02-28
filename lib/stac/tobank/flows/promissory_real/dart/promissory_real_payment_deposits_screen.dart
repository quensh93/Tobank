import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

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
      StacApiCallAction(
        path:
            '/api/digitalbanking/deposits/v1.0/customer/{{userData.nationalCode}}',
        method: 'get',
        dataBind: 'customerDeposits',
        results: [
          {
            'statusCode': 200,
            'action': StacSequenceAction(
              actions: [
                StacLogAction(
                  message:
                      'DEBUG: payment deposits fetch success. payload={{responses.customerDeposits.data}}',
                ).toJson(),
                StacCustomSetValueAction(
                  values: const [
                    {
                      'key': 'deposits.rawData',
                      'value': '{{responses.customerDeposits.data}}',
                    },
                    {'key': 'deposits.isLoaded', 'value': true},
                    {'key': 'deposits.error', 'value': null},
                  ],
                ).toJson(),
              ],
            ).toJson(),
          },
          {
            'statusCode': -1, // Wildcard Catch-All Error Handler
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {'key': 'deposits.error', 'value': '{{data.status.message.0}}'},
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  final onContinueAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(key: 'isDraftLoading', value: true),
      StacCustomSetValueAction(key: 'hasSelection', value: true),
      StacCustomSetValueAction(
        values: [
          {
            'key': 'payload.recipientType',
            'value': 'I',
            'condition': 'recipientType',
          },
          {
            'key': 'payload.recipientBirthDate',
            'value': '{{receiver.birthDateCompact}}',
            'condition': 'recipientType',
          },
          {
            'key': 'payload.recipientNationalId',
            'value': '{{receiver.nationalCode}}',
            'condition': 'recipientType',
          },
          {
            'key': 'payload.recipientCellphone',
            'value': '{{removeLeadingZero(receiver.phoneNumber)}}',
            'condition': 'recipientType',
          },
          {
            'key': 'payload.recipientType',
            'value': 'C',
            'condition': '!recipientType',
          },
          {
            'key': 'payload.recipientBirthDate',
            'value': '',
            'condition': '!recipientType',
          },
          {
            'key': 'payload.recipientNationalId',
            'value': '{{receiverIdentity.nationalId}}',
            'condition': '!recipientType',
          },
          {
            'key': 'payload.recipientCellphone',
            'value': '{{receiverIdentity.phone}}',
            'condition': '!recipientType',
          },
        ],
      ).toJson(),
      StacApiCallAction(
        path: '/api/digitalbanking/collateral/v1.0/promissories/draft',
        dataBind: 'draftResponse',
        method: 'post',
        data: {
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
          'recipientType': '{{payload.recipientType}}',
          'recipientBirthDate': '{{payload.recipientBirthDate}}',
          'recipientNationalId': '{{payload.recipientNationalId}}',
          'recipientCellphone': '{{payload.recipientCellphone}}',
          'recipientFullName': '{{receiverIdentity.fullName}}',
          'paymentPlace': '{{form.paymentPlace}}',
          'amount': '{{toInt(form.promissory_amount)}}',
          'dueDate': "{{replace(form.promissory_due_date, '/', '')}}",
          'description': '{{form.description}}',
          'transferable': '{{form.transferable}}',
        },
        results: [
          {
            'statusCode': 200,
            'action': StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  values: const [
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
                    {
                      'key': 'rawTransactionTime',
                      'value': '{{data.meta.time}}',
                    },
                  ],
                ).toJson(),
                {
                  'actionType': 'formatDate',
                  'sourceKey': 'rawTransactionTime',
                  'destinationKey': 'transactionTime',
                },
                const StacNavigateAction(
                  routeName: 'promissory_real_sign',
                  navigationStyle: NavigationStyle.push,
                ).toJson(),
              ],
            ).toJson(),
          },
          {
            'statusCode':
                -1, // Acts as Catch-All wildcard for any other failure
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
      ),
    ],
  );
  return StacStatefulWidget(
    onInit: fetchDepositsAction,
    child: StacScaffold(
      appBar: buildPromissoryAppBar(
        // انتخاب سپرده پرداخت
        title: '{{appStrings.promissory.selectPaymentDepositTitle}}',
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
              loadingWidget: StacCenter(
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
              ).toJson(),
              errorWidget: _buildErrorContent(fetchDepositsAction).toJson(),
              emptyWidget: StacCenter(
                child: StacText(
                  // سپرده‌ای یافت نشد. لطفا از طریق شعبه اقدام نمایید.
                  data: '{{appStrings.promissory.noDepositFound}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacTextStyle(
                    fontSize: 14.0,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ).toJson(),
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
          // ----- CONTINUE BUTTON (with draft API call + loading state) -----
          StacPadding(
            padding: const StacEdgeInsets.all(16.0),
            child: StacCustomReactiveElevatedButton(
              enabledKey: 'hasSelection',
              loadingKey: 'isDraftLoading',
              onPressed: onContinueAction,
              style: StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                elevation: 0.0,
                fixedSize: StacSize(999999.0, 56.0),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12.0),
                ),
              ).toJson(),
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
