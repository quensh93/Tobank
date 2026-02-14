import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';
import '../../../../../core/stac/builders/stac_promissory_sign_action.dart';

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
  final fetchSignAssetsAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(key: 'signViewState', value: 0), // 0: Loading
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
        url:
            'http://192.168.107.22:8280/api/digitalbanking/files/v1.0/{{form.unsigned_pdf_id}}/download/base64',
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
              values: [
                {
                  'key': 'form.unsigned_pdf',
                  'value': '{{data_payload.base64}}',
                },
                {'key': 'signViewState', 'value': 1}, // 1: Content
              ],
            ).toJson(),
          },
          {
            'statusCode': -1,
            'action': StacCustomSetValueAction(
              values: [
                {'key': 'signViewState', 'value': 2}, // 2: Error
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  return StacStatefulWidget(
    // Load sign assets (coordinates) and initialize signing state
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isSigning', value: false),
        StacCustomSetValueAction(key: 'signViewState', value: 0), // 0: Loading
        fetchSignAssetsAction,
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
      body: StacStack(
        children: [
          // Content State (1)
          StacRawJsonWidget({
            'type': 'visibility',
            'visible': '{{signViewState == 1}}',
            'child': {
              'type': 'column',
              'crossAxisAlignment': 'stretch',
              'textDirection': 'rtl',
              'children': [
                {
                  'type': 'expanded',
                  'child': {
                    'type': 'singleChildScrollView',
                    'padding': 16,
                    'child': {
                      'type': 'column',
                      'crossAxisAlignment': 'stretch',
                      'textDirection': 'rtl',
                      'children': [
                        // Instructions (Clean UI from dart)
                        {
                          'type': 'container',
                          'width': 999999,
                          'height': 500,
                          'decoration': {
                            'color':
                                '{{appColors.current.background.surfaceContainer}}',
                            'borderRadius': 8,
                            'border': {
                              'color':
                                  '{{appColors.current.input.borderEnabled}}',
                              'width': 1,
                            },
                          },
                          'child': {
                            'type': 'center',
                            'child': {
                              'type': 'column',
                              'mainAxisAlignment': 'center',
                              'children': [
                                {
                                  'type': 'image',
                                  'src':
                                      'assets/icons/sign-pdf.svg', // Using clean asset
                                  'imageType': 'asset',
                                  'width': 145,
                                  'height': 145,
                                },
                                {'type': 'sizedBox', 'height': 16},
                                {
                                  'type': 'text',
                                  'data':
                                      '{{appStrings.promissory.signInstructionsDetail}}',
                                  'textDirection': 'rtl',
                                  'textAlign': 'center',
                                  'style': {
                                    'type': 'custom',
                                    'fontSize': 14,
                                    'color':
                                        '{{appColors.current.text.subtitle}}',
                                  },
                                },
                              ],
                            },
                          },
                        },
                        {'type': 'sizedBox', 'height': 24},
                        // Signature Area Info (Real Flow Addition from temp)
                        {
                          'type': 'container',
                          'width': 999999,
                          'padding': 16,
                          'decoration': {
                            'color':
                                '{{appColors.current.background.surfaceContainer}}',
                            'borderRadius': 8,
                            'border': {
                              'color': '{{appColors.current.primary.color}}',
                              'width': 1,
                            },
                          },
                          'child': {
                            'type': 'column',
                            'crossAxisAlignment': 'start',
                            'textDirection': 'rtl',
                            'children': [
                              {
                                'type': 'row',
                                'textDirection': 'rtl',
                                'children': [
                                  {
                                    'type': 'image',
                                    'src': 'assets/icons/ic_info.svg',
                                    'imageType': 'asset',
                                    'width': 20,
                                    'height': 20,
                                    'color':
                                        '{{appColors.current.primary.color}}',
                                  },
                                  {'type': 'sizedBox', 'width': 8},
                                  {
                                    'type': 'text',
                                    'data':
                                        '{{appStrings.promissory.signaturePlace}}',
                                    'textDirection': 'rtl',
                                    'style': {
                                      'type': 'custom',
                                      'fontSize': 14,
                                      'fontWeight': 'w600',
                                      'color':
                                          '{{appColors.current.primary.color}}',
                                    },
                                  },
                                ],
                              },
                              {'type': 'sizedBox', 'height': 8},
                              {
                                'type': 'text',
                                'data':
                                    '{{appStrings.promissory.signatureCoordinateInfo}}',
                                'textDirection': 'rtl',
                                'style': {
                                  'type': 'custom',
                                  'fontSize': 12,
                                  'color':
                                      '{{appColors.current.text.subtitle}}',
                                  'height': 1.5,
                                },
                              },
                            ],
                          },
                        },
                      ],
                    },
                  },
                },

                // Sign and Finalize Button
                {
                  'type': 'padding',
                  'padding': 16,
                  'child': {
                    'type': 'reactiveElevatedButton',
                    'enabled': true,
                    'loadingKey': 'isSigning',
                    'onPressed': {
                      'actionType': 'showDialog',
                      'widget': {
                        'type': 'alertDialog',
                        'title': {
                          'type': 'text',
                          'data':
                              '{{appStrings.promissory.signConfirmationTitle}}',
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
                          'data':
                              '{{appStrings.promissory.signConfirmationMessage}}',
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
                                StacPromissorySignAction(
                                  unsignedContract:
                                      '{{form.unsigned_pdf}}', // MOCK PDF (To be replaced)
                                  signLocation: {
                                    "x": 450,
                                    "y": 450,
                                    "width": 150,
                                    "height": 50,
                                    "x_ios": 450,
                                    "y_ios": 450,
                                    "width_ios": 150,
                                    "height_ios": 50,
                                    "page": 0,
                                  },
                                  promissoryTitle: 'سفته',
                                  onSuccess: {
                                    'actionType': 'sequence',
                                    'actions': [
                                      // Success flow checks result then navigates. The parser handles signing result.
                                      // If signing was successful, we proceed.
                                      // But wait, the parser *only* triggers onSuccess if local signing was good.
                                      // The network request logic is inside onSuccess here.
                                      {
                                        'actionType': 'setValue',
                                        'key': 'isSigning',
                                        'value': true,
                                      },
                                      {
                                        'actionType': 'log',
                                        'message':
                                            'Signed PDF: {{form.signed_pdf}}',
                                      },
                                      {
                                        'actionType': 'networkRequest',
                                        'url':
                                            'http://192.168.107.22:8280/api/digitalbanking/files/v1.0/promissory/upload/base64',
                                        'method': 'post',
                                        'headers': {
                                          'accept': '*/*',
                                          'app-platform': 'android',
                                          'app-store': 'application/json',
                                          'app-version': '456',
                                          'device-uuid':
                                              '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                                          'serviceauthorization':
                                              'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                                          'authorization':
                                              '{{auth.accessToken}}',
                                        },
                                        'data': {
                                          "fileName": "promisorry.pdf",
                                          "contentType": "application/pdf",
                                          "base64": "{{form.signed_pdf}}",
                                        },
                                        'results': [
                                          {
                                            'statusCode': 200,
                                            'action': {
                                              'actionType': 'sequence',
                                              'actions': [
                                                {
                                                  'actionType': 'setValue',
                                                  'key': 'form.signed_pdf_id',
                                                  'value':
                                                      '{{data_payload.id}}',
                                                },
                                                {
                                                  'actionType':
                                                      'networkRequest',
                                                  'url':
                                                      'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/finalize/{{form.promissory_id}}',
                                                  'method': 'post',
                                                  'headers': {
                                                    'accept': '*/*',
                                                    'app-platform': 'android',
                                                    'app-store':
                                                        'application/json',
                                                    'app-version': '456',
                                                    'device-uuid':
                                                        '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                                                    'serviceauthorization':
                                                        'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                                                    'authorization':
                                                        '{{auth.accessToken}}',
                                                  },
                                                  'data': {
                                                    'signedPdfId':
                                                        '{{form.signed_pdf_id}}',
                                                  },
                                                  'results': [
                                                    {
                                                      'statusCode': 200,
                                                      'action': {
                                                        'actionType':
                                                            'sequence',
                                                        'actions': [
                                                          {
                                                            'actionType':
                                                                'setValue',
                                                            'key': 'isSigning',
                                                            'value': false,
                                                          },
                                                          {
                                                            'actionType':
                                                                'setValue',
                                                            'values': [
                                                              {
                                                                'key':
                                                                    'promissoryId',
                                                                'value':
                                                                    '{{data.data.promissoryId}}',
                                                              },
                                                              {
                                                                'key':
                                                                    'transactionAmount',
                                                                'value':
                                                                    '{{form.promissory_amount}}',
                                                              },
                                                              {
                                                                'key':
                                                                    'transactionTime',
                                                                'value':
                                                                    '{{data.data.transactionTime}}',
                                                              },
                                                              {
                                                                'key':
                                                                    'trackingNumber',
                                                                'value':
                                                                    '{{data.data.trackingNumber}}',
                                                              },
                                                            ],
                                                          },
                                                          {
                                                            'actionType':
                                                                'navigate',
                                                            'widgetType':
                                                                'promissory_real_success',
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
                                                        'actionType':
                                                            'sequence',
                                                        'actions': [
                                                          {
                                                            'actionType':
                                                                'setValue',
                                                            'key': 'isSigning',
                                                            'value': false,
                                                          },
                                                          {
                                                            'actionType':
                                                                'showSnackBar',
                                                            'content': {
                                                              'type': 'text',
                                                              'data':
                                                                  'finalize failed',
                                                            },
                                                          },
                                                        ],
                                                      },
                                                    },
                                                  ],
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
                                                  'key': 'isSigning',
                                                  'value': false,
                                                },
                                                {
                                                  'actionType': 'showSnackBar',
                                                  'content': {
                                                    'type': 'text',
                                                    'data': 'upload failed',
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
                                      'data':
                                          '{{appStrings.promissory.signError}}',
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
                    'style': {
                      'backgroundColor': '{{appColors.current.primary.color}}',
                      'elevation': 0,
                      'fixedSize': {'width': 999999, 'height': 56},
                      'shape': {
                        'type': 'roundedRectangleBorder',
                        'borderRadius': 12,
                      },
                    },
                    'child': {
                      'type': 'text',
                      'data': '{{appStrings.promissory.signAndFinalize}}',
                      'textDirection': 'rtl',
                      'style': {
                        'type': 'custom',
                        'fontSize': 18,
                        'fontWeight': 'bold',
                        'color': '{{appColors.current.primary.onPrimary}}',
                      },
                    },
                  },
                },
              ],
            },
          }),
          // Loading State (0)
          StacRawJsonWidget({
            'type': 'container',
            'visible': '{{signViewState == 0 || signViewState == null}}',
            'alignment': 'center',
            'child': {'type': 'circularProgressIndicator'},
          }),
          // Error State (2)
          StacRawJsonWidget({
            'type': 'container',
            'visible': '{{signViewState == 2}}',
            'alignment': 'center',
            'child': {
              'type': 'column',
              'mainAxisAlignment': 'center',
              'children': [
                {
                  'type': 'image',
                  'src': 'assets/icons/ic_warning.svg',
                  'imageType': 'asset',
                  'width': 64,
                  'height': 64,
                  'color': '{{appColors.current.text.error}}',
                },
                {'type': 'sizedBox', 'height': 16},
                {
                  'type': 'text',
                  'data': '{{appStrings.common.error}}',
                  'textDirection': 'rtl',
                  'style': {
                    'type': 'custom',
                    'fontSize': 16,
                    'color': '{{appColors.current.text.title}}',
                  },
                },
                {'type': 'sizedBox', 'height': 24},
                {
                  'type': 'elevatedButton',
                  'onPressed': fetchSignAssetsAction.toJson(),
                  'style': {
                    'backgroundColor': '{{appColors.current.primary.color}}',
                    'fixedSize': {'width': 120, 'height': 48},
                  },
                  'child': {
                    'type': 'text',
                    'data': '{{appStrings.common.retry}}',
                    'style': {
                      'type': 'custom',
                      'color': '{{appColors.current.primary.onPrimary}}',
                    },
                  },
                },
              ],
            },
          }),
        ],
      ),
    ),
  );
}
