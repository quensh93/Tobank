import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';
import '../../../../../core/stac/builders/stac_promissory_sign_action.dart';

/// Promissory Real Flow - Digital Signature Page
///
/// This screen allows users to digitally sign the promissory PDF:
/// 1. Loads sign assets (coordinates) on init via Real API (background).
/// 2. Shows PDF instructions immediately (no loading state).
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
        // Initialize loading state flags
        StacCustomSetValueAction(
          values: [
            {'key': 'signScreenLoading', 'value': true},
            {'key': 'signScreenError', 'value': false},
            {'key': 'signScreenLoaded', 'value': false},
          ],
        ),
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
        // Real API call to get PDF base64
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
              'action': {
                'actionType': 'setValue',
                'values': [
                  {'key': 'form.unsigned_pdf', 'value': '{{data.data.base64}}'},
                  {'key': 'signScreenLoading', 'value': false},
                  {'key': 'signScreenError', 'value': false},
                  {'key': 'signScreenLoaded', 'value': true},
                ],
              },
            },
            {
              'statusCode': -1,
              'action': {
                'actionType': 'setValue',
                'values': [
                  {'key': 'signScreenLoading', 'value': false},
                  {'key': 'signScreenError', 'value': true},
                  {'key': 'signScreenLoaded', 'value': false},
                ],
              },
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
            child: StacRawJsonWidget({
              'type': 'stack',
              'children': [
                // ── Loading State ──
                {
                  'type': 'registryReactive',
                  'registryKey': 'signScreenLoading',
                  'child': {
                    'type': 'visibility',
                    'visible': '{{signScreenLoading}}',
                    'child': {
                      'type': 'center',
                      'child': {
                        'type': 'column',
                        'mainAxisAlignment': 'center',
                        'children': [
                          {
                            'type': 'circularProgressIndicator',
                            'color': '{{appColors.current.primary.color}}',
                          },
                          {'type': 'sizedBox', 'height': 16},
                          {
                            'type': 'text',
                            'data': '{{appStrings.promissory.loadingText}}',
                            'textDirection': 'rtl',
                            'style': {
                              'type': 'custom',
                              'fontSize': 14,
                              'color': '{{appColors.current.text.subtitle}}',
                            },
                          },
                        ],
                      },
                    },
                  },
                },
                // ── Error State ──
                {
                  'type': 'registryReactive',
                  'registryKey': 'signScreenError',
                  'child': {
                    'type': 'visibility',
                    'visible': '{{signScreenError}}',
                    'child': {
                      'type': 'center',
                      'child': {
                        'type': 'column',
                        'mainAxisAlignment': 'center',
                        'children': [
                          {
                            'type': 'image',
                            'src': 'assets/icons/ic_info.svg',
                            'imageType': 'asset',
                            'width': 48,
                            'height': 48,
                            'color': '#D32F2F',
                          },
                          {'type': 'sizedBox', 'height': 16},
                          {
                            'type': 'text',
                            'data':
                                '{{appStrings.promissory.serverConnectionError}}',
                            'textDirection': 'rtl',
                            'textAlign': 'center',
                            'style': {
                              'type': 'custom',
                              'fontSize': 16,
                              'fontWeight': 'bold',
                              'color': '#D32F2F',
                            },
                          },
                          {'type': 'sizedBox', 'height': 8},
                          {
                            'type': 'text',
                            'data':
                                '{{appStrings.promissory.serverConnectionErrorDetail}}',
                            'textDirection': 'rtl',
                            'textAlign': 'center',
                            'style': {
                              'type': 'custom',
                              'fontSize': 14,
                              'color': '{{appColors.current.text.subtitle}}',
                            },
                          },
                          {'type': 'sizedBox', 'height': 24},
                          {
                            'type': 'filledButton',
                            'onPressed': StacRawJsonAction({
                              'actionType': 'navigate',
                              'widgetType': 'promissory_real_sign',
                              'navigationStyle': 'pushReplacement',
                            }).toJson(),
                            'style': StacButtonStyle(
                              backgroundColor: '#D32F2F',
                              elevation: 0,
                              fixedSize: StacSize(160, 48),
                              shape: StacRoundedRectangleBorder(
                                borderRadius: StacBorderRadius.all(12),
                              ),
                            ).toJson(),
                            'child': StacText(
                              data: 'تلاش مجدد',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                fontWeight: StacFontWeight.bold,
                                color: '#FFFFFF',
                              ),
                            ).toJson(),
                          },
                        ],
                      },
                    },
                  },
                },
                // ── Success State (Sign Content) ──
                {
                  'type': 'registryReactive',
                  'registryKey': 'signScreenLoaded',
                  'child': {
                    'type': 'visibility',
                    'visible': '{{signScreenLoaded}}',
                    'child': StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacExpanded(
                          child: StacSingleChildScrollView(
                            padding: StacEdgeInsets.all(16),
                            child: StacCenter(
                              child: StacColumn(
                                crossAxisAlignment:
                                    StacCrossAxisAlignment.stretch,
                                textDirection: StacTextDirection.rtl,
                                children: [
                                  StacContainer(
                                    width: 999999,
                                    height: 500,
                                    child: StacCenter(
                                      child: StacColumn(
                                        mainAxisAlignment:
                                            StacMainAxisAlignment.center,
                                        children: [
                                          StacImage(
                                            src: 'assets/icons/sign-pdf.svg',
                                            imageType: StacImageType.asset,
                                            width: 145,
                                            height: 145,
                                          ),
                                          StacSizedBox(height: 16),
                                          StacText(
                                            data:
                                                '{{appStrings.promissory.signInstructionsDetail}}',
                                            textDirection:
                                                StacTextDirection.rtl,
                                            textAlign: StacTextAlign.center,
                                            style: StacCustomTextStyle(
                                              fontSize: 14,
                                              color:
                                                  '{{appColors.current.text.subtitle}}',
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
                        ),
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
                                  'type': 'column',
                                  'mainAxisAlignment': 'center',
                                  'children': [
                                    {
                                      'type': 'container',
                                      'width': 48,
                                      'height': 48,
                                      'decoration': {},
                                      'child': {
                                        'type': 'image',
                                        'src': 'assets/icons/ic_info.svg',
                                        'imageType': 'asset',
                                        'width': 12,
                                        'height': 12,
                                        'color':
                                            '{{appColors.current.primary.color}}',
                                      },
                                    },
                                    {'type': 'sizedBox', 'height': 12},
                                    {
                                      'type': 'text',
                                      'data':
                                          '{{appStrings.promissory.signTitledialog}}',
                                      'textDirection': 'rtl',
                                      'textAlign': 'center',
                                      'style': {
                                        'type': 'custom',
                                        'fontSize': 16,
                                        'fontWeight': 'bold',
                                        'color':
                                            '{{appColors.current.text.title}}',
                                      },
                                    },
                                  ],
                                },
                                'actions': [
                                  {
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
                                      'onPressed': {
                                        'actionType': 'closeDialog',
                                      },
                                      'style': StacButtonStyle(
                                        foregroundColor:
                                            '{{appColors.current.text.title}}',
                                        fixedSize: StacSize(120, 44),
                                        shape: StacRoundedRectangleBorder(
                                          borderRadius: StacBorderRadius.all(
                                            12,
                                          ),
                                        ),
                                        elevation: 0,
                                      ).toJson(),
                                      'child': {
                                        'type': 'text',
                                        'data': '{{appStrings.common.cancel}}',
                                        'textDirection': 'rtl',
                                        'style': {
                                          'type': 'custom',
                                          'fontSize': 16,
                                          'fontWeight': 'bold',
                                          'color':
                                              '{{appColors.current.text.title}}',
                                        },
                                      },
                                    },
                                  },
                                  {
                                    'type': 'elevatedButton',
                                    'onPressed': {
                                      'actionType': 'sequence',
                                      'actions': [
                                        {'actionType': 'closeDialog'},
                                        StacPromissorySignAction(
                                          unsignedContract:
                                              '{{form.unsigned_pdf}}',
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
                                              {
                                                'actionType': 'setValue',
                                                'key': 'isSigning',
                                                'value': true,
                                              },
                                              {
                                                'actionType': 'networkRequest',
                                                'url':
                                                    'http://192.168.107.22:8280/api/digitalbanking/files/v1.0/promissory/upload/base64',
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
                                                  "fileName": "promisorry.pdf",
                                                  "contentType":
                                                      "application/pdf",
                                                  "base64":
                                                      "{{form.signed_pdf}}",
                                                },
                                                'results': [
                                                  {
                                                    'statusCode': 200,
                                                    'action': {
                                                      'actionType': 'sequence',
                                                      'actions': [
                                                        {
                                                          'actionType':
                                                              'networkRequest',
                                                          'url':
                                                              'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/finalize/{{form.promissory_id}}',
                                                          'method': 'post',
                                                          'headers': {
                                                            'accept': '*/*',
                                                            'app-platform':
                                                                'android',
                                                            'app-store':
                                                                'application/json',
                                                            'app-version':
                                                                '456',
                                                            'device-uuid':
                                                                '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                                                            'serviceauthorization':
                                                                'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                                                            'authorization':
                                                                '{{auth.accessToken}}',
                                                          },
                                                          'data': {
                                                            'signedPdfId':
                                                                '{{data_payload.id}}',
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
                                                                    'key':
                                                                        'isSigning',
                                                                    'value':
                                                                        false,
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
                                                                            '{{form.promissory_due_date}}',
                                                                      },
                                                                      {
                                                                        'key':
                                                                            'serverSignedPdfId',
                                                                        'value':
                                                                            '{{data.data.serverSignedPdfId}}',
                                                                      },
                                                                      {
                                                                        'key':
                                                                            'requestId',
                                                                        'value':
                                                                            '{{data.data.requestId}}',
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
                                                              'statusCode': -1,
                                                              'action': {
                                                                'actionType':
                                                                    'sequence',
                                                                'actions': [
                                                                  {
                                                                    'actionType':
                                                                        'setValue',
                                                                    'key':
                                                                        'isSigning',
                                                                    'value':
                                                                        false,
                                                                  },
                                                                  {
                                                                    'actionType':
                                                                        'showSnackBar',
                                                                    'content': {
                                                                      'type':
                                                                          'text',
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
                                                    'statusCode': -1,
                                                    'action': {
                                                      'actionType': 'sequence',
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
                                                                'upload failed',
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
                                    'style': StacButtonStyle(
                                      backgroundColor:
                                          '{{appColors.current.primary.color}}',
                                      foregroundColor:
                                          '{{appColors.current.primary.onPrimary}}',
                                      fixedSize: StacSize(120, 44),
                                      shape: StacRoundedRectangleBorder(
                                        borderRadius: StacBorderRadius.all(12),
                                      ),
                                      elevation: 0,
                                    ).toJson(),
                                    'child': {
                                      'type': 'text',
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
                                ],
                              },
                            },
                            'style': StacButtonStyle(
                              backgroundColor:
                                  '{{appColors.current.primary.color}}',
                              elevation: 0,
                              fixedSize: StacSize(999999, 56),
                              shape: StacRoundedRectangleBorder(
                                borderRadius: StacBorderRadius.all(12),
                              ),
                            ).toJson(),
                            'child': StacText(
                              data: 'امضا سفته',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 18,
                                fontWeight: StacFontWeight.bold,
                                color:
                                    '{{appColors.current.primary.onPrimary}}',
                              ),
                            ).toJson(),
                          }),
                        ),
                      ],
                    ).toJson(),
                  },
                },
              ],
            }),
          ),
        ],
      ),
    ),
  );
}
