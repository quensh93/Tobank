import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

/// Promissory Real Flow - Preview Page
///
/// This screen displays a preview of the promissory note:
/// 1. Shows loading spinner while fetching PDF base64.
/// 2. Shows error state if fetch fails.
/// 3. On success, renders the PDF as an image preview + Save/Share buttons.
@StacScreen(screenName: 'promissory_real_preview')
StacWidget promissoryRealPreview() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        // Initialize state flags
        StacCustomSetValueAction(
          values: [
            {'key': 'previewLoading', 'value': true},
            {'key': 'previewError', 'value': false},
            {'key': 'previewLoaded', 'value': false},
          ],
        ),
        // Fetch PDF base64 from the endpoint
        StacNetworkRequestAction(
          url:
              'http://192.168.107.22:8280/api/digitalbanking/files/v1.0/{{serverSignedPdfId}}/download/base64',
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
                  {
                    'key': 'serverSignedPdf',
                    'value': '{{data_payload.base64}}',
                  },
                  {'key': 'previewLoading', 'value': false},
                  {'key': 'previewError', 'value': false},
                  {'key': 'previewLoaded', 'value': true},
                ],
              },
            },
            {
              'statusCode': -1,
              'action': {
                'actionType': 'setValue',
                'values': [
                  {'key': 'previewLoading', 'value': false},
                  {'key': 'previewError', 'value': true},
                  {'key': 'previewLoaded', 'value': false},
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
          data: 'نمایش سفته',
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
                  'registryKey': 'previewLoading',
                  'child': {
                    'type': 'visibility',
                    'visible': '{{previewLoading}}',
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
                  'registryKey': 'previewError',
                  'child': {
                    'type': 'visibility',
                    'visible': '{{previewError}}',
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
                              'widgetType': 'promissory_real_preview',
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
                // ── Success State (PDF Preview) ──
                {
                  'type': 'registryReactive',
                  'registryKey': 'previewLoaded',
                  'child': {
                    'type': 'visibility',
                    'visible': '{{previewLoaded}}',
                    'child': StacSingleChildScrollView(
                      padding: StacEdgeInsets.all(16),
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        textDirection: StacTextDirection.rtl,
                        children: [
                          StacContainer(
                            width: 999999,
                            decoration: StacBoxDecoration(
                              color:
                                  '{{appColors.current.background.surfaceContainer}}',
                              borderRadius: StacBorderRadius.all(12),
                              border: StacBorder.all(
                                color:
                                    '{{appColors.current.input.borderEnabled}}',
                                width: 1,
                              ),
                            ),
                            padding: StacEdgeInsets.all(8),
                            child: StacRawJsonWidget({
                              'type': 'pdfPreview',
                              'src': '{{serverSignedPdf}}',
                              'registryKey': 'serverSignedPdf',
                              'width': 999999,
                              'height': 500,
                            }),
                          ),
                        ],
                      ),
                    ).toJson(),
                  },
                },
              ],
            }),
          ),

          // ── Bottom Buttons: Save & Share (only when loaded) ──
          StacRawJsonWidget({
            'type': 'registryReactive',
            'registryKey': 'previewLoaded',
            'child': {
              'type': 'visibility',
              'visible': '{{previewLoaded}}',
              'child': StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    // Save Button (Red)
                    StacExpanded(
                      child: StacRawJsonWidget({
                        'type': 'elevatedButton',
                        'onPressed': {
                          'actionType': 'saveFile',
                          'fileName': 'promissory_preview.pdf',
                          'registryKey': 'serverSignedPdf',
                          'content': '{{serverSignedPdf}}',
                          'isBase64': true,
                        },
                        'style': StacButtonStyle(
                          backgroundColor: '#D32F2F',
                          foregroundColor: '#FFFFFF',
                          elevation: 0,
                          fixedSize: StacSize(999999, 52),
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(12),
                          ),
                        ).toJson(),
                        'child': {
                          'type': 'text',
                          'data': 'ذخیره',
                          'textDirection': 'rtl',
                          'style': {
                            'type': 'custom',
                            'fontSize': 16,
                            'fontWeight': 'bold',
                            'color': '#FFFFFF',
                          },
                        },
                      }),
                    ),
                    StacSizedBox(width: 12),
                    // Share Button (Outlined)
                    StacExpanded(
                      child: StacRawJsonWidget({
                        'type': 'elevatedButton',
                        'onPressed': {
                          'actionType': 'shareFile',
                          'fileName': 'promissory.pdf',
                          'registryKey': 'serverSignedPdf',
                          'content': '{{serverSignedPdf}}',
                          'mimeType': 'application/pdf',
                        },
                        'style': StacButtonStyle(
                          backgroundColor: '#FFFFFF',
                          foregroundColor: '{{appColors.current.text.title}}',
                          elevation: 0,
                          fixedSize: StacSize(999999, 52),
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(12),
                            side: StacBorderSide(
                              color:
                                  '{{appColors.current.input.borderEnabled}}',
                              width: 1,
                            ),
                          ),
                        ).toJson(),
                        'child': {
                          'type': 'text',
                          'data': 'اشتراک گذاری',
                          'textDirection': 'rtl',
                          'style': {
                            'type': 'custom',
                            'fontSize': 16,
                            'fontWeight': 'bold',
                            'color': '{{appColors.current.text.title}}',
                          },
                        },
                      }),
                    ),
                  ],
                ),
              ).toJson(),
            },
          }),
        ],
      ),
    ),
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
