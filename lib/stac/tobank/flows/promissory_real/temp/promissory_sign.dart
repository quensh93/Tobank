import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Digital Signature Page
///
/// This screen allows users to digitally sign the promissory PDF:
/// 1. Loads sign assets (coordinates) on init
/// 2. Shows PDF preview/viewer
/// 3. Shows signature area info
/// 4. Sign button triggers confirmation dialog
/// 5. After confirmation, signs PDF and finalizes promissory
/// 6. Navigates to transaction detail page (promissory_success)
///
/// Reference: docs/promissory_docs/promissory_issuance.md (Step 8)
/// Reference: docs/promissory_docs/request_promissory_sign_page.dart
@StacScreen(screenName: 'promissory_sign')
StacWidget promissorySign() {
  return StacStatefulWidget(
    // Load sign assets (coordinates) and initialize signing state
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isSigning', value: false),
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
                  // Instructions
                  StacText(
                    data: '{{appStrings.promissory.signInstructions}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // PDF Preview Container
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
                            src: 'assets/icons/ic_pdf.svg',
                            imageType: StacImageType.asset,
                            width: 64,
                            height: 64,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                          StacSizedBox(height: 16),
                          StacText(
                            data: '{{appStrings.promissory.pdfPreview}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacText(
                            data:
                                '{{appStrings.promissory.signInstructionsDetail}}',
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.center,
                            style: StacCustomTextStyle(
                              fontSize: 12,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StacSizedBox(height: 24),

                  // Signature Area Info
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
                              data: '{{appStrings.promissory.signInfoTitle}}',
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
                          data: '{{appStrings.promissory.signInfoMessage}}',
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
              'enabledKey': 'isSigning',
              'enabled': false,
              'onPressed': {
                'actionType': 'dialog',
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
                              'id': '{{form.promissory_request_id}}',
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
                                      'key': 'promissoryId',
                                      'value': '{{data.data.promissoryId}}',
                                    },
                                    {
                                      'actionType': 'setValue',
                                      'key': 'transactionAmount',
                                      'value': '{{form.promissory_amount}}',
                                    },
                                    {
                                      'actionType': 'setValue',
                                      'key': 'transactionTime',
                                      'value': '{{data.data.transactionTime}}',
                                    },
                                    {
                                      'actionType': 'setValue',
                                      'key': 'trackingNumber',
                                      'value': '{{data.data.trackingNumber}}',
                                    },
                                    {
                                      'actionType': 'navigate',
                                      'request': {
                                        'url':
                                            'https://api.tobank.com/flows/promissory/promissory_success',
                                        'method': 'get',
                                      },
                                      'navigationStyle': 'pushReplacement',
                                    },
                                  ],
                                },
                              },
                            ],
                          },
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

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper for complex widgets
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
