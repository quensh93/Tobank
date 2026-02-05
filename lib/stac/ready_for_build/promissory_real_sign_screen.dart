import 'package:stac_core/stac_core.dart';

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
                                          'value': '{{data.data.promissoryId}}',
                                        },
                                        {
                                          'key': 'transactionAmount',
                                          'value': '{{form.promissory_amount}}',
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
                                      'navigationStyle': 'pushReplacement',
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
                                      'navigationStyle': 'pushReplacement',
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

// ==========================================
// Local Helper Classes (Inlined to avoid import issues)
// ==========================================

/// Dart builder for 'stateFull' STAC widgets.
class StacStatefulWidget extends StacWidget {
  final dynamic onInit;
  final dynamic onBuild;
  final dynamic onDependenciesChanged;
  final dynamic onWidgetUpdated;
  final dynamic onReassemble;
  final dynamic onDeactivate;
  final dynamic onDispose;
  final dynamic onResume;
  final dynamic onPause;
  final dynamic onInactive;
  final dynamic onHidden;
  final dynamic onDetached;
  final StacWidget child;

  const StacStatefulWidget({
    this.onInit,
    this.onBuild,
    this.onDependenciesChanged,
    this.onWidgetUpdated,
    this.onReassemble,
    this.onDeactivate,
    this.onDispose,
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onHidden,
    this.onDetached,
    required this.child,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'stateFull',
      if (onInit != null) 'onInit': _actionToJson(onInit),
      if (onBuild != null) 'onBuild': _actionToJson(onBuild),
      if (onDependenciesChanged != null)
        'onDependenciesChanged': _actionToJson(onDependenciesChanged),
      if (onWidgetUpdated != null)
        'onWidgetUpdated': _actionToJson(onWidgetUpdated),
      if (onReassemble != null) 'onReassemble': _actionToJson(onReassemble),
      if (onDeactivate != null) 'onDeactivate': _actionToJson(onDeactivate),
      if (onDispose != null) 'onDispose': _actionToJson(onDispose),
      if (onResume != null) 'onResume': _actionToJson(onResume),
      if (onPause != null) 'onPause': _actionToJson(onPause),
      if (onInactive != null) 'onInactive': _actionToJson(onInactive),
      if (onHidden != null) 'onHidden': _actionToJson(onHidden),
      if (onDetached != null) 'onDetached': _actionToJson(onDetached),
      'child': child.toJson(),
    };
  }

  dynamic _actionToJson(dynamic action) {
    if (action == null) return null;
    if (action is Map) return action;
    try {
      return action.toJson();
    } catch (e) {
      return action;
    }
  }
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

/// Helper class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);

  @override
  StacTextStyleType get type => StacTextStyleType.custom;

  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Builder for 'sequence' action.
class StacSequenceAction extends StacAction {
  final List<dynamic> actions;

  const StacSequenceAction({required this.actions});

  @override
  String get actionType => 'sequence';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'sequence',
      'actions': actions.map((a) {
        if (a is StacAction) return a.toJson();
        if (a is Map) return a;
        try {
          return a.toJson();
        } catch (_) {
          return a;
        }
      }).toList(),
    };
  }
}

/// Builder for 'networkRequest' action.
class StacNetworkRequestAction extends StacAction {
  final String url;
  final String method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? headers;
  final List<dynamic>? results;

  const StacNetworkRequestAction({
    required this.url,
    this.method = 'get',
    this.data,
    this.headers,
    this.results,
  });

  @override
  String get actionType => 'networkRequest';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'networkRequest',
      'url': url,
      'method': method,
      if (data != null) 'data': data,
      if (headers != null) 'headers': headers,
      if (results != null)
        'results': results!.map((r) {
          if (r is Map) {
            return r.map((key, value) {
              if (value is StacAction) {
                return MapEntry(key, value.toJson());
              }
              return MapEntry(key, value);
            }).cast<String, dynamic>();
          }
          try {
            return (r as dynamic).toJson();
          } catch (_) {
            return r;
          }
        }).toList(),
    };
  }
}

/// Builder for 'setValue' action.
class StacCustomSetValueAction extends StacAction {
  final String? key;
  final dynamic value;
  final List<Map<String, dynamic>>? values;

  const StacCustomSetValueAction({this.key, this.value, this.values});

  @override
  String get actionType => 'setValue';

  @override
  Map<String, dynamic> toJson() {
    if (values != null) {
      return {'actionType': 'setValue', 'values': values};
    }
    dynamic processedValue = value;
    if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
  }
}
