import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/format/format_number_action.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

/// Promissory Real Flow - Payment Method Page
///
/// This screen allows users to select payment method:
/// 1. Wallet payment
/// 2. Deposit payment
///
///
/// Note: Integrating with Real API flow logic.
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'promissory_payment')
StacWidget promissoryRealPayment() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacFormatNumberAction(
          sourceKey: 'promissory.fees.total',
          destinationKey: 'promissory.fees.total_formatted',
        ),
        StacFormatNumberAction(
          sourceKey: 'promissory.fees.stampFee',
          destinationKey: 'promissory.fees.stampFee_formatted',
        ),
        StacFormatNumberAction(
          sourceKey: 'promissory.fees.wage',
          destinationKey: 'promissory.fees.wage_formatted',
        ),
        StacFormatNumberAction(
          sourceKey: 'wallet.balance',
          destinationKey: 'wallet.balance_formatted',
        ),
        StacCustomSetValueAction(key: 'isWalletSelected', value: false),
        StacCustomSetValueAction(key: 'isDepositSelected', value: false),
        StacCustomSetValueAction(key: 'selectedPaymentMethod', value: ''),
        StacCustomSetValueAction(key: 'isPayEnabled', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        // پرداخت هزینه
        title: '{{appStrings.promissory.paymentTitle}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  _buildIssuanceSummary(),
                  StacSizedBox(height: 16),
                  _buildFeesSection(),
                  StacSizedBox(height: 16),
                  StacText(
                    // روش پرداخت
                    data: '{{appStrings.promissory.paymentMethod}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),
                  _buildWalletPaymentOption(),
                  StacSizedBox(height: 12),
                  _buildDepositPaymentOption(),
                  StacSizedBox(height: 12),
                ],
              ),
            ),
          ),
          _buildPaymentButtons(),
        ],
      ),
    ),
  );
}

StacWidget _buildIssuanceSummary() {
  return StacColumn(
    children: [
      StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.all(40),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 0.5,
          ),
        ),
        padding: StacEdgeInsets.all(12),
        child: StacImage(
          src: 'assets/icons/ic_promissory_request.svg',
          imageType: StacImageType.asset,
          width: 40,
          height: 40,
        ),
      ),
      StacSizedBox(height: 12),
      StacText(
        // صدور سفته
        data: '{{appStrings.promissory.issuanceTitle}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 20),
      StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceAround,
        children: [
          StacText(
            // مبلغ قابل پرداخت
            data: '{{appStrings.promissory.payableAmount}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacText(
                data: '{{promissory.fees.total_formatted}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w900,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(width: 4),
              StacText(
                // ریال
                data: '{{appStrings.common.rial}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

StacWidget _buildFeesSection() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    child: StacColumn(
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacExpanded(
              child: StacText(
                // حق تمبر
                data: '{{appStrings.promissory.stampDuty}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data:
                  // ریال
                  '{{promissory.fees.stampFee_formatted}} {{appStrings.common.rial}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 16),
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacExpanded(
              child: StacText(
                // کارمزد صدور
                data: '{{appStrings.promissory.issuanceFee}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data:
                  // ریال
                  '{{promissory.fees.wage_formatted}} {{appStrings.common.rial}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildWalletPaymentOption() {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'selectedPaymentMethod', value: 'wallet'),
        StacCustomSetValueAction(key: 'paymentMethod', value: 'کیف پول'),
        StacCustomSetValueAction(key: 'isPayEnabled', value: true),
        StacCustomSetValueAction(key: 'isDepositSelected', value: false),
        StacCustomSetValueAction(key: 'isWalletSelected', value: true),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color:
              '{{isWalletSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(25),
            ),
            child: StacImage(
              src: 'assets/icons/ic_wallet.svg',
              imageType: StacImageType.asset,
              width: 32,
              height: 32,
            ),
          ),
          StacSizedBox(width: 6),
          StacText(
            // کیف پول
            data: '{{appStrings.promissory.walletPayment}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.start,
              children: [
                StacSizedBox(height: 4),
                // StacText(
                //   data:
                //       // ریال
                //       '{{wallet.balance_formatted}} {{appStrings.common.rial}}',
                //   textDirection: StacTextDirection.rtl,
                //   style: StacCustomTextStyle(
                //     fontSize: 12,
                //     color: '{{appColors.current.text.subtitle}}',
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildDepositPaymentOption() {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: 'selectedPaymentMethod',
          value: 'deposit',
        ),
        StacCustomSetValueAction(key: 'paymentMethod', value: 'حساب'),
        StacCustomSetValueAction(key: 'isPayEnabled', value: true),
        StacCustomSetValueAction(key: 'isWalletSelected', value: false),
        StacCustomSetValueAction(key: 'isDepositSelected', value: true),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color:
              '{{isDepositSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(25),
            ),
            child: StacImage(
              src: 'assets/icons/ic_gateway.svg',
              imageType: StacImageType.asset,
              width: 32,
              height: 32,
            ),
          ),
          StacSizedBox(width: 6),
          StacText(
            // سپرده
            data: '{{appStrings.promissory.depositPayment}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.start,
              children: [
                StacSizedBox(height: 4),
                StacText(
                  data: '',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 12,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildPaymentButtons() {
  return StacColumn(
    children: [
      // Pay Button (Wallet Action - Default)
      StacCustomContainer(
        height: '{{isDepositSelected ? 0 : 88}}',
        clipBehavior: 'hardEdge',
        decoration: StacBoxDecoration(color: 'transparent').toJson(),
        child: StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacCustomReactiveElevatedButton(
            enabledKey: 'isPayEnabled',
            enabled: false,
            onPressed: StacShowDialogAction(
              dialog: {
                'type': 'alertDialog',
                'title': {
                  'type': 'column',
                  'mainAxisAlignment': 'center',
                  'children': [
                    {
                      'type': 'container',
                      'width': 48,
                      'height': 48,
                      'child': {
                        'type': 'image',
                        'src': 'assets/icons/ic_info.svg',
                        'imageType': 'asset',
                        'width': 12,
                        'height': 12,
                        'color': '{{appColors.current.primary.color}}',
                      },
                    },
                    {'type': 'sizedBox', 'height': 12},
                    {
                      'type': 'text',
                      // آیا از پرداخت مبلغ مورد نظر اطمینان دارید؟
                      'data': '{{appStrings.promissory.payConfirmMessage}}',
                      'textDirection': 'rtl',
                      'textAlign': 'center',
                      'style': {
                        'type': 'custom',
                        'fontSize': 16,
                        'fontWeight': 'bold',
                        'color': '{{appColors.current.text.title}}',
                      },
                    },
                  ],
                },
                'content': {
                  'type': 'text',
                  // در صورت لغو سفته امضا نشده، مبلغ تمبر به حساب شما برنمی‌گردد
                  'data': '{{appStrings.promissory.signConfirmationMessage}}',
                  'textDirection': 'rtl',
                  'textAlign': 'center',
                  'style': {
                    'type': 'custom',
                    'fontSize': 14,
                    'color': '{{appColors.current.text.subtitle}}',
                  },
                },
                'actions': [
                  {
                    'type': 'row',
                    'textDirection': 'ltr',
                    'children': [
                      {
                        'type': 'expanded',
                        'child': {
                          'type': 'container',
                          'decoration': StacBoxDecoration(
                            borderRadius: StacBorderRadius.all(12),
                            border: StacBorder.all(
                              color: '#000000',
                              width: 0.8,
                            ),
                          ).toJson(),
                          'child': {
                            'type': 'elevatedButton',
                            'onPressed': const StacCloseDialogAction().toJson(),
                            'style': StacButtonStyle(
                              foregroundColor:
                                  '{{appColors.current.text.title}}',
                              fixedSize: StacSize(999999, 44),
                              shape: StacRoundedRectangleBorder(
                                borderRadius: StacBorderRadius.all(12),
                              ),
                              elevation: 0,
                            ).toJson(),
                            'child': {
                              'type': 'text',
                              // انصراف
                              'data': '{{appStrings.common.cancel}}',
                              'textDirection': 'rtl',
                              'style': {
                                'type': 'custom',
                                'fontSize': 16,
                                'fontWeight': 'bold',
                                'color': '{{appColors.current.text.title}}',
                              },
                            },
                          },
                        },
                      },
                      {'type': 'sizedBox', 'width': 10},
                      {
                        'type': 'expanded',
                        'child': {
                          'type': 'elevatedButton',
                          'onPressed': StacSequenceAction(
                            actions: [
                              const StacCloseDialogAction(),
                              StacNetworkRequestAction(
                                url:
                                    'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/draft',
                                method: 'post',
                                headers: {
                                  'accept': 'application/json',
                                  'authorization': '{{auth.accessToken}}',
                                  'content-type': 'application/json',
                                },
                                data: {
                                  'issuerType': 'I',
                                  'sourceAccount': null,
                                  'issuerBirthDate':
                                      "{{replace(userData.birthDate, '/', '')}}",
                                  'issuerNN': '{{userData.nationalCode}}',
                                  'issuerSanaCheck': true,
                                  'issuerCellphone':
                                      '{{removeLeadingZero(userData.mobile)}}',
                                  'issuerFullName': '{{userData.fullName}}',
                                  'issuerAccountNumber': null,
                                  'issuerAddress': '{{userData.address}}',
                                  'issuerPostalCode': '{{userData.postalCode}}',
                                  'recipientType': '{{payload.recipientType}}',
                                  'recipientBirthDate':
                                      '{{payload.recipientBirthDate}}',
                                  'recipientNationalId':
                                      '{{payload.recipientNationalId}}',
                                  'recipientCellphone':
                                      '{{payload.recipientCellphone}}',
                                  'recipientFullName':
                                      '{{receiverIdentity.fullName}}',
                                  'paymentPlace': '{{form.paymentPlace}}',
                                  'amount': '{{toInt(form.promissory_amount)}}',
                                  'dueDate':
                                      "{{replace(form.promissory_due_date, '/', '')}}",
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
                                            {
                                              'key': 'form.unsigned_pdf_id',
                                              'value':
                                                  '{{data_payload.unSignedPdfId}}',
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
                                          routeName: 'promissory_sign',
                                          navigationStyle:
                                              NavigationStyle.pushReplacement,
                                        ).toJson(),
                                      ],
                                    ).toJson(),
                                  },
                                ],
                              ),
                            ],
                          ).toJson(),
                          'style': StacButtonStyle(
                            backgroundColor:
                                '{{appColors.current.primary.color}}',
                            foregroundColor:
                                '{{appColors.current.primary.onPrimary}}',
                            fixedSize: StacSize(999999, 44),
                            shape: StacRoundedRectangleBorder(
                              borderRadius: StacBorderRadius.all(12),
                            ),
                            elevation: 0,
                          ).toJson(),
                          'child': {
                            'type': 'text',
                            // تایید
                            'data': '{{appStrings.common.confirm}}',
                            'textDirection': 'rtl',
                            'style': {
                              'type': 'custom',
                              'fontSize': 16,
                              'fontWeight': 'bold',
                              'color':
                                  '{{appColors.current.primary.onPrimary}}',
                            },
                          },
                        },
                      },
                    ],
                  },
                ],
              },
            ),
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              elevation: 0,
              fixedSize: StacSize(999999, 56),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ).toJson(),
            child: StacText(
              // پرداخت و امضای سفته
              data: '{{appStrings.promissory.payAndSign}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.bold,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ).toJson(),
          ),
        ).toJson(),
      ),
      // Pay Button (Deposit Action)
      StacCustomContainer(
        height: '{{isDepositSelected ? 88 : 0}}',
        clipBehavior: 'hardEdge',
        decoration: StacBoxDecoration(color: 'transparent').toJson(),
        child: StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacCustomReactiveElevatedButton(
            enabledKey: 'isPayEnabled',
            enabled: false,
            onPressed: const StacNavigateAction(
              routeName: 'promissory_payment_deposits',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              elevation: 0,
              fixedSize: StacSize(999999, 56),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ).toJson(),
            child: StacText(
              // پرداخت و امضای سفته
              data: '{{appStrings.promissory.payAndSign}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.bold,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ).toJson(),
          ),
        ).toJson(),
      ),
    ],
  );
}

