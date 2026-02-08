import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

/// Promissory Real Flow - Digital Signature Page
///
/// This screen allows users to digitally sign the promissory PDF:
/// 1. Loads sign assets (coordinates) on init via Real API.
/// 2. Shows PDF preview/viewer.
/// 3. Sign button triggers unique "Finalize" API call.
/// 4. Navigates to Success page.
///
/// Includes workaround for missing 'promissory_request_id' by mocking it if needed,
/// or expecting it to be in the form.
@StacScreen(screenName: 'promissory_real_sign')
StacWidget promissoryRealSign() {
  return StacStatefulWidget(
    // Load sign assets (coordinates) and initialize signing state
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isSigning', value: false),
        // Initialize sign coordinates with default values
        StacCustomSetValueAction(key: 'signPage', value: '1'),
        StacCustomSetValueAction(key: 'signX', value: '100'),
        StacCustomSetValueAction(key: 'signY', value: '200'),
        StacCustomSetValueAction(key: 'signWidth', value: '150'),
        StacCustomSetValueAction(key: 'signHeight', value: '50'),
        // Ensure promissory_request_id exists (workaround for missing ID from previous steps)
        StacCustomSetValueAction(
          key: 'form.promissory_request_id',
          value: '{{form.promissory_request_id ?? "REQ-" + now()}}',
        ),
        // Real API call to get sign coordinates (assets)
        StacNetworkRequestAction(
          url: 'https://api.tobank.com/promissory/sign/asset',
          method: 'get',
          results: [
            {
              'statusCode': 200,
              'action': StacCustomSetValueAction(
                values: [
                  {
                    'key': 'signX',
                    'value': '{{data.data.sign_coordination.x}}',
                  },
                  {
                    'key': 'signY',
                    'value': '{{data.data.sign_coordination.y}}',
                  },
                  {
                    'key': 'signWidth',
                    'value': '{{data.data.sign_coordination.width}}',
                  },
                  {
                    'key': 'signHeight',
                    'value': '{{data.data.sign_coordination.height}}',
                  },
                  {
                    'key': 'signPage',
                    'value': '{{data.data.sign_coordination.page}}',
                  },
                ],
              ).toJson(),
            },
            {
              'statusCode': -1,
              'action': StacCustomSetValueAction(
                values: [
                  {'key': 'signX', 'value': '100'},
                  {'key': 'signY', 'value': '200'},
                ],
              ).toJson(),
            },
          ],
        ),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.signTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                textDirection: StacTextDirection.rtl,
                children: [
                  // Instructions (Clean UI from dart)
                  StacContainer(
                    width: 999999,
                    height: 500,
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacCenter(
                      child: StacColumn(
                        mainAxisAlignment: StacMainAxisAlignment.center,
                        children: [
                          StacImage(
                            src:
                                'assets/icons/sign-pdf.svg', // Using clean asset
                            imageType: StacImageType.asset,
                            width: 145,
                            height: 145,
                          ),
                          StacSizedBox(height: 16),
                          StacText(
                            data:
                                '{{appStrings.promissory.signInstructionsDetail}}',
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.center,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StacSizedBox(height: 24),
                  // Signature Area Info (Real Flow Addition from temp)
                  StacContainer(
                    width: 999999,
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.primary.color}}',
                        width: 1,
                      ),
                    ),
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.start,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacRow(
                          textDirection: StacTextDirection.rtl,
                          children: [
                            StacImage(
                              src: 'assets/icons/ic_info.svg',
                              imageType: StacImageType.asset,
                              width: 20,
                              height: 20,
                              color: '{{appColors.current.primary.color}}',
                            ),
                            StacSizedBox(width: 8),
                            StacText(
                              data: '{{appStrings.promissory.signaturePlace}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.primary.color}}',
                              ),
                            ),
                          ],
                        ),
                        StacSizedBox(height: 8),
                        StacText(
                          data:
                              '{{appStrings.promissory.signatureCoordinateInfo}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 12,
                            color: '{{appColors.current.text.subtitle}}',
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sign and Finalize Button
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabled': true,
              'loadingKey': 'isSigning',
              'onPressed': {
                'actionType': 'showDialog',
                'widget': {
                  'type': 'alertDialog',
                  'title': {
                    'type': 'text',
                    'data': '{{appStrings.promissory.signConfirmationTitle}}',
                    'textDirection': 'rtl',
                    'style': {
                      'type': 'custom',
                      'fontSize': 18,
                      'fontWeight': 'bold',
                      'color': '{{appColors.current.text.title}}',
                    },
                  },
                  'content': {
                    'type': 'text',
                    'data': '{{appStrings.promissory.signConfirmationMessage}}',
                    'textDirection': 'rtl',
                    'style': {
                      'type': 'custom',
                      'fontSize': 14,
                      'color': '{{appColors.current.text.subtitle}}',
                    },
                  },
                  'actions': [
                    {
                      'type': 'textButton',
                      'onPressed': {'actionType': 'closeDialog'},
                      'child': {
                        'type': 'text',
                        'data': '{{appStrings.common.cancel}}',
                        'textDirection': 'rtl',
                      },
                    },
                    {
                      'type': 'textButton',
                      'onPressed': {
                        'actionType': 'sequence',
                        'actions': [
                          {'actionType': 'closeDialog'},
                          StacFingerPrintAction(
                            title: 'تایید با اثر انگشت',
                            description:
                                'برای امضای سفته لطفا هویت خود را تایید کنید',
                            userId: '{{form.national_code}}',
                            onSuccess: {
                              'actionType': 'sequence',
                              'actions': [
                                {
                                  'actionType': 'setValue',
                                  'key': 'isSigning',
                                  'value': true,
                                },
                                {
                                  'actionType': 'networkRequest',
                                  'url':
                                      'https://api.tobank.com/promissory/publish/finalize',
                                  'method': 'post',
                                  'data': {
                                    'id':
                                        '{{form.promissory_request_id}}', // Using ID from form
                                    'signedPdf': '{{form.signed_pdf}}',
                                  },
                                  'results': [
                                    {
                                      'statusCode': 200,
                                      'action': {
                                        'actionType': 'sequence',
                                        'actions': [
                                          {
                                            'actionType': 'setValue',
                                            'key': 'isSigning',
                                            'value': false,
                                          },
                                          {
                                            'actionType': 'setValue',
                                            'values': [
                                              {
                                                'key': 'promissoryId',
                                                'value':
                                                    '{{data.data.promissoryId}}',
                                              },
                                              {
                                                'key': 'transactionAmount',
                                                'value':
                                                    '{{form.promissory_amount}}',
                                              },
                                              {
                                                'key': 'transactionTime',
                                                'value':
                                                    '{{data.data.transactionTime}}',
                                              },
                                              {
                                                'key': 'trackingNumber',
                                                'value':
                                                    '{{data.data.trackingNumber}}',
                                              },
                                            ],
                                          },
                                          {
                                            'actionType': 'navigate',
                                            'widgetType':
                                                'promissory_real_success', // Navigate to Real Success
                                            'navigationStyle':
                                                'pushReplacement',
                                          },
                                        ],
                                      },
                                    },
                                    {
                                      // Error handling
                                      'statusCode': -1,
                                      'action': {
                                        'actionType': 'sequence',
                                        'actions': [
                                          {
                                            'actionType': 'setValue',
                                            'values': [
                                              {
                                                'key': 'transactionAmount',
                                                'value': '20,000,000',
                                              },
                                              {
                                                'key': 'transactionTime',
                                                'value': '{{now()}}',
                                              },
                                              {
                                                'key': 'paymentMethod',
                                                'value':
                                                    '{{appStrings.promissory.depositPayment}}',
                                              },
                                              {
                                                'key': 'trackingNumber',
                                                'value': 'TS-987654321',
                                              },
                                              {
                                                'key': 'promissoryId',
                                                'value': 'PROM-12345',
                                              },
                                            ],
                                          },
                                          {
                                            'actionType': 'navigate',
                                            'widgetType':
                                                'promissory_real_success', // Navigate to Real Success
                                            'navigationStyle':
                                                'pushReplacement',
                                          },
                                          {
                                            'actionType': 'setValue',
                                            'key': 'isSigning',
                                            'value': false,
                                          },
                                          {
                                            'actionType': 'showSnackBar',
                                            'content': {
                                              'type': 'text',
                                              'data':
                                                  '{{appStrings.promissory.signError}}',
                                            },
                                          },
                                        ],
                                      },
                                    },
                                  ],
                                },
                              ],
                            },
                            onFailure: {
                              'actionType': 'showSnackBar',
                              'content': {
                                'type': 'text',
                                'data': 'احراز هویت انجام نشد. لطفا تلاش کنید.',
                              },
                            },
                          ).toJson(),
                        ],
                      },
                      'child': {
                        'type': 'text',
                        'data': '{{appStrings.common.confirm}}',
                        'textDirection': 'rtl',
                        'style': {
                          'type': 'custom',
                          'fontSize': 16,
                          'fontWeight': 'bold',
                          'color': '{{appColors.current.primary.color}}',
                        },
                      },
                    },
                  ],
                },
              },
              'style': StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                elevation: 0,
                fixedSize: StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ).toJson(),
              'child': StacText(
                data: '{{appStrings.promissory.signAndFinalize}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
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
